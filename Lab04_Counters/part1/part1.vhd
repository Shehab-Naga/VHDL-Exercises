library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity T_FF is
    port( T, Clear, Clock: in std_logic;
        Q: out std_logic);
end T_FF;
 
architecture Behavioral of T_FF is
    signal  tmp: std_logic;
begin
    process (Clock)
    begin
        if rising_edge(Clock) then
            IF (Clear = '0') then
                tmp <= '0';
            ELSIF T='0' then
                tmp <= tmp;
            ELSIF T='1' then
                tmp <= not (tmp);
            end if;
        end if;
    end process;
    Q <= tmp;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part1 IS
    GENERIC (N: integer := 8);
    PORT (
        En, Clk, Clear  : IN std_logic;
        Q     : OUT std_logic_vector (N-1 downto 0);
        HEX0, HEX1     : OUT std_logic_vector (6 downto 0)
    );
END part1;

ARCHITECTURE structure OF part1 IS
    COMPONENT T_FF 
        port( T, Clear, Clock: in std_logic;
            Q: out std_logic);
    end COMPONENT;
    COMPONENT Displaying
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
        END COMPONENT;
    SIGNAL Q_temp, T_temp: std_logic_vector (N-1 downto 0);
BEGIN
    T_FF_0: T_FF port map (T=> En, Clear=>Clear, Clock=>Clk, Q=>Q_temp(0));
    Q(0) <= Q_temp(0);
    T_temp(0) <= Q_temp(0) AND En;
    GENERATE_LOOP: for i in 1 to N-2 GENERATE
                        T_FF_INST: T_FF port map(T=>T_temp(i-1), Clear=> Clear, Clock=>Clk, Q=>Q_temp(i));
                        Q(i) <= Q_temp(i);
                        T_temp(i) <= Q_temp(i) AND T_temp(i-1);
                    END GENERATE;
    T_FF_N: T_FF port map(T=>T_temp(N-2), Clear=> Clear, Clock=>Clk, Q=>Q_temp(N-1));
    Q(N-1)<= Q_temp(N-1);
    Displaying_0: Displaying port map (SW0=> Q_temp(3 downto 0), HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> Q_temp(7 downto 4), HEX0=> HEX1);
END structure;