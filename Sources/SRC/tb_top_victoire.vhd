-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 27.3.2021 17:19:54 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_victoire is
end tb_top_victoire;

architecture tb of tb_top_victoire is

    component top_victoire
        port (reset   : in std_logic;
              clk100M : in std_logic;
              BTNC    : in std_logic;
              BTNL    : in std_logic;
              BTNR    : in std_logic;
              VGA_R   : out std_logic_vector (3 downto 0);
              VGA_B   : out std_logic_vector (3 downto 0);
              VGA_G   : out std_logic_vector (3 downto 0);
              VGA_HS  : out std_logic;
              VGA_VS  : out std_logic
             );
    end component;

    signal reset   : std_logic;
    signal clk100M : std_logic;
    signal BTNC    : std_logic;
    signal BTNL    : std_logic;
    signal BTNR    : std_logic;
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
              BTNL    => BTNL,
              BTNR    => BTNR,
              VGA_R   => VGA_R,
              VGA_B   => VGA_B,
              VGA_G   => VGA_G,
              VGA_HS  => VGA_HS,
              VGA_VS  => VGA_VS
             );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk100M is really your main clock signal
    clk100M <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        BTNC <= '0';
        BTNL <= '0';
        BTNR <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        
        -- Déplacement de 1 vers la droite
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
       
        wait for 800 * TbPeriod;
         
        btnR <= '1';
        wait for 2 * TbPeriod;
        btnR <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
         
        btnR <= '1';
        wait for 2 * TbPeriod;
        btnR <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
         
        btnR <= '1';
        wait for 2 * TbPeriod;
        btnR <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnL <= '1';
        wait for 2 * TbPeriod;
        btnL <= '0';
        wait for 2 * TbPeriod;
        
        wait for 800 * TbPeriod;
        
        btnC <= '1';
        wait for 2 * TbPeriod;
        btnC <= '0';
        wait for 2 * TbPeriod;
        
          wait for 800 * TbPeriod;
         
       
        
  
        
       
        
--        -- Déplacement de 1 vers la gauche
--        btnL <= '1';
--        wait for 2 * TbPeriod;
--        btnL <= '0';
              
--        wait for 800 * TbPeriod;
        
--        -- Validation de la position du jeton
--        btnC <= '1';
--        wait for 2 * TbPeriod;
--        btnC <= '0';
--        wait for 2 * TbPeriod;
        
--        wait for 20 * TbPeriod;
        
--        -- Simulation d'un resultat nul par le bloc check victoire

--        wait for 2 * TbPeriod;
      
--        wait for 2 * TbPeriod;
        
--        wait for 100 * TbPeriod;
        
--        -- Validation de la position du jeton
--        btnC <= '1';
--        wait for 2 * TbPeriod;
--        btnC <= '0';
--        wait for 2 * TbPeriod;
        
--        wait for 20 * TbPeriod;
        
--        -- Simulation de victoire du joueur jaune
      
--        wait for 2 * TbPeriod;
      
--        wait for 2 * TbPeriod;
        
--        wait for 50 * TbPeriod;
        
--        -- Relance d'une partie après victoire
--        btnC <= '1';
--        wait for 2 * TbPeriod;
--        btnC <= '0';
--        wait for 2 * TbPeriod;
        
        wait for 100000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;