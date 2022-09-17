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
           else "0000011" when SW0 = "1011"
           else "1000110" when SW0 = "1100"
           else "0100001" when SW0 = "1101"
           else "0000110" when SW0 = "1110"
           else "0001110" when SW0 = "1111"
           else (Others => '1');

end architecture rtl;

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
        Q     : OUT std_logic_vector (N-1 downto 0)
    );
END part1;

ARCHITECTURE structure OF part1 IS
    COMPONENT T_FF 
        port( T, Clear, Clock: in std_logic;
            Q: out std_logic);
    end COMPONENT;
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
END structure;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part4 IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		reset_n 	: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wraddress	: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q			: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5  : OUT std_logic_vector(6 downto 0)
	);
END part4;


ARCHITECTURE STRUCTURAL OF part4 IS
    COMPONENT ram32x4
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
    END COMPONENT;
    COMPONENT part1 IS
        GENERIC (N: integer := 8);
        PORT (
            En, Clk, Clear  : IN std_logic;
            Q     : OUT std_logic_vector (N-1 downto 0)
        );
    END COMPONENT;
    COMPONENT Displaying
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
	SIGNAL timer        : std_logic_vector (25 downto 0);
    SIGNAL counter_en   : std_logic;
    SIGNAL count        : std_logic_vector (4 downto 0);

	signal Data_Out_signal, READ_Address_signal, WRITE_Address_signal : std_logic_vector(3 downto 0);
BEGIN

    clock_divider   : part1         GENERIC map (N => 26)   port map (En=> '1'          , Clk => clock    , Clear=> reset_n, Q=> timer);
    counter         : part1         GENERIC map (N => 5)    port map (En=> counter_en   , Clk=> clock     , Clear=> reset_n, Q=> count);
    counter_en <=        '1' when timer = "10111110101111000010000000"
                    else '0';

	ram32x4_inst: ram32x4 port map (clock => clock, data => data, rdaddress => count, wraddress => wraddress, wren => wren, q => Data_Out_signal);

	q <= Data_Out_signal;

	READ_Address_signal <= "000" & count (4);
	WRITE_Address_signal <= "000" & wraddress (4);

	Display_Data_OUT: Displaying PORT MAP (Data_Out_signal, HEX0);
	Display_READ_Address1: Displaying PORT MAP (count (3 downto 0), HEX2);
	Display_READ_Address2: Displaying PORT MAP (READ_Address_signal, HEX3);
	Display_Data_IN : Displaying PORT MAP (data, HEX1);
	Display_WRITE_Address1: Displaying PORT MAP (wraddress (3 downto 0), HEX4);
	Display_WRITE_Address2: Displaying PORT MAP (WRITE_Address_signal, HEX5);
END STRUCTURAL;