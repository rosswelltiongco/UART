`timescale 1ns / 1ps
///////****************************************************************//
// File name: Bit_Counter.v
//
// Created by       Rosswell Tiongco on <11/01/18>. 
// Copyright © 2018 Rosswell Tiongco. All rights reserved.
// 
// 
// In submitting this file for class work at CSULB
// I am confirming that this is my work and the work
// of no one else. In submitting this code I acknowledge that
// plagiarism in student project work is subject to dismissal
// from the class. 
//****************************************************************//
module Bit_Counter(clk, reset, BTU, DOIT, DONE,DONED1);
	input     clk, reset, BTU, DOIT;
	output 	                   DONE; 
	output reg               DONED1; 
	
	reg [3:0] n_count, count; 
    assign DONE = (count == 4'hB)? 1'b1: 1'b0; 

	always @(posedge clk, posedge reset)
		if(reset) begin
            count  <= 1'b0; 
            DONED1 <= 1'b0;
        end 
        else begin
            count  <= n_count; 
            DONED1 <= DONE;
        end
		
	always @ (*)
		case({DOIT,BTU})
			2'b00  : n_count = 1'b0; 
			2'b01  : n_count = 1'b0; 
			2'b10  : n_count = count; 
			2'b11  : n_count = count + 1'b1; 
		endcase
endmodule
