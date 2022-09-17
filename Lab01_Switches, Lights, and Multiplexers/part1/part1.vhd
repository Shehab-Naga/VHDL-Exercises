LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- Simple entity that connects the SW switches to the LEDR lights
ENTITY part1 IS
PORT ( SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
LEDR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END part1;
ARCHITECTURE Behavior OF part1 IS
BEGIN
LEDR <= SW;
END Behavior;