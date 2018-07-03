`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 12:56:52
// Design Name: 
// Module Name: CounterModTen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CounterModTen(clk,rst,start,q);
/*MOD 10 Counter Module*/
input clk;//clock signal
input rst;//reset signal
input start;//start signal
output reg [3:0] q;// output
always @(posedge clk or posedge rst) //up signal or reset signal valid
begin
    if (rst)
        q <= 4'b0000;//set q=4'b0000
    else if(start) //start valid
    begin
        if(q==4'b1001)
            q <=4'b0000;//MOD 10
        else
            q<=q+4'b0001;//add 1
    end
end
endmodule
