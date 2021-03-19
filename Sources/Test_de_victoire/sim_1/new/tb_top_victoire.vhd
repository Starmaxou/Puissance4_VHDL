-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 16.3.2021 18:41:50 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_victoire is
end tb_top_victoire;

architecture tb of tb_top_victoire is

    component top_victoire
        port (reset   : in std_logic;
              clk100M : in std_logic;
              BTNC    : in std_logic;
              VGA_R   : out std_logic_vector (3 downto 0);
              VGA_B   : out std_logic_vector (3 downto 0);
              VGA_G   : out std_logic_vector (3 downto 0);
              VGA_HS  : out std_logic;
              VGA_VS  : out std_logic;
              LED     : out std_logic_vector (1 downto 0));
    end component;

    signal reset   : std_logic;
    signal clk100M : std_logic;
    signal BTNC    : std_logic;
    signal VGA_R   : std_logic_vector (3 downto 0);
    signal VGA_B   : std_logic_vector (3 downto 0);
    signal VGA_G   : std_logic_vector (3 downto 0);
    signal VGA_HS  : std_logic;
    signal VGA_VS  : std_logic;
    signal LED     : std_logic_vector (1 downto 0);

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_victoire
    port map (reset   => reset,
              clk100M => clk100M,
              BTNC    => BTNC,
              VGA_R   => VGA_R,
              VGA_B   => VGA_B,
              VGA_G   => VGA_G,
              VGA_HS  => VGA_HS,
              VGA_VS  => VGA_VS,
              LED     => LED);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk100M is really your main clock signal
    clk100M <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        BTNC <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        BTNC<='1';
        wait for 5 ns;
        BTNC<='0';
        -- EDIT Add stimuli here
        wait for 10000000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;