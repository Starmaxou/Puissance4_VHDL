
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 2.3.2021 12:43:19 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_VGA_bitmap_160x100 is
end tb_VGA_bitmap_160x100;

architecture tb of tb_VGA_bitmap_160x100 is

    component VGA_bitmap_160x100
        port (clk        : in std_logic;
              reset      : in std_logic;
              VGA_hs     : out std_logic;
              VGA_vs     : out std_logic;
              VGA_red    : out std_logic_vector (3 downto 0);
              VGA_green  : out std_logic_vector (3 downto 0);
              VGA_blue   : out std_logic_vector (3 downto 0);
              ADDR       : in std_logic_vector (13 downto 0);
              data_in    : in std_logic_vector (2 downto 0);
              data_write : in std_logic;
              data_out   : out std_logic_vector (2 downto 0));
    end component;

    signal clk        : std_logic;
    signal reset      : std_logic;
    signal VGA_hs     : std_logic;
    signal VGA_vs     : std_logic;
    signal VGA_red    : std_logic_vector (3 downto 0);
    signal VGA_green  : std_logic_vector (3 downto 0);
    signal VGA_blue   : std_logic_vector (3 downto 0);
    signal ADDR       : std_logic_vector (13 downto 0);
    signal data_in    : std_logic_vector (2 downto 0);
    signal data_write : std_logic;
    signal data_out   : std_logic_vector (2 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : VGA_bitmap_160x100
    port map (clk        => clk,
              reset      => reset,
              VGA_hs     => VGA_hs,
              VGA_vs     => VGA_vs,
              VGA_red    => VGA_red,
              VGA_green  => VGA_green,
              VGA_blue   => VGA_blue,
              ADDR       => ADDR,
              data_in    => data_in,
              data_write => data_write,
              data_out   => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ADDR <= (others => '0');
        data_in <= (others => '0');
        data_write <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_VGA_bitmap_160x100 of tb_VGA_bitmap_160x100 is
    for tb
    end for;
end cfg_tb_VGA_bitmap_160x100;