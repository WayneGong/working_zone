library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;


entity project_reti_logiche is
  port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
);

end entity project_reti_logiche;

architecture behavioral of project_reti_logiche is

signal  o_address_dly:std_logic_vector(15 downto 0);
signal  o_en_dly:std_logic;
signal  o_we_dly:std_logic;
signal  data0:std_logic_vector(7 downto 0);
signal  data1:std_logic_vector(7 downto 0);
signal  data2:std_logic_vector(7 downto 0);
signal  data3:std_logic_vector(7 downto 0);
signal  data4:std_logic_vector(7 downto 0);
signal  data5:std_logic_vector(7 downto 0);
signal  data6:std_logic_vector(7 downto 0);
signal  data7:std_logic_vector(7 downto 0);
signal  i_addr:std_logic_vector(7 downto 0);
signal  o_address_temp :std_logic_vector(15 downto 0);

signal  o_en_temp :std_logic;
signal  o_we_temp :std_logic;

signal  i_data_en:std_logic;
signal  WZ_BIT:std_logic;
signal  WZ_NUM:std_logic_vector(2 downto 0);
signal  WZ_OFFSET:std_logic_vector(7 downto 0);
signal  WZ_OFFSET_ONE_HOT:std_logic_vector(3 downto 0);
signal  wz0,wz1,wz2,wz3,wz4,wz5,wz6,wz7:std_logic;
signal  wz:std_logic_vector(7 downto 0);

TYPE State_type IS (IDLE, READ_DATA, ENCODE, WRITE_DATA ,DONE   );  -- 定义状�??
SIGNAL state : State_type;    -- 创建信号 


begin

  o_address <=  o_address_temp;
  o_en      <=  o_en_temp;  
  o_we      <=  o_we_temp; 
  
process(wz0,wz1,wz2,wz3,wz4,wz5,wz6,wz7)
begin
    WZ_BIT  <= ( wz0 or wz1 or wz2 or wz3 or wz4 or wz5 or wz6 or wz7);
    wz  <=  wz7 & wz6 & wz5 & wz4 & wz3 & wz2 & wz1 & wz0;
end process;

process(i_addr,data0)
begin
    if( (  data0 <= i_addr ) and ( i_addr <= data0 +   3 ) )then
        wz0 <=  '1';
    else
        wz0 <=  '0';
    end if;        
end process;

process(i_addr,data1)
begin
    if( (  data1 <= i_addr ) and ( i_addr <= data1 +   3 ) )then
        wz1 <=  '1';
    else
        wz1 <=  '0';
    end if;        
end process;

process(i_addr,data2)
begin
    if( (  data2 <= i_addr ) and ( i_addr <= data2 +   3 ) )then
        wz2 <=  '1';
    else
        wz2 <=  '0';
    end if;        
end process;

process(i_addr,data3)
begin
    if( (  data3 <= i_addr ) and ( i_addr <= data3 +   3 ) )then
        wz3 <=  '1';
    else
        wz3 <=  '0';
    end if;        
end process;

process(i_addr,data4)
begin
    if( (  data4 <= i_addr ) and ( i_addr <= data4 +   3 ) )then
        wz4 <=  '1';
    else
        wz4 <=  '0';
    end if;        
end process;

process(i_addr,data5)
begin
    if( (  data5 <= i_addr ) and ( i_addr <= data5 +   3 ) )then
        wz5 <=  '1';
    else
        wz5 <=  '0';
    end if;        
end process;

process(i_addr,data6)
begin
    if( (  data6 <= i_addr ) and ( i_addr <= data6 +   3 ) )then
        wz6 <=  '1';
    else
        wz6 <=  '0';
    end if;        
end process;

process(i_addr,data7)
begin
    if( (  data7 <= i_addr ) and ( i_addr <= data7 +   3 ) )then
        wz7 <=  '1';
    else
        wz7 <=  '0';
    end if;        
end process;


process(WZ_BIT,i_addr,WZ_NUM,WZ_OFFSET_ONE_HOT)
begin
    if( WZ_BIT  =  '0' )  then
        o_data   <=   i_addr;
    else
        o_data   <=   '1'& WZ_NUM & WZ_OFFSET_ONE_HOT ;
    end if;
end process;

process(wz)
begin
    case wz is
        when "00000001" =>   WZ_NUM  <=   "000";  
        when "00000010" =>   WZ_NUM  <=   "001";
        when "00000100" =>   WZ_NUM  <=   "010";
        when "00001000" =>   WZ_NUM  <=   "011";
        when "00010000" =>   WZ_NUM  <=   "100";
        when "00100000" =>   WZ_NUM  <=   "101";
        when "01000000" =>   WZ_NUM  <=   "110";
        when "10000000" =>   WZ_NUM  <=   "111";
        WHEN OTHERS     =>   WZ_NUM  <=   "000";
    end case;
end process;

process(wz)
begin
    case wz is
        when "00000001" =>   WZ_OFFSET  <=   i_addr - data0;  
        when "00000010" =>   WZ_OFFSET  <=   i_addr - data1;
        when "00000100" =>   WZ_OFFSET  <=   i_addr - data2;
        when "00001000" =>   WZ_OFFSET  <=   i_addr - data3;
        when "00010000" =>   WZ_OFFSET  <=   i_addr - data4;
        when "00100000" =>   WZ_OFFSET  <=   i_addr - data5;
        when "01000000" =>   WZ_OFFSET  <=   i_addr - data6;
        when "10000000" =>   WZ_OFFSET  <=   i_addr - data7;
        WHEN OTHERS     =>   WZ_OFFSET  <=   "00000000";
    end case;
end process;


process(WZ_OFFSET)
begin
    case WZ_OFFSET is
        when "00000000" =>   WZ_OFFSET_ONE_HOT  <=   "0001";  
        when "00000001" =>   WZ_OFFSET_ONE_HOT  <=   "0010";
        when "00000010" =>   WZ_OFFSET_ONE_HOT  <=   "0100";
        when "00000011" =>   WZ_OFFSET_ONE_HOT  <=   "1000";
        WHEN OTHERS => WZ_OFFSET_ONE_HOT  <=   "0000";       
    end case;
end process;

process( i_clk)
begin
    if( i_rst = '1' ) then
        o_address_temp    <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then         
        if( state = IDLE  ) then
            o_address_temp    <=  (others=>'0');
        elsif( state = WRITE_DATA  )then
            o_address_temp    <=  std_logic_vector(to_unsigned(9, 16));
        elsif( state = READ_DATA  )then
            o_address_temp    <=  o_address_temp  +   '1';
        else
            o_address_temp    <=  o_address_temp;
        end if;
    end if;
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        o_done  <=  '0';
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( state = DONE  ) then
            o_done <= '1';
        else
            o_done <= '0';
        end if;
    end if;
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        o_address_dly   <=  (others=>'0');
        o_en_dly        <=  '0';
        o_we_dly        <=  '0';
    elsif ( i_clk'event and i_clk = '1' ) then    
        o_address_dly   <=  o_address_temp;
        o_en_dly        <=  o_en_temp;
        o_we_dly        <=  o_we_temp;
    end if;
end process;

process(state)
begin
    if( state = READ_DATA or state = WRITE_DATA )then
        o_en_temp    <=  '1';
    else
        o_en_temp    <=  '0';
    end if;
end process;


process(state)
begin
    if( state = WRITE_DATA )then
        o_we_temp    <=  '1';
    else
        o_we_temp    <=  '0';
    end if;
end process;

process(o_en_dly ,o_we_dly)
begin
    i_data_en <=   o_en_dly and  ( not o_we_dly );
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data0   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 0 ) )then    
            data0   <=  i_data;
        else
            data0   <=  data0   ;
        end if;
    end if;    
end process;


process( i_clk )
begin
    if( i_rst = '1' ) then
        data1   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 1 ) )then    
            data1   <=  i_data;
        else
            data1   <=  data1   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data2   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 2 ) )then    
            data2   <=  i_data;
        else
            data2   <=  data2   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data3   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 3 ) )then    
            data3   <=  i_data;
        else
            data3   <=  data3   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data4   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 4 ) )then    
            data4   <=  i_data;
        else
            data4   <=  data4   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data5   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 5 ) )then    
            data5   <=  i_data;
        else
            data5   <=  data5   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data6   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 6 ) )then    
            data6   <=  i_data;
        else
            data6   <=  data6   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        data7   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 7 ) )then    
            data7   <=  i_data;
        else
            data7   <=  data7   ;
        end if;
    end if;    
end process;

process( i_clk )
begin
    if( i_rst = '1' ) then
        i_addr   <=  (others=>'0');
    elsif ( i_clk'event and i_clk = '1' ) then 
        if( ( i_data_en = '1' ) and ( o_address_dly = 8 ) )then    
            i_addr   <=  i_data;
        else
            i_addr   <=  i_addr   ;
        end if;
    end if;    
end process;

process (i_clk)  
begin
    if( i_rst = '1' ) then
        state   <=  IDLE;
    elsif ( i_clk'event and i_clk = '1' ) then
        CASE state is
            when IDLE   => 
                if( i_start = '1') then               
                   state   <=  READ_DATA;                 
                end if;           
            when READ_DATA  =>
                if( o_address_temp = 8 ) then
                    state   <=  ENCODE;                  
                end if;             
            when ENCODE =>                
                    state   <=  WRITE_DATA;
            when WRITE_DATA=>                
                    state   <=  DONE;
            when DONE   =>
                if( i_start = '0' ) then
                    state   <=  IDLE;
                else    
                    state   <=  DONE;      
                
                end if; 
        end case;
    end if;
end process;
    --IDLE, READ_DATA, ENCODE, WRITE_DATA ,DONE

end behavioral;