----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 11:51:19
-- Design Name: 
-- Module Name: fdivider - Behavioral
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
-- El funcionamiento del divisor de frecuencia es almacenar en una señal el número de cambios realizados para poder así establecer los cambios de estado de la salida
-- en función del número de cambios de la señal de entrada. Nuestro reloj de la placa es de 100 Mhz, por lo que realizará 100x10e6 cambios en un segundo. 


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity FDIVIDER is
    generic (
        CLKIN_FREQ  : positive;  -- Frecuencia de entrada
        CLKOUT_FREQ : positive   -- Frecuencia de salida
    );
    port (
        RST_N  : in  std_logic;  -- reset negado asíncrono
        CLK_IN : in  std_logic;  -- señal de reloj de entrada
        CLK_OUT: out std_logic   -- salida de reloj con cambio de estado a la frecuencia deseada
    );
end FDIVIDER;

architecture BEHAVIORAL of FDIVIDER is
	signal clk_state : std_logic;  -- Señal para manejar el estado del reloj de salida
begin
	process (RST_N, CLK_IN)
        subtype count_t is integer range 0 to CLKIN_FREQ / (2 * CLKOUT_FREQ) - 1;
	    variable count : count_t;    -- Cuenta para cambiar el estado de nuestra salida una vez producidos todos los cambios del reloj de entrada
	begin
	    if RST_N ='0' then
	       count := count_t'high;
           clk_state <= '0';	       
		elsif rising_edge(CLK_IN) then
            if count /= 0 then              
				count := count - 1;
			else
	            count := count_t'high;
                clk_state <= not clk_state;	       
			end if;
		end if;
    end process;	
    clk_out <= clk_state;
end architecture;


