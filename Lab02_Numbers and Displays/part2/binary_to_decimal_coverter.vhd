----------------------------------------------------
--     Lab2 Part 2: binary_to_decimal_coverter    --
----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity binary_to_decimal_coverter is
    port (
        V   : IN std_logic_vector(3 downto 0);
        d0, d1 : OUT std_logic_vector(6 downto 0)
    );
end entity binary_to_decimal_coverter;

architecture behavior of binary_to_decimal_coverter is
    signal z : std_logic;    
begin
    process (V) is 
    begin

        if (V > "1001") then
            z <= '1';
        else 
            z <= '0';
        end if;

        if (z = '1') then 
            d1 <= "1111001";
            case V is
                when "1010" =>
                    d0 <= "1000000";
                when "1011" =>
                    d0 <= "1111001";
                when "1100" =>
                    d0 <= "0100100";
                when "1101" =>
                    d0 <= "0110000";
                when "1110" =>
                    d0 <= "0011001";
                when "1111" =>
                    d0 <= "0010010";
                when others => 
                    d0 <= (others => '1');
            end case;
        else 
            d1 <= "1000000";
            case V is
                when "0000" =>
                    d0 <= "1000000";
                when "0001" =>
                    d0 <= "1111001";
                when "0010" =>
                    d0 <= "0100100";
                when "0011" =>
                    d0 <= "0110000";
                when "0100" =>
                    d0 <= "0011001";
                when "0101" =>
                    d0 <= "0010010";
                when "0110" =>
                    d0 <= "0000010";
                when "0111" =>
                    d0 <= "1111000";
                when "1000" =>
                    d0 <= "0000000";
                when "1001" =>
                    d0 <= "0010000";
                when others => 
                    d0 <= (others => '1');
            end case;
        end if;
   end process;
end architecture behavior;