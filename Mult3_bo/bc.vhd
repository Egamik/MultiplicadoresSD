library IEEE;
use IEEE.std_logic_1164.all;

entity bc is
port (clk, reset, inicio: in std_logic;
		Azero,Bzero,Countzero,AlessSig : in std_logic;
		m1,m2,mPH2,mff : out std_logic;  -- Sinais mux.
		CPH,CPL,CB,CA,Ccount,Csaida : out std_logic; -- Sinais regs.
		ShPH,ShPL,ShA: out std_logic; -- Sinais de shift.
		pronto: out std_logic
		);
end entity;

architecture comportamento of bc is

type state is (s0, s1, s2, s3, s4, s5, s6);
signal current_state : state;

begin
	process(clk, reset)
		begin
		if (reset = '1') then 
			current_state <= s0;
		elsif (clk'event and clk = '1') then
			case current_state is
				when s0 =>
					if (inicio = '1') then
						current_state <= s1;
					else
						current_state <= s0;
					end if;	
				when s1 =>
					current_state <= s2;
				when s2 =>
					if (Azero = '1' or Bzero = '1') then 
						current_state <= s6;
					else 
						current_state <= s3;
					end if;	
				when s3 =>
					if Countzero = '1' then -- Countzero = 1 -> i = 0, sem termos.
						current_state <= s6;
					elsif (AlessSig = '1') then -- A(0) != 0.
						current_state <= s4;
					else
						current_state <= s5;
					end if;	
				when s4 =>
					current_state <= s5;
				when s5 =>
					current_state <= s3;
				when s6 =>
					current_state <= s0;
				end case;	
		end if;
	end process;
	
	process(current_state)
	begin
		case current_state is
			when s0 =>
				  m1     <= '0';
				  m2     <= '0';
              mPH2   <= '0';
              mff    <= '0';
              CPH    <= '0';
              CPL    <= '0';
              CB     <= '0';
              CA     <= '0';
              Ccount <= '0';
              Csaida <= '0';
              ShPH   <= '0';
              ShPL   <= '0';
              ShA    <= '0';
              pronto <= '1'; -- termino da operação.
			when s1 =>
				  m1     <= '0';
				  m2     <= '0'; -- sel n (num de bits do multiplicando.
              mPH2   <= '1'; -- sel zero.
              mff    <= '0';
              CPH    <= '1'; -- Carrega PH com zeros (limpa PH antes de começar).
              CPL    <= '1'; -- reseta PL.
              CB     <= '1'; -- entB <= B.
              CA     <= '1'; -- entA <= A.
              Ccount <= '1'; -- carrega n no reg Count.
              Csaida <= '0';
              ShPH   <= '0';
              ShPL   <= '0';
              ShA    <= '0';
              pronto <= '0';
			when s2 =>              -- A e B ja estao prontos para serem consultados.
				  m1     <= '0';       -- sao precisa carregar para ler.
				  m2     <= '0';
              mPH2   <= '0';
              mff    <= '0';
              CPH    <= '0';
              CPL    <= '0';
              CB     <= '0';
              CA     <= '0';
              Ccount <= '0';
              Csaida <= '0';
              ShPH   <= '0';
              ShPL   <= '0';
              ShA    <= '0';
              pronto <= '0';
			when s3 =>
			     m1     <= '0';
				  m2     <= '0';
              mPH2   <= '0';
              mff    <= '0';				  
              CPH    <= '0';
              CPL    <= '0';
              CB     <= '0';
              CA     <= '0';
              Ccount <= '0';
              Csaida <= '0';
              ShPH   <= '0';
              ShPL   <= '0';
              ShA    <= '0';
              pronto <= '0';
			when s4 =>
				  m1     <= '0'; -- Para fazer a soma com B
              mPH2   <= '0'; -- sel , s1 do demux.
              mff    <= '0'; -- deve ser 0, p/ pegar cout pois a soma esta sendo feita.
              CPH    <= '1'; -- PH é carregado na transição de s4 para s5 com o valor da soma. 
              CPL    <= '0';
              CB     <= '0';
              CA     <= '0';
              Ccount <= '0';
              Csaida <= '0';
              ShPH   <= '0'; 
              ShPL   <= '0'; 
              ShA    <= '0';
              pronto <= '0';
			when s5 =>
				  m1     <= '1'; -- libera caminho para a subtração e entra em Cin.
				  m2     <= '1'; -- libera caminho para a subtração.
				  mPH2   <= '0';
				  
              CPH    <= '0'; 
              CPL    <= '0';
              CB     <= '0'; 
              CA     <= '0'; 
              Ccount <= '1'; -- carrega o resultado da subtração na transição de s5 p/ s3 ou s6
              Csaida <= '0';
				  
				  mff    <= '1'; -- so deve ser 1 no estado s5.
              ShPH   <= '1'; -- deslogo o PH para direita. 
              ShPL   <= '1'; -- deslogo o PL para direita.
				  
              ShA    <= '1'; -- deslogo A para ver o prox bit de A.
              pronto <= '0';
			when s6 =>
				  m1     <= '0';
				  m2     <= '0';
              mPH2   <= '0';
              mff    <= '0';				  
              CPH    <= '0';
              CPL    <= '0';
              CB     <= '0';
              CA     <= '0';
              Ccount <= '0';
              Csaida <= '0';
              ShPH   <= '0';
              ShPL   <= '0';
              ShA    <= '0';
              pronto <= '0';
              Csaida <= '1'; -- carrega reg saida.
			end case;
	end process;		
end comportamento;