LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Displaying is
    port (
        SW0   : IN std_logic_vector(3 downto 0);

        HEX0  : OUT std_logic_vector(6 downto 0)
    );
end entity Displaying;

architecture rtl of Displaying is
    
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
    else "0001000" when SW0 = "1010"
    else (Others => '1');    

end architecture rtl;