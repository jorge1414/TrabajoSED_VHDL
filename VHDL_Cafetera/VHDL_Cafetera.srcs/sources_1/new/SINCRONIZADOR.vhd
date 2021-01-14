----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 11:30:39
-- Design Name: 
-- Module Name: SINCRONIZADOR - Behavioral
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

entity SINCRONIZADOR is
    Port ( CLK : in STD_LOGIC;
           --ASYNC_IN : in STD_LOGIC;
           --SYNC_OUT : out STD_LOGIC);
           --MLK_SYNC: std_logic_vector(0 to 2);
           --MLK_SYNC_OUT: std_logic_vector(0 to 2)
            more_in : IN STD_LOGIC;
            less_in : IN STD_LOGIC;
            ok_in   : IN STD_LOGIC;
            more_out: OUT STD_LOGIC;
            less_out: OUT STD_LOGIC;
            ok_out  : OUT STD_LOGIC
           );
end SINCRONIZADOR;

architecture Behavioral of SINCRONIZADOR is
  signal sreg_M : std_logic_vector(1 downto 0);
  signal sreg_L : std_logic_vector(1 downto 0);
  signal sreg_K : std_logic_vector(1 downto 0);
     begin
        process (CLK)
            begin
                if rising_edge(CLK) then
                    more_out <= sreg_M(1);
                    sreg_M <= sreg_M(0) & more_in;
                    less_out <= sreg_L(1);
                    sreg_L <= sreg_L(0) & less_in;
                    ok_out <= sreg_K(1);
                    sreg_K <= sreg_K(0) & ok_in;     
                end if;
        end process;
end Behavioral;
