----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:36:07
-- Design Name: 
-- Module Name: grille - Behavioral
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

entity grille is
    port (
            ce : in std_logic;
            clk : in std_logic;
            reset : in std_logic;
            in_HG : in std_logic_vector(15 downto 0);
            in_data: in std_logic_vector(1 downto 0);
            init_cpt : in STD_LOGIC;
            out_adr : out std_logic_vector(13 downto 0);
            out_data : out std_logic_vector(2 downto 0);
            data_ok: out std_logic
    );
end grille;

architecture Behavioral of grille is
begin
    process(clk,reset)
    variable Nb_pixel_HG: integer range 0 to 15999;
    variable cpt_c: integer range 0 to 8;
    variable cpt_l: integer range 0 to 8;
    variable flag: boolean :=false;
    begin
        if(reset = '1') then
            cpt_l := 0;
            cpt_c := 0;
            Nb_pixel_HG:= 0;
            data_ok <='0';
            out_adr<="00000000000000";
            out_data<="000";
        elsif (clk'event and clk ='1') then
            if (ce = '1') then
                if(init_cpt = '1') then
                         Nb_pixel_HG:=160*to_integer(unsigned(in_HG(7 downto 0)))+to_integer(unsigned(in_HG(15 downto 8)));
                         cpt_l := 0;
                         cpt_c := 0;
                         data_ok<='0';
                         flag:=false;
                 else
                    if(flag=false)then
                         if(cpt_c /= 8 or cpt_l /= 8) then
                             if(cpt_c<8) then
                                    cpt_c := cpt_c + 1;
                             else
                                    cpt_c:=0;
                                    cpt_l:=cpt_l+1;
                             end if;
                         else
                               data_ok<='1';
                         end if;
                    end if;
                 end if;
                 case in_data is
                      when "01" =>   out_data <= "100"; --Red
                      when "10" =>   out_data <= "110"; --Yellow
                      when others => out_data <= "111"; --White
                 end case;
                    if(Nb_pixel_HG<11220)then
                        out_adr <= std_logic_vector(to_unsigned(Nb_pixel_HG+cpt_c+(160*cpt_l), 14));
                        flag:=true;
                    else
                        out_adr<="00000000000000";
                    end if;
                 end if;
        end if;
    end process;
      

    
end Behavioral;
