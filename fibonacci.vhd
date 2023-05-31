library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity fibonacci is
Port ( n : in std_logic_vector(5 downto 0);
clk : in STD_LOGIC;
reset : in STD_LOGIC;
start : in STD_LOGIC;
output : out std_logic_vector (49 downto 0));
end fibonacci;


architecture Behavioral of fibonacci is
type state_type is (idle, ab0,ab1 ,load,op,stop);
constant Width:integer :=50;
signal state_reg, state_next : state_type;
signal a_reg,a_next,b_reg,b_next:std_logic_vector(Width-1 downto 0);
signal output_reg,output_next:std_logic_vector(Width-1 downto 0);
signal count:std_logic_vector(5 downto 0);
signal count_next:std_logic_vector(5 downto 0);

begin
-- state and data registers
process (CLK, RESET) is
begin
    if RESET = '1' then
        state_reg <= idle;
        a_reg <= (others=>'0');
        b_reg <=(others=>'0');
        output_reg <= (others=>'0');
    elsif CLK'event and CLK='1' then
        state_reg <= state_next;
        a_reg <= a_next;
        b_reg <= b_next;
        output_reg <= output_next;
        count<=count_next;
    end if;
end process;

-- combinational circuit
process (n,start, state_reg, a_reg,a_next, b_reg,b_next, count,output_reg, output_next) is
begin
    -- default value
    a_next <= a_reg;
    b_next <= b_reg;
    output_next <= output_reg;
    
    case state_reg is
    when idle =>
        if start = '1' then
            if (n="000000") then
                state_next <= ab0;
            else if(n="000001")then
                state_next <= ab1;
                else
                    state_next <= load;
                end if;
            end if;
            else
                state_next <= idle;
        end if;
        
    when ab0 =>
        output_next<=(others=>'0');
        state_next <= idle;
    
    when ab1 =>
        output_next<="00000000000000000000000000000000000000000000000001";
        state_next <= idle;
        
    when stop =>
    output_next<=output_reg;
    state_next <= stop;
    
    when load =>
        count_next<="000000";
        a_next <="00000000000000000000000000000000000000000000000001";
        b_next <= (others=>'0');
        state_next <= op;
    
    when op =>
        count_next<=count+1;
        output_next<=a_reg+b_reg;
        b_next<=a_reg;
        a_next<=output_next;
        if (count = 61) then
            state_next <= stop;
        else
            state_next <= op;
        end if ;
    end case;
end process;

output <= output_next;

end architecture Behavioral;