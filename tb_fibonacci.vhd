library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 

entity tb_fibonacci is
-- Port ( );
end tb_fibonacci;


architecture Behavioral of tb_fibonacci is
component fibonacci
port (clk,reset: in std_logic;
start: in std_logic;
n: in std_logic_vector;
output:out std_logic_vector
);
end component;

signal clk_tb , reset_tb : std_logic :='0';
signal output_tb:STD_LOGIC_VECTOR(49 DOWNTO 0):=(others=>'0');
signal n_tb : STD_LOGIC_VECTOR(5 DOWNTO 0):="111111";
signal start_tb : std_logic :='1';
--signal finish_tb : std_logic :='0';

begin
uut: fibonacci port map ( clk=>clk_tb,reset=>reset_tb,n=>n_tb,output=>output_tb,start=>start_tb);

reset_process : process
begin
    reset_tb <= '1';
    for i in 1 to 2 loop
        wait until clk_tb = '1';
    end loop;
    reset_tb <= '0';
    wait;
end process;

clock_gen: process
constant clk_period : time := 500ns;
begin
    clk_tb <= '0';
    wait for clk_period/2;
    clk_tb <= '1';
    wait for clk_period/2;
end process;

end Behavioral;