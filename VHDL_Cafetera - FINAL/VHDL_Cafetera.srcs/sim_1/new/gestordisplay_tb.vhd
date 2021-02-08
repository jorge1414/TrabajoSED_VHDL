library ieee;
use ieee.std_logic_1164.all;

entity GESTORDISPLAY_TB is
end GESTORDISPLAY_TB;

architecture TEST of GESTORDISPLAY_TB is

    component GESTORDISPLAY
        port (
            STD_VECTOR_IN  : in  std_logic_vector(27 downto 0);
            CATHODE_VECTOR : out std_logic_vector( 6 downto 0);
            DIGITSEL_N     : out std_logic_vector( 3 downto 0);
            CLK_IN         : in  std_logic  
        );
    end component;

    signal STD_VECTOR_IN  : std_logic_vector(27 downto 0);
    signal CATHODE_VECTOR : std_logic_vector( 6 downto 0);
    signal DIGITSEL_N     : std_logic_vector( 3 downto 0);
    signal CLK_IN         : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns; -- EDIT Put right period here

begin

    dut : GESTORDISPLAY
        port map (
            STD_VECTOR_IN  => STD_VECTOR_IN,
            CATHODE_VECTOR => CATHODE_VECTOR,
            DIGITSEL_N     => DIGITSEL_N,
            CLK_IN         => CLK_IN
        );

    -- Clock generation
    CLK_IN <= not CLK_IN after 0.5 * CLK_PERIOD;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        STD_VECTOR_IN <= (others => '0');
        STD_VECTOR_IN <= "1111111000000011100000001111";
        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        

        -- EDIT Add stimuli here
        wait for 9 * CLK_PERIOD;

        -- Stop the clock and hence terminate the simulation
        assert false
            report "[SUCCESS]: simulation finished."
            severity failure;
    end process;
end architecture TEST;
