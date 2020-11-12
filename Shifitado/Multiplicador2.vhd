LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Multiplicador2 is 
generic(N: natural:= 4);
port(Rst, CLK, inicio: in std_logic;
	  entA, entB: in std_logic_vector(N-1 downto 0);
	  pronto: out std_logic;
	  mult: out std_logic_vector(7 downto 0));
end Multiplicador2;

architecture bhv of Multiplicador2 is 

signal Az1, Bz1, contz1, Azero1, mPH1, mcont1, mFF1, cA1, cB1, ccont1, cmult1, srAA1, srPH1, cPH1, srPL1, cPL1 : std_logic;
signal mult1: std_logic_vector(7 downto 0);

 
	component bc is
	port (clk, rst, init: in std_logic;
		Az, Bz, contz, Azero: in std_logic;
		mPH, mcont, mFF : out std_logic; -- Sinais dos mux
		cA, cB, ccont, cmult: out std_logic; -- sinais dos registradores
		srAA, srPH, cPH, srPL, cPL: out std_logic;
		pronto: out std_logic
		);
	end component;
	
	component bo IS
	generic(N: natural:= 4);
	PORT (clk : IN std_logic;
      mPH, mcont, mFF : in std_logic; -- Sinais dos mux
		cA, cB, ccont, cmult: in std_logic; -- sinais dos registradores
		srAA, srPH, cPH, srPL, cPL: in std_logic;
      entA, entB : IN std_logic_vector(N-1 DOWNTO 0);
      Az, Bz, contz, Azero : OUT std_logic;
		mult: OUT std_logic_vector(7 downto 0));
	END component;


begin 

BC1: bc port map(CLK, Rst, inicio, Az1, Bz1, contz1, Azero1, mPH1, mcont1, mFF1, cA1, cB1, ccont1, cmult1, srAA1, srPH1, cPH1, srPL1, cPL1, pronto);
BO1: bo port map(CLK, mPH1, mcont1, mFF1, cA1, cB1, ccont1, cmult1, srAA1, srPH1, cPH1, srPL1, cPL1, entA, entB, Az1, Bz1, contz1, Azero1, mult1);

mult <= mult1;

end bhv;







