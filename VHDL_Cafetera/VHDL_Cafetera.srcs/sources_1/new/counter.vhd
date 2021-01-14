----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2021 11:11:19
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           TIEMPO_in : unsigned  (7 downto 0);
           COUNT : out STD_LOGIC_VECTOR (7 downto 0);
           led_out: out STD_LOGIC
           );
end counter;

architecture Behavioral of counter is
-- Señal de tiempo para el contador
signal reg: unsigned (7 downto 0);        -- Declaramos unsigned para respetar la arquitectura de registros little endian
signal led_r: std_logic;
begin
    led_out <= clk when reg < tiempo_in else 
               '0';
                  
    
    process(CLK,CLR)
    begin

       if CLR = '1' then
        reg <= (others =>'0');                          -- Usamos el agregado para que sea parametrizable
       elsif rising_edge(CLK) then
           if reg < tiempo_in then
            reg <= reg +1;
            
           end if;
       end if;
    end process;
    
--    led: process (clk,clr)
--    begin
    
----    if CLR = '1' then
----        led_r <= '0';
----       elsif clk'event then
----       if reg < tiempo_in then
----        led_r <= not(led_r);
----        else
----        led_r <= '0';
----       end if;
----       end if;
    
    
--    end process;
    count <= std_logic_vector(reg);
end Behavioral;
