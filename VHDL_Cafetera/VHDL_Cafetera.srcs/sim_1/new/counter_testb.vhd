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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_testb is
--  Port ( );
end counter_testb;

architecture Behavioral of counter_testb is
-- Inputs
signal CLK : STD_LOGIC:='0';
signal CLR :  STD_LOGIC;
signal TIEMPO_in : unsigned (7 downto 0):= "00001111";
-- outputs
signal COUNT : STD_LOGIC_VECTOR (7 downto 0):="00000000";
signal led_out: STD_LOGIC;


component counter is
Port ( CLK : in STD_LOGIC;
       CLR : in STD_LOGIC;
       TIEMPO_in : in unsigned (7 downto 0);
       COUNT : out STD_LOGIC_VECTOR (7 downto 0);
       led_out: out STD_LOGIC
       );
end component;

--constant CLK_PERIOD : time := 10 ms;

begin

uut: counter

port map (
    CLK => CLK,
    CLR => CLR,
    TIEMPO_in => TIEMPO_in,
    COUNT => COUNT,
    led_out => led_out
    );

    

    clk <= not CLK after 5 ms;

    CLR <= '1' after 2.5 ms,
           '0' after 7.5 ms;


tester: process
begin
    wait until CLR = '0';
    for i in 1 to 20 loop                               -- Bucle detectando flancos de reloj
    wait until clk = '1';
    end loop;
    
   
    assert false  
           report "[SUCCESS]: simulation finished."    
           severity failure; 
    end process; 
 


end Behavioral;
