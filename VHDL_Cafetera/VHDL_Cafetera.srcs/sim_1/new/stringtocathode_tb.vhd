library ieee;
use ieee.std_logic_1164.all;

entity tb_stringtocathode is
end tb_stringtocathode;

architecture tb of tb_stringtocathode is

    component stringtocathode
        port (STR_IN         : in string (4 downto 1);
              STD_VECTOR_OUT : out std_logic_vector (27 downto 0));
    end component;

    signal STR_IN         : string (4 downto 1);
    signal STD_VECTOR_OUT : std_logic_vector (27 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : stringtocathode
    port map (STR_IN         => STR_IN,
              STD_VECTOR_OUT => STD_VECTOR_OUT);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        STR_IN <= (others => '0');

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        STR_IN<="LARG";
        wait for 100 ns;
        STR_IN<="CORT";
        wait for 100 ns;
        STR_IN<="LECH";

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_stringtocathode of tb_stringtocathode is
    for tb
    end for;
end cfg_tb_stringtocathode;