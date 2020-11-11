LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY igualazero IS
generic(N: natural:= 4);
PORT (a : IN unsigned(N-1 DOWNTO 0);
igual : OUT std_logic);
END igualazero;

ARCHITECTURE estrutura OF igualazero IS
BEGIN
	igual <= '1' WHEN A = "0000" ELSE '0';
END estrutura;