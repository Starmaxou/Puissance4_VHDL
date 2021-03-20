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

entity top_affichage is
    port( reset : in std_logic ;
          clk100M : in std_logic;
          in_HG: in std_logic_vector(15 downto 0);
          in_BD: in std_logic_vector(15 downto 0);
          in_affichage_en: in std_logic;
          num_figure: in std_logic_vector( 2 downto 0);
          VGA_R: out std_logic_vector(3 downto 0);
          VGA_B: out std_logic_vector(3 downto 0);
          VGA_G: out std_logic_vector(3 downto 0);
          VGA_HS: out std_logic;
          VGA_VS: out std_logic;
          Write_ready_out: out std_logic
          );
end top_affichage;

architecture Behavioral of top_affichage is
    signal ADDR: std_logic_vector(13 downto 0);
    signal ADDR_reg: std_logic_vector(13 downto 0);
    signal data_RGB: std_logic_vector(2 downto 0);
    signal dataout: std_logic_vector(2 downto 0);
    signal R_W_D: std_logic;
    signal R_W_Q: std_logic;
    signal ADDR_affichage_W_in: std_logic_vector(13 downto 0);
    signal ADDR_affichage_W_out: std_logic_vector(13 downto 0);
    signal ADDR_affichage_R: std_logic_vector(13 downto 0);
    signal figure_RGB: std_logic_vector(2 downto 0);
    signal NOT_R_W: std_logic;
    signal ADDR_fig: std_logic_vector(13 downto 0);
    
begin
    
    compteur : entity  work.compteur
      port map (
                CE =>'1',
                H=>clk100M,
                RST=>reset,
                en_cpt=>NOT_R_W,
                init_cpt=>'0',
                dataout=>ADDR_affichage_R
                );  
                
        mux : entity  work.mux
           port map (
                sel_mux =>R_W_Q,
                in_data0 =>ADDR_affichage_R,
                in_data1 => ADDR_affichage_W_out,
                out_data =>ADDR
                );   
                
     reg : entity work.registre  
        port map(
                    in_data => ADDR_affichage_R,
                    ce =>'1',
                    clk =>clk100M,
                    reset=>reset,
                    out_data=> ADDR_reg);
                    
     
                    
     reg2 : entity work.registre  
        port map(
                    in_data => ADDR_affichage_W_in,
                    ce =>'1',
                    clk =>clk100M,
                    reset=>reset,
                    out_data=> ADDR_affichage_W_out);
                
                
    bascule_D : entity work.bascule_D 
        port map(
                   
                    ce =>'1',
                    clk =>clk100M,
                    reset=>reset,
                    D=>R_W_D, 
                    Q=>R_W_Q);    
    
                    
    
     men_affichage : entity work.memoire
        port map(
                en_men=>'1',
                R_W =>R_W_Q,
                ce=>'1',
                clk=>clk100M,
                in_adr=>ADDR,
                in_data=>figure_RGB,
                out_data=>data_RGB);
                
      men_figure : entity work.mem_figure
        port map(
           clk =>clk100M,
           ce=>'1',
           en_mem=>'1',
           in_addr_figure => ADDR_fig,
           num_figure=> num_figure,
           out_data =>figure_RGB);
           
           
      affichage_figure : entity work.affichage_figure
        port map(
            ce=>'1',
            clk =>clk100M,
            reset =>reset,
            in_HG =>in_HG,
            in_BD => in_BD,
            in_affichage_en=> in_affichage_en,
            out_adr =>ADDR_affichage_W_in,
            out_adr_figure => ADDR_fig,
            out_R_W=>R_W_D);
  
     VGA: entity  work.VGA_bitmap_160x100
      port map (
       clk          =>clk100M,
       reset        =>reset,
       VGA_hs       => VGA_HS,
       VGA_vs       =>VGA_VS,
       VGA_red      =>VGA_R,
       VGA_green    =>VGA_G,
       VGA_blue     =>VGA_B,

       ADDR         =>ADDR_reg,
       data_in      =>data_RGB,
       data_write   =>NOT_R_W,
       data_out => dataout
                );
        NOT_R_W<=not(R_W_Q);
        Write_ready_out<=NOT_R_W;
end Behavioral;

