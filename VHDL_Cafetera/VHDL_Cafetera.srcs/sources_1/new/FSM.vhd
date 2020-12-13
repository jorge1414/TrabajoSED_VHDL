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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
port(
    SEL : in std_logic;
    ENABLE : in std_logic;
    MORE : in std_logic;
    LESS : in std_logic;
    OK : in std_logic;
    RESET : in std_logic;
    CLK : in std_logic;
    TIEMPO_CAFE : out natural; 
    LECHE : out std_logic;
    AZUCAR : out std_logic;
    --ESTADO : out integer;
    LED_OK : out std_logic
);
end FSM;

architecture behavioral of fsm is
     type STATES is (S0, S1, S2, S3, S4);
     signal current_state: STATES;
     signal next_state: STATES;
     
     signal tiempo_buffer_corto: natural := 0;
     signal tiempo_buffer_largo: natural := 0;
     
     constant tiempo_largo: natural := 15;
     constant tiempo_corto: natural := 5;
     
     constant aumento_cafe_largo: natural := 5;
     constant aumento_cafe_corto: natural := 2;
     
begin
state_register: process (RESET, CLK)
begin
    if clk = '1' then
        current_state <= next_state;
    end if;
        
    if reset = '0' then
        current_state <= S0;
    end if;
end process;

nextstate_decod: process (ENABLE, OK, RESET, current_state)
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

         when others =>
            next_state <= S0;
            
            
     end case;
 end process;



output_decod: process (current_state, SEL, MORE, LESS)
     
 begin
     case current_state is
         when S0 =>
         --Podemos poner un led de que está listo para funcionar
         
         when S1 =>
            if SEL = '1' then
               tiempo_cafe<=tiempo_largo+tiempo_buffer_largo;
               if (MORE = '1' and tiempo_buffer_largo<=20) then
                  tiempo_buffer_largo<=tiempo_buffer_largo+aumento_cafe_largo;
                  tiempo_cafe<=tiempo_largo+tiempo_buffer_largo; 
                  
               elsif (LESS = '1' and tiempo_buffer_largo>0) then
                  tiempo_buffer_largo<=tiempo_buffer_largo-aumento_cafe_largo;
                  tiempo_cafe<=tiempo_largo+tiempo_buffer_largo;
                  
               end if;
            
            elsif SEL = '0' then
                tiempo_cafe<=tiempo_corto+tiempo_buffer_corto;
                if (MORE = '1' and tiempo_buffer_corto<=10) then --
                  tiempo_buffer_corto<=tiempo_buffer_corto+aumento_cafe_corto;
                  tiempo_cafe<=tiempo_corto+tiempo_buffer_corto; 
                  
                elsif (LESS = '1' and tiempo_buffer_corto>0) then
                  tiempo_buffer_corto<=tiempo_buffer_corto-aumento_cafe_corto;
                  tiempo_cafe<=tiempo_corto+tiempo_buffer_corto;
                  
               end if;  
           end if;
         when S2 =>
            if SEL = '1' then
                LECHE <= '1';
            elsif SEL = '0' then
                LECHE <= '0';
            end if;
         
         when S3 =>
            if SEL = '1' then
                AZUCAR <= '1';
            elsif SEL = '0' then
                AZUCAR <= '0';
            end if;
         
         when others =>
             tiempo_cafe<=0;
             AZUCAR<='0';
             LECHE<='0';
     end case;
 end process;


end Behavioral;

