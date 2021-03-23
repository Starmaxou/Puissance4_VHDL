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
-- Description: Machine d'�tat du projet VHDL Puissance4
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
use IEEE.NUMERIC_STD.ALL;

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
	signal pr_player, nx_player : Joueur := Joueur_Rouge;
	
	signal btn :   std_logic := '0';
	signal position :  unsigned (2 downto 0) := "001";
	signal init_grille :   std_logic; 
	signal ligne_grille :  std_logic_vector (2 downto 0);
	signal colonne_grille : std_logic_vector (2 downto 0);
	signal type_piece_grille : std_logic_vector (2 downto 0); 
	 
begin
------ 
-- Mise � jour synchrone des etats
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
        end process maj_joueur;

------
-- Calcul du nouvel etat en fonction des entr�es
------    
    cal_nx_state : process (pr_state, btnC, btnL, btnR, init_grille)
        begin
            case pr_state is
                when Etat_Init =>
                    nx_state <= Etat_Init_grille;
                    
                when Etat_Init_grille =>
                    if ( init_grille = '1') then
                        nx_state <= Etat_Affichage_jeu;
                    else
                        nx_state <= Etat_Init_grille;
                    end if;
                    
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
                    -- Ajouter v�rification d'�criture de la case blanche
                    -- Effacement du jeton � la position actuelle
                    if( btn = '1' ) then
                        nx_state <= Etat_Incrementer;
                    else
                        nx_state <= Etat_Decrementer;
                    end if;
                
                when Etat_Incrementer =>
                    nx_state <= Etat_Ecriture_pos;
                    
                when Etat_Decrementer =>
                    nx_state <= Etat_Ecriture_pos;
                
                when Etat_Ecriture_pos =>
                    -- Affichage de la nouvelle position du jeton
                    nx_state <= Etat_Affichage_jeu;
                
                when Etat_Check_mouv =>
                    nx_state <= Etat_Ecriture_mouv;
                
                when Etat_Ecriture_mouv =>
                    nx_state <= Etat_Check_victoire;
                
                when Etat_Check_victoire =>
                    case pr_player is
                        when Joueur_Rouge =>
                            nx_player <= Joueur_Jaune;
                        when Joueur_Jaune =>
                            nx_player <= Joueur_Rouge;
                    end case;
                    nx_state <= Etat_Affichage_jeu;
                    position <= "001";
                                
                when Etat_Victoire =>
                    if( btnC = '1' ) then
                        nx_state <= Etat_Init;
                    end if;
                    
                when others =>
                    nx_state <= Etat_Init_grille;
            end case;
        end process cal_nx_state;

------
-- Mise � jours des sorties en fonction de l'�tat courant
------    
    cal_output : process( pr_state, ligne_grille, colonne_grille, type_piece_grille )
        begin
            case pr_state is
                when Etat_Init =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_init_verif        <= '0';
                    I_sel_LC            <= '0';
                when Etat_Init_grille =>
                    C_ligne_grille      <= ligne_grille;
                    D_colonne_grille    <= colonne_grille;   
                    E_write_type_piece  <= type_piece_grille;
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_init_verif        <= '0';
                    I_sel_LC            <= '1';
                when Etat_Affichage_jeu =>
                
                when Etat_Effacer_pos =>
                
                when Etat_Incrementer =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_init_verif         <= '0';
                    I_sel_LC             <= '1';
                    
                    btn <= '0';
                    position <= position + 1;
                                    
                when Etat_Decrementer =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_init_verif         <= '0';
                    I_sel_LC             <= '1';
                    
                    position <= position - 1;
                     
                when Etat_Ecriture_pos =>
                
                when Etat_Check_mouv =>
                
                when Etat_Ecriture_mouv =>
                
                when Etat_Check_victoire =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_init_verif         <= '0';
                    I_sel_LC             <= '1';
                
                when Etat_Victoire =>
                
                when others =>
                                                                                      
            end case;
        end process cal_output;
        
    white_grille : process( H, RST )
        variable cpt_l : integer range 0 to 7;
        variable cpt_c : integer range 0 to 6;
        begin
            if ( RST = '1') then
                cpt_l := 0;
                cpt_c := 0;
                type_piece_grille <= "000";
                ligne_grille <= "000";
                colonne_grille <= "000";
                init_grille <= '0';
            elsif ( H'event and H = '1') then
                if (pr_state = Etat_Init_grille) then
                    if (cpt_l = 6 and cpt_c = 6) then
                         init_grille <= '1';
                    else
                        if (cpt_c = 6) then
                            cpt_c := 0;
                            cpt_l := cpt_l + 1;
                        end if;
                        cpt_c := cpt_c + 1;
                            
                        init_grille <= '0';      
                        if (cpt_l = 0) then
                             type_piece_grille <= "000";
                        else
                             type_piece_grille <= "100";
                        end if;
                        ligne_grille <= std_logic_vector(to_unsigned(cpt_l, 3));
                        colonne_grille <= std_logic_vector(to_unsigned(cpt_c, 3));
                        
                    end if;
                end if;
            end if;
    end process white_grille;

end Behavioral;
