

library ieee;
use ieee.std_logic_1164.all;

entity tb_affichage_figure is
end tb_affichage_figure;

architecture tb of tb_affichage_figure is

    component affichage_figure
        port (ce              : in std_logic;
              clk             : in std_logic;
              reset           : in std_logic;
              in_HG           : in std_logic_vector (15 downto 0);
              in_BD           : in std_logic_vector (15 downto 0);
              in_affichage_en : in std_logic;
              out_adr         : out std_logic_vector (13 downto 0);
              out_adr_firgure : out std_logic_vector (13 downto 0);
              out_R_W         : out std_logic);
    end component;

    signal ce              : std_logic;
    signal clk             : std_logic;
    signal reset           : std_logic;
    signal in_HG           : std_logic_vector (15 downto 0);
    signal in_BD           : std_logic_vector (15 downto 0);
    signal in_affichage_en : std_logic;
    signal out_adr         : std_logic_vector (13 downto 0);
    signal out_adr_firgure : std_logic_vector (13 downto 0);
    signal out_R_W         : std_logic;

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : affichage_figure
    port map (ce              => ce,
              clk             => clk,
              reset           => reset,
              in_HG           => in_HG,
              in_BD           => in_BD,
              in_affichage_en => in_affichage_en,
              out_adr         => out_adr,
              out_adr_firgure => out_adr_firgure,
              out_R_W         => out_R_W);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
         ce <= '1';
        in_HG <= (others => '0');
        in_BD <= (others => '0');
        in_affichage_en <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        in_affichage_en <= '1';
        in_HG <= "0000000000000000";--C=0 L=0
        in_BD <= "0000100100001001";--C=9 L=9
        wait for 2 ns;
        in_affichage_en <= '0';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        in_BD <= "0000000000000000";--C=0 L=0
        in_HG <= "0000100100001001";--C=9 L=9
        wait for 5 * TbPeriod;
        in_affichage_en <= '1';
        wait for 1 * TbPeriod;
        in_affichage_en <= '0';
        wait for 100 * TbPeriod;
        in_affichage_en <= '1';
        in_HG <= "0000000000000000";--C=0 L=0
        in_BD <= "0000100100001001";--C=9 L=9
        wait for 2 ns;
        in_affichage_en <= '0';
        wait for 100 * TbPeriod;
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;



