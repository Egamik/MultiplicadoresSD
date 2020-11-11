LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY registrador_1 IS
generic(N: natural:= 3);
PORT (clk, carga : IN std_logic;
	  d : IN unsigned(N-1 DOWNTO 0);
	  q : OUT unsigned(N-1 DOWNTO 0));
END registrador_1;

ARCHITECTURE estrutura OF registrador_1 IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;