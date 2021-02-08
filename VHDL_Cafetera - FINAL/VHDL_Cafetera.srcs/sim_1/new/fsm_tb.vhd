-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.12.2020 17:22:53 UTC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_TB is
end FSM_TB;

architecture TEST of FSM_TB is

    component FSM
        port (
            SEL : in std_logic;
            ENABLE : in std_logic;
            OK : in std_logic;
            CLK : in std_logic; 
            RST_N         : in  std_logic;
            COUNTER_EN    : out std_logic;
            FINAL_COUNTER: in std_logic;
            SALIDA_DISP_1 : out string(4 downto 1);
            SALIDA_DISP_2 : out string(4 downto 1);
            CORTO : out std_logic;
            LARGO : out std_logic;
            ESTADO_CAFE : out std_logic
        );
    end component;

    signal SEL           : std_logic;
    signal ENABLE        : std_logic;
    signal OK          : std_logic;
    signal RST_N         : std_logic;
    signal CLK           : std_logic := '0';
    signal COUNTER_EN    : std_logic;
    signal FINAL_COUNTER     : std_logic;
    signal SALIDA_DISP_1 : string(4 downto 1);
    signal SALIDA_DISP_2 : string(4 downto 1);
    signal CORTO :  std_logic;
    signal LARGO :  std_logic;
    signal ESTADO_CAFE :  std_logic;
    --signal LECHE       : std_logic;
    --signal AZUCAR      : std_logic;
    --signal ESTADO        : integer;
    --signal LED_OK      : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    dut: FSM
        port map (
            SEL           => SEL,
            ENABLE        => ENABLE,
            CORTO          => CORTO,
            LARGO          => LARGO,
            OK            => OK,
            RST_N         => RST_N,
            CLK           => CLK,
            FINAL_COUNTER => FINAL_COUNTER,
            COUNTER_EN    => COUNTER_EN,
            SALIDA_DISP_1 => SALIDA_DISP_1,
            SALIDA_DISP_2 => SALIDA_DISP_2
            --LECHE         => LECHE,
            --AZUCAR        => AZUCAR,
            --ESTADO        => ESTADO,
            --LED_OK        => LED_OK
        );

    -- Clock generation
    CLK <= not CLK after 0.5 * CLK_PERIOD;

    stimuli: process
    begin
        -- Reset generation
        RST_N <= '0' after 0.25 * CLK_PERIOD, '1' after 0.75 * CLK_PERIOD;
        wait until RST_N = '1';
      
        -- Inputs initialization
        SEL <= '0';
        ENABLE <= '0';
        OK <= '0';
        RST_N <= '1';

        -- ???
        wait for 5 * CLK_PERIOD;
        ENABLE <= '1';
        wait for 12.5 * CLK_PERIOD;
        
        SEL <= '1';
        wait for 5 * CLK_PERIOD;
        SEL <= '0';
        wait for 5 * CLK_PERIOD;
        
        
        OK <= '1';
        wait for 1 * CLK_PERIOD;
        OK <= '0';
        
        SEL <= '1';
        wait for 5 * CLK_PERIOD;
        SEL <= '0';
        wait for 5 * CLK_PERIOD;
        
        OK <= '1';
        wait for 1 * CLK_PERIOD;
        OK <= '0';
        wait for 5 * CLK_PERIOD;
        
        
        
        SEL <= '1';
        wait for 20 * CLK_PERIOD;
        SEL <= '0';
        wait for 20 * CLK_PERIOD;
        
        wait for 5 * CLK_PERIOD;
        OK <= '1';
        wait for 5 * CLK_PERIOD;
        OK <= '0';
        
        wait for 20 * CLK_PERIOD;
        FINAL_COUNTER <= '1';
        
        wait for 20 * CLK_PERIOD;

        -- EDIT Add stimuli here
        wait for 100 * CLK_PERIOD;

        -- Stop the clock and hence terminate the simulation
        assert false
            report "[SUCCESS]: simulation finished."
            severity failure;
    end process;
end TEST;
