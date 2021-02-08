library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_cuentatiempo is
end tb_cuentatiempo;

architecture tb of tb_cuentatiempo is

    component cuentatiempo
        port (CLK          : in std_logic;
              RESET        : in std_logic;
              MAS          : in std_logic;
              MENOS        : in std_logic;
              CORTO        : in std_logic;
              LARGO        : in std_logic;
              ESTADO_CAFE  : in std_logic;
              T_OUT        : out unsigned (7 downto 0);
              ENTRADA_DISP : in string (4 downto 1);
              SALIDA_DISP  : out string (4 downto 1));
    end component;

    signal CLK          : std_logic;
    signal RESET        : std_logic;
    signal MAS          : std_logic;
    signal MENOS        : std_logic;
    signal CORTO        : std_logic;
    signal LARGO        : std_logic;
    signal ESTADO_CAFE  : std_logic;
    signal T_OUT        : unsigned (7 downto 0);
    signal ENTRADA_DISP : string (4 downto 1);
    signal SALIDA_DISP  : string (4 downto 1);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : cuentatiempo
    port map (CLK          => CLK,
              RESET        => RESET,
              MAS          => MAS,
              MENOS        => MENOS,
              CORTO        => CORTO,
              LARGO        => LARGO,
              ESTADO_CAFE  => ESTADO_CAFE,
              T_OUT        => T_OUT,
              ENTRADA_DISP => ENTRADA_DISP,
              SALIDA_DISP  => SALIDA_DISP);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        MAS <= '0';
        MENOS <= '0';
        CORTO <= '0';
        LARGO <= '0';
        ESTADO_CAFE <= '0';
        ENTRADA_DISP <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        ESTADO_CAFE <= '1';
        wait for 5 * TbPeriod;
        CORTO <= '1';
        wait for 5 * TbPeriod;
        
        MAS <= '1';
        wait for 1 * TbPeriod;
        MAS <= '0';
        wait for 5 * TbPeriod;
        MAS <= '1';
        wait for 1 * TbPeriod;
        MAS <= '0';
        wait for 5 * TbPeriod;
        
        MENOS <= '1';
        wait for 1 * TbPeriod;
        MENOS <= '0';
        wait for 5 * TbPeriod;
        MENOS <= '1';
        wait for 1 * TbPeriod;
        MENOS <= '0';
        wait for 5 * TbPeriod;
        
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cuentatiempo of tb_cuentatiempo is
    for tb
    end for;
end cfg_tb_cuentatiempo;
