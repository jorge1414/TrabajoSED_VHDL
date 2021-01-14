----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2020 11:36:54
-- Design Name: 
-- Module Name: DETECTOR_testb - test
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

entity DETECTOR_testb is
end DETECTOR_testb;

architecture test of DETECTOR_testb is
-- Inputs
    signal CLK      : std_logic:='0';
    signal more_in  : std_logic:='0';
    signal less_in  : std_logic:='0';
    signal ok_in    : std_logic:='0';
-- outputs
    signal more_out : std_logic;
    signal less_out : std_logic;
    signal ok_out   : std_logic;
    
   component DETECTOR_FLANCO is
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
end component; 
        
begin
--Unit Under Test
    uut : DETECTOR_FLANCO
    port map (CLK      => CLK,
              more_in  => more_in,
              less_in  => less_in,
              ok_in    => ok_in,
              more_out => more_out,
              less_out => less_out,
              ok_out   => ok_out);
        
        CLK <= not CLK after 50 ns;
        
         process
    begin
           wait for 100 ns;
           more_in <= '1';
           wait for 100 ns;
           more_in <= '0';
           wait for 100 ns;
           less_in <= '1';
           wait for 100 ns;
           less_in <= '0';
           wait for 100ns;
           ok_in <= '1';
           wait for 100 ns;
           ok_in <= '0';
           wait for 100 ns;
           
           wait for 400 ns;
         
        assert false  
           report "[SUCCESS]: simulation finished."    
           severity failure; 
    end process;

end test;
