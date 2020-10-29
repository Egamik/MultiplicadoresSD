LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity MultiplicadorT is 
generic(N: natural:= 4);
port(Rst, CLK, inicio: in std_logic;
	  entA, entB: in std_logic_vector(N-1 downto 0);
	  pronto: out std_logic;
	  saida, conteudoA, conteudoB: out std_logic_vector(N-1 downto 0));
end MultiplicadorT;

architecture bhv of MultiplicadorT is 

signal ini, CP, CA, dec, Az, Bz: std_logic;


	component bc IS
	PORT (Reset, clk, inicio : IN STD_LOGIC;
			Az, Bz : IN STD_LOGIC;
			pronto : OUT STD_LOGIC;
			ini, CA, dec, CP: OUT STD_LOGIC );
	END component;
	
	component bo is
	PORT (clk : IN STD_LOGIC;
			ini, CP, CA, dec : IN STD_LOGIC;
			entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Az, Bz : OUT STD_LOGIC;
			saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END component;

begin 

BC1: bc port map(RST, CLK, inicio, Az, BZ, pronto, ini, CA, dec, CP);
BO1: bo port map(CLK, ini, CP, CA, dec, entA, entB, Az, Bz, saida, conteudoA, conteudoB);


end bhv;







