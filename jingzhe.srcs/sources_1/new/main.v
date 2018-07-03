`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 12:56:52
// Design Name: 
// Module Name: main
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


module main(clk,clk0,clk1,clk2,clk3,rst,setpw,judge,pos,led,pos_countdown,led_countdown,staus);
/*Main Module*/
input clk;//clock signal by FPGA ---->100MHz
input clk0,clk1,clk2,clk3;//clock signal
input rst;//reset signal
input setpw;//set password signal
input judge;//checke password signal----->check whether the input word is equal to the password or not

output reg [3:0] pos;//the bright led's position
output [6:0] led;//the figure showed by led
output [6:0] led_countdown;//countdown showed by led
output reg pos_countdown;//the position of countdown--->default the left
output reg staus;//lock or unlock

integer clock_led,clock_countdown;// count the number of posedge clk
wire [3:0] q0,q1,q2,q3;//cache the input
reg [3:0] pw0,pw1,pw2,pw3;//cache the password
reg [3:0] num;//the temp of the number showed on the led
reg timeout;//timeout ---->>500Hz
reg [3:0] countdown;//5s (this is 12.5s in fact)
reg input_start,input_rst;

initial
begin
	/*initialization*/
    countdown=4'b0101;
    pos=4'b0001;
    timeout=0;
    clock_led=0;
    clock_countdown=0;
    pos_countdown=1;
    staus=1;
end

/*input*/
CounterModTen u0(clk0,input_rst,input_start,q0);
CounterModTen u1(clk1,input_rst,input_start,q1);
CounterModTen u2(clk2,input_rst,input_start,q2);
CounterModTen u3(clk3,input_rst,input_start,q3);

/*screen*/
screen s0(clk,num,input_rst,led);
screen s1(clk,countdown,0,led_countdown);

always @(posedge clk)
begin
	/*control the input and its reset*/
    if(countdown==4'b0000)
    begin
    input_start<=0;
    input_rst<=1;
    end
    else
    begin
    	input_start<=setpw|judge;
    	input_rst<=rst|((~judge)&(~setpw));
    end

    /*Reduce Frequency*/
    if(clock_led==200000)
    begin
        timeout<=1;
        clock_led<=0;
    end
    else
    begin
        timeout<=0;
        clock_led<=clock_led+1;
    end

    /*countdown*/
    if(judge&&countdown!=4'b0000&&~staus)
    begin
        if(clock_countdown!=1250000000)
        begin
            clock_countdown<=clock_countdown+1;
        end
        case(clock_countdown)
            1250000000:
                countdown<=4'b0000;
            1000000000:
                countdown<=4'b0001;
            750000000:
                countdown<=4'b0010;
            500000000:
                countdown<=4'b0011;
            250000000:
                countdown<=4'b0100;
            0:
                countdown<=4'b0101;
        endcase
    end
    else if(~judge)
    begin
        countdown<=4'b0101;
        clock_countdown<=0;
    end

    /*save password*/
    if(setpw && staus)//only the staus of set password and unlock 
    begin
        pw0<=q0;
        pw1<=q1;
        pw2<=q2;
        pw3<=q3;
    end

end

/*control the four leds by refreshing*/
always @(posedge timeout)
begin
    if (pos==4'b0001)
    begin
        pos<=4'b0010;
        num<=q1;
    end
    else if(pos==4'b0010)
    begin
        pos<=4'b0100;
        num<=q2;
    end
    else if(pos==4'b0100)
    begin
        pos<=4'b1000;
        num<=q3;
    end
    else if(pos==4'b1000)
    begin
        pos<=4'b0001;
        num<=q0;
    end
end

/*jugde the staus of lock and unlock*/
always @(*)
begin
    if(judge)
    begin
        if(pw0==q0&&pw1==q1&&pw2==q2&&pw3==q3&&countdown!=4'b0000)
            staus<=1;
        else
            staus<=0;
    end
end

endmodule