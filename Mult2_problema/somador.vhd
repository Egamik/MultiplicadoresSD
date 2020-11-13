LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY somador IS
generic(N: natural:= 4);
PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
      s : OUT std_logic_vector(N-1 DOWNTO 0);
		cout: out std_logic);
END somador;

ARCHITECTURE estrutura OF somador IS
signal s1: std_logic_vector(N downto 0);

BEGIN
         S1 <= a+b;
			cout <= s1(n);
			--overflow <= '1' when a(n-1)=b(n-1) and s1(n-1)/=a(n-1) else '0';
			s <= S1;
END estrutura;