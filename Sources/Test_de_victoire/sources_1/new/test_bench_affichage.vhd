----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 15:24:25
-- Design Name: 
-- Module Name: test_bench_affichage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench_affichage is
    port( reset : in std_logic ;
          clk100M : in std_logic;
          BTNC: in std_logic;
          BTNU: in std_logic;
          BTNL: in std_logic;
          BTNR: in std_logic;
          BTND: in std_logic;
          VGA_R: out std_logic_vector(3 downto 0);
          VGA_B: out std_logic_vector(3 downto 0);
          VGA_G: out std_logic_vector(3 downto 0);
          VGA_HS: out std_logic;
          VGA_VS: out std_logic
          );
end test_bench_affichage;

architecture Behavioral of test_bench_affichage is
 signal HG: std_logic_vector(15 downto 0);
 signal BD: std_logic_vector(15 downto 0);
 signal affichage_en: std_logic;
 signal num_figure: std_logic_vector(2 downto 0);
 signal Write_ready: std_logic;
  signal signot_Reset: std_logic;
begin

top_affichage : entity  work.top_affichage
      port map (
                  reset =>signot_Reset,
                  clk100M =>clk100M,
                  in_HG =>HG,
                  in_BD=>BD,
                  in_affichage_en =>affichage_en,
                  num_figure =>num_figure,
                  VGA_R =>VGA_R,
                  VGA_B =>VGA_B,
                  VGA_G =>VGA_G,
                  VGA_HS =>VGA_HS,
                  VGA_VS=> VGA_VS
                );  
  test_affichage : entity  work.test_affichage
    port map( 
            clk=>clk100M,
            Bp1=> BTNC,
            Bp2=> BTNU,
            Bp3=>BTNL,
            Bp4=>BTNR,
            Bp5=>BTND,
            out_HG=>HG,
            out_BD=>BD,
            out_num_figure=>num_figure,
            out_en_affichage_test=>affichage_en);
 signot_reset<=not(reset);
end Behavioral;
