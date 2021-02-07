library ieee;
use ieee.std_logic_1164.all;

entity tb_gestordisplay is
end tb_gestordisplay;

architecture tb of tb_gestordisplay is

    component gestordisplay
        port (STD_VECTOR_IN  : in std_logic_vector (27 downto 0);
              CATHODE_VECTOR : out std_logic_vector (6 downto 0);
              SELEC_DISP     : out std_logic_vector (3 downto 0);
              CLK_IN         : in std_logic);
    end component;

    signal STD_VECTOR_IN  : std_logic_vector (27 downto 0);
    signal CATHODE_VECTOR : std_logic_vector (6 downto 0);
    signal SELEC_DISP     : std_logic_vector (3 downto 0);
    signal CLK_IN         : std_logic;

    constant TbPeriod : time := 250 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : gestordisplay
    port map (STD_VECTOR_IN  => STD_VECTOR_IN,
              CATHODE_VECTOR => CATHODE_VECTOR,
              SELEC_DISP     => SELEC_DISP,
              CLK_IN         => CLK_IN);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK_IN is really your main clock signal
    CLK_IN <= TbClock;

   
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        STD_VECTOR_IN <= (others => '0');
        STD_VECTOR_IN <= "1111111000000011100000001111";
        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_gestordisplay of tb_gestordisplay is
    for tb
    end for;
end cfg_tb_gestordisplay;

