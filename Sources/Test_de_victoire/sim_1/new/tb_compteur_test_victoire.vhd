-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.3.2021 14:41:56 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_compteur_test_victoire is
end tb_compteur_test_victoire;

architecture tb of tb_compteur_test_victoire is

    component compteur_test_victoire
        port (CE                 : in std_logic;
              H                  : in std_logic;
              RST                : in std_logic;
              en_cpt             : in std_logic;
              init_cpt           : in std_logic;
              addr_grille_c_out  : out std_logic_vector (2 downto 0);
              addr_grille_l_out  : out std_logic_vector (2 downto 0);
              en_affichage_out   : out std_logic;
              out_check_victoire : out std_logic);
    end component;

    signal CE                 : std_logic;
    signal H                  : std_logic;
    signal RST                : std_logic;
    signal en_cpt             : std_logic;
    signal init_cpt           : std_logic;
    signal addr_grille_c_out  : std_logic_vector (2 downto 0);
    signal addr_grille_l_out  : std_logic_vector (2 downto 0);
    signal en_affichage_out   : std_logic;
    signal out_check_victoire : std_logic;

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin
    
    dut : compteur_test_victoire
    port map (CE                 => CE,
              H                  => H,
              RST                => RST,
              en_cpt             => en_cpt,
              init_cpt           => init_cpt,
              addr_grille_c_out  => addr_grille_c_out,
              addr_grille_l_out  => addr_grille_l_out,
              en_affichage_out   => en_affichage_out,
              out_check_victoire => out_check_victoire);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    H <= TbClock;
    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        en_cpt <= '0';
        init_cpt <= '0';

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;
        en_cpt <= '1';
        init_cpt <= '1';
        wait for 5 ns;
        init_cpt <= '0';
        wait for 10 * TbPeriod;
        en_cpt <= '0';
        wait for 50 * TbPeriod;
        en_cpt <= '1';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;