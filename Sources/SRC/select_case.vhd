----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 14:47:31
-- Design Name: 
-- Module Name: select_case - Behavioral
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

entity select_case is
    Port ( C_case : in STD_LOGIC_VECTOR (2 downto 0);
           L_case : in STD_LOGIC_VECTOR (2 downto 0);
           px_HG : out STD_LOGIC_VECTOR (15 downto 0);
           px_BD : out STD_LOGIC_VECTOR (15 downto 0));
end select_case;

architecture Behavioral of select_case is


begin

with C_case select
    px_HG(15 downto 8) <=   std_logic_vector(to_unsigned(34,8)) when "000",
                            std_logic_vector(to_unsigned(48,8)) when "001",
                            std_logic_vector(to_unsigned(62,8)) when "010",
                            std_logic_vector(to_unsigned(76,8)) when "011",
                            std_logic_vector(to_unsigned(90,8)) when "100",
                            std_logic_vector(to_unsigned(104,8)) when "101",
                            std_logic_vector(to_unsigned(118,8)) when others;
with C_case select                            
    px_BD(15 downto 8) <=   std_logic_vector(to_unsigned(43,8)) when "000",
                            std_logic_vector(to_unsigned(57,8)) when "001",
                            std_logic_vector(to_unsigned(71,8)) when "010",
                            std_logic_vector(to_unsigned(85,8)) when "011",
                            std_logic_vector(to_unsigned(99,8)) when "100",
                            std_logic_vector(to_unsigned(113,8)) when "101",
                            std_logic_vector(to_unsigned(127,8)) when others;
with L_case select                            
    px_HG(7 downto 0) <=    std_logic_vector(to_unsigned(17,8)) when "000",
                            std_logic_vector(to_unsigned(31,8)) when "001",
                            std_logic_vector(to_unsigned(45,8)) when "010",
                            std_logic_vector(to_unsigned(59,8)) when "011",
                            std_logic_vector(to_unsigned(73,8)) when "100",
                            std_logic_vector(to_unsigned(87,8)) when others;
with L_case select                            
    px_BD(7 downto 0) <=    std_logic_vector(to_unsigned(26,8)) when "000",
                            std_logic_vector(to_unsigned(40,8)) when "001",
                            std_logic_vector(to_unsigned(54,8)) when "010",
                            std_logic_vector(to_unsigned(68,8)) when "011",
                            std_logic_vector(to_unsigned(82,8)) when "100",
                            std_logic_vector(to_unsigned(96,8)) when others;
                          
end Behavioral;
