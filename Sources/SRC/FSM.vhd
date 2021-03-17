----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime ALBERTY
-- 
-- Create Date: 24.02.2021 09:38:01
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: Puissance4_VHDL 
-- Target Devices: xc7a50tcsg324-1
-- Tool Versions: 
-- Description: Machine d'état du projet VHDL Puissance4
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

entity FSM is
    Port ( CE                   : in STD_LOGIC;
           H                    : in STD_LOGIC;
           RST                  : in STD_LOGIC;
           btnL                 : in STD_LOGIC;
           btnC                 : in STD_LOGIC;
           btnR                 : in STD_LOGIC;
           A_read_type_piece    : in STD_LOGIC_VECTOR(2  downto 0);
           B_state_victoire     : in STD_LOGIC_VECTOR(1 downto 0);
           
           C_ligne_grille       : out STD_LOGIC_VECTOR(2 downto 0);
           D_colonne_grille     : out STD_LOGIC_VECTOR(2 downto 0);
           E_write_type_piece   : out STD_LOGIC_VECTOR(2 downto 0);
           F_RW_plateau         : out STD_LOGIC;
           G_en_verif           : out STD_LOGIC;
           H_init_verif         : out STD_LOGIC;
           I_sel_LC             : out STD_LOGIC
           );
end FSM;

architecture Behavioral of FSM is

    type Etat is ( Etat_init, Etat_Init_grille, Etat_Affichage_jeu, Etat_Effacer_pos, Etat_Incrementer, Etat_Decrementer, Etat_Ecriture_pos, Etat_Check_mouv, Etat_Ecriture_mouv, Etat_Check_victoire, Etat_Victoire);
	signal pr_state , nx_state : Etat := Etat_init;
	
	type Joueur is (Joueur_Rouge, Joueur_Jaune);
	signal pr_player : Joueur := Joueur_Rouge;
	
	signal btn : std_logic := '0';
begin
------ 
-- Mise à jour synchrone des etats
------
    maj_etat : process ( H , RST )
    begin
        if (RST ='1') then
            pr_state <= Etat_init ;
        elsif ( H' event and H ='1') then
            if(CE = '1') then
            	pr_state <= nx_state ;
            end if;
        end if;
    end process maj_etat;
    
    maj_joueur : process ( H , RST )
        begin
            if (RST ='1') then
                pr_player <= Joueur_Rouge ;
            elsif ( H' event and H ='1') then
                if(CE = '1') then
                    pr_player <= nx_player;
                end if;
            end if;
        end process maj_etat;

------
-- Calcul du nouvel etat en fonction des entrées
------    
    cal_nx_state : process (pr_state, btnC, btnL, btnR)
        begin
            case pr_state is
                when Etat_Init =>
                    nx_state <= Etat_Affichage_jeu;
                    
                --when Etat_Init_grille =>
                    
                when Etat_Affichage_jeu =>
                    if( btnC = '1' ) then
                        nx_state <= Etat_check_mouv;
                    elsif( btnL = '1' ) then
                        btn <= '0';
                        nx_state <= Etat_Effacer_pos;
                    elsif( btnR = '1' ) then
                        btn <= '1';
                        nx_state <= Etat_Effacer_pos;
                    end if;
                
                when Etat_Effacer_pos =>
                    -- Ajouter vérification d'écriture de la case blanche
                    if( btn = '1' ) then
                        nx_state <= Etat_Incrementer;
                    else
                        nx_statue <= Etat_Decrementer;
                
                --when Etat_Incrementer =>
                
                --when Etat_Decrementer =>
                
                --when Etat_Ecriture_pos =>
                
                --when Etat_Check_mouv =>
                
                --when Etat_Ecriture_mouv =>
                
                --when Etat_Check_victoire =>
                                
                --when Etat_Victoire =>
                    
                when others =>
                    nx_state <= Etat_init;
            end case;
        end process cal_nx_state;

------
-- Mise à jours des sorties en fonction de l'état courant
------    
    cal_output : process( pr_state )
        begin
            case pr_state is
                when Etat_Init =>
                    
                --when Etat_Init_grille =>
                
                when Etat_Affichage_jeu =>
                
                --when Etat_Effacer_pos =>
                
                --when Etat_Incrementer =>
                
                --when Etat_Decrementer =>
                               
                --when Etat_Ecriture_pos =>
                
                --when Etat_Check_mouv =>
                
                --when Etat_Ecriture_mouv =>
                
                --when Etat_Check_victoire =>
                
                --when Etat_Victoire =>
                
                when others =>
                                                                                      
            end case;
        end process cal_output;

end Behavioral;
