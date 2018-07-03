`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 12:56:52
// Design Name: 
// Module Name: screen
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


module screen(clk,num,rst,led);
/*screen module for single led*/
input clk;//clock signal
input [3:0] num;//4 bits number
input rst;//reset signal
output reg [6:0] led;//output for controlling the led
always @(posedge clk or posedge rst)
begin
    if(rst)
        led<=7'b1111110;//set led to show "0"
    else
    begin
        case(num)
            4'b0000:
                led <= 7'b1111110;
            4'b0001:
                led <= 7'b0110000;
            4'b0010:
                led <= 7'b1101101;
            4'b0011:
                led <= 7'b1111001;
            4'b0100:
                led <= 7'b0110011;
            4'b0101:
                led <= 7'b1011011;
            4'b0110:
                led <= 7'b1011111;
            4'b0111:
                led <= 7'b1110000;
            4'b1000:
                led <= 7'b1111111;
            4'b1001:
                led <= 7'b1111011;
            default:
                led <= 7'b1111110;
        endcase
    end
end
endmodule
