module fifo_tb();
reg clk,rst,wr_en,rd_en;
reg[7:0] data_in;

wire[7:0] data_out;
wire full,empty;
wire[7:0] count;


fifo f(clk,rst,data_in,data_out,wr_en,rd_en,full,empty,count);

initial
begin
  clk<=0;
  rst<=1;
end

always #5 clk<=~clk;

initial
        begin
        $dumpfile("fifo.vcd");
        $dumpvars(0,fifo_tb);
        // write 8'b11001100;
        #7
        rst<=0;
        #5
        wr_en<=1;
        data_in<= 8'b11001100;
        #5 wr_en<=0;

        #5 rd_en<=1;
        // #5 rd_en<=0;

        #20 $finish;
        end

endmodule