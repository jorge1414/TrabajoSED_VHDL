library IEEE;
use IEEE.std_logic_1164.all;

entity STRINGTOCATHODE is
    port(
        STR_IN         : in  string(4 downto 1);
        STD_VECTOR_OUT : out std_logic_vector(27 downto 0)
    );
end STRINGTOCATHODE;

architecture DATAFLOW of STRINGTOCATHODE is
begin
    with STR_IN(4) select
        STD_VECTOR_OUT(27 downto 21) <=
            "0000001" when '0',
            "1001111" when '1',
            "0010010" when '2',
            "0000110" when '3',
            "1001100" when '4',
            "0100100" when '5',
            "0100000" when '6',
            "0001111" when '7',
            "0000000" when '8',
            "0000100" when '9',
            "0001000" when 'A',
            "0110001" when 'C',
            "0000001" when 'O',
            "1111010" when 'R',
            "1110001" when 'L',
            "1110000" when 'T',
            "0110000" when 'E',
            "1001000" when 'H',
            "1000001" when 'U',
            "0100001" when 'G',
            "0100100" when 'S',
            "1111001" when 'I',
            "1101010" when 'N',
            "0010010" when 'Z',
            "1111111" when ' ',
            "1111110" when '-',
            "1111110" when others;
                                            
    WITH STR_IN(3) SELECT
        STD_VECTOR_OUT(20 downto 14) <=
            "0000001" when '0',
            "1001111" when '1',
            "0010010" when '2',
            "0000110" when '3',
            "1001100" when '4',
            "0100100" when '5',
            "0100000" when '6',
            "0001111" when '7',
            "0000000" when '8',
            "0000100" when '9',
            "0001000" when 'A',
            "0110001" when 'C',
            "0000001" when 'O',
            "1111010" when 'R',
            "1110001" when 'L',
            "1110000" when 'T',
            "0110000" when 'E',
            "1001000" when 'H',
            "1000001" when 'U',
            "0100001" when 'G',
            "0100100" when 'S',
            "1111001" when 'I',
            "1101010" when 'N',
            "0010010" when 'Z',
            "1111111" when ' ',
            "1111110" when '-',
            "1111110" when others;
                                            
    with STR_IN(2) select
        STD_VECTOR_OUT(13 downto 7) <=
            "0000001" when '0',
            "1001111" when '1',
            "0010010" when '2',
            "0000110" when '3',
            "1001100" when '4',
            "0100100" when '5',
            "0100000" when '6',
            "0001111" when '7',
            "0000000" when '8',
            "0000100" when '9',
            "0001000" when 'A',
            "0110001" when 'C',
            "0000001" when 'O',
            "1111010" when 'R',
            "1110001" when 'L',
            "1110000" when 'T',
            "0110000" when 'E',
            "1001000" when 'H',
            "1000001" when 'U',
            "0100001" when 'G',
            "0100100" when 'S',
            "1111001" when 'I',
            "1101010" when 'N',
            "0010010" when 'Z',
            "1111111" when ' ',
            "1111110" when '-',
            "1111110" when others;
                                            
    with STR_IN(1) select
        STD_VECTOR_OUT(6 downto 0) <=
            "0000001" when '0',
            "1001111" when '1',
            "0010010" when '2',
            "0000110" when '3',
            "1001100" when '4',
            "0100100" when '5',
            "0100000" when '6',
            "0001111" when '7',
            "0000000" when '8',
            "0000100" when '9',
            "0001000" when 'A',
            "0110001" when 'C',
            "0000001" when 'O',
            "1111010" when 'R',
            "1110001" when 'L',
            "1110000" when 'T',
            "0110000" when 'E',
            "1001000" when 'H',
            "1000001" when 'U',
            "0100001" when 'G',
            "0100100" when 'S',
            "1111001" when 'I',
            "1101010" when 'N',
            "0010010" when 'Z',
            "1111111" when ' ',
            "1111110" when '-',
            "1111110" when others;
end DATAFLOW;
