----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 11:54:36
-- Design Name: 
-- Module Name: DETECTOR_FLANCO - Behavioral
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

entity detector_flanco is
port (
-- Inputs
    CLK : in std_logic;
    more_in : IN STD_LOGIC;
    less_in : IN STD_LOGIC;
    ok_in   : IN STD_LOGIC;
-- Outputs
    more_out: OUT STD_LOGIC;
    less_out: OUT STD_LOGIC;
    ok_out  : OUT STD_LOGIC 

 );
end detector_flanco;

architecture Behavioral of detector_flanco is

signal sreg_M : std_logic_vector(2 downto 0);
signal sreg_L : std_logic_vector(2 downto 0);
signal sreg_K : std_logic_vector(2 downto 0);
    begin
     process (CLK)
         begin
         if rising_edge(CLK) then
             sreg_M <= sreg_M(1 downto 0) & more_in;
             sreg_L <= sreg_L(1 downto 0) & less_in;
             sreg_K <= sreg_K(1 downto 0) & ok_in;
         end if;
     end process;
         with sreg_M select
         more_out <= '1' when "011",
        '0' when others;
        with sreg_L select
         less_out <= '1' when "011",
        '0' when others;
        with sreg_K select
         ok_out <= '1' when "011",
        '0' when others;
    
end Behavioral;
