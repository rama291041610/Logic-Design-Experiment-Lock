`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 17:07:23
// Design Name: 
// Module Name: main_sim
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


module main_sim(

    );
    reg clk, rst, setpw, judge;
    reg [3:0]q;//4-bit input
    wire [6:0]led;//real-time display
    wire [3:0]pos;//real-time display position
    wire [6:0]countdown;//countdown display
    wire led_countdown;//countdown display position
    wire staus;
    main m1(clk,q[0],q[1],q[2],q[3],rst,setpw,judge,pos,led,led_countdown,countdown,staus);
    initial
    begin
        clk = 0; rst = 0; setpw = 0; judge = 0;
        q = 4'b0000;
        
        /* Password reset test */
        #400 setpw = 1;
        #400 q[0] = ~q[0];
        #400 q[0] = ~q[0];
        #400 q[1] = ~q[1];
        #400 q[1] = ~q[1];
        #400 setpw = 0;
        
        /* Timeout test */
        #400 judge = ~judge;
        #400 q[0] = ~q[0];
        #400 q[0] = ~q[0];
        #400 q[1] = ~q[1];
        #400 q[1] = ~q[1];
        #100 judge = ~judge;
        
        /* Unlock test */
        #400 judge = ~judge;
        #100 q[0] = ~q[0];
        #100 q[0] = ~q[0];
        #100 q[1] = ~q[1];
        #100 q[1] = ~q[1];
        #1000 judge = ~judge;
        
        /* Reset test */
        #400 judge = ~judge;
        #50 q[0] = ~q[0];
        #50 q[0] = ~q[0];
        #200 rst =  1;
        #200 rst = 0;
        #50 q[0] = ~q[0];
        #50 q[0] = ~q[0];
        #50 q[1] = ~q[1];
        #50 q[1] = ~q[1];
        #1000 judge = ~judge;
    end
    
    always #1 clk = ~clk;
    
endmodule
