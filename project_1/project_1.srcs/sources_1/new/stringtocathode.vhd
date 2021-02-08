library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stringtocathode is
port(
    STR_IN: in string(4 downto 1);
    STD_VECTOR_OUT: out std_logic_vector(27 downto 0)
);
end stringtocathode;

architecture Dataflow of stringtocathode is

begin
    WITH str_in(4) SELECT
        std_vector_out(27 downto 21) <=     "0000001" WHEN '0',
                                            "1001111" WHEN '1',
                                            "0010010" WHEN '2',
                                            "0000110" WHEN '3',
                                            "1001100" WHEN '4',
                                            "0100100" WHEN '5',
                                            "0100000" WHEN '6',
                                            "0001111" WHEN '7',
                                            "0000000" WHEN '8',
                                            "0000100" WHEN '9',
                                            "0001000" WHEN 'A',
                                            "0110001" WHEN 'C',
                                            "0000001" WHEN 'O',
                                            "1111010" WHEN 'R',
                                            "1110001" WHEN 'L',
                                            "1110000" WHEN 'T',
                                            "0110000" WHEN 'E',
                                            "1001000" WHEN 'H',
                                            "1000001" WHEN 'U',
                                            "0100001" WHEN 'G',
                                            "0100100" WHEN 'S',
                                            "1111001" WHEN 'I',
                                            "1101010" WHEN 'N',
                                            "0010010" WHEN 'Z',
                                            "1111111" WHEN ' ',
                                            "1111110" WHEN others;
                                            
    WITH str_in(3) SELECT
        std_vector_out(20 downto 14) <=     "0000001" WHEN '0',
                                            "1001111" WHEN '1',
                                            "0010010" WHEN '2',
                                            "0000110" WHEN '3',
                                            "1001100" WHEN '4',
                                            "0100100" WHEN '5',
                                            "0100000" WHEN '6',
                                            "0001111" WHEN '7',
                                            "0000000" WHEN '8',
                                            "0000100" WHEN '9',
                                            "0001000" WHEN 'A',
                                            "0110001" WHEN 'C',
                                            "0000001" WHEN 'O',
                                            "1111010" WHEN 'R',
                                            "1110001" WHEN 'L',
                                            "1110000" WHEN 'T',
                                            "0110000" WHEN 'E',
                                            "1001000" WHEN 'H',
                                            "1000001" WHEN 'U',
                                            "0100001" WHEN 'G',
                                            "0100100" WHEN 'S',
                                            "1111001" WHEN 'I',
                                            "1101010" WHEN 'N',
                                            "0010010" WHEN 'Z',
                                            "1111111" WHEN ' ',
                                            "1111110" WHEN others;
                                            
    WITH str_in(2) SELECT
        std_vector_out(13 downto 7) <=     "0000001" WHEN '0',
                                            "1001111" WHEN '1',
                                            "0010010" WHEN '2',
                                            "0000110" WHEN '3',
                                            "1001100" WHEN '4',
                                            "0100100" WHEN '5',
                                            "0100000" WHEN '6',
                                            "0001111" WHEN '7',
                                            "0000000" WHEN '8',
                                            "0000100" WHEN '9',
                                            "0001000" WHEN 'A',
                                            "0110001" WHEN 'C',
                                            "0000001" WHEN 'O',
                                            "1111010" WHEN 'R',
                                            "1110001" WHEN 'L',
                                            "1110000" WHEN 'T',
                                            "0110000" WHEN 'E',
                                            "1001000" WHEN 'H',
                                            "1000001" WHEN 'U',
                                            "0100001" WHEN 'G',
                                            "0100100" WHEN 'S',
                                            "1111001" WHEN 'I',
                                            "1101010" WHEN 'N',
                                            "0010010" WHEN 'Z',
                                            "1111111" WHEN ' ',
                                            "1111110" WHEN others;
                                            
    WITH str_in(1) SELECT
        std_vector_out(6 downto 0) <=     "0000001" WHEN '0',
                                            "1001111" WHEN '1',
                                            "0010010" WHEN '2',
                                            "0000110" WHEN '3',
                                            "1001100" WHEN '4',
                                            "0100100" WHEN '5',
                                            "0100000" WHEN '6',
                                            "0001111" WHEN '7',
                                            "0000000" WHEN '8',
                                            "0000100" WHEN '9',
                                            "0001000" WHEN 'A',
                                            "0110001" WHEN 'C',
                                            "0000001" WHEN 'O',
                                            "1111010" WHEN 'R',
                                            "1110001" WHEN 'L',
                                            "1110000" WHEN 'T',
                                            "0110000" WHEN 'E',
                                            "1001000" WHEN 'H',
                                            "1000001" WHEN 'U',
                                            "0100001" WHEN 'G',
                                            "0100100" WHEN 'S',
                                            "1111001" WHEN 'I',
                                            "1101010" WHEN 'N',
                                            "0010010" WHEN 'Z',
                                            "1111111" WHEN ' ',
                                            "1111110" WHEN others;
                                            
                              

end Dataflow;