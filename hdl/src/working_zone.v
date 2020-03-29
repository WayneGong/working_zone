module working_zone
(
    input               i_clk,
    input               i_start,
    input               i_rst,
    input   [7:0]       i_data,
    
    output reg [15:0]      o_address,
    output reg             o_done,
    output reg             o_en,
    output reg             o_we,
    output reg [7:0]       o_data
    
);

reg [4:0]   state;
reg [15:0]  o_address_dly;
reg         o_en_dly,o_we_dly;

reg [7:0]   data0;
reg [7:0]   data1;
reg [7:0]   data2;
reg [7:0]   data3;
reg [7:0]   data4;
reg [7:0]   data5;
reg [7:0]   data6;
reg [7:0]   data7;
reg [7:0]   i_addr;

wire            WZ_BIT;
reg     [2:0]   WZ_NUM;
reg     [3:0]   WZ_OFFSET;
reg     [3:0]   WZ_OFFSET_ONE_HOT;


wire    [7:0]   wz;
assign  wz[0]= (data0 <= i_addr ) && ( i_addr <= data0 +   3 );
assign  wz[1]= (data1 <= i_addr ) && ( i_addr <= data1 +   3 );
assign  wz[2]= (data2 <= i_addr ) && ( i_addr <= data2 +   3 );
assign  wz[3]= (data3 <= i_addr ) && ( i_addr <= data3 +   3 );
assign  wz[4]= (data4 <= i_addr ) && ( i_addr <= data4 +   3 );
assign  wz[5]= (data5 <= i_addr ) && ( i_addr <= data5 +   3 );
assign  wz[6]= (data6 <= i_addr ) && ( i_addr <= data6 +   3 );
assign  wz[7]= (data7 <= i_addr ) && ( i_addr <= data7 +   3 );

assign  WZ_BIT  = |wz[7:0];

parameter       WAIT        =   1  ;    
parameter       READ_DATA   =   2  ;
parameter       ENCODE      =   4  ;
parameter       WRITE       =   8   ;
parameter       DONE        =   16  ;    



always@(*)
begin
    if( WZ_BIT  ==  0 )
        o_data   =   i_addr;
    else
        o_data   =   {1'b1,WZ_NUM,WZ_OFFSET_ONE_HOT};
end

always@(*)
begin
    case(wz)
        8'b00000001 :   WZ_NUM  =   3'd0;  
        8'b00000010 :   WZ_NUM  =   3'd1;
        8'b00000100 :   WZ_NUM  =   3'd2;
        8'b00001000 :   WZ_NUM  =   3'd3;
        8'b00010000 :   WZ_NUM  =   3'd4;
        8'b00100000 :   WZ_NUM  =   3'd5;
        8'b01000000 :   WZ_NUM  =   3'd6;
        8'b10000000 :   WZ_NUM  =   3'd7;
        default     :   WZ_NUM  =   3'd0;
    endcase
end

always@(*)
begin
    case(wz)
        8'b00000001 :   WZ_OFFSET  =   i_addr - data0;  
        8'b00000010 :   WZ_OFFSET  =   i_addr - data1;
        8'b00000100 :   WZ_OFFSET  =   i_addr - data2;
        8'b00001000 :   WZ_OFFSET  =   i_addr - data3;
        8'b00010000 :   WZ_OFFSET  =   i_addr - data4;
        8'b00100000 :   WZ_OFFSET  =   i_addr - data5;
        8'b01000000 :   WZ_OFFSET  =   i_addr - data6;
        8'b10000000 :   WZ_OFFSET  =   i_addr - data7;
        default     :   WZ_OFFSET  =   4'd0;
    endcase
end

always@(*)
begin
    case(WZ_OFFSET)
        0 :   WZ_OFFSET_ONE_HOT  =   4'b0001;  
        1 :   WZ_OFFSET_ONE_HOT  =   4'b0010;
        2 :   WZ_OFFSET_ONE_HOT  =   4'b0100;
        3 :   WZ_OFFSET_ONE_HOT  =   4'b1000;

        default :   WZ_OFFSET_ONE_HOT  =   4'd0;
    endcase
end



always@(posedge i_clk)
begin
    if( i_rst )
        o_address    <=  'b0;
    else if( state == WAIT  )
        o_address    <=  'b0;
    else if( state == WRITE  )
        o_address    <=  9;
    else if( state == READ_DATA  )
        o_address    <=  o_address  +   1'b1;
    else
        o_address    <=  o_address;
end


always@(posedge i_clk)
begin
    if( i_rst )
        o_done    <=  1'b0;
    else if( state == DONE  )
        o_done    <=  1'b1;
    else
        o_done    <=  1'b0;
end


always@(*)
begin
    if( i_rst )
        o_en    <=  1'b0;
    else if( state == READ_DATA || state == WRITE )
        o_en    <=  1'b1;
    else
        o_en    <=  1'b0;
end

always@(posedge i_clk)
begin
    if( i_rst ) begin
        o_address_dly   <=  'b0;
        o_en_dly        <=  'b0;
        o_we_dly        <=  'b0;
    end
    else begin
        o_address_dly   <=  o_address;
        o_en_dly        <=  o_en;
        o_we_dly        <=  o_we;
    end
end


always@(*)
begin
    if( state == WRITE )
        o_we    <=  1'b1;
    else
        o_we    <=  1'b0;
end

wire    i_data_en =   o_en_dly && !o_we_dly;

always@(posedge i_clk)
begin
    if( i_rst ) 
        data0   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 0 ) )       
        data0   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data1   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 1 ) )       
        data1   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data2   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 2 ) )       
        data2   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data3   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 3 ) )       
        data3   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data4   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 4 ) )       
        data4   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data5   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 5 ) )       
        data5   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data6   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 6 ) )       
        data6   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        data7   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 7 ) )       
        data7   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst ) 
        i_addr   <=  8'b0;
    else if( ( i_data_en ) && ( o_address_dly == 8 ) )       
        i_addr   <=  i_data;       
end

always@(posedge i_clk)
begin
    if( i_rst )
        state   <=  WAIT;
    else case( state )
        WAIT       : 
            if( i_start )
                state   <=  READ_DATA;
        
        READ_DATA  :
            if( o_address == 8 )
                state   <=  ENCODE;
        
        ENCODE     : 
                state   <=  WRITE;
        WRITE      :
                state   <=  DONE;
        DONE       : 
            if( i_start == 0 )
                state   <=  WAIT;
            else
                state   <=  state ;      
    endcase
end

endmodule 

