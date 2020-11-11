LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY bo IS
generic(N: natural:= 4);
PORT (clk : IN std_logic;
      mPH, mcont, mFF : in std_logic; -- Sinais dos mux
		cA, cB, ccont, cmult: in std_logic; -- sinais dos registradores
		srAA, srPH, cPH, srPL, cPL: in std_logic;
      entA, entB : IN unsigned(N-1 DOWNTO 0);
      Az, Bz, contz, Azero : OUT std_logic;
		mult: OUT unsigned(7 downto 0));
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador_r IS
	generic(N: natural:= 4);
	PORT (clk,  sr, carga: IN std_logic;
		  d : IN unsigned(N-1 DOWNTO 0);
	     q : OUT unsigned(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT registrador IS
	generic(N: natural:= 4);
	PORT (clk, carga : IN std_logic;
		  d : IN unsigned(N-1 DOWNTO 0);
		  q : OUT unsigned(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT registrador_8 IS
	generic(N: natural:= 8);
	PORT (clk, carga : IN std_logic;
		  d : IN unsigned(N-1 DOWNTO 0);
		  q : OUT unsigned(N-1 DOWNTO 0));
	END COMPONENT;
	
	component registrador_1 IS
	generic(N: natural:= 3);
	PORT (clk, carga : IN std_logic;
			d : IN unsigned(N-1 DOWNTO 0);
			q : OUT unsigned(N-1 DOWNTO 0));
	END component;
	
	component registrador_r1 IS
	generic(N: natural:= 4);
	PORT (clk, sr, carga: IN std_logic;
			e,d: IN unsigned(N-1 DOWNTO 0);
			q : OUT unsigned(N-1 DOWNTO 0));
	END component;
	
	COMPONENT mux2para1 IS
	generic(N: natural:= 4);
	PORT ( a, b : IN unsigned(N-1 DOWNTO 0);
           sel: IN std_logic;
           y : OUT unsigned(N-1 DOWNTO 0));
	END COMPONENT;
	
	component mux2para1_1 IS
	generic(N: natural:= 3);
	PORT ( a, b : IN unsigned(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT unsigned(N-1 DOWNTO 0));
	END component;
	
	component mux2para1_bit IS
	PORT ( a, b : std_logic;
			sel: IN std_logic;
         y : OUT std_logic);
	END component ;
	
	component subtrator IS
	generic(N: natural:= 3);
	PORT (a, b : IN unsigned(N-1 DOWNTO 0);
			s : OUT unsigned(N-1 DOWNTO 0));
	END component;
	
	component somador IS
	generic(N: natural:= 4);
	PORT (a, b : IN unsigned(N-1 DOWNTO 0);
			s : OUT unsigned(N-1 DOWNTO 0);		  
			overflow: out std_logic);
	END component;
	
   COMPONENT igualazero IS
	generic(N: natural:= 4);
	PORT (a : IN unsigned(N-1 DOWNTO 0);
          igual : OUT std_logic);
	END COMPONENT;
	
	component igualazero_c IS
	generic(N: natural:= 3);
	PORT (a : IN unsigned(N-1 DOWNTO 0);
			igual : OUT std_logic);
	END component;
		
	signal saimux2, sairegPH, sairegPL, sairegA, sairegB, saisoma, x: unsigned (N-1 DOWNTO 0);
	signal y: unsigned (7 downto 0);
	signal saimux1, sairegcont, saisub: unsigned (2 DOWNTO 0);
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
	regPH: registrador_r port map (clk, srPH, cPH, x, sairegPh);
	regPL: registrador_r1 port map (clk, srPL, cPL, sairegPH, "0000", sairegPL);
	regB: registrador PORT MAP (clk, cB, entB, sairegB);
	soma: somador port map(sairegPH, sairegB, saisoma, ov);
	mux3: mux2para1_bit PORT MAP (ov, '0', mFF, saimux3);
	geraBz: igualazero PORT MAP (sairegB, Bz);		
	regmult: registrador_8 port map(clk, cmult, y, mult);

END estrutura;