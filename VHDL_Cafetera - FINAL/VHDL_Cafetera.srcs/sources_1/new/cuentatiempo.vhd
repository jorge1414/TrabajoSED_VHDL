----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2021 19:40:00
-- Design Name: 
-- Module Name: cuentatiempo - Behavioral
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

entity cuentatiempo is
  Port ( 
        CLK: in std_logic;
        RESET: in std_logic;
        MAS: in std_logic;
        MENOS: in std_logic;
        CORTO: in std_logic;
        LARGO: in std_logic;
        ESTADO_CAFE: in std_logic;
        T_OUT: out unsigned(7 downto 0);
        ENTRADA_DISP: in string (4 downto 1);
        SALIDA_DISP: out string(4 downto 1)
  );
end cuentatiempo;

architecture Behavioral of cuentatiempo is

subtype tiempo_t is integer range 0 to 100;

signal t_cafe: tiempo_t := 0;

signal t_decenas: tiempo_t := 0;
signal t_unidades: tiempo_t := 0;

signal t_buffer_corto: tiempo_t := 0;
signal t_buffer_largo: tiempo_t := 0;
    
constant t_largo: tiempo_t := 15;
constant t_corto: tiempo_t := 5;
    
constant aumento_largo: tiempo_t := 5;
constant aumento_corto: tiempo_t := 2;

begin

process(CLK,RESET)
begin 

    if RESET = '0' then 
    
        t_buffer_corto<=0;
        t_buffer_largo<=0;
        
    elsif rising_edge(CLK) then 
        
        T_OUT<=to_unsigned(t_cafe, 8);
        
        if ESTADO_CAFE = '1' then
            
            if LARGO = '1' then
                
                t_cafe<=t_largo+t_buffer_largo;
                
            elsif CORTO = '1' then 
            
                t_cafe<=t_corto+t_buffer_corto;
                
            end if;
            
            t_decenas<=t_cafe/10;
            t_unidades<=t_cafe MOD 10;
            
            
           SALIDA_DISP(4 downto 3)<="  ";
           
           case t_decenas is
                when 0 => SALIDA_DISP(2)<='0';
                when 1 => SALIDA_DISP(2)<='1';
                when 2 => SALIDA_DISP(2)<='2';
                when 3 => SALIDA_DISP(2)<='3';
                when 4 => SALIDA_DISP(2)<='4';
                when 5 => SALIDA_DISP(2)<='5';
                when 6 => SALIDA_DISP(2)<='6';
                when 7 => SALIDA_DISP(2)<='7';
                when 8 => SALIDA_DISP(2)<='8';
                when 9 => SALIDA_DISP(2)<='9';
                when others => SALIDA_DISP(2)<='0';
           end case;
               
           case t_unidades is
                when 0 => SALIDA_DISP(1)<='0';
                when 1 => SALIDA_DISP(1)<='1';
                when 2 => SALIDA_DISP(1)<='2';
                when 3 => SALIDA_DISP(1)<='3';
                when 4 => SALIDA_DISP(1)<='4';
                when 5 => SALIDA_DISP(1)<='5';
                when 6 => SALIDA_DISP(1)<='6';
                when 7 => SALIDA_DISP(1)<='7';
                when 8 => SALIDA_DISP(1)<='8';
                when 9 => SALIDA_DISP(1)<='9';
                when others => SALIDA_DISP(1)<='0';
           end case;
            
            
           if MAS = '1' then
                
                if CORTO = '1' AND t_cafe<15 then
                
                    t_buffer_corto<=t_buffer_corto+aumento_corto;
                
                end if;
                                        
                if LARGO = '1' AND t_cafe<60 then
                
                    t_buffer_largo<=t_buffer_largo+aumento_largo;
                    
                end if;
            end if;
                
            if MENOS = '1' then
            
                if CORTO = '1' AND t_cafe>5 then
                
                    t_buffer_corto<=t_buffer_corto-aumento_corto;
                    
                end if;
                    
                if LARGO = '1' AND t_cafe>15 then
                
                    t_buffer_largo<=t_buffer_largo-aumento_largo;
                    
                end if;
                    
            end if;
            
         elsif ESTADO_CAFE = '0' then
         
            SALIDA_DISP<=ENTRADA_DISP;
            
         end if;
      end if;             
end process;

end Behavioral;
