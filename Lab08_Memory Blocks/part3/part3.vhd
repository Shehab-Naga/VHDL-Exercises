LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part3 IS
	PORT
	(
		Address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Clock		: IN STD_LOGIC  := '1';
		DataIn		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Write		: IN STD_LOGIC ;
		DataOut		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

        HEX5, HEX4, HEX2, HEX0  : OUT std_logic_vector(6 downto 0) 
	);
END part3;

ARCHITECTURE Behaviour OF part3 IS
    TYPE mem IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL memory_array : mem := (others => (others => '0'));
    signal Data_Out_signal, Address_signal : std_logic_vector(3 downto 0);

    component Displaying is
        port (
            SW0   : IN std_logic_vector(3 downto 0);
    
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    end component Displaying;
BEGIN
	
    PROCESS (Clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (Write = '1') THEN
            memory_array(to_integer(unsigned(Address))) <= DataIn;
            END IF;
        END IF;
    END PROCESS;
    Data_Out_signal <= memory_array(to_integer(unsigned(Address)));

    DataOut <= Data_Out_signal;

    Address_signal <= "000" & Address (4);

    Display_Address1: Displaying PORT MAP (Address (3 downto 0), HEX4);
    Display_Address2: Displaying PORT MAP (Address_signal, HEX5);
    Display_Data_IN : Displaying PORT MAP (DataIn, HEX2);
    Display_Data_OUT: Displaying PORT MAP (Data_Out_signal, HEX0);
END Behaviour;