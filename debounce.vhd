--Debouncer
--Utiliza o FF tipo D usado no 2º trabalho

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity debounce is 
port
	(
		CLK:	in std_logic;
		sin: 	in std_logic;
		reset:in std_logic;
		sai: 	out std_logic
	);
end debounce;

architecture behav of debounce is
begin
	FF1: entity work.ffd port map(sin, CLK, s1, reset);
	FF2: entity work.ffd port map(s1, CLK, s2, reset);
	FF3: entity work.ffd port map(s2, CLK, s3, reset);
	sai <= s1 and s2 and s3;
end behav;