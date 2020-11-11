LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


ENTITY registrador_r IS
generic(N: natural:= 4);
PORT (clk, sr, carga: IN std_logic;
	   d : IN unsigned(N-1 DOWNTO 0);
	   q : OUT unsigned(N-1 DOWNTO 0));
END registrador_r;

ARCHITECTURE estrutura OF registrador_r IS
BEGIN
	PROCESS(clk, sr)
	BEGIN
		IF(sr = '1') THEN
			q <= "0000";
		ELSIF(clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d srl 1;
		END IF;
	END PROCESS;
END estrutura;