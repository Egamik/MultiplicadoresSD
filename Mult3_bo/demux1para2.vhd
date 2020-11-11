library ieee;
use ieee.std_logic_1164.all;

entity demux1para2 is
generic(N: natural := 8);
  port ( d : in std_logic_vector(N-1 downto 0);
         sel: in std_logic;
         s1,s2 : out std_logic_vector(N-1 downto 0));
  end demux1para2;

architecture comportamento of demux1para2 is
begin
process (sel,d)
	begin
	if (sel = '0') then
	s1 <= d;
	else
	s2 <= d;
	end if;
	end process;
end comportamento;