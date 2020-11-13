library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;

entity Mult2 is
port (clk, init : in std_logic;
		pronto : out std_logic;
		mult : out std_logic_vector(7 downto 0));
end entity;

architecture behav of Mult2 is

component bc is
generic (n : natural := 8;
			i : natural := 4);
port (clk, init : in std_logic;
		Az, Bz, ContZ, Alsb: in std_logic;
		cPH, cPL, cA, cB, cCont, cMult : out std_logic; -- Carga dos registradores
		shPH, shPL, shA : out std_logic;	-- Shift dos registradores
		mPH, mFF, mCont : out std_logic; -- Controle dos mux
		pronto : out std_logic
		);	
end component;

component bo is
generic(n : natural := 8;
			i : natural := 4); -- Pro lado de CONT log2(n) + 1
port( clk, cPH, cPL, cA, cB, cCont, cMult : in std_logic; -- Carga dos registradores
		shPH, shPL, shA : in std_logic;	-- Shift dos registradores
		mPH, mFF, mCont : in std_logic; -- Controle dos mux
		entA, entB : in std_logic_vector(n-1 downto 0);
		Az, Alsb, Bz, ContZ: out std_logic;	 -- Sinais pro BC
		saida : out std_logic_vector(n-1 downto 0)
		);
end component;

signal NN, II : natural;
signal n1, i1 : real;
signal cA, cB, cPL, cPH, cCont, cMult, shPH, shPL, shA, mPH, mFF, mCont, Az, Alsb, Bz, ContZ : std_logic;

begin
NN <= 8;
n1 <= 8.0;
i1 <= LOG(2, n1)+1;
II <= natural(i1);
beoh: bo generic map(NN, II) port map(clk, cPH, cPL, cA, cB, cCont, cMult, shPH, shPL, shA, mPH, mFF, mCont, entA, entB, Az, Alsb, Bz, ContZ, mult);
bece: bc generic map(NN, II) port map(clk, init, Az, Bz, ContZ, Alsb, cPh, cPL, cA, cB, cCont, cMult, shPH, shPL, shA, mPH, mFF, mCont, pronto);
end behav;