-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 28.3.2021 11:50:43 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_affichage is
end tb_top_affichage;

architecture tb of tb_top_affichage is

    component top_affichage
        port (reset           : in std_logic;
              clk100M         : in std_logic;
              in_HG           : in std_logic_vector (15 downto 0);
              in_BD           : in std_logic_vector (15 downto 0);
              in_affichage_en : in std_logic;
              num_figure      : in std_logic_vector (2 downto 0);
              VGA_R           : out std_logic_vector (3 downto 0);
              VGA_B           : out std_logic_vector (3 downto 0);
              VGA_G           : out std_logic_vector (3 downto 0);
              VGA_HS          : out std_logic;
              VGA_VS          : out std_logic;
              Write_ready_out : out std_logic);
    end component;

    signal reset           : std_logic;
    signal clk100M         : std_logic;
    signal in_HG           : std_logic_vector (15 downto 0);
    signal in_BD           : std_logic_vector (15 downto 0);
    signal in_affichage_en : std_logic;
    signal num_figure      : std_logic_vector (2 downto 0);
    signal VGA_R           : std_logic_vector (3 downto 0);
    signal VGA_B           : std_logic_vector (3 downto 0);
    signal VGA_G           : std_logic_vector (3 downto 0);
    signal VGA_HS          : std_logic;
    signal VGA_VS          : std_logic;
    signal Write_ready_out : std_logic;

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_affichage
    port map (reset           => reset,
              clk100M         => clk100M,
              in_HG           => in_HG,
              in_BD           => in_BD,
              in_affichage_en => in_affichage_en,
              num_figure      => num_figure,
              VGA_R           => VGA_R,
              VGA_B           => VGA_B,
              VGA_G           => VGA_G,
              VGA_HS          => VGA_HS,
              VGA_VS          => VGA_VS,
              Write_ready_out => Write_ready_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk100M is really your main clock signal
    clk100M <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        in_HG <= (others => '0');
        in_BD <= (others => '0');
        in_affichage_en <= '0';
        num_figure <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 * TbPeriod;  
        -- EDIT Add stimuli here
         num_figure<="111";
         in_HG<=x"2211";
         in_BD<=x"2B1A";
         in_affichage_en<='1';
         wait for 1 * TbPeriod;   
         in_affichage_en<='0';
        
        wait for 10000000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;