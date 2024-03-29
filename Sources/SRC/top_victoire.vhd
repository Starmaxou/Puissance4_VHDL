----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2021 14:28:06
-- Design Name: 
-- Module Name: top_victoire - Behavioral
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

entity top_victoire is
        port(
          reset : in std_logic ;
          clk100M : in std_logic;
          BTNC: in std_logic;
          BTNL: in std_logic;
          BTNR: in std_logic;
          VGA_R: out std_logic_vector(3 downto 0);
          VGA_B: out std_logic_vector(3 downto 0);
          VGA_G: out std_logic_vector(3 downto 0);
          VGA_HS: out std_logic;
          VGA_VS: out std_logic;
          LED :out std_logic_vector(1 downto 0)
          );
end top_victoire;

architecture Behavioral of top_victoire is
    signal HG: std_logic_vector(15 downto 0);
    signal BD: std_logic_vector(15 downto 0);
    signal type_piece: std_logic_vector(2 downto 0);
    signal out_addr_L: std_logic_vector(2 downto 0);
    signal out_addr_C: std_logic_vector(2 downto 0);
    signal compteur_addr_L: std_logic_vector(2 downto 0);
    signal compteur_addr_C: std_logic_vector(2 downto 0);
    signal verif_addr_L: std_logic_vector(2 downto 0);
    signal verif_addr_C: std_logic_vector(2 downto 0);
    signal addr_L_FSM: std_logic_vector(2 downto 0);
    signal addr_C_FSM: std_logic_vector(2 downto 0);
    signal addr_L_FSM_cpt: std_logic_vector(2 downto 0);
    signal addr_C_FSM_cpt: std_logic_vector(2 downto 0);
    signal signot_Reset: std_logic;
    signal W_ready: std_logic;
    signal victoire: std_logic_vector(1 downto 0);
    signal En_affichage: std_logic;
    signal en_cpt: std_logic;
    signal en_FDM_aff: std_logic;
    signal en_FDM_aff_Q: std_logic;
    signal init_verif: std_logic;
    signal write_type_piece: std_logic_vector(2 downto 0);
    signal piece1_LC : STD_LOGIC_VECTOR (15 downto 0);
    signal piece2_LC : STD_LOGIC_VECTOR (15 downto 0);
    signal piece3_LC : STD_LOGIC_VECTOR (15 downto 0);
    signal piece4_LC : STD_LOGIC_VECTOR (15 downto 0);
    signal F_RW_plateau: std_logic;
    signal H_sel_LC: std_logic;
    signal BTNL_Edge: std_logic;
    signal BTNC_Edge: std_logic;
    signal BTNR_Edge: std_logic;
    
  
begin

      Edge_BTNL  :entity work.Edge_detector
      Port map ( 
           clk =>clk100M,
           reset =>signot_reset,
           ce =>'1',
           data_in =>BTNL,
           data_out=>BTNL_Edge);
      Edge_BTNC  :entity work.Edge_detector
       Port map ( 
           clk =>clk100M,
           reset =>signot_reset,
           ce =>'1',
           data_in =>BTNC,
           data_out=>BTNC_Edge);
           
       Edge_BTNR  :entity work.Edge_detector
        Port map ( 
           clk =>clk100M,
           reset =>signot_reset,
           ce =>'1',
           data_in =>BTNR,
           data_out=>BTNR_Edge);
           
       
           
           

       FSM  :entity work.FSM
       Port map ( CE =>'1',
           H  =>clk100M,
           RST=>signot_reset,
           btnL=>BTNL_Edge,
           btnC=>BTNC_Edge,
           btnR=>BTNR_Edge,
           A_read_type_piece=>type_piece,
           B_state_victoire=>victoire,
           W_Ready  =>W_Ready,
           
           
           C_ligne_grille =>addr_L_FSM,
           D_colonne_grille=>addr_C_FSM,
           E_write_type_piece=>write_type_piece,
           F_RW_plateau=>F_RW_plateau,
           G_en_verif=>init_verif,
           H_sel_LC=>H_sel_LC,
           I_AFF_plateau =>en_FDM_aff,
          
           LED=>LED
           );

        bascule_D_affichage: entity  work.bascule_D
            port map (
                clk =>clk100M,
                reset =>signot_reset,
                ce =>'1',
                D =>en_FDM_aff,
                Q=>en_FDM_aff_Q
        );

        mux_L: entity  work.mux_L_C
        port map (
                sel_mux =>en_FDM_aff,
                in_data1 => compteur_addr_L,
                in_data0 => addr_L_FSM,
                out_data =>addr_L_FSM_cpt
        );
        mux_C: entity  work.mux_L_C
        port map (
                sel_mux =>en_FDM_aff,
                in_data1 => compteur_addr_C,
                in_data0 =>addr_C_FSM,
                out_data =>addr_C_FSM_cpt
        );
        
         mux_L_V: entity  work.mux_L_C
        port map (
                sel_mux =>H_sel_LC,
                in_data1 => verif_addr_L,
                in_data0 => addr_L_FSM_cpt,
                out_data =>out_addr_L
        );
        mux_C_V: entity  work.mux_L_C
        port map (
                sel_mux =>H_sel_LC,
                in_data1 => verif_addr_C,
                in_data0 =>addr_C_FSM_cpt,
                out_data =>out_addr_C
        );
        
     FSM_affichage: entity  work.mini_FSM_victoire
         port map (
           CE =>'1',
           H =>clk100M,
           RST  => signot_reset,
           W_ready=>W_ready,
           en_FSM=>en_FDM_aff_Q,
           out_en_affichage=>En_affichage,
           out_en_cpt=>en_cpt
            );
    affichage: entity  work.top_affichage
         port map (
          reset => signot_reset,
          clk100M =>clk100M,
          in_HG=>HG,
          in_BD=>BD,
          in_affichage_en=>En_affichage,
          num_figure=>type_piece,
          VGA_R=>VGA_R,
          VGA_B=>VGA_B,
          VGA_G=>VGA_G,
          VGA_HS=>VGA_HS,
          VGA_VS=>VGA_VS,
          Write_ready_out=>W_ready
         );
         
   LC_to_HG_BG: entity   work.select_case
         port map (
           C_case =>out_addr_C,
           L_case =>out_addr_L,
           px_HG =>HG,
           px_BD =>BD
         );

    grille: entity   work.grille
         port map (
           clk =>clk100M,
           ce =>'1',
           en_mem=>'1',
           in_data =>write_type_piece,
           R_W =>F_RW_plateau,
           addr_grille_c =>out_addr_C,
           addr_grille_l =>out_addr_L,
           type_piece  => type_piece
         );
   compteur_test_victoire:   entity work.compteur_test_victoire
     port map (
               CE =>'1',
               H =>clk100M,
               RST =>signot_reset,
               en_cpt => en_cpt,
               init_cpt =>'0',
               addr_grille_c_out=>compteur_addr_C,
               addr_grille_l_out=>compteur_addr_L    
               );
  
  verification_victoire: entity    work.verification_victoire
         port map (
           clk =>clk100M,
           ce=>'1',
           reset=> signot_reset,
           init_state => init_verif,
           in_data =>type_piece,
           addr_grille_c_out =>verif_addr_C,
           addr_grille_l_out =>verif_addr_L,
           out_victoire=>victoire,
           piece1_LC=> piece1_LC,
           piece2_LC=> piece2_LC,
           piece3_LC=> piece3_LC,
           piece4_LC=> piece4_LC
          
         );
          signot_reset<=not(reset);
        
        
    end Behavioral;