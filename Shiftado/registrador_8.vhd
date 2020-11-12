LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY registrador_8 IS
generic(N: natural:= 8);
PORT (clk, carga : IN std_logic;
	  d : IN std_logic_vector(N-1 DOWNTO 0);
	  q : OUT std_logic_vector(N-1 DOWNTO 0));
END registrador_8;

ARCHITECTURE estrutura OF registrador_8 IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;