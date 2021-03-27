-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 23.3.2021 16:18:55 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_FSM is
end tb_FSM;

architecture tb of tb_FSM is

    component FSM
        port (CE                 : in std_logic;
              H                  : in std_logic;
              RST                : in std_logic;
              btnL               : in std_logic;
              btnC               : in std_logic;
              btnR               : in std_logic;
              A_read_type_piece  : in std_logic_vector (2  downto 0);
              B_state_victoire   : in std_logic_vector (1 downto 0);
              C_ligne_grille     : out std_logic_vector (2 downto 0);
              D_colonne_grille   : out std_logic_vector (2 downto 0);
              E_write_type_piece : out std_logic_vector (2 downto 0);
              F_RW_plateau       : out std_logic;
              G_en_verif         : out std_logic;
              H_sel_LC           : out std_logic);
    end component;

    signal CE                 : std_logic;
    signal H                  : std_logic;
    signal RST                : std_logic;
    signal btnL               : std_logic;
    signal btnC               : std_logic;
    signal btnR               : std_logic;
    signal A_read_type_piece  : std_logic_vector (2  downto 0);
    signal B_state_victoire   : std_logic_vector (1 downto 0);
    signal C_ligne_grille     : std_logic_vector (2 downto 0);
    signal D_colonne_grille   : std_logic_vector (2 downto 0);
    signal E_write_type_piece : std_logic_vector (2 downto 0);
    signal F_RW_plateau       : std_logic;
    signal G_en_verif         : std_logic;
    signal H_sel_LC           : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : FSM
    port map (CE                 => CE,
              H                  => H,
              RST                => RST,
              btnL               => btnL,
              btnC               => btnC,
              btnR               => btnR,
              A_read_type_piece  => A_read_type_piece,
              B_state_victoire   => B_state_victoire,
              C_ligne_grille     => C_ligne_grille,
              D_colonne_grille   => D_colonne_grille,
              E_write_type_piece => E_write_type_piece,
              F_RW_plateau       => F_RW_plateau,
              G_en_verif         => G_en_verif,
              H_sel_LC           => H_sel_LC);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    H <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        btnL <= '0';
        btnC <= '0';
        btnR <= '0';
        A_read_type_piece <= (others => '0');
        B_state_victoire <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        
        btnR <= '1';
        wait for 2 * TbPeriod;
        btnR <= '0';
        wait for 2 * TbPeriod;
        btnR <= '1';
        wait for 2 * TbPeriod;
        btnR <= '0';
        wait for 2 * TbPeriod;
        
        wait for 50 * TbPeriod;
        
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;        
        
        
        wait for 100 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 20 * TbPeriod;
        
        B_state_victoire <= "11";
        wait for 2 * TbPeriod;
        B_state_victoire <= "00";
        wait for 2 * TbPeriod;
        
        wait for 100 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 20 * TbPeriod;
        
        B_state_victoire <= "10";
        wait for 2 * TbPeriod;
        B_state_victoire <= "00";
        wait for 2 * TbPeriod;
        
        wait for 50 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 50 * TbPeriod;
        
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
