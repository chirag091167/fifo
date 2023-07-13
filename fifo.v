module fifo(clk,rst,data_in,data_out,wr_en,rd_en,full,empty,count);

input clk,rst,wr_en,rd_en;
input[7:0] data_in;

output reg[7:0] data_out;
output reg full,empty;
output reg[7:0] count;

reg[8:0] fifo_mem[63:0];
reg wr_ptr , rd_ptr;

always@(count)
begin
  empty=(count==0);
  full=(count==63);
end

// updating count
always@(posedge clk or posedge rst)
    begin
      if(rst)
      count<=0;
      else if((!full && wr_en) && (!empty && rd_en))
      count<=count;
      else if(!full && wr_en)
      count<=count+1;
      else if(!empty && rd_en)
      count<=count-1;
      else 
      count<=count;
    end

// reading
always@(posedge clk or posedge rst)
    begin
      if(rst)
      data_out<=0;
      else if(!empty && rd_en)
      data_out<=fifo_mem[rd_ptr];
      else 
      data_out<=data_out;
    end
// writing
always@(posedge clk or posedge rst)
    begin
       if(!full && wr_en)
      fifo_mem[wr_ptr] <= data_in;
      else
      fifo_mem[wr_ptr] <= fifo_mem[wr_ptr];

    end
// pointers

always @(posedge clk or posedge rst)
begin
  if(rst)
  begin
    wr_ptr<=0;
    rd_ptr<=0;
  end
  else
    begin
      if(!empty && rd_en)
      rd_ptr<=rd_ptr-1;
      else 
      rd_ptr<=rd_ptr;
      if(!full && wr_en)
      wr_ptr<=wr_ptr+1;
      else
      wr_ptr<=wr_ptr;
    end
end
endmodule