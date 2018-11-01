`timescale 1ns / 1ps
//****************************************************************//
// File name: Bit_Time_Counter.v
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
module Bit_Time_Counter(clk, reset, BAUD_VAL, DOIT, BTU);
	input 		clk, reset, DOIT; 
	input [3:0] BAUD_VAL; 
	
	output		BTU; 

	wire   BTU_wire;
	
	reg  [18:0]	count,n_count, baud_count ;   
		
	assign BTU = (count == baud_count) ? 1'b1 : 1'b0; 
	
	always @ (*)
		case(BAUD_VAL)
			4'b0000: baud_count = 333333;
			4'b0001: baud_count =  83333;
			4'b0010: baud_count =  41667;
			4'b0011: baud_count =  20833;
			4'b0100: baud_count =  10417;
			4'b0101: baud_count =   5208;
			4'b0110: baud_count =   2604;
			4'b0111: baud_count =   1736;
			4'b1000: baud_count =    868;
			4'b1001: baud_count =    434;
			4'b1010: baud_count =    217;
			4'b1011: baud_count =    109;
			default: baud_count =      0; 
		endcase
	
	// COUNTER FLOP
	always @ (posedge clk, posedge reset)
		if(reset) count <= 19'b0; 
		else 		 count <= n_count;
	
	always @(*) 
		case({DOIT,BTU})
			2'b00 : n_count = 19'b0; 
			2'b01 : n_count = 19'b0; 
			2'b10 : n_count = count + 1'b1; 
			2'b11 : n_count = 19'b0;
			default : n_count = 19'b0; 
		endcase

endmodule
