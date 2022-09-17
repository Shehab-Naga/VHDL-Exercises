LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY part2 IS
    PORT (  D, Clk : IN STD_LOGIC ;
            Q : OUT STD_LOGIC) ;
END part2 ;

ARCHITECTURE Behavior OF part2 IS
BEGIN
    PROCESS ( D, Clk )
    BEGIN
        IF Clk = '1' THEN
            Q <= D ;
        END IF ;
    END PROCESS ;
END Behavior ;
