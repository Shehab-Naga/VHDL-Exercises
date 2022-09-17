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

    HEX0 <= "1000000" when SW0 = "0000"     -- 0
    else "1111001" when SW0 = "0001"        -- 1
    else "0100100" when SW0 = "0010"        -- 2
    else "0110000" when SW0 = "0011"        -- 3
    else "0011001" when SW0 = "0100"        -- 4
    else "0010010" when SW0 = "0101"        -- 5
    else "0000010" when SW0 = "0110"        -- 6
    else "1111000" when SW0 = "0111"        -- 7
    else "0000000" when SW0 = "1000"        -- 8
    else "0010000" when SW0 = "1001"        -- 9
    else (Others => '1');    


end architecture rtl;