library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity microProcessor is port(
	clk , reset: in std_logic;
	BZ : out std_logic
	);
end entity;
architecture microProcessor_arch of microProcessor is
signal wr_w : std_logic ;
signal A_w , D_w  ,ADR_w: std_logic_vector(7 downto 0);
component ram port (
	clk , wr: in std_logic;
	ADR , A : in std_logic_vector(7 downto 0);
	D : out std_logic_vector(7 downto 0)
);
end component;
component cpu port (
	clk , reset: in std_logic;
	D: in std_logic_vector(7 downto 0);
	ADR , A : out std_logic_vector(7 downto 0);
	wr , BZ : out std_logic
);
end component;
begin
	com_cpu :cpu  port map(clk =>clk , reset=>reset ,wr => wr_w , ADR =>ADR_w , A =>A_w,D =>D_w,BZ => BZ);
	mem : ram port map (clk =>clk ,wr => wr_w , ADR =>ADR_w , A =>A_w ,D =>D_w);
		
end architecture;