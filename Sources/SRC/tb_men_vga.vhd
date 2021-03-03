library ieee;
use ieee.std_logic_1164.all;

entity tb_top_vga is
end tb_top_vga;

architecture tb of tb_top_vga is

    component top_vga
        port (reset   : in std_logic;
              clk100M : in std_logic;
              VGA_R   : out std_logic_vector (3 downto 0);
              VGA_B   : out std_logic_vector (3 downto 0);
              VGA_G   : out std_logic_vector (3 downto 0);
              VGA_HS  : out std_logic;
              VGA_VS  : out std_logic);
    end component;

    signal reset   : std_logic;
    signal clk100M : std_logic;
    signal VGA_R   : std_logic_vector (3 downto 0);
    signal VGA_B   : std_logic_vector (3 downto 0);
    signal VGA_G   : std_logic_vector (3 downto 0);
    signal VGA_HS  : std_logic;
    signal VGA_VS  : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_vga
    port map (reset   => reset,
              clk100M => clk100M,
              VGA_R   => VGA_R,
              VGA_B   => VGA_B,
              VGA_G   => VGA_G,
              VGA_HS  => VGA_HS,
              VGA_VS  => VGA_VS);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk100M is really your main clock signal
    clk100M <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;