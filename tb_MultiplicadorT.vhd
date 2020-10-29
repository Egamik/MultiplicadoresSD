library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MultiplicadorT is
generic(N: natural:= 4); 
end tb_MultiplicadorT;

architecture tb of tb_MultiplicadorT is
signal clk1: std_logic;
signal reset1: std_logic;
signal inicio1: std_logic;
signal entA1: std_logic_vector(N-1 downto 0);
signal entB1: std_logic_vector(N-1 downto 0);
signal pronto1: std_logic;
signal saida1: std_logic_vector(N-1 downto 0);
signal conteudoA1 : std_logic_vector(N-1 downto 0);
signal conteudoB1 : std_logic_vector(N-1 downto 0);

	component MultiplicadorT is 
	port(Rst, CLK, inicio: in std_logic;
		  entA, entB: in std_logic_vector(N-1 downto 0);
		  pronto: out std_logic;
		  saida, conteudoA, conteudoB: out std_logic_vector(N-1 downto 0));
	end component;
	
begin 

UUT: entity work.MultiplicadorT port map(Rst => reset1, CLK => clk1, inicio => inicio1, entA => entA1, entB => entB1, pronto => pronto1, saida => saida1, conteudoA => conteudoA1, conteudoB => conteudoB1);

	reset1 <= '1', '0' after 20 ns;
	
	inicio1 <= '0', '1' after 20 ns, '0' after 60 ns;
	
	-- lembrar de arrumar os valores quando for trabalhar com 8 bits
	entA1 <= "0000", "0011" after 40 ns;
	entB1 <= "0000", "0100" after 40 ns;
	
	tb1 :process
        constant periodo: time := 20 ns; 
        begin
				clk1 <= '1';
            wait for periodo/2; 
				clk1 <= '0';
				wait for periodo/2;
        end process;
end tb;