-- Single-Port Block RAM Write-First Mode (recommended template)
--
-- File: rams_02.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rams_sp_wf is
    generic (
        DWIDTH  : INTEGER :=8;
        AWIDTH  : INTEGER :=4;
        DEPTH   : INTEGER :=16       
        
        );
port(
 clk : in std_logic;
 we : in std_logic;
 en : in std_logic;
 addr : in std_logic_vector(AWIDTH-1 downto 0);
 di : in std_logic_vector(DWIDTH-1 downto 0);
 do : out std_logic_vector(DWIDTH-1 downto 0)
);
end rams_sp_wf;

architecture syn of rams_sp_wf is

type ram_type is array (DEPTH-1 downto 0) of std_logic_vector(DWIDTH-1 downto 0);
signal RAM : ram_type;

begin
process(clk)
begin
    if clk'event and clk = '1' then
        if en = '1' then
            if we = '1' then
                RAM(conv_integer(addr)) <= di;
                do <= di;
            else
                do <= RAM(conv_integer(addr));
            end if;
        end if;
    end if;
end process;
end syn;