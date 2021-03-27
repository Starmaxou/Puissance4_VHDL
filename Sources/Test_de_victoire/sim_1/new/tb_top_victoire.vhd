-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.3.2021 12:33:06 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_victoire is
end tb_top_victoire;

architecture tb of tb_top_victoire is

    component top_victoire
        port (reset   : in std_logic;
              clk100M : in std_logic;
              BTNC    : in std_logic;
              BTNU    : in std_logic;
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
    signal BTNU    : std_logic;
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
              BTNU    => BTNU,
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
        BTNU <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        BTNC <= '1';
        wait for 5 * TbPeriod;
        BTNC <= '0';
        wait for 7000 * TbPeriod;
        BTNU <= '1';
        wait for 5 * TbPeriod;
        BTNU <= '0';
        wait for 10000000 * TbPeriod;
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

