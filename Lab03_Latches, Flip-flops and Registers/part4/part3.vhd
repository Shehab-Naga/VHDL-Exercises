LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY part3 IS
    PORT (  D, Clk : IN STD_LOGIC ;
            Q : OUT STD_LOGIC) ;
END part3;

ARCHITECTURE Behavior OF part3 IS
BEGIN
    PROCESS (Clk)
    BEGIN
        IF rising_edge(Clk) THEN
            Q <= D ;
        END IF ;
    END PROCESS ;
END Behavior ;
