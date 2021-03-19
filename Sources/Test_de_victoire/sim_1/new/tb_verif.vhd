-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.3.2021 12:58:30 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_verification_victoire is
end tb_verification_victoire;

architecture tb of tb_verification_victoire is

    component verification_victoire
        port (clk               : in std_logic;
              reset             : in std_logic;
              ce                : in std_logic;
              en_verif          : in std_logic;
              init_state        : in std_logic;
              in_data           : in std_logic_vector (1 downto 0);
              addr_grille_c_out : out std_logic_vector (2 downto 0);
              addr_grille_l_out : out std_logic_vector (2 downto 0);
              out_victoire      : out std_logic_vector (1 downto 0);
              out_test          : out std_logic);
    end component;

    signal clk               : std_logic;
    signal reset             : std_logic;
    signal ce                : std_logic;
    signal en_verif          : std_logic;
    signal init_state        : std_logic;
    signal in_data           : std_logic_vector (1 downto 0);
    signal addr_grille_c_out : std_logic_vector (2 downto 0);
    signal addr_grille_l_out : std_logic_vector (2 downto 0);
    signal out_victoire      : std_logic_vector (1 downto 0);
    signal out_test          : std_logic;

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : verification_victoire
    port map (clk               => clk,
              reset             => reset,
              ce                => ce,
              en_verif          => en_verif,
              init_state        => init_state,
              in_data           => in_data,
              addr_grille_c_out => addr_grille_c_out,
              addr_grille_l_out => addr_grille_l_out,
              out_victoire      => out_victoire,
              out_test          => out_test);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ce <= '1';
        en_verif <= '1';
        init_state <= '0';
        in_data <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        in_data <= "10";
        init_state <= '1';
        wait for 5 ns;
        init_state <= '0';
        wait for 5 ns;
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
