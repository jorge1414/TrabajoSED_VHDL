----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2021 12:16:39
-- Design Name: 
-- Module Name: counter_testb - Behavioral
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

entity COUNTER_TB is
end COUNTER_TB;

architecture TEST of COUNTER_TB is

    procedure wait_for_n_ticks(ticks : positive; signal clk : std_logic) is
    begin
        for i in 1 to ticks loop
            wait until clk = '1';
        end loop;
    end procedure;

    component COUNTER is
        port (
            CLK       : in std_logic;
            CLR_N     : in std_logic;
            ENABLE    : in std_logic;
            TIEMPO_IN : unsigned(7 downto 0);
            FINAL_COUNTER : out std_logic;
            LED_OUT   : out std_logic
        );
    end component;

    -- Inputs
    signal CLK       : std_logic := '0';
    signal CLR_N     : std_logic;
    signal ENABLE    : std_logic;
    signal TIEMPO_IN : unsigned(7 downto 0) := to_unsigned(15, 8);

    -- outputs
    --signal COUNT     : STD_LOGIC_VECTOR (7 downto 0):="00000000";
    signal LED_OUT   : STD_LOGIC;
    signal FINAL_COUNTER : std_logic;

    constant CLK_PERIOD : time := 1 ms;

begin
    uut: counter
        port map (
            CLK       => CLK,
            CLR_N     => CLR_N,
            ENABLE    => ENABLE,
            TIEMPO_IN => TIEMPO_IN,
            FINAL_COUNTER => FINAL_COUNTER,
            LED_OUT   => LED_OUT
        );

    clkgen: clk <= not CLK after 0.5 * CLK_PERIOD;

    tester: process
    begin
        CLR_N <= '0' after 0.25 * CLK_PERIOD, '1' after 0.75 * CLK_PERIOD;
        wait until CLR_N = '1';
        ENABLE <= '0';
        wait_for_n_ticks(4, CLK);
        ENABLE <= '1';
        wait_for_n_ticks(20000, CLK);

        assert false  
            report "[SUCCESS]: simulation finished."    
            severity failure; 
    end process; 
end TEST;
