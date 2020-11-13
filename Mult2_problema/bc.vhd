library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;

entity bc is
generic (n : natural := 8;
			i : natural := 4);
port (clk, init : in std_logic;
		Az, Bz, ContZ, Alsb: in std_logic;
		cPH, cPL, cA, cB, cCont, cMult : out std_logic; -- Carga dos registradores
		shPH, shPL, shA : out std_logic;	-- Shift dos registradores
		mPH, mFF, mCont : out std_logic; -- Controle dos mux
		pronto : out std_logic
		);			
end entity;

architecture behav of bc is
type state is (s0, s1, s2, s3, s4, s5, s6);
signal current_state : state;

begin
	process (clk)
	begin
		if (clk'event and clk = '1') then
			case current_state is
				when s0 =>
					if init = '1' then
						current_state <= s1;
					else 
						current_state <= s0;
					end if;
				when s1 =>
					current_state <= s2;
				when s2 =>
					if Az = '1' or Bz = '1' then
						current_state <= s6;
					else 
						current_state <= s3;
					end if;
				when s3=>
					if contZ = '0' and Alsb = '1' then
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
				cA <= '0';
				cB <= '0';
				cMult <= '0';
				pronto <= '1';
			when s1 =>
				cA <= '1';
				cB <= '1';
				cPL <= '1';
				cPH <= '1';
				cCont <= '1';
				mCont <= '1';
				mPH <= '1';
				mFF <= '1';
				shPH <= '0';
				shPL <= '0';
				shA <= '0';
			when s2 =>
				cA <= '0';
				cB <= '0';
				cPL <= '0';
				cPH <= '0';
				cCont <= '0';
				mCont <= '0';
				mPH <= '0';
			when s3 =>
				cPH <= '0';
				cPL <= '0';
				cCont <= '0';
				shPH <= '0';
				shPL <= '0';
				shA <= '0';
			when s4 =>
				cPH <= '1';
				mFF <= '0';
			when s5 =>
				cPH <= '0';
				shPH <= '1';
				shPL <= '1';
				shA <= '1';
				mCont <= '0';
				cCont <= '1';
			when s6 =>
				cMult <= '1';
			end case;	
	end process;
end behav;