----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 19:26:48
-- Design Name: 
-- Module Name: fdivider_testb - Behavioral
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

entity FDIVIDER_TB is
end entity;

architecture TEST of FDIVIDER_TB is
-- inputs
signal  reset:  STD_LOGIC:='0';
signal clk_in:  STD_LOGIC:='0';
--outputs
signal clk_out: STD_LOGIC:='0';

component fdivider is 
port (
    reset:  in STD_LOGIC;
	clk_in: in STD_LOGIC;
	clk_out: out STD_LOGIC                    -- Salida que debe cambiar de estado a la frecuencia deseada
);
end component;

begin
uut: fdivider
port map(
reset => reset,
clk_in => clk_in,
clk_out => clk_out
);

clk_in <= not CLK_in after 5 ms;


process
begin
            wait for 1500 ms;

 assert false  
           report "[SUCCESS]: simulation finished."    
           severity failure; 
    end process;

end test;

