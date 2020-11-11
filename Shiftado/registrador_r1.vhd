LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


ENTITY registrador_r1 IS
generic(N: natural:= 4);
PORT (clk, sr, carga: IN std_logic;
	   e,d: IN unsigned(N-1 DOWNTO 0);
	   q : OUT unsigned(N-1 DOWNTO 0));
END registrador_r1;

ARCHITECTURE estrutura OF registrador_r1 IS
signal x: unsigned(N-1 downto 0);

BEGIN
	x <= (e(0) or d(N-1)) & d(N-2 downto 0); 

	PROCESS(clk, sr)
	BEGIN
		IF(sr = '1') THEN
			q <= d;
		ELSIF(clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= x srl 1;
		END IF;
	END PROCESS;
END estrutura;