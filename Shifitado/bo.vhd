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
	generic(N: natural:= 4);
	port (clk, carga, sh, in_sh: in std_logic;
			d: in std_logic_vector (N-1 downto 0);
			q: inout std_logic_vector(N-1 downto 0));
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
	
	component flipflop is
	port (clk, D : in std_logic;
      Q : out std_logic);
	end component;
		
          signal  saimuxPH, sairegPH, sairegPL, saisoma,sairegB, sairegA: std_logic_vector(3 downto 0);
          signal  saimuxcont, sairegcont, saisub: std_logic_vector (2 downto 0);
          signal  sairegmult, y: std_logic_vector(7 downto 0);
          signal  ov, saimuxflip, czero, Az0, Bz0, saiflip: std_logic;
begin
          ff:       flipflop      port map (clk, saimuxflip, saiflip);
          muxPH:    mux2para1     port map (saisoma, "0000", mPH, saimuxPH);
          muxcont:  mux2para1_1   port map (saisub, "100", mcont, saimuxcont);
          muxov:    mux2para1_bit port map (ov, '0', mFF, saimuxflip);
          regPH:    registrador_r port map (clk, cPH, srPH, saiflip, saimuxPH, sairegPH);
          regPL:    registrador_r port map (clk, cPL, srPL, sairegPH(0), "0000", sairegPL);
          regB:     registrador   port map (clk, cB, entB, sairegB);
          regA:     registrador_r port map (clk, cA, srAA, '0', entA, sairegA);
          regcont:  registrador_1 port map (clk, ccont, saimuxcont, sairegcont);
          regmult:  registrador_8 port map (clk, cmult, y, sairegmult);
          soma:     somador       port map (sairegPH, sairegB, saisoma, ov);
          subt:     subtrator     port map (sairegcont,"001", saisub);
          Aze:      igualazero    port map (sairegA, Az0);
          Bze:      igualazero    port map (sairegB, Bz0);
          contzero: igualazero_c  port map (sairegcont, czero);

			 y     <= sairegPH & sairegPL;
          Azero <= sairegA(0);
          mult  <= sairegmult;
          contz <= czero;
          Az    <= Az0;
          Bz    <= Bz0;
END estrutura;