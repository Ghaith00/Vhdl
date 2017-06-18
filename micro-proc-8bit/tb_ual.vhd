-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 24.5.2017 22:17:14 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ual is
end tb_ual;

architecture tb of tb_ual is

    component ual
        port (I    : in std_logic_vector (3 downto 0);
              Op1  : in std_logic_vector (7 downto 0);
              Op2  : in std_logic_vector (7 downto 0);
              C_in : in std_logic;
              Res  : out std_logic_vector (7 downto 0);
              C    : out std_logic;
              Z    : out std_logic);
    end component;

    signal I    : std_logic_vector (3 downto 0);
    signal Op1  : std_logic_vector (7 downto 0);
    signal Op2  : std_logic_vector (7 downto 0);
    signal C_in : std_logic;
    signal Res  : std_logic_vector (7 downto 0);
    signal C    : std_logic;
    signal Z    : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ual
    port map (I    => I,
              Op1  => Op1,
              Op2  => Op2,
              C_in => C_in,
              Res  => Res,
              C    => C,
              Z    => Z);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        I <= (others => '0');
        Op1 <= (others => '0');
        Op2 <= (others => '0');
        C_in <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        Op1 <= "111111111";
		  Op2 <= "111111111";
		  I <= "0100";
        wait for 100 ns;
       
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ual of tb_ual is
    for tb
    end for;
end cfg_tb_ual;