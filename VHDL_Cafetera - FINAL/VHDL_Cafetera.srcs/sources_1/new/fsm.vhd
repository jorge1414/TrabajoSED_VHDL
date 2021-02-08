----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2020 20:01:06
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
port(
    SEL : in std_logic;
    ENABLE : in std_logic;
    OK : in std_logic;
    CLK : in std_logic; 
    RST_N         : in  std_logic;
    FINAL_COUNTER: in std_logic;
    COUNTER_EN    : out std_logic;
    SALIDA_DISP_1 : out string(4 downto 1);
    SALIDA_DISP_2 : out string(4 downto 1);
    LED_LECHE:      out std_logic;
    LED_AZUCAR:     out std_logic;
    LED_ENABLE:     out std_logic;
    CORTO : out std_logic;
    LARGO : out std_logic;
    ESTADO_CAFE : out std_logic
     
);
end FSM;

architecture behavioral of fsm is
     type STATES is (S0, S1, S2, S3, S4);
     --type STATES is (S0, SC, SL, S2, LS, LN, S3, AS, AN, S4);
     signal current_state: STATES;
     signal next_state: STATES;
     
begin
state_register: process (RST_N, CLK)
begin
    
    if RST_N = '0' then
        current_state <= S0;
    
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
        
    
end process;

nextstate_decod: process (ENABLE, OK, RST_N, FINAL_COUNTER, SEL, current_state)
 begin
     next_state <= current_state;
          
     case current_state is
     
         when S0 =>
            if ENABLE = '1' then
            next_state <= S1;
            end if;
            
         when S1 =>
             if OK = '1'  then
             next_state <= S2;
             end if;
            
         when S2 =>
             if OK = '1'  then
             next_state <= S3;
             end if;    
         
         when S3 =>
             if OK = '1'  then
             next_state <= S4;
             end if; 

         when S4 =>
            if FINAL_COUNTER = '1' then
            next_state <= S0;
            end if;
            
            
     end case;
 end process;



output_decod: process (current_state, SEL)
     
 begin
     case current_state is
         when S0 =>
         LED_LECHE<='0';
         LED_AZUCAR<='0';
         COUNTER_EN<='0';
         ESTADO_CAFE<='0';
         SALIDA_DISP_1 <= "----";
         SALIDA_DISP_2 <= "----";
         
            
        when S1 =>
            COUNTER_EN <= '0';
            ESTADO_CAFE <= '1';

            if SEL = '1' then
            
                SALIDA_DISP_1 <= "LARG";
                LARGO<='1';
                CORTO<='0';
                
            
            elsif SEL = '0' then
                
                SALIDA_DISP_1 <= "CORT";
                CORTO<='1';
                LARGO<='0';
                  
            end if;  
           
         when S2 =>
            COUNTER_EN <= '0';
            ESTADO_CAFE <= '0';
            
            SALIDA_DISP_1 <= "LECH";
            
            if SEL = '1' then
            
                SALIDA_DISP_2<="  SI";
                LED_LECHE<='1';
            
            elsif SEL = '0' then
            
                SALIDA_DISP_2<="  NO";
                LED_LECHE<='0';
            
            end if;
         
         when S3 =>
            COUNTER_EN <= '0';
            ESTADO_CAFE <= '0';
            
            SALIDA_DISP_1 <= "AZUC";
            
            if SEL = '1' then
            
                SALIDA_DISP_2<="  SI";
                LED_AZUCAR<='1';
            
            elsif SEL = '0' then
            
                SALIDA_DISP_2<="  NO";
                LED_AZUCAR<='0';
            
            end if;
            
         when S4 =>
            COUNTER_EN <= '1';
            ESTADO_CAFE <= '0';
         
            SALIDA_DISP_1 <= "SERU";
            SALIDA_DISP_2<=  "ICIO";
         
         when others =>
         
             SALIDA_DISP_1<="OOOO";
             SALIDA_DISP_2<="OOOO";
     end case;
 end process;


end Behavioral;

