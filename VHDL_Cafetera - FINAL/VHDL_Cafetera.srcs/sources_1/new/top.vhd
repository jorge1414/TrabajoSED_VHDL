----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2021 14:05:28
-- Design Name: 
-- Module Name: TOP - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TOP is
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
        LED_SERVICIO    : out std_logic;
        LED_LECHE    : out std_logic;
        LED_AZUCAR    : out std_logic;
        LED_ENABLE     : out std_logic
    );
end TOP;

architecture STRUCTURAL of TOP is

    constant SYSCLK_FREQ : positive := 1_000;  -- System clock frequency

    -- DIVISOR DE FRECUENCIA CONTADOR
    component FDIVIDER is
        generic (
            CLKIN_FREQ  : positive;
            CLKOUT_FREQ : positive
        );
        port (
            RST_N   : in  std_logic;
            CLK_IN  : in  std_logic;
            CLK_OUT : out std_logic
        );
    end component;

    -- SINCRONIZADOR
    component SINCRONIZADOR is
        port (
            CLK      : in  std_logic;
            MORE_IN  : in  std_logic;
            LESS_IN  : in  std_logic;
            OK_IN    : in  std_logic;
            MORE_OUT : out std_logic;
            LESS_OUT : out std_logic;
            OK_OUT   : out std_logic
        );
    end component;

    -- DETECTOR DE FLANCO
    component DETECTOR_FLANCO is
        port (
            -- Inputs
            CLK      : in  std_logic;
            MORE_IN  : in  std_logic;
            LESS_IN  : in  std_logic;
            OK_IN    : in  std_logic;
            -- Outputs
            MORE_OUT : out std_logic;
            LESS_OUT : out std_logic;
            OK_OUT   : out std_logic 
         );
    end component;

    -- FSM
    component FSM is
        port(
            SEL           : in  std_logic;
            ENABLE        : in  std_logic;
            OK            : in  std_logic;
            RST_N         : in  std_logic;
            CLK           : in  std_logic;
            FINAL_COUNTER : in std_logic;
            COUNTER_EN    : out std_logic;
            SALIDA_DISP_1 : out string(4 downto 1);
            SALIDA_DISP_2 : out string(4 downto 1);
            LED_LECHE:      out std_logic;
            LED_AZUCAR:     out std_logic;
            LED_ENABLE:     out std_logic;
            CORTO           : out std_logic;
            LARGO           : out std_logic;
            ESTADO_CAFE     : out std_logic  
        );
    end component;

    --CUENTA TIEMPO
    
    component CUENTATIEMPO is 
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            MAS: in std_logic;
            MENOS: in std_logic;
            CORTO: in std_logic;
            LARGO: in std_logic;
            ESTADO_CAFE: in std_logic;
            T_OUT: out unsigned(7 downto 0);
            ENTRADA_DISP: in string (4 downto 1);
            SALIDA_DISP: out string(4 downto 1)
         );
     end component;


    -- CONTADOR
    component COUNTER is
        Port (
            CLK       : in std_logic;
            CLR_N     : in std_logic;
            TIEMPO_IN : unsigned(7 downto 0);
            ENABLE    : in  std_logic;
            FINAL_COUNTER: out std_logic;
            LED_OUT   : out std_logic
        );
    end component;

    -- DECODER
    component STRINGTOCATHODE is
        port(
            STR_IN         : in  string(4 downto 1);
            STD_VECTOR_OUT : out std_logic_vector(27 downto 0)
        );
    end component;

    -- GESTOR DE DISPLAYS
    component GESTORDISPLAY is
        port(
            STD_VECTOR_IN_1  : in  std_logic_vector(27 downto 0);
            STD_VECTOR_IN_2  : in  std_logic_vector(27 downto 0);
            CATHODE_VECTOR : out std_logic_vector(6 downto 0);
            DIGITSEL     : out std_logic_vector(7 downto 0);
            CLK_IN         : in  std_logic  
        );
    end component;

    -- Input aliases
    alias MORE_BTTN  : std_logic is BTNU;
    alias LESS_BTTN  : std_logic is BTND;
    alias OK_BTTN    : std_logic is BTNC;
    alias SEL_SWITCH : std_logic is SW(1);
    alias ENABLE     : std_logic is SW(0);

    -- Output aliases
    alias DIGITSEL   : std_logic_vector(7 downto 0) is AN;

    signal CATHODE_OUT: std_logic_vector(6 downto 0);

    -- Reloj del sistema
    signal sysclk : std_logic;

    -- Outputs Sincronizador
    signal more_sync : std_logic;
    signal less_sync : std_logic;
    signal ok_sync   : std_logic;

    -- Outputs Detector de flanco
    signal more_edge : std_logic;
    signal less_edge : std_logic;
    signal ok_edge   : std_logic;

    -- Outputs FSM
    signal salida_disp_1  : string(4 downto 1);
    signal salida_disp_2  : string(4 downto 1);
    signal tiempo_out     : unsigned(7 downto 0);
    signal counter_enable : std_logic;
    signal corto          : std_logic;
    signal largo          : std_logic;
    signal estado_cafe    : std_logic;
    
    --Outputs Counter
    signal final_counter: std_logic;
    
    -- Outputs CuentaTiempo
    signal salida_disp_2_CT : string (4 downto 1);
    

    -- Outputs StringtoCathode
    signal std_vector_out1: std_logic_vector(27 downto 0);
    signal std_vector_out2: std_logic_vector(27 downto 0);

begin
    --(CG, CF, CE, CD, CC, CB, CA)<= CATHODE_OUT;
    (CA, CB, CC, CD, CE, CF, CG)<= CATHODE_OUT;
    LED_ENABLE <= ENABLE;

    prescaler0: FDIVIDER
        generic map (
            CLKIN_FREQ  => CLKIN_FREQ,
            CLKOUT_FREQ => SYSCLK_FREQ
        )
        port map (
            RST_N   => CPU_RESETN,
            CLK_IN  => CLK100MHZ,
            CLK_OUT => sysclk
        );

    syncro0: SINCRONIZADOR
        port map (
            CLK      => sysclk,
            MORE_IN  => MORE_BTTN,
            LESS_IN  => LESS_BTTN,
            OK_IN    => OK_BTTN,
            MORE_OUT => more_sync,
            LESS_OUT => less_sync,
            OK_OUT   => ok_sync
        ); 

    edgedtctr0: DETECTOR_FLANCO
        port map (
            CLK      => sysclk,
            MORE_IN  => more_sync,
            LESS_IN  => less_sync,
            OK_IN    => ok_sync,
            MORE_OUT => more_edge,
            LESS_OUT => less_edge,
            OK_OUT   => ok_edge
        );

    fsm0: FSM
        port map (
            CLK           => sysclk,
            RST_N         => CPU_RESETN,
            SEL           => SEL_SWITCH,
            ENABLE        => ENABLE,
            OK            => ok_edge,
            COUNTER_EN    => counter_enable,
            FINAL_COUNTER => final_counter,
            SALIDA_DISP_1 => salida_disp_1,
            SALIDA_DISP_2 => salida_disp_2,
            CORTO         => corto,
            LARGO         => largo,
            ESTADO_CAFE   => estado_cafe,
            LED_ENABLE   =>  LED_ENABLE,
            LED_AZUCAR   =>  LED_AZUCAR,
            LED_LECHE   =>  LED_LECHE
        );

    cuentatiempo0: CUENTATIEMPO
        port map(
            CLK             => sysclk,
            RESET           => CPU_RESETN,
            MAS             => more_edge,
            MENOS           => less_edge,
            CORTO           => corto,
            LARGO           => largo,
            ESTADO_CAFE     => estado_cafe,
            T_OUT           => tiempo_out,
            ENTRADA_DISP    => salida_disp_2,
            SALIDA_DISP     => salida_disp_2_CT
         );
    

    cntr0: COUNTER
        port map (
            CLK       => sysclk,
            CLR_N     => CPU_RESETN,
            ENABLE    => counter_enable,
            FINAL_COUNTER => final_counter,
            TIEMPO_IN => tiempo_out,
            LED_OUT   => LED_SERVICIO
        );

    stringtocathode0: STRINGTOCATHODE
        port map (
            STR_IN         => salida_disp_1,
            STD_VECTOR_OUT => std_vector_out1
        );
        
    stringtocathode1: STRINGTOCATHODE
        port map (
            STR_IN         => salida_disp_2_CT,
            STD_VECTOR_OUT => std_vector_out2
        );

    gestordisplay0: GESTORDISPLAY
        port map (
            CLK_IN         => sysclk,
            STD_VECTOR_IN_1  => std_vector_out1,
            STD_VECTOR_IN_2  => std_vector_out2,
            CATHODE_VECTOR => CATHODE_OUT,
            DIGITSEL       => DIGITSEL
        );
        

end STRUCTURAL;
