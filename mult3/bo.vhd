library IEEE;
use IEEE.std_logic_1164.all;

entity bo is
generic(n: natural:= 8);
port (entA, entB: in std_logic_vector(n-1 downto 0);
		srPH, srAA: in std_logic; -- shift_right
		m1: in std_logic; -- seletores mux
		result: out std_logic_vector(2n-1 downto 0)
		);
end entity;

architecture behav of bo is

component mux2para1 is
generic(N: natural:= 4);
  PORT ( a, b : IN unsigned(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT unsigned(N-1 DOWNTO 0));
end component;

component somadorsubtrator is
generic(N: natural:= 4);
PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      op: IN STD_LOGIC;
      s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
end component;

component registrador is
generic(N: natural:= 4);
PORT (clk, carga : IN std_logic;
	  d : IN unsigned(N-1 DOWNTO 0);
	  q : OUT unsigned(N-1 DOWNTO 0));
END component;

component registrador_r
generic(N: natural:= 4);
PORT (clk, sr, carga: IN std_logic;
	   d : IN unsigned(N-1 DOWNTO 0);
	   q : OUT unsigned(N-1 DOWNTO 0));
end component;		

component demux1para2 is
generic (n: natural := 8);
port (A: in std_logic_vector(n-1 downto 0);
		sel: in std_logic;
		Q, D: out std_logic_vector(n-1 downto 0)
		);
end component;
signal outA, outB, out_PH, out_mPH, outssA, outssB, outregContN: std_logic_vector(n-1 downto 0);
signal in_PL, out_demux0, out_demux1: std_logic_vector(n-1 downto 0);
signal inSS1, inSS2: std_logic_vector(n-1 downto 0); -- entrada do somador subtrator
signal zero, menos1: std_logic_vector(n-1 downto 0); -- sinais para operacao
signal ent_saida: std_logic_vector((2*n)-1 downto 0); -- saida final
begin
zero <= (others=>'0');
menos1 <= (n-1 downto 1 => '1') & '0';
in_PL <= out_PH(n-1) & (n-2 downto 0 => '0');

regA: registrador_r generic map(n-1), port map(clk, srAA, cA, entA, outA);
regB: registrador generic map(n-1), port map(clk, cB, entB, outB);
msomasub1: mux2para1 generic map(n-1), port map(outPH, menos1, m1, inSS1); -- mux do lado de A
msomasub2: mxu2para1 generic map(n-1), port map(outB, outregContN, m1, inSS2); -- mux do lado de B
mPH: mux2para1 generic map(n-1), port map(out_demux0, zero, sPH, out_mPH); -- mux em cima de PH
PH: registrador_r generic map(n-1), port map(clk srPH, cPH, out_mPH, outPH);
PL: registrador_r generic map(n-1); port map(clk, srPL, cPL, in_PL, out_PL);
saida: registrador generic map(2n - 1), port map()
end behav;
