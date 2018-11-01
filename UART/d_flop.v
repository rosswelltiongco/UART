`timescale 1ns / 1ps
//****************************************************************//
// File name: D_Flop.v
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
module D_FLOP(clk, reset, D, Q);
	input      clk, reset, D; 
	output reg Q; 
	
	always @(posedge clk, posedge reset)
		if  (reset)	Q <= 1'b0; 
		else		Q <= D; 

endmodule
