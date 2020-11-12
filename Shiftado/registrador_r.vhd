LIBRARY ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity registrador_r is
generic(N: natural := 4);
port (clk, darshift, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end registrador_r;

architecture estrutura OF registrador_r is

begin
	process(clk)
	begin
		if (clk'event and clk = '1' and carga = '1') then
			if (darshift = '1') then
			q <= std_logic_vector(shift_left(unsigned(d),1));
			else
			q <= d;
			end if;
		end if;
	end process;
end estrutura;