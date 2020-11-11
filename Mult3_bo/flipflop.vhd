LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity flipflop is
generic(N: natural := 8);
port (clk, D : in std_logic;
	  Q : out std_logic);
end flipflop;

ARCHITECTURE estrutura OF flipflop IS

BEGIN
	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			Q <= D;
		END IF;
	END PROCESS;
END estrutura;