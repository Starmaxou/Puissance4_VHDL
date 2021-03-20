----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 13:48:59
-- Design Name: 
-- Module Name: mem_figure - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_figure is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           en_mem : in STD_LOGIC;
           in_addr_figure : in STD_LOGIC_VECTOR (13 downto 0);
           num_figure : in STD_LOGIC_VECTOR (2 downto 0);
           out_data : out STD_LOGIC_VECTOR (2 downto 0));
end mem_figure;

architecture Behavioral of mem_figure is

type tab_mem is array (0 to 15999) of std_logic_vector(2 downto 0);

signal yellow_white : tab_mem := ("111","111","111","110","110","110","110","111","111","111","111","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","111","111","111","111","110","110","110","110","111","111","111",others => "111");
signal red_white : tab_mem := ("111","111","111","100","100","100","100","111","111","111","111","100","100","100","100","100","100","100","100","111","111","100","100","100","100","100","100","100","100","111","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","111","100","100","100","100","100","100","100","100","111","111","100","100","100","100","100","100","100","100","111","111","111","111","100","100","100","100","111","111","111",others => "111");
signal yellow_blue : tab_mem := ("001","001","001","110","110","110","110","001","001","001","001","110","110","110","110","110","110","110","110","001","001","110","110","110","110","110","110","110","110","001","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","001","110","110","110","110","110","110","110","110","001","001","110","110","110","110","110","110","110","110","001","001","001","001","110","110","110","110","001","001","001",others => "111");
signal red_blue : tab_mem := ("001","001","001","100","100","100","100","001","001","001","001","100","100","100","100","100","100","100","100","001","001","100","100","100","100","100","100","100","100","001","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","100","001","100","100","100","100","100","100","100","100","001","001","100","100","100","100","100","100","100","100","001","001","001","001","100","100","100","100","001","001","001",others => "111");
signal blue_circle : tab_mem := ("001","001","001","111","111","111","111","001","001","001","001","111","111","111","111","111","111","111","111","001","001","111","111","111","111","111","111","111","111","001","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","001","111","111","111","111","111","111","111","111","001","001","111","111","111","111","111","111","111","111","001","001","001","001","111","111","111","111","001","001","001",others => "111");
signal white_square : tab_mem :=(others => "111");
begin
    process(clk)
    begin
        if(clk = '1' and clk'event) then
         if(ce='1') then
            if(en_mem='1')then
                case num_figure is
                    when "001" =>
                        out_data <= yellow_white(to_integer(unsigned(in_addr_figure)));
                    when "010" =>
                        out_data <= red_white(to_integer(unsigned(in_addr_figure)));
                    when "011" =>
                        out_data <= yellow_blue(to_integer(unsigned(in_addr_figure)));
                    when "100" =>
                        out_data <= red_blue(to_integer(unsigned(in_addr_figure)));
                    when "000" =>
                         out_data <= blue_circle(to_integer(unsigned(in_addr_figure)));
                    when others =>
                         out_data <= white_square(to_integer(unsigned(in_addr_figure)));
                end case;          
            end if;
         end if;
        end if;
    end process;

end Behavioral;