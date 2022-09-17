LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY mem_top IS
	PORT
	(
		Address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Clock		: IN STD_LOGIC  := '1';
		DataIn		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Write		: IN STD_LOGIC ;
		DataOut		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

        HEX5, HEX4, HEX2, HEX0  : OUT std_logic_vector(6 downto 0) 
	);
END mem_top;


ARCHITECTURE STRUCTURAL OF mem_top IS
    COMPONENT ram32x4
    PORT
    (
        address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        clock		: IN STD_LOGIC  := '1';
        data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        wren		: IN STD_LOGIC ;
        q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
    END COMPONENT;

    component Displaying is
        port (
            SW0   : IN std_logic_vector(3 downto 0);
    
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    end component Displaying;

    signal Data_Out_signal, Address_signal : std_logic_vector(3 downto 0);
BEGIN
	
ram32x4_inst: ram32x4 port map (address => Address, clock => Clock, data => DataIn, wren =>	Write, q => Data_Out_signal);

DataOut <= Data_Out_signal;

Address_signal <= "000" & Address (4);

Display_Address1: Displaying PORT MAP (Address (3 downto 0), HEX4);
Display_Address2: Displaying PORT MAP (Address_signal, HEX5);
Display_Data_IN : Displaying PORT MAP (DataIn, HEX2);
Display_Data_OUT: Displaying PORT MAP (Data_Out_signal, HEX0);


END STRUCTURAL;