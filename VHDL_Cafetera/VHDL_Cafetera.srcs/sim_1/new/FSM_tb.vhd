-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.12.2020 17:22:53 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_FSM is
end tb_FSM;

architecture tb of tb_FSM is

    component FSM
        port (SEL         : in std_logic;
              ENABLE      : in std_logic;
              MORE        : in std_logic;
              LESS        : in std_logic;
              OK          : in std_logic;
              RESET       : in std_logic;
              CLK         : in std_logic;
              TIEMPO_CAFE : out natural;
              LECHE       : out std_logic;
              AZUCAR      : out std_logic;
              LED_OK      : out std_logic);
    end component;

    signal SEL         : std_logic;
    signal ENABLE      : std_logic;
    signal MORE        : std_logic;
    signal LESS        : std_logic;
    signal OK          : std_logic;
    signal RESET       : std_logic;
    signal CLK         : std_logic;
    signal TIEMPO_CAFE : natural;
    signal LECHE       : std_logic;
    signal AZUCAR      : std_logic;
    signal LED_OK      : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : FSM
    port map (SEL         => SEL,
              ENABLE      => ENABLE,
              MORE        => MORE,
              LESS        => LESS,
              OK          => OK,
              RESET       => RESET,
              CLK         => CLK,
              TIEMPO_CAFE => TIEMPO_CAFE,
              LECHE       => LECHE,
              AZUCAR      => AZUCAR,
              LED_OK      => LED_OK);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SEL <= '0';
        ENABLE <= '0';
        MORE <= '0';
        LESS <= '0';
        OK <= '0';
        RESET <= '1';

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        wait for 50 ns;
        ENABLE <= '1';
        wait for 125 ns;
        MORE <= '1';
        wait for 50 ns;
        MORE <= '0';
        wait for 50 ns;
        MORE <= '1';
        wait for 50 ns;
        MORE <= '0';
        wait for 100 ns;
        
        LESS <= '1';
        wait for 50 ns;
        LESS <= '0';
        wait for 50 ns;
        LESS <= '1';
        wait for 50 ns;
        LESS <= '0';
        wait for 50 ns;
        
        OK <= '1';
        wait for 200 ns;
        OK <= '0';
        wait for 50 ns;
        OK <= '1';
        wait for 50 ns;
        OK <= '0';
        wait for 50 ns;
        OK <= '1';
        wait for 50 ns;
        OK <= '0';

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_FSM of tb_FSM is
    for tb
    end for;
end cfg_tb_FSM;