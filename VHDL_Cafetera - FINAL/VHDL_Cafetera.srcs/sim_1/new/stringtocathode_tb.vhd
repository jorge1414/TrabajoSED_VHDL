library ieee;
use ieee.std_logic_1164.all;

entity STRINGTOCATHODE_TB is
end STRINGTOCATHODE_TB;

architecture TEST of STRINGTOCATHODE_TB is

    component stringtocathode
        port (
            STR_IN         : in string(4 downto 1);
            STD_VECTOR_OUT : out std_logic_vector(27 downto 0)
        );
    end component;

    signal STR_IN         : string(4 downto 1);
    signal STD_VECTOR_OUT : std_logic_vector(27 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    dut : stringtocathode
    port map (STR_IN         => STR_IN,
              STD_VECTOR_OUT => STD_VECTOR_OUT);

    stimuligen: process
    begin
        STR_IN <= "LARG";
        wait for CLK_PERIOD;
        STR_IN <= "CORT";
        wait for CLK_PERIOD;
        STR_IN <= "LECH";

        wait for CLK_PERIOD;
        assert false  
            report "[SUCCESS]: simulation finished."    
            severity failure; 
    end process;

end TEST;
