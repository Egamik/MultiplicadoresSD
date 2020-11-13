LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux21_1bit IS
  PORT ( a, b : IN std_logic;
         sel: IN std_logic;
         y : OUT std_logic);
  END mux21_1bit ;

ARCHITECTURE comportamento OF mux21_1bit IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;