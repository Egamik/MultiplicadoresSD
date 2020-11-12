LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY igualazero_c IS
generic(N: natural:= 3);
PORT (a : IN std_logic_vector(N-1 DOWNTO 0);
igual : OUT std_logic);
END igualazero_c;

ARCHITECTURE estrutura OF igualazero_c IS
BEGIN
	igual <= '1' WHEN A = "000" ELSE '0';
END estrutura;