----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime ALBERTY & Clement SAVARY
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
          
           LED : out STD_LOGIC_VECTOR(1  downto 0)
           );
end FSM;

architecture Behavioral of FSM is

    type Etat is ( Etat_init, Etat_Init_grille,ATT_W_readyR,ATT_W_readyL,ATT_W_readyC, Etat_Affichage_jeu,Etat_next_player, Etat_Effacer_posL,Etat_Effacer_posR, Etat_Incrementer, Etat_Decrementer, Etat_Ecriture_pos, Etat_Check_mouv, Etat_Effacer_mouv, Etat_Ecriture_mouv,Etat_Check_victoire_init, Etat_Check_victoire, Etat_Victoire);
	signal pr_state , nx_state : Etat := Etat_init;
	
	type Joueur is (Joueur_Rouge, Joueur_Jaune);
	signal player : Joueur := Joueur_Rouge; 
	
	
	signal position :  unsigned (2 downto 0) := "000"; -- Curseur du joueur
	signal end_check :   std_logic :='0';
	signal r_end_check :   std_logic :='0';
	-- white_grille process
	signal init_grille :   std_logic;                          -- flag to check if initialization ok 
	signal ligne_grille :  std_logic_vector (2 downto 0);      -- signal for initialization
	signal colonne_grille : std_logic_vector (2 downto 0);     -- signal for initialization

	
	-- check_mouv process
	signal mouv_state : std_logic_vector (1 downto 0); -- Result of check_mouv
	signal ligne_check_mouv :  std_logic_vector (2 downto 0);
	signal ligne_write_mouv :  std_logic_vector (2 downto 0);
	
	 
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
    
   

------
-- Calcul du nouvel etat en fonction des entrées
------    
    cal_nx_state : process (pr_state, btnC, btnL, btnR, init_grille , mouv_state, B_state_victoire,W_Ready)
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
                        nx_state <= ATT_W_readyC;
                    elsif( btnL = '1' ) then
                        nx_state <= ATT_W_readyL;
                    elsif( btnR = '1' ) then
                       nx_state <= ATT_W_readyR;
                    else
                        nx_state <= Etat_Affichage_jeu;
                    end if;
               when ATT_W_readyC =>
                      if(W_Ready='1')then
                             nx_state<=Etat_Check_mouv;
                        else
                             nx_state<=ATT_W_readyC;
                        end if;
                
               when ATT_W_readyR =>
                        if(W_Ready='1')then
                             nx_state<=Etat_Effacer_posR;
                        else
                             nx_state<=ATT_W_readyR;
                        end if;
                when ATT_W_readyL =>
                        if(W_Ready='1')then
                             nx_state<=Etat_Effacer_posL;
                        else
                             nx_state<=ATT_W_readyL;
                        end if;
            
                         
                         
                when Etat_Effacer_posR =>
                    -- Effacement du jeton à la position actuelle
                  
                        nx_state <= Etat_Incrementer;
                        
                 when Etat_Effacer_posL =>
                    -- Effacement du jeton à la position actuelle
                  
                        nx_state <= Etat_Decrementer;  
                
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
                            nx_state <= Etat_Effacer_mouv;
                        when others =>
                            nx_state <= Etat_Check_mouv;
                    end case;
                    
                when Etat_Effacer_mouv =>    
                    nx_state <=  Etat_Ecriture_mouv;
                    
                when Etat_Ecriture_mouv =>
                    nx_state <= Etat_Check_victoire_init;
                    
                when Etat_next_player =>
                     nx_state <= Etat_Ecriture_pos;
                 
                when Etat_Check_victoire_init =>
                   if(B_state_victoire="00")then
                    nx_state <= Etat_Check_victoire;
                  end if;
                when Etat_Check_victoire =>
                    case B_state_victoire is
                        when "11" =>
                            nx_state <= Etat_next_player;
                        when "10" =>    -- Yellow win
                            
                              nx_state <= Etat_Victoire;
                            
                        when "01" =>    -- Red win
                             
                              nx_state <= Etat_Victoire;
                             
                          
                        when others =>    -- Check_victoire ongoing
                            nx_state <= Etat_Check_victoire;
                    end case;    
                    
               
                
                  
                       
                when Etat_Victoire =>
                
                
                
                
                    --if( btnC = '1' ) then
                        nx_state <= Etat_Victoire;
                   -- end if;
                    
                when others =>
                    nx_state <= Etat_Init_grille;
            end case;
        end process cal_nx_state;

------
-- Mise à jours des sorties en fonction de l'état courant
------    
    cal_output : process( pr_state, ligne_grille, colonne_grille, ligne_check_mouv,position,player,B_state_victoire)
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
				        E_write_type_piece <= "100"; --white_square
				    else
						E_write_type_piece <= "000";  --blue_circle
					end if;    
                    F_RW_plateau        <= '1'; 
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                    LED<="00";
                when Etat_next_player=>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
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
                 when ATT_W_readyR =>    
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                 when ATT_W_readyL =>    
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                 when ATT_W_readyC =>    
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                when Etat_Effacer_posR =>
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= std_logic_vector(position);   
                    E_write_type_piece  <= "100";
                    F_RW_plateau        <= '1';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                  when Etat_Effacer_posL =>
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
                    if (player = Joueur_Rouge) then
                        E_write_type_piece   <= "001";
                    elsif (player = Joueur_Jaune)then
                        E_write_type_piece   <= "101";
                    end if;
                    F_RW_plateau        <= '1';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                
                
                
                    
                when Etat_Check_mouv =>
                    C_ligne_grille       <= ligne_check_mouv;
                    D_colonne_grille     <= std_logic_vector(position);
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '0';
                    
				when Etat_Effacer_mouv =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= std_logic_vector(position);
                    E_write_type_piece   <= "100";
                    F_RW_plateau         <= '1';
                    G_en_verif           <= '0';
                    H_sel_LC             <= '0';
                    I_AFF_plateau       <= '0';

				when Etat_Ecriture_mouv =>
                    C_ligne_grille       <= ligne_write_mouv;
                    D_colonne_grille     <= std_logic_vector(position);
                    if (player = Joueur_Rouge) then
                        E_write_type_piece   <= "010";
                    elsif (player = Joueur_Jaune)then
                        E_write_type_piece   <= "110";
                    end if;
                    F_RW_plateau         <= '1';
                    G_en_verif           <= '0';
                    H_sel_LC             <= '0'; 
                    I_AFF_plateau       <= '0';    
                                             
								
                when Etat_Check_victoire_init =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '1';
                    H_sel_LC            <= '1';
                    I_AFF_plateau       <= '0';
                    
                when Etat_Check_victoire =>
                    C_ligne_grille       <= "000";
                    D_colonne_grille     <= "000";
                    E_write_type_piece   <= "000";
                    F_RW_plateau         <= '0';
                    G_en_verif           <= '0';
                    H_sel_LC            <= '1';
                    I_AFF_plateau       <= '0';
                    LED<=B_state_victoire;
              
                    
                when Etat_Victoire =>
                    C_ligne_grille      <= "000";
                    C_ligne_grille      <= "000";
                    D_colonne_grille    <= "000";   
                    E_write_type_piece  <= "000";
                    F_RW_plateau        <= '0';
                    G_en_verif          <= '0';
                    H_sel_LC            <= '0';
                    I_AFF_plateau       <= '1';

                
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

    
    
     cpt_check_mouv : process ( H, RST)
        variable cpt_l : integer range 0 to 6;
        begin
            if (RST = '1') then 
                cpt_l := 0;
            elsif (H'event and H = '1') then
              case pr_state is
                 when Etat_Check_mouv=>
                        if(cpt_l<6)then      
                          cpt_l :=  cpt_l +1;
                         else
                           r_end_check<='1';
                           end_check<= r_end_check;
                        end if; 
                  when others=>
                     cpt_l := 0;  
                     r_end_check<='0';
                     end_check<= r_end_check;
                    
                  end case;
                   ligne_check_mouv <= std_logic_vector(to_unsigned(cpt_l, 3));
                   
            end if;
    end process  cpt_check_mouv;
    
    check_mouv : process (H,RST,end_check,A_read_type_piece,pr_state)
        variable  nb_empty : integer range 0 to 6;
        begin
         if (RST = '1') then 
                  mouv_state <= "00";
                  nb_empty:=0;
            elsif (H'event and H = '1') then
          
                  if(pr_state=Etat_Check_mouv)then
                       if (A_read_type_piece = "000" and end_check='0') then -- il n'y a pas de jeton
                           nb_empty := nb_empty + 1;
                       end if;
                       if( end_check='1')then
                           if (nb_empty =0) then
                                  mouv_state <= "10";
                           else
                                  mouv_state <= "11";
                           end if;

                       end if;
                       ligne_write_mouv<=std_logic_vector(to_unsigned(nb_empty, 3));
                  else
                     mouv_state <= "00";
                     nb_empty:=0;
                  end if;
           end if;
    end process  check_mouv;
    
    
    
        
    update_pos : process (pr_state,position,RST,H)
        begin
         if ( RST = '1') then
               position <= "000";
            elsif ( H'event and H = '1') then
            case pr_state is
                when Etat_init_grille =>
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

                    
                when others =>
            end case;    
        end if;
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
    
    

update_player : process (pr_state,RST,H,player)
        begin
         if ( RST = '1') then
                player <= Joueur_Rouge;
            elsif ( H'event and H = '1') then
            case pr_state is
                when Etat_next_player =>
                      case player is
                          when Joueur_Rouge =>
                                player <= Joueur_Jaune;
                          when Joueur_Jaune =>
                                player <= Joueur_Rouge;
                        end case; 
                    
                when others =>
            end case;    
        end if;
    end process update_player;
   
   
 end Behavioral;