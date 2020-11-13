LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity Mult2Vinc is
generic(N: natural := 8);
port( Inicioo,Resett,Clkk : in std_logic;
		A,B : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N+N-1 downto 0);
		Pront : out std_logic);
end Mult2Vinc;

architecture comportamento of Mult2Vinc is

component bo is
generic(N: natural := 8);
port (clkbo : in std_logic; -- Clock.
      entA, entB : in std_logic_vector(N-1 downto 0); -- Operandos.
		mCount,mPH,mff : in std_logic; -- Sinais de controle dos muxs , demux e Cin.
		CPH,CPL,CB,CA,Ccount,Csaida : in std_logic; -- Sinais de carga dos registradores.
		ShPH,ShPL,ShA : in std_logic; -- Sinais de shift dos registradores.
		Azero,Bzero,Countzero,AlessSig : out std_logic;
      saida : out std_logic_vector(N+N-1 downto 0)); -- Saida.
end component;

component bc is
port (clk, reset, inicio: in std_logic;
		Azero,Bzero,Countzero,AlessSig : in std_logic;
		mCount,mPH,mff : out std_logic;  -- Sinais mux.
		CPH,CPL,CB,CA,Ccount,Csaida : out std_logic; -- Sinais regs.
		ShPH,ShPL,ShA: out std_logic; -- Sinais de shift.
		pronto: out std_logic);
end component;

signal sinalmCount,sinalmPH,sinalmff :  std_logic;
signal sinalCPH,sinalCPL,sinalCB,sinalCA,sinalCcount,sinalCsaida :  std_logic;
signal sinalShPH,sinalShPL,sinalShA :  std_logic; 
signal sinalAzero,sinalBzero,sinalCountzero,SinalAlessSig : std_logic;

begin

BOo : bo port map(clkbo => clkk , entA => A, entB => B , mCount => sinalmCount , mPH => sinalmPH , mff => sinalmff , CPH => sinalCPH , CPL => sinalCPL , CB => sinalCB , CA => sinalCA ,Ccount => sinalCcount , Csaida => sinalCsaida , ShPH => sinalShPH , ShPL => sinalShPL , ShA => sinalShA , Azero => sinalAzero, Bzero => sinalBzero, Countzero => sinalCountzero ,AlessSig => SinalAlessSig , saida => S );
BCc : bc port map(clk => clkk, reset => Resett, inicio => inicioo , Azero => sinalAzero , Bzero => sinalBzero , Countzero => sinalCountzero, AlessSig => SinalAlessSig , mCount => sinalmCount , mPH => sinalmPH , mff => sinalmff, CPH => sinalCPH , CPL => sinalCPL , CB => sinalCB , CA => sinalCA , Ccount => sinalCcount ,Csaida => sinalCsaida , ShPH => sinalShPH, ShPL => sinalShPL , Sha => sinalShA, pronto => pront);

end comportamento;