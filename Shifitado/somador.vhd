LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY somador IS
generic(N: natural:= 4);
PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
      s : OUT std_logic_vector(N-1 DOWNTO 0);
		overflow: out std_logic);
END somador;

ARCHITECTURE estrutura OF somador IS
signal s1: std_logic_vector(N downto 0);

BEGIN
         S1 <= ('0'&a)+('0'&b);
			overflow <= s1(N);
			s <= S1(N-1 downto 0);
END estrutura;