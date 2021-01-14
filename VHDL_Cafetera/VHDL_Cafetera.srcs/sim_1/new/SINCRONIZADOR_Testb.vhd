----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 17:00:38
-- Design Name: 
-- Module Name: SINCRONIZADOR_Testb - test
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 12:05:10
-- Design Name: 
-- Module Name: SINCRONIZADOR_tb - test
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


entity SINCRONIZADOR_tb is
end SINCRONIZADOR_tb;

architecture test of SINCRONIZADOR_tb is

-- Inputs
    signal CLK      : std_logic:='0';
    signal more_in  : std_logic:='0';
    signal less_in  : std_logic:='0';
    signal ok_in    : std_logic:='0';
-- outputs
    signal more_out : std_logic;
    signal less_out : std_logic;
    signal ok_out   : std_logic;


    component SINCRONIZADOR
        port (CLK      : in std_logic:='0';
              more_in  : in std_logic:='0';
              less_in  : in std_logic:='0';
              ok_in    : in std_logic:='0';
              more_out : out std_logic:='0';
              less_out : out std_logic:='0';
              ok_out   : out std_logic:='0'
              );
    end component;

begin

--Unit Under Test
    uut : SINCRONIZADOR
    port map (CLK      => CLK,
              more_in  => more_in,
              less_in  => less_in,
              ok_in    => ok_in,
              more_out => more_out,
              less_out => less_out,
              ok_out   => ok_out);
        
        CLK <= not CLK after 50 ns;
--        MORE_IN <= not MORE_IN after 125ns;
--        LESS_IN <= not LESS_IN after 250ns;
--        OK_IN <= not OK_IN after 375ns;     

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


