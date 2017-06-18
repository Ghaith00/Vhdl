library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity register_gen is 
	generic(t: natural range 1 to 16 :=8);
	port(
		clk ,load , reset: in std_logic;
		e: in std_logic_vector(t-1 downto 0);
		o: out std_logic_vector(t-1 downto 0)
		);
end entity;
architecture register_gen_arch of register_gen is

begin
	process(clk, reset )
	begin
		if reset = '1' then 
			o <= (others=>'0');
		elsif rising_edge(clk) then 
			if load = '1' then 
				o <= e ;
			end if ;
		end if ;
	end process;	
end architecture;