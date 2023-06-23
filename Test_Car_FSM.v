`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2022 15:43:15
// Design Name: 
// Module Name: Test_Car_FSM
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


module Test_Car_FSM(
    );
    reg clk, reset, left, right; 
    wire [2:0] l, r;
    
    Car_FSM a1(clk, reset, left, right, l, r);

    initial 
    begin
    clk =0;
    repeat(50)
    #5 clk=~clk;
    $finish;
    end
    
    initial
    begin
    reset=1'b1; left=1'b0;right=1'b0; 
    #20
    reset=1'b0;
    #50 left=1'b1;right=1'b0;
    #50 left=1'b0;right=1'b1;
    #50 left=1'b1;right=1'b1;
    #50 left=1'b0;right=1'b0;
    end
        
endmodule
