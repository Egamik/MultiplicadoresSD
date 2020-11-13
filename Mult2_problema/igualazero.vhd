LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY igualazero IS
generic(N: natural:= 4);
PORT (a : IN std_logic_vector(N-1 DOWNTO 0);
igual : OUT std_logic);
END igualazero;

ARCHITECTURE estrutura OF igualazero IS
signal zero: std_logic_vector(n-1 downto 0) := (others=>'0');
BEGIN
	igual <= '1' WHEN A = zero ELSE '0';
END estrutura;