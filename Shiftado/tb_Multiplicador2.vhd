library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity tb_Multiplicador2 is
generic(N: natural:= 4); 
end tb_Multiplicador2;

architecture tb of tb_Multiplicador2 is
signal clk1: std_logic;
signal reset1: std_logic;
signal inicio1: std_logic;
signal entA1: std_logic_vector(N-1 downto 0);
signal entB1: std_logic_vector(N-1 downto 0);
signal pronto1: std_logic;
signal mult1: std_logic_vector(7 downto 0);

	component Multiplicador2 is 
	generic(N: natural:= 4);
	port(Rst, CLK, inicio: in std_logic;
		  entA, entB: in std_logic_vector(N-1 downto 0);
		  pronto: out std_logic;
		  mult: out std_logic_vector(7 downto 0));
	end component;
	
begin 

UUT: entity work.Multiplicador2 port map(Rst => reset1, CLK => clk1, inicio => inicio1, entA => entA1, entB => entB1, pronto => pronto1, mult => mult1);

	reset1 <= '1', '0' after 20 ns;
	
	inicio1 <= '0', '1' after 20 ns, '0' after 40 ns;
	
	-- lembrar de arrumar os valores quando for trabalhar com 8 bits
	entA1 <= "0011";
	entB1 <= "0100";
	
	tb1 :process
        constant periodo: time := 20 ns; 
        begin
				clk1 <= '1';
            wait for periodo/2; 
				clk1 <= '0';
				wait for periodo/2;
        end process;
end tb;