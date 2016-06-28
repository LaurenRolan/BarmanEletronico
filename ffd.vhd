-- Por Lauren Rolan
-- FF tipo D usado no 2º trabalho 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ffd is
port
(
	D		: in std_logic;
	CLK	: in std_logic;
	Q		: out std_logic;
	reset : in std_logic
);
end ffd;

architecture flipflop of ffd is
begin
	process(CLK, reset)
		begin
			if (reset = '1') then -- se reset for acionado, zera a saída
				Q <= '0';
			elsif(rising_edge(CLK)) then
				Q <= D;
			end if;
		end process;
end flipflop;