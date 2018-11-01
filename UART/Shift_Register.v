`timescale 1ns / 1ps
//****************************************************************//
// File name: Shift_Register.v
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
module Shift_Register(reset, clk, ld, sh, sdi, 
                         bit_10, bit_9, LData,
						   bit_1, bit_0, sdo);
			
		input           reset, clk, ld, sh, sdi,
                    bit_10, bit_9, bit_1, bit_0; 
		input [6:0] LData; 
		
		output sdo; 
		
		reg  [10:0] store;
		
		assign sdo = store[0];
		
		always @(posedge clk, posedge reset)
			if      (reset) store <= 11'h7FF;
            else if (ld)    store <= {bit_10, bit_9, LData[6:0],
                                      bit_1, bit_0}; 
            else if (sh)    store <= {sdi, store[10:1]};
			else            store <= store;
			
	
endmodule
