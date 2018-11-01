`timescale 1ns / 1ps
//****************************************************************//
// File name: AISO.v
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
module AISO(clk, reset, reset_s );
    input  clk, reset;
	output reset_s;
	
	reg [1:0] sync;
	
	assign reset_s = ~sync[0];
	
	always @(posedge reset, posedge clk)
		if   (reset) sync = 2'b0;
		else         sync = {1'b1, sync[1]};

endmodule 
