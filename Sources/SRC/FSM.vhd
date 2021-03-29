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
           W_Ready     : in STD_LOGIC;
           
           C_ligne_grille       : out STD_LOGIC_VECTOR(2 downto 0);
           D_colonne_grille     : out STD_LOGIC_VECTOR(2 downto 0);
           E_write_type_piece   : out STD_LOGIC_VECTOR(2 downto 0);
           F_RW_plateau         : out STD_LOGIC;
           G_en_verif           : out STD_LOGIC;
           H_sel_LC             : out STD_LOGIC;
           I_AFF_plateau        : out STD_LOGIC;
           posled :           out STD_LOGIC_VECTOR(2 downto 0)
           );
end FSM;

architecture Behavioral of FSM is

    type Etat is ( Etat_init, Etat_Init_grille,ATT_W_ready, Etat_Affichage_jeu, Etat_Effacer_pos, Etat_Incrementer, Etat_Decrementer, Etat_Ecriture_pos, Etat_Check_mouv, Etat_Effacer_mouv, Etat_Ecriture_mouv, Etat_Check_victoire, Etat_Victoire);
	signal pr_state , nx_state : Etat := Etat_init;
	
	type Joueur is (Joueur_Rouge, Joueur_Jaune);
	signal pr_player, nx_player : Joueur := Joueur_Rouge;
	
	signal btn_mem :   std_logic := '0';               -- '0' if btnL pushed or '1' if lbtnR pushed 
	signal position :  unsigned (2 downto 0) := "000"; -- Curseur du joueur
	
	-- white_grille process
	signal init_grille :   std_logic;                          -- flag to check if initialization ok 
	signal ligne_grille :  std_logic_vector (2 downto 0);      -- signal for initialization
	signal colonne_grille : std_logic_vector (2 downto 0);     -- signal for initialization

	
	-- check_mouv process
	signal mouv_state : std_logic_vector (1 downto 0); -- Result of check_mouv
	signal ligne_check_mouv :  std_logic_vector (2 downto 0);
	signal colonne_check_mouv :  std_logic_vector (2 downto 0);
	 
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
        end process maj_joueur;

------
-- Calcul du nouvel etat en fonction des entrées
------    
    cal_nx_state : process (pr_state, btnC, btnL, btnR, init_grille , mouv_state, B_state_victoire,W_Ready,pr_player,btn_mem)
        begin
            case pr_state is
                when Etat_Init =>
                	nx_player <= Joueur_Rouge;
                    nx_state <= Etat_Init_grille;
                    
                when Etat_Init_grille =>
                    if ( init_grille = '1') then
                        nx_state <= Etat_Affichage_jeu;
                    else
                        nx_state <= Etat_Init_grille;
                    end if;

                when Etat_Affichage_jeu =>
--                    if( btnC = '1' ) then
--                        nx_state <= Etat_check_mouv;
                    if( btnL = '1' ) then
                        btn_mem <= '0';
                        nx_state <= ATT_W_ready;
                    elsif( btnR = '1' ) then
                        btn_mem <= '1';
                       nx_state <= ATT_W_ready;
                    else
                        nx_state <= Etat_Affichage_jeu;
                    end if;
                
                
                
                
               when ATT_W_ready =>
                        if(W_Ready='1')then
                             nx_state<=Etat_Effacer_pos;
                        else
                             nx_state<=ATT_W_ready;
                        end if;
                    
                when Etat_Effacer_pos =>
                    -- Effacement du jeton à la position actuelle
                    if( btn_mem = '1' and mouv_state = "00") then
                        nx_state <= Etat_Incrementer;
                    elsif ( btn_mem = '0' and mouv_state = "00") then
                        nx_state <= Etat_Decrementer;
                    elsif ( mouv_state = "11") then
                        nx_state <= Etat_Ecriture_mouv; 
                    end if;
                
                when Etat_Incrementer =>
                    nx_state <= Etat_Ecriture_pos;
                    
                when Etat_Decrementer =>
                    nx_state <= Etat_Ecriture_pos;
                
                when Etat_Ecriture_pos =>
                    -- Affichage de la nouvelle position du jeton
                    -- Check si ecriture OK
                    nx_state <= Etat_Affichage_jeu;
                
                when Etat_Check_mouv =>
                    case mouv_state is
                        when "10" => -- mouvement non valide
                            nx_state <= Etat_Affichage_jeu;
                        when "11" => -- mouvement valide
                            nx_state <= Etat_Effacer_pos;
                        when others =>
                            nx_state <= Etat_Check_mouv;
                    end case;
                    
                
                when Etat_Ecriture_mouv =>
                    nx_state <= Etat_Check_victoire;
                
                when Etat_Check_victoire =>
                    case B_state_victoire is
                        when "11" =>
                            case pr_player is
                                when Joueur_Rouge =>
                                    nx_player <= Joueur_Jaune;
                                when Joueur_Jaune =>
                                    nx_player <= Joueur_Rouge;
                            end case;
                            nx_state <= Etat_Affichage_jeu;
                        when "10" =>    -- Yellow win
                            nx_state <= Etat_Victoire;
                        when "01" =>    -- Red win
                            nx_state <= Etat_Victoire;
                        when others =>    -- Check_victoire ongoing
                            nx_state <= Etat_Check_victoire;
                    end case;
                                
                when Etat_Victoire =>
                    if( btnC = '1' ) then
                        nx_state <= Etat_Init;
                    end if;
                    
                when others =>
                    nx_state <= Etat_Init_grille;
            end case;
        end process cal_nx_state;

------
-- Mise à jours des sorties en fonction de l'état courant
------    
    cal_output : process( pr_state, ligne_grille, colonne_grille, ligne_check_mouv, colonne_check_mouv,position,pr_player)
        begin
            case pr_state is
                when Etat_Init =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                when Etat_Init_grille =>
                    C_ligne_grille      <= ligne_grille;
                    D_colonne_grille    <= colonne_grille; 
                    if (ligne_grille = "000" and  colonne_grille="000") then
                         E_write_type_piece <= "001"; --red_white		
				    elsif(ligne_grille = "000")then
				        E_write_type_piece <= "111"; --white_square
				    else
						E_write_type_piece <= "000";  --blue_circle
					end if;    
                    F_RW_plateau        <= '1'; 
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';

                
                when Etat_Affichage_jeu =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '1';
                 when ATT_W_ready =>    
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                when Etat_Effacer_pos =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= std_logic_vector(position);   
                    E_write_type_piece  <= "100";
                    F_RW_plateau        <= '1';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                    
                when Etat_Incrementer =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC             <= '0';
                    I_AFF_plateau       <= '0';
                    
                                    
                when Etat_Decrementer =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                                         
                when Etat_Ecriture_pos =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= std_logic_vector(position);   
                    if (pr_player = Joueur_Rouge) then
                        E_write_type_piece   <= "001";
                    else 
                        E_write_type_piece   <= "101";
                    end if;
                    F_RW_plateau        <= '1';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                
                
                
                    
                when Etat_Check_mouv =>
                    C_ligne_grille       <= ligne_check_mouv;
                    D_colonne_grille     <= colonne_check_mouv;
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                    
				when Etat_Effacer_mouv =>
                    C_ligne_grille       <= ligne_check_mouv;
                    D_colonne_grille     <= colonne_check_mouv;
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '1';
                    G_en_verif           <= '0';
                    H_sel_LC             <= '0';
                    I_AFF_plateau       <= '0';

				when Etat_Ecriture_mouv =>
                    C_ligne_grille       <= ligne_check_mouv;
                    D_colonne_grille     <= colonne_check_mouv;
                    if (pr_player = Joueur_Rouge) then
                        E_write_type_piece   <= "010";
                    else 
                        E_write_type_piece   <= "110";
                    end if;
                    F_RW_plateau         <= '1';
                    G_en_verif           <= '0';
                    H_sel_LC             <= '0'; 
                    I_AFF_plateau       <= '0';                                   
								
                when Etat_Check_victoire =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '1';
                    H_sel_LC            <= '1';
                    I_AFF_plateau       <= '0';
                    
                
                when Etat_Victoire =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                
                when others =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                                                                                      
            end case;
        end process cal_output;
        
    check_mouv : process ( H, RST)
        variable cpt_l : integer range 1 to 6;
        variable nb_empty : integer range 0 to 6;
        begin
            if (RST = '1') then
                mouv_state <= "00";
                cpt_l := 1;
                ligne_check_mouv <= "000";
                colonne_check_mouv <= "000";
            elsif (H'event and H = '1') then
                case pr_state is
                    when Etat_Check_mouv =>
                        if (cpt_l < 6) then
                            mouv_state <= "01";
                            if (A_read_type_piece(1) = '0') then -- il n'y a pas de jeton
                                nb_empty := nb_empty + 1;
                            end if;
                            cpt_l := cpt_l + 1;
                        else
                            if (nb_empty < 1) then
                                mouv_state <= "10";
                            else
                                mouv_state <= "11";
                                cpt_l := nb_empty;
                            end if;
                        end if;
                        ligne_check_mouv <= std_logic_vector(to_unsigned(cpt_l, 3));
                        colonne_check_mouv <= std_logic_vector(position);
                        
					when Etat_Effacer_pos =>
						mouv_state <= "11";
                        ligne_check_mouv <= std_logic_vector(to_unsigned(cpt_l, 3));
                        colonne_check_mouv <= std_logic_vector(position);
                        					
                    when Etat_Ecriture_mouv =>
                        ligne_check_mouv <= std_logic_vector(to_unsigned(cpt_l, 3));
                        colonne_check_mouv <= std_logic_vector(position);
                    when others =>
                        mouv_state <= "00";
                        cpt_l := 1;
                        nb_empty := 0;
                end case;
               
            end if;
    end process check_mouv;
        
    update_pos : process (pr_state,position)
        begin
            case pr_state is
                when Etat_init =>
                     position <= "000";
                when Etat_Incrementer =>
                    if ( position = "110" ) then
                        position <= "000";
                    else 
                        position <= position + 1;
                    end if;
            
                when Etat_Decrementer =>
                    if ( position = "000" ) then
                        position <= "110";
                    else
                        position <= position - 1;
                    end if;
                when Etat_Check_victoire =>
                    position <= "000";
                    
                when others =>
            end case;    
    end process update_pos;
    
        
    white_grille : process( H, RST )
        variable cpt_l : integer range 0 to 7;
        variable cpt_c : integer range 0 to 6;
        begin
            if ( RST = '1') then
                cpt_l := 0;
                cpt_c := 0;
                ligne_grille <= "000";
                colonne_grille <= "000";
                init_grille <= '0';
            elsif ( H'event and H = '1') then
                case pr_state is
                	when Etat_Init_grille => 
						if (cpt_l = 6 and cpt_c = 6) then
							 init_grille <= '1';
						else
							if (cpt_c = 6) then
								cpt_c := 0;
								cpt_l := cpt_l + 1;
						    else
						        cpt_c := cpt_c + 1;
							end if;
							
								
							init_grille <= '0';       
							ligne_grille <= std_logic_vector(to_unsigned(cpt_l, 3));
							colonne_grille <= std_logic_vector(to_unsigned(cpt_c, 3));
						end if;
					when others => 
						init_grille <= '0';
						cpt_l := 0;
						cpt_c := 0;
                		ligne_grille <= "000";
                		colonne_grille <= "000";					
                end case;
            end if;
    end process white_grille;
posled<=std_logic_vector(position);
end Behavioral;