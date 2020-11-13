library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;

entity bo is
generic(n : natural := 8;
			i : natural := 4); -- Pro lado de CONT log2(n) + 1
port( clk, cPH, cPL, cA, cB, cCont, cMult : in std_logic; -- Carga dos registradores
		shPH, shPL, shA : in std_logic;	-- Shift dos registradores
		mPH, mFF, mCont : in std_logic; -- Controle dos mux
		entA, entB : in std_logic_vector(n-1 downto 0);
		Az, Alsb, Bz, ContZ: out std_logic;	 -- Sinais pro BC
		saida : out std_logic_vector(n-1 downto 0)
		);
end entity;

architecture behav of bo is

component registrador
generic(N: natural:= 4);
PORT (clk, carga : IN std_logic;
	  d : IN std_logic_vector(N-1 DOWNTO 0);
	  q : OUT std_logic_vector(N-1 DOWNTO 0));
end component;

component registrador_sh is
generic(N: natural:= 4);
PORT (clk, carga, in_shift, shift: IN std_logic;
	  d : IN std_logic_vector(N-1 DOWNTO 0);
	  q : OUT std_logic_vector(N-1 DOWNTO 0);
	  out_shift : out std_logic);
end component;

component igualazero is
generic(N: natural:= 4);
PORT (a : IN std_logic_vector(N-1 DOWNTO 0);
igual : OUT std_logic);
end component;

component somador is
generic(N: natural:= 4);
PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
      s : OUT std_logic_vector(N-1 DOWNTO 0);
		cout: out std_logic);
end component;

component subtrator is
generic(N : natural := 4);
PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
      s : OUT std_logic_vector(N-1 DOWNTO 0));
end component;

component mux2para1 is
generic(N: natural:= 4);
  PORT ( a, b : IN std_logic_vector(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT std_logic_vector(N-1 DOWNTO 0));
end component;

component mux21_1bit is
  PORT ( a, b : IN std_logic;
         sel: IN std_logic;
         y : OUT std_logic);
end component;
  

component flipflop is
port (clk, D : in std_logic;
      Q : out std_logic);
end component;

signal zero : std_logic_vector(n-1 downto 0) := (others => '0');
signal um : std_logic_vector(i-1 downto 0) := (others => '0');
signal saiSoma, saiMPH, saiPH, saiPL, saiA, saiB: std_logic_vector(n-1 downto 0);
signal entCont, saiCont, saiSub: std_logic_vector(i-1 downto 0);
signal cout, saiMFF, saiFF, saiPHsh : std_logic;
signal dontcare : std_logic;

begin
	Alsb <= saiA(0);
	entCont <= std_logic_vector(to_unsigned(n, entCont'length));
	um(0) <= '1';
	-- Multiplexadores
	muxPH: mux2para1 generic map(n) port map(saiSoma, zero, mPH, saiMPH);
	muxCont: mux2para1 generic map(i) port map(saiSub, um, mCont, entCont);
	muxFF: mux21_1bit port map(cout, '0', mFF, saiFF);
	-- Registradores com shift right
	PH: registrador_sh generic map(n) port map(clk, cPH, shPH, saiFF, saiMPH, saiPH, saiPHsh);
	PL: registrador_sh generic map(n) port map(clk, cPL, shPL, saiPHsh, zero, saiPL, dontcare);
	A: registrador_sh generic map (n) port map(clk, cA, '0', shA, entA, saiA, dontcare);
	B: registrador generic map(n) port map(clk, cB, entB, saiB);
	cont: registrador generic map(i) port map(clk, cCont, entCont, saiCont);
	-- Comparadores com 0
	Azero: igualazero generic map(n) port map(saiA, Az);
	Bzero: igualazero generic map(n) port map(saiB, Bz);
	Contzero: igualazero generic map(i) port map(saiCont, ContZ);
	-- Somador e Subtrator
	Soma: somador generic map(n) port map(saiPH, saiB, saiSoma, cout);
	Subt: subtrator generic map(i) port map(saiCont, um, saiSub);
	-- Flip Flop
	FF: flipflop port map(clk, saiMFF, saiFF);
	
end behav;