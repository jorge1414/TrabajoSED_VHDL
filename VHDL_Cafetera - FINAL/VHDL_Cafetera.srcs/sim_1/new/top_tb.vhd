-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.12.2020 17:22:53 UTC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOP_TB is
end TOP_TB;

architecture TEST of TOP_TB is

    procedure wait_for_n_ticks(ticks : positive; signal clk : std_logic) is
    begin
        for i in 1 to ticks loop
            wait until clk = '1';
        end loop;
    end procedure;

    procedure pulse_for(signal s : inout std_logic; duration : time; delay : time := 0 ns; negated : boolean := false) is
        variable s_prv : std_logic;
    begin
        wait for delay;
        s_prv := s;
        if negated then
            s <= '0';
        else 
            s <= '1';
        end if;
        wait for duration;
        s <= s_prv;
    end procedure;

    component TOP is
        generic (
            CLKIN_FREQ : positive := 100_000_000
        );
        port(
            CLK100MHZ  : in  std_logic;
            CPU_RESETN : in  std_logic;
            BTNC       : in  std_logic;
            BTNU       : in  std_logic;
            BTND       : in  std_logic;
            SW         : in  std_logic_vector(1 downto 0);
            CA, CB, CC : out std_logic;
            CD, CE, CF : out std_logic;
            CG         : out std_logic;
            AN         : out std_logic_vector(7 downto 0);
            LED        : out std_logic_vector(0 downto 0)
        );
    end component TOP;

    -- Inputs
    signal CLK      : std_logic := '0';
    signal RST_N    : std_logic;
    signal BTN_OK   : std_logic;
    signal BTN_MR   : std_logic;
    signal BTN_LS   : std_logic;
    signal SLCT     : std_logic;
    signal ENABLE   : std_logic;

    -- Outputs
    signal SEGMENTS : std_logic_vector(6 downto 0);
    signal AN       : std_logic_vector(7 downto 0);
    signal LED      : std_logic_vector(0 downto 0);

    signal SW : std_logic_vector(1 downto 0);

    constant CLKIN_FREQ : positive := 4_000;  -- 4 kHz clock for sim
    constant CLK_PERIOD : time := 1 sec / CLKIN_FREQ;

begin
    SW <= ENABLE & SLCT;

    dut: TOP
        generic map (
            CLKIN_FREQ => CLKIN_FREQ
        )
        port map (
            CLK100MHZ  => CLK,
            CPU_RESETN => RST_N,
            BTNC       => BTN_OK,
            BTNU       => BTN_MR,
            BTND       => BTN_LS,
            SW         => SW,
            CA         => SEGMENTS(0),
            CB         => SEGMENTS(1),
            CC         => SEGMENTS(2),
            CD         => SEGMENTS(3),
            CE         => SEGMENTS(4),
            CF         => SEGMENTS(5),
            CG         => SEGMENTS(6),
            AN         => AN,
            LED        => LED
        );

    -- Clock generation
    CLK <= not CLK after 0.5 * CLK_PERIOD;

    stimuli: process
    begin
        -- Reset
        RST_N <= '1';
        pulse_for(RST_N, 100 ms, 30 ms, true);

        -- Input initalization
        SLCT   <= '0';
        ENABLE <= '1';
        BTN_MR <= '0';
        BTN_LS <= '0';
        BTN_OK <= '0';

        -- Push twice "MORE" button
        pulse_for(BTN_MR, 100 ms, 100 ms);
        pulse_for(BTN_MR, 100 ms, 100 ms);

        -- Push twice "LESS" button
        pulse_for(BTN_LS, 100 ms, 200 ms);
        pulse_for(BTN_LS, 100 ms, 100 ms);

        -- Push twice "OK" button
        pulse_for(BTN_OK, 100 ms, 200 ms);
        pulse_for(BTN_OK, 100 ms, 100 ms);
        pulse_for(BTN_OK, 100 ms, 100 ms);

        wait for 15 sec;
        assert false
            report "[SUCCESS]: simulation finished."
            severity failure;
    end process;
end TEST;
