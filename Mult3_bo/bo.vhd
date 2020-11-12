LIBRARY ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bo is
generic(N: natural := 8);
port (clkbo : in std_logic; -- Clock.
      entA, entB : in std_logic_vector(N-1 downto 0); -- Operandos.
		m1,m2,mPH2,mff : in std_logic; -- Sinais de controle dos muxs , demux e Cin.
		CPH,CPL,CB,CA,Ccount,Csaida : in std_logic; -- Sinais de carga dos registradores.
		ShPH,ShPL,ShA : in std_logic; -- Sinais de shift dos registradores.
		Azero,Bzero,Countzero,AlessSig : out std_logic;
      saida : out std_logic_vector(N+N-1 downto 0)); -- Saida.
end bo;

architecture comportamento of bo is

component somadorComCin is -- Somador.
generic (N: natural := 8);
 port ( A,B : in std_logic_vector(N-1 downto 0);
			CIN : in std_logic;
			S : out std_logic_vector(N-1 downto 0);
			Cout : out std_logic);
end component;

component registrador_sh is
generic(N: natural := 8);
port (clk, carga, darshift , in_sh: in std_logic;
      d: in std_logic_vector (N-1 downto 0);
      q: inout std_logic_vector(N-1 downto 0));
end component;

component registrador is -- Reg sem reset.
generic(N: natural := 8);
port (clk, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end component;

component mux2para1T1 is -- mux.
generic(N: natural := 8);
  port ( a, b : in std_logic_vector(N-1 downto 0);
         sel: in std_logic;
         y : out std_logic_vector(N-1 downto 0));
end component;

component demux1para2 is -- demux.
generic(N: natural := 8);
  port ( d : in std_logic_vector(N-1 downto 0);
         sel: in std_logic;
         s1,s2 : out std_logic_vector(N-1 downto 0));
 end component;
 
component igualazero_AB is -- igualazero 8 bits.
generic(N: natural:= 8);
port (entrada : in std_logic_vector(N-1 downto 0);
saida : out std_logic);
end component;

component flipflop is
generic(N: natural := 8);
port (clk, D : in std_logic;
	  Q : out std_logic);
end component;

signal saidamuxPH , saidaMuxPH2 , saidamuxB , SaidaSomador , SaidaS1demux , SaidaS2demux : std_logic_vector(N-1 downto 0); -- Saidas muxes e demux.
signal SaidaregPH, SaidaregPL, SaidaregB, SaidaregA , sinalConcatena : std_logic_vector(N-1 downto 0); -- Saidas registradores N-1 bits.
signal EntradaDPLparaReset : std_logic_vector(N-1 downto 0); -- Para resetar PL.
signal SaidaregCount : std_logic_vector((N/2)-1 downto 0); -- Saida reg count.
signal SaidaMuxCount : std_logic_vector((N/2)-1 downto 0);
signal sinalCout,sinalFF : std_logic_vector(0 downto 0);
signal BitPH : std_logic;
constant Zeros : std_logic_vector(entA'range) := (others => '0'); 
signal MenosUm : std_logic_vector(entA'range) := (others => '1');

begin	

MenosUm(0) <= '0'; -- para ficar -1 em complemento de 2.
sinalConcatena <= (Zeros((N/2)-1 downto 0) & SaidaregCount);
AlessSig <= SaidaregA(0); 

Somador : somadorComCin generic map (N) port map (A => saidamuxPH, B => saidamuxB, Cin => m1, S => SaidaSomador, Cout => sinalCout(0));
demux1 : demux1para2 generic map (N) port map (d => SaidaSomador, sel => m1, s1 => SaidaS1demux, s2 => SaidaS2demux);
muxCount : mux2para1T1 generic map (N/2) port map (a => "1000" , b => SaidaS2demux((N/2)-1 downto 0) , sel => m2, Y => SaidaMuxCount);
muxCout : mux2para1T1 generic map (1) port map (a => sinalCout, b => "0" , sel => mff, y => sinalFF );
muxPH2 : mux2para1T1 generic map(N) port map (a => SaidaS1demux , b => Zeros , sel => mPH2 , y => saidaMuxPH2);
muxPH : mux2para1T1 generic map(N) port map (a => SaidaregPH, b => MenosUm , sel => m1 , y => saidamuxPH);
muxB : mux2para1T1 generic map(N) port map (a => SaidaregB, b => SinalConcatena  , sel => m1, y => saidamuxB);
regCount : registrador generic map((N/2)) port map (clk => clkbo, carga => Ccount, d => SaidaMuxCount , q => SaidaregCount);
regB : registrador generic map(N) port map (clk => clkbo, carga => CB, d => entB , q => SaidaregB);
regSaida : registrador generic map(N+N) port map (clk => clkbo, carga => Csaida, d => SaidaregPH & SaidaregPL , q => Saida);
regA : registrador_sh  port map (clk => clkbo, carga => CA, darshift => ShA, in_sh => '0', d => entA , q => SaidaregA);
regPH : registrador_sh  port map (clk => clkbo, carga => CPH, darshift => ShPH, in_sh => BitPH, d => SaidamuxPH2, q => SaidaregPH);
regPL : registrador_sh  port map (clk => clkbo, carga => CPL, darshift => ShPL, in_sh => SaidaregPH(0), d => Zeros, q => SaidaregPL);
A_IgualAzero : igualazero_AB generic map(N) port map (entrada => entA, saida => Azero);
B_IgualAzero : igualazero_AB generic map(N) port map (entrada => entB, saida => Bzero);
Count_IgualAzero : igualazero_AB generic map((N/2)) port map (entrada => saidaregCount, saida => Countzero);
FF : flipflop port map (clk => clkbo, D => sinalFF(0),Q => BitPH);


end comportamento;