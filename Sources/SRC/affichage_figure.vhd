----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:36:07
-- Design Name: 
-- Module Name: affichage_figure - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity affichage_figure is
    port (
            ce : in std_logic;
            clk : in std_logic;
            reset : in std_logic;
            in_HG : in std_logic_vector(15 downto 0);
            in_BD : in std_logic_vector(15 downto 0);
            init_cpt : in STD_LOGIC;
            out_adr : out std_logic_vector(13 downto 0);
            data_ok: out std_logic
    );
end affichage_figure;

architecture Behavioral of affichage_figure is
begin
    process(clk,reset)
    --variable Nb_pixel_HG: integer range 0 to 15999;
    --variable Nb_pixel_BD: integer range 0 to 15999;
    variable Nb_HGL:integer range 0 to 100;
    variable Nb_HGC:integer range 0 to 160;
    variable Nb_BDL:integer range 0 to 100;
    variable Nb_BDC:integer range 0 to 160;
    variable cpt_c: integer range 0 to 8;
    variable cpt_l: integer range 0 to 8;
    variable flag: boolean :=false;
    begin
        if(reset = '1') then
            cpt_l := 0;
            cpt_c := 0;
            --Nb_pixel_HG:= 0;
            --Nb_pixel_BD:=0;
            Nb_HGL:=0;
            Nb_HGC:=0;
            Nb_BDL:=0;
            Nb_BDC:=0;
            data_ok <='0';
            out_adr<="00000000000000";
        elsif (clk'event and clk ='1') then
            if (ce = '1') then
                if(init_cpt = '1') then
                         Nb_HGL:=to_integer(unsigned(in_HG(7 downto 0)));
                         Nb_HGC:=to_integer(unsigned(in_HG(15 downto 8)));
                         Nb_BDL:=to_integer(unsigned(in_BD(7 downto 0)));
                         Nb_BDC:=to_integer(unsigned(in_BD(15 downto 8)));
                         --Nb_pixel_HG:=160*to_integer(unsigned(in_HG(7 downto 0)))+to_integer(unsigned(in_HG(15 downto 8)));
                         --Nb_pixel_BD:=160*to_integer(unsigned(in_BD(7 downto 0)))+to_integer(unsigned(in_BD(15 downto 8)));
                         cpt_l := 0;
                         cpt_c := 0;
                         data_ok<='0';
                         flag:=false;
                         
                 elsif(Nb_HGC>Nb_BDC or Nb_HGL>Nb_BDL or Nb_BDC>160 or Nb_HGC>160 or Nb_BDL>100 or Nb_HGL>100 or Nb_BDC<0 or Nb_HGC<0 or Nb_BDL<0 or Nb_HGL<0) then
                    --ERREUR
                        flag:=false;
                        out_adr <="11111111111111";
                 else
                    if(flag=true)then
                         if(cpt_c /= (Nb_BDC-Nb_HGC) or cpt_l /= (Nb_BDL-Nb_HGL)) then
                             if(cpt_c<(Nb_BDC-Nb_HGC)) then
                                    cpt_c := cpt_c + 1;
                             else
                                    cpt_c:=0;
                                    cpt_l:=cpt_l+1;
                             end if;
                         else
                               data_ok<='1';
                         end if;
                    end if;
                        flag:=true;
                        out_adr <= std_logic_vector(to_unsigned((160*to_integer(unsigned(in_HG(7 downto 0)))+to_integer(unsigned(in_HG(15 downto 8))))+cpt_c+(160*cpt_l), 14));
                 end if;    
            end if;
        end if;
    end process;
end Behavioral;
