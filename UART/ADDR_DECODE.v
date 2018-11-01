`timescale 1ns / 1ps
//****************************************************************//
// File name: ADDR_DECODE.v
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
module ADDR_DECODE(ADHI, ADIO, READ, WRITE,
                   READS0, WRITES0, READS1, WRITES1, 
                   READS2, WRITES2, READS3, WRITES3);
						 
	input [1:0]  ADHI; 
	input [3:0]  ADIO; 
	input 		 READ; 
	input       WRITE; 
	
	output [15:0]  READS0,  READS1,  READS2,  READS3; 
	output [15:0] WRITES0, WRITES1, WRITES2, WRITES3; 
	
	assign READS0	= (ADHI == 2'b00) ?  (READ << ADIO) : 16'b0; 
	assign READS1	= (ADHI == 2'b01) ?  (READ << ADIO) : 16'b0; 
	assign READS2 	= (ADHI == 2'b10) ?  (READ << ADIO) : 16'b0; 	
	assign READS3 	= (ADHI == 2'b11) ?  (READ << ADIO) : 16'b0; 

	assign WRITES0  = (ADHI == 2'b00) ? (WRITE << ADIO) : 16'b0; 
	assign WRITES1  = (ADHI == 2'b01) ? (WRITE << ADIO) : 16'b0; 
	assign WRITES2  = (ADHI == 2'b10) ? (WRITE << ADIO) : 16'b0; 
	assign WRITES3  = (ADHI == 2'b11) ? (WRITE << ADIO) : 16'b0; 

endmodule
