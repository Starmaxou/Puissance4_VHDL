library ieee;
use ieee.std_logic_1164.all;

entity tb_grille is
end tb_grille;

architecture tb of tb_grille is

    component grille
        port (ce       : in std_logic;
              clk      : in std_logic;
              reset    : in std_logic;
              in_HG    : in std_logic_vector (15 downto 0);
              in_data  : in std_logic_vector (1 downto 0);
              init_cpt : in std_logic;
              out_adr  : out std_logic_vector (13 downto 0);
              out_data : out std_logic_vector (2 downto 0);
              data_ok  : out std_logic);
    end component;

    signal ce       : std_logic;
    signal clk      : std_logic;
    signal reset    : std_logic;
    signal in_HG    : std_logic_vector (15 downto 0);
    signal in_data  : std_logic_vector (1 downto 0);
    signal init_cpt : std_logic;
    signal out_adr  : std_logic_vector (13 downto 0);
    signal out_data : std_logic_vector (2 downto 0);
    signal data_ok  : std_logic;

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : grille
    port map (ce       => ce,
              clk      => clk,
              reset    => reset,
              in_HG    => in_HG,
              in_data  => in_data,
              init_cpt => init_cpt,
              out_adr  => out_adr,
              out_data => out_data,
              data_ok  => data_ok);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ce <= '1';
        in_HG <= (others => '0');
        in_data <= (others => '0');
        init_cpt <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        in_data<="10";
        wait for 100 ns;
        
      
        
        -- EDIT Add stimuli here
      

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;