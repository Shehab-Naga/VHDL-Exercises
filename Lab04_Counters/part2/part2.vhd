library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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
           else (Others => '1');    

end architecture rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all, ieee.numeric_std.all;
ENTITY part2 IS
    PORT (
        En, Clock, Clear  : IN std_logic;
        Q     : OUT std_logic_vector (15 downto 0);
        HEX0, HEX1, HEX2, HEX3     : OUT std_logic_vector (6 downto 0)
    );
END part2;

ARCHITECTURE structure OF part2 IS
    COMPONENT Displaying
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
        END COMPONENT;
    SIGNAL Q_temp: std_logic_vector (15 downto 0);
BEGIN
    
    process (Clock)
    begin
        if rising_edge(Clock) then
            IF (Clear = '0') then
                Q_temp <= (others => '0');
            ELSIF En='0' then
                Q_temp <= Q_temp;
            ELSIF En='1' then
                Q_temp <= std_logic_vector(unsigned(Q_temp) + (0 => '1', 15 downto 1 => '0'));
            end if;
        end if;
    end process;
    Q <= Q_temp;

    Displaying_0: Displaying port map (SW0=> Q_temp(3 downto 0), HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> Q_temp(7 downto 4), HEX0=> HEX1);
    Displaying_2: Displaying port map (SW0=> Q_temp(11 downto 8), HEX0=> HEX2);
    Displaying_3: Displaying port map (SW0=> Q_temp(15 downto 12), HEX0=> HEX3);
END structure;