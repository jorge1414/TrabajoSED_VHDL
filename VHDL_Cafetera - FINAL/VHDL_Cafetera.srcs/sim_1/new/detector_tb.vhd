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

entity DETECTOR_TB is
end DETECTOR_TB;

architecture TEST of DETECTOR_TB is

    procedure wait_for_n_ticks(ticks : positive; signal clk : std_logic) is
    begin
        for i in 1 to ticks loop
            wait until clk = '1';
        end loop;
    end procedure;

    component DETECTOR_FLANCO is
        port (
            CLK      : in std_logic;
            MORE_IN  : in std_logic;
            LESS_IN  : in std_logic;
            OK_IN    : in std_logic;
            MORE_OUT : out std_logic;
            LESS_OUT : out std_logic;
            OK_OUT   : out std_logic 
        );
    end component; 

    -- Inputs
    signal CLK      : std_logic := '0';
    signal MORE_IN  : std_logic := '0';
    signal LESS_IN  : std_logic := '0';
    signal OK_IN    : std_logic := '0';

    -- outputs
    signal MORE_OUT : std_logic;
    signal LESS_OUT : std_logic;
    signal OK_OUT   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    --Unit Under Test
    uut: DETECTOR_FLANCO
    port map (
        CLK      => CLK,
        MORE_IN  => MORE_IN,
        LESS_IN  => LESS_IN,
        OK_IN    => OK_IN,
        MORE_OUT => MORE_OUT,
        LESS_OUT => LESS_OUT,
        OK_OUT   => OK_OUT
    );
        
    clkgen: clk <= not CLK after 0.5 * CLK_PERIOD;

    stimuligen: process
    begin
        wait for 0.25 * CLK_PERIOD;
        MORE_IN <= '0';
        LESS_IN <= '0';
        OK_IN   <= '0';
        wait_for_n_ticks(6, CLK);
        
        MORE_IN <= '1';
        wait_for_n_ticks(6, CLK);

        LESS_IN <= '1';
        wait_for_n_ticks(6, CLK);

        OK_IN   <= '1';
        wait_for_n_ticks(6, CLK);
        
        MORE_IN <= '0';
        LESS_IN <= '0';
        OK_IN   <= '0';
        wait_for_n_ticks(6, CLK);

        assert false  
           report "[SUCCESS]: simulation finished."    
           severity failure; 
    end process;
end TEST;
