library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity ram is port(
	clk , wr: in std_logic;
	ADR , A : in std_logic_vector(7 downto 0);
	D : out std_logic_vector(7 downto 0)
	);
end entity;
architecture ram_arch of ram is
type memory is array(0 to 2**8 -1) of std_logic_vector(7 downto 0);
signal mem : memory ;
begin
		ecriture : process(clk)
		begin 
			if rising_edge(clk) then	
				if (wr = '1') then 
					mem(to_integer(unsigned(ADR))) <= A ;
				end if;
			end if ;
		end process ;
		D <=  mem(to_integer(unsigned(ADR))) ;
		
end architecture;