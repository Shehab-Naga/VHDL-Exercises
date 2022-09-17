LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity part1 is
    port (
        SW0, SW1   : IN std_logic_vector(3 downto 0);
        HEX0, HEX1 : OUT std_logic_vector(6 downto 0)
    );
end entity part1;

architecture rtl of part1 is
begin
    HEX0 <= "1000000" when SW0 = "0000"
       else "1111001" when SW0 = "0001"
       else "0100100" when SW0 = "0010"
       else "0110000" when SW0 = "0011"
       else "0011001" when SW0 = "0100"
       else "0010010" when SW0 = "0101"
       else "0000010" when SW0 = "0110"
       else "1111000" when SW0 = "0111"
       else "0000000" when SW0 = "1000"
       else "0010000" when SW0 = "1001"
       else (Others => '1');    
    
    HEX1 <= "1000000" when SW1 = "0000"
       else "1111001" when SW1 = "0001"
       else "0100100" when SW1 = "0010"
       else "0110000" when SW1 = "0011"
       else "0011001" when SW1 = "0100"
       else "0010010" when SW1 = "0101"
       else "0000010" when SW1 = "0110"
       else "1111000" when SW1 = "0111"
       else "0000000" when SW1 = "1000"
       else "0010000" when SW1 = "1001"
       else (Others => '1');
end architecture rtl;