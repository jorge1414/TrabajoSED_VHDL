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
use IEEE.std_logic_1164.all;

entity SINCRONIZADOR_TB is
end SINCRONIZADOR_TB;

architecture TEST of SINCRONIZADOR_TB is

    procedure wait_for_n_ticks(ticks : positive; signal clk : std_logic) is
    begin
        for i in 1 to ticks loop
            wait until clk = '1';
        end loop;
    end procedure;

    component SINCRONIZADOR
        port (
            CLK      : in  std_logic;
            MORE_IN  : in  std_logic;
            LESS_IN  : in  std_logic;
            OK_IN    : in  std_logic;
            MORE_OUT : out std_logic;
            LESS_OUT : out std_logic;
            OK_OUT   : out std_logic
        );
    end component;

    -- Inputs
    signal CLK      : std_logic := '0';
    signal MORE_IN  : std_logic;
    signal LESS_IN  : std_logic;
    signal OK_IN    : std_logic;

    -- outputs
    signal MORE_OUT : std_logic;
    signal LESS_OUT : std_logic;
    signal OK_OUT   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    --Unit Under Test
    uut: SINCRONIZADOR
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
        
        wait for 0.25 * CLK_PERIOD;
        MORE_IN <= '1';
        wait_for_n_ticks(6, CLK);

        wait for 0.25 * CLK_PERIOD;
        LESS_IN <= '1';
        wait_for_n_ticks(6, CLK);

        wait for 0.25 * CLK_PERIOD;
        OK_IN   <= '1';
        wait_for_n_ticks(6, CLK);
        
        wait for 0.25 * CLK_PERIOD;
        MORE_IN <= '0';
        LESS_IN <= '0';
        OK_IN   <= '0';
        wait_for_n_ticks(6, CLK);

        assert false  
           report "[SUCCESS]: simulation finished."    
           severity failure; 
    end process;
end TEST;
