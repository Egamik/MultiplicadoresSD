LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY bo IS
generic(N: natural:= 4);
PORT (clk: IN std_logic;
      mPH, mcont, mFF : in std_logic; -- Sinais dos mux
		cA, cB, ccont, cmult: in std_logic; -- sinais dos registradores
		srAA, srPH, srPL, cPH, cPL: in std_logic;
      entA, entB : IN std_logic_vector(N-1 DOWNTO 0);
      Az, Bz, contz, Azero : OUT std_logic;
		mult: OUT std_logic_vector(7 downto 0));
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador_r IS
	generic(N: natural := 4);
	port (clk, darshift, carga : in std_logic;
			d : in std_logic_vector(N-1 downto 0);
			q : out std_logic_vector(N-1 downto 0));
	end component;
	
	COMPONENT registrador IS
	generic(N: natural:= 4);
	PORT (clk, carga : IN std_logic;
		  d : IN std_logic_vector(N-1 DOWNTO 0);
		  q : OUT std_logic_vector(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT registrador_8 IS
	generic(N: natural:= 8);
	PORT (clk, carga : IN std_logic;
		  d : IN std_logic_vector(N-1 DOWNTO 0);
		  q : OUT std_logic_vector(N-1 DOWNTO 0));
	END COMPONENT;
	
	component registrador_1 IS
	generic(N: natural:= 3);
	PORT (clk, carga : IN std_logic;
			d : IN std_logic_vector(N-1 DOWNTO 0);
			q : OUT std_logic_vector(N-1 DOWNTO 0));
	END component;
	
	COMPONENT mux2para1 IS
	generic(N: natural:= 4);
	PORT ( a, b : IN std_logic_vector(N-1 DOWNTO 0);
           sel: IN std_logic;
           y : OUT std_logic_vector(N-1 DOWNTO 0));
	END COMPONENT;
	
	component mux2para1_1 IS
	generic(N: natural:= 3);
	PORT ( a, b : IN std_logic_vector(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT std_logic_vector(N-1 DOWNTO 0));
	END component;
	
	component mux2para1_bit IS
	PORT ( a, b : std_logic;
			sel: IN std_logic;
         y : OUT std_logic);
	END component ;
	
	component subtrator IS
	generic(N: natural:= 3);
	PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
			s : OUT std_logic_vector(N-1 DOWNTO 0));
	END component;
	
	component somador IS
	generic(N: natural:= 4);
	PORT (a, b : IN std_logic_vector(N-1 DOWNTO 0);
			s : OUT std_logic_vector(N-1 DOWNTO 0);		  
			overflow: out std_logic);
	END component;
	
   COMPONENT igualazero IS
	generic(N: natural:= 4);
	PORT (a : IN std_logic_vector(N-1 DOWNTO 0);
          igual : OUT std_logic);
	END COMPONENT;
	
	component igualazero_c IS
	generic(N: natural:= 3);
	PORT (a : IN std_logic_vector(N-1 DOWNTO 0);
			igual : OUT std_logic);
	END component;
		
	signal saimux2, sairegA, sairegB, saisoma, sairegPH, sairegPL, x: std_logic_vector (N-1 DOWNTO 0);
	signal y: std_logic_vector (7 DOWNTO 0);
	signal saimux1, sairegcont, saisub: std_logic_vector (2 DOWNTO 0);
	signal saimux3, ov: std_logic;

BEGIN

	-- parte do sinal comparativo de A
	regA: registrador_r port map (clk, srAA, cA, entA, sairegA);
	geraAz: igualazero port map (sairegA, Az);
	Azero <= sairegA(0);

	-- parte do cont 
	mux1: mux2para1_1 port map (saisub, "100", mcont, saimux1);
	regcont: registrador_1 port map(clk, ccont, saimux1, sairegcont);
	sub: subtrator port map (sairegcont, "001", saisub);
	geracontz: igualazero_c port map (sairegcont, contz);

	-- parte do sinal A e P 
	x <= (saimux3 or saimux2(N-1)) & saimux2(N-2 downto 0);
	y <= sairegPH & sairegPL;
	
	mux2: mux2para1 port map (saisoma, "0000", mPH, saimux2);
	regPH: registrador_r port map(clk, srPH, cPH, x, sairegPH);
	regPL: registrador_r port map(clk, srPL, cPL, "0000", sairegPL);	
	regB: registrador PORT MAP (clk, cB, entB, sairegB);
	soma: somador port map(sairegPH, sairegB, saisoma, ov);
	mux3: mux2para1_bit PORT MAP (ov, '0', mFF, saimux3);
	geraBz: igualazero PORT MAP (sairegB, Bz);		
	regmult: registrador_8 port map(clk, cmult, y, mult);
	

END estrutura;