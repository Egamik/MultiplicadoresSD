library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Multiplicador3tb is
generic(N: natural:= 8); 
end Multiplicador3tb;

architecture tb of Multiplicador3tb is
signal clk1: std_logic;
signal reset1: std_logic;
signal inicio1: std_logic;
signal entA1: std_logic_vector(N-1 downto 0);
signal entB1: std_logic_vector(N-1 downto 0);
signal pronto1: std_logic;
signal mult1: std_logic_vector(15 downto 0);

component Multiplicador3 is
generic(N: natural := 8);
port( Inicioo,Resett,Clkk : in std_logic;
		A,B : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N+N-1 downto 0);
		Pront : out std_logic);
end component;
	
begin 

UUT: entity work.Multiplicador3 port map(Resett => reset1, Clkk => clk1, Inicioo => inicio1, A => entA1, B => entB1, Pront => pronto1, S => mult1);

	reset1 <= '1', '0' after 20 ns;
	
	inicio1 <= '0', '1' after 20 ns, '0' after 40 ns;
	
	
	entA1 <= "00001010"; --10
	entB1 <= "00000010"; -- 2
	
	tb1 :process
        constant periodo: time := 20 ns; 
        begin
				clk1 <= '1';
            wait for periodo/2; 
				clk1 <= '0';
				wait for periodo/2;
        end process;
end tb;