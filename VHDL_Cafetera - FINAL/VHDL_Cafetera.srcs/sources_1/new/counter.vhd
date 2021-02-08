----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2021 11:11:19
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COUNTER is
    port (
        CLK       : in std_logic;
        CLR_N     : in std_logic;
        ENABLE    : in std_logic;
        TIEMPO_IN : in unsigned(7 downto 0);
        FINAL_COUNTER : out std_logic;
        --COUNT :  out STD_LOGIC_VECTOR (7 downto 0);
        LED_OUT   : out std_logic
    );
end COUNTER;

architecture BEHAVIORAL of COUNTER is
    -- Señal de tiempo para el contador
    signal reg   : unsigned(7 downto 0);        
    signal led_r : std_logic;
    signal cuenta_ms : unsigned(9 downto 0) := (others =>'0');
        
begin
    
    led_out <= '1' when reg < TIEMPO_IN and ENABLE = '1' and cuenta_ms < to_unsigned(500,10) else 
               '0';
               
    FINAL_COUNTER <= '1' when reg > TIEMPO_IN and ENABLE = '1' else
                     '0';

    process (CLK,CLR_N)
    begin
        if CLR_N = '0' then
            reg <= (others =>'0');                          
        elsif rising_edge(CLK) then
            if ENABLE = '1' then
                    cuenta_ms <= cuenta_ms+1;
                    if cuenta_ms > to_unsigned(999, 10) then
                        reg <= reg +1; 
                        cuenta_ms <= (others => '0');
                    end if;
                    
                    if reg > TIEMPO_IN then
                        
                        reg <= (others => '0');
                        cuenta_ms <= (others => '0');
                            
                    end if;
                    
               end if;
        end if;
    end process;
    
--    led: process (clk,clr)
--    begin
    
----    if CLR = '1' then
----        led_r <= '0';
----       elsif clk'event then
----       if reg < tiempo_in then
----        led_r <= not(led_r);
----        else
----        led_r <= '0';
----       end if;
----       end if;
    
    
--    end process;
    --count <= std_logic_vector(reg);
end BEHAVIORAL;
