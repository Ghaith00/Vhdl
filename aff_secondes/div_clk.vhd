library ieee;
use ieee.std_logic_1164.all;
entity div_clk is port(
	in_reset , in_clk : in std_logic;
	out_clk:out std_logic);
end entity;
architecture arch_segment of div_clk is
signal count: integer:=0;
signal tmp : std_logic := '1';

begin
		process(in_clk,in_reset)
			begin
			if(in_reset='1') then
				count<=0;
				tmp<='0';
			elsif(in_clk'event and in_clk='1') then
				count <=count+1;
				if (count = 12000000) then
					tmp <= NOT tmp;
					count <= 0;
				end if;
			end if;
			out_clk <= tmp;
		end process;	
end architecture;