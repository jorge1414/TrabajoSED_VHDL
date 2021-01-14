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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity fdivider is
port (
    reset:  in STD_LOGIC;
	clk_in: in STD_LOGIC;                              -- Señal de reloj de entrada
	clk_out: out STD_LOGIC                             -- Salida de reloj con cambio de estado a la frecuencia deseada
);
end fdivider;

architecture behavioral of fdivider is
--    constant freq_clk_ext: INTEGER := 100_000_000;    -- Frecuencia del reloj de la placa
--    constant freq_clk_out: INTEGER := 1;              -- Frecuencia deseada para la señal de salida
	constant max_count : INTEGER := 100_000_000;        -- Constante que simboliza todos los cambios de nuestro reloj de 100 MHz
	signal count: INTEGER range 0 to max_count;         -- Cuenta para cambiar el estado de nuestra salida una vez producidos todos los cambios del reloj de entrada
	signal clk_state: STD_LOGIC := '0';                 -- Señal para manejar el estado del reloj de salida
	
begin
	process(reset,clk_in, clk_state, count)
	begin
	    if reset ='1' then
	    count <= 0;
		elsif rising_edge(clk_in) then
			if count < max_count then              
				count <= count+1;
			else
				clk_state <= not clk_state;             
				count <= 0;
			end if;
		end if;
		clk_out <= clk_state;
end process;	
end architecture;


