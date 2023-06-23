`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2023 15:17:16
// Design Name: 
// Module Name: Car_FSM
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


module Car_FSM( 
input clk,
input reset,
input left, 
input right, 
output reg [2:0] l,
output reg [2:0] r
    );
    
    
    reg [24:0] clk_count;
    wire clk_en;
    // clock division circuit
    always @(posedge clk) 
    begin
        if(reset)
        clk_count<=0;
        else
        clk_count<= clk_count +1;
    end
    assign clk_en = &clk_count;
    
    
    parameter s0 = 3'b000, s1 = 3'b001,s2 = 3'b010,s3 = 3'b011,s4 = 3'b100,s5 = 3'b101,s6 = 3'b110;
    
    reg [2:0] ps, ns;
    
    /*
    // present state logic for simulation
    always@(posedge clk, reset) begin
            if(reset) ps<= 0;
            else ps <= ns;
            end
    */
        
    // present state logic
    always@(posedge clk_en) begin
        ps <= ns;
        end
    
        
    //next state logic dependent on present state and inputs
    always@(ps,left,right) begin
        case(ps)
            s0: begin
                if(right==0 && left==1) 
                ns = s1;
                else if(right==1 && left==0)
                ns = s4;
                else 
                ns = s0;
                end
            s1: begin
                if (right ==0) // left can be 0 or 1 but right should be 0
                ns = s2;
                else
                ns = s0;
                end
            s2: begin
                if(right ==0) // left can be 0 or 1 but right should be 0         
                ns = s3;
                else
                ns = s0;
                end
            s3: begin
                ns = s0;
                end    
            s4: begin
                if (left ==0) // right can be 0 or 1 but left should be 0
                ns = s5;
                else
                ns = s0;
                end
            s5: begin
                if(left ==0) // right can be 0 or 1 but left should be 0          
                ns = s6;
                else
                ns = s0;
                end
            s6: begin
                ns =s0;
                end
            default: ns =s0;
        endcase
     end
              
     //output logic
     always@(ps) begin
        case(ps)
            s0: begin  
                l=3'b000; 
                r=3'b000;
                end
            s1: l[0] =1;
            s2: l[1] =1;
            s3: l[2] =1;
            s4: r[0] =1;
            s5: r[1] =1;
            s6: r[2] =1;
            default:begin 
            l=3'b000; r=3'b000;
            end
        endcase
        end
                    
endmodule
