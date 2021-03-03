----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2021 14:06:28
-- Design Name: 
-- Module Name: top_vga - Behavioral
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

entity top_vga is
    port( reset : in std_logic ;
          clk100M : in std_logic;
          VGA_R: out std_logic_vector(3 downto 0);
          VGA_B: out std_logic_vector(3 downto 0);
          VGA_G: out std_logic_vector(3 downto 0);
          VGA_HS: out std_logic;
          VGA_VS: out std_logic
          );
end top_vga;

architecture Behavioral of top_vga is
    signal ADDR: std_logic_vector(13 downto 0);
    signal ADDR_reg: std_logic_vector(13 downto 0);
    signal data: std_logic_vector(2 downto 0);
    signal dataout: std_logic_vector(2 downto 0);
    signal signot_Reset: std_logic;
begin
    
    compteur : entity  work.compteur
      port map (
                CE =>'1',
                H=>clk100M,
                RST=>signot_reset,
                en_cpt=>'1',
                init_cpt=>'0',
                dataout=>ADDR
                );  
     reg : entity work.registre  
        port map(
                    in_data => ADDR,
                    ce =>'1',
                    clk =>clk100M,
                    reset=>signot_reset,
                    out_data=> ADDR_reg);
    
     men : entity work.memoire
        port map(
                en_men=>'1',
                R_W =>'0',
                ce=>'1',
                clk=>clk100M,
                in_adr=>ADDR,
                in_data=>"000",
                out_data=>data);
  
  
     VGA: entity  work.VGA_bitmap_160x100
      port map (
       clk          =>clk100M,
       reset        =>signot_reset,
       VGA_hs       => VGA_HS,
       VGA_vs       =>VGA_VS,
       VGA_red      =>VGA_R,
       VGA_green    =>VGA_G,
       VGA_blue     =>VGA_B,

       ADDR         =>ADDR_reg,
       data_in      =>data,
       data_write   =>'1',
       data_out => dataout
                );
        signot_reset<=not(reset);
end Behavioral;

