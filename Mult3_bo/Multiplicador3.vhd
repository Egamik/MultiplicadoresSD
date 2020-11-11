LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity Multiplicador3 is
generic(N: natural := 8);
port( Inicio,Reset,Clk : in std_logic;
		EntA,EntB : in std_logic_vector(N-1 downto 0);
		Saida : out std_logic_vector(N-1 downto 0);
		Pronto : out std_logic);
end Multiplicador3;

architecture comportamento of Multiplicador3 is

begin

end comportamento;