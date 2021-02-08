library IEEE;
use IEEE.std_logic_1164.all;

entity GESTORDISPLAY is
    port(
        STD_VECTOR_IN_1  : in  std_logic_vector(27 downto 0);
        STD_VECTOR_IN_2  : in std_logic_vector(27 downto 0);
        CATHODE_VECTOR : out std_logic_vector( 6 downto 0);
        DIGITSEL     : out std_logic_vector( 7 downto 0);
        CLK_IN         : in  std_logic  
    );
end GESTORDISPLAY;

architecture DATAFLOW of GESTORDISPLAY is
    signal digitsel_i  : std_logic_vector(7 downto 0) := "01111111";
    signal catodos     : std_logic_vector(55 downto 0);
begin
    catodos <= STD_VECTOR_IN_1 & STD_VECTOR_IN_2;
    DIGITSEL <= digitsel_i;

    ringcntr: digitsel_i <= digitsel_i(0) & digitsel_i(7 downto 1) when rising_edge(CLK_IN) else
                             digitsel_i;

    mux: with digitsel_i select
        CATHODE_VECTOR <= catodos(55 downto 49) when "01111111",
                          catodos(48 downto 42) when "10111111",
                          catodos(41 downto 35) when "11011111",
                          catodos(34 downto 28) when "11101111",
                          catodos(27 downto 21) when "11110111",
                          catodos(20 downto 14) when "11111011",
                          catodos(13 downto  7) when "11111101",
                          catodos( 6 downto  0) when "11111110",
                          (others => '-') when others;
end DATAFLOW;
