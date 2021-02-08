library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestordisplay is
port(
    STD_VECTOR_IN: in std_logic_vector(27 downto 0);
    CATHODE_VECTOR: out std_logic_vector(6 downto 0);
    SELEC_DISP: out std_logic_vector(3 downto 0);
    CLK_IN: in std_logic  
);
end gestordisplay;

architecture Behavioral of gestordisplay is
signal i: integer :=2;
begin

process(CLK_IN)
begin
    i<=i+1;

    if i=3 then
    i<=0;
    end if;

    if i=0 then
    cathode_vector<=std_vector_in(27 downto 21);
    selec_disp<="1000";
    elsif i=1 then
    cathode_vector<=std_vector_in(20 downto 14);
    selec_disp<="0100";
    elsif i=2 then
    cathode_vector<=std_vector_in(13 downto 7);
    selec_disp<="0010";
    elsif i=3 then
    cathode_vector<=std_vector_in(6 downto 0);
    selec_disp<="0001";
    end if;
     
end process;


end Behavioral;

