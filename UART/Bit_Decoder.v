`timescale 1ns / 1ps
//****************************************************************//
// File name: Bit_Decoder.v
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
module Bit_Decoder(Load_Data, bit_8, parity_en, odd_n_even, b10,b9);
	input 		bit_8, parity_en, odd_n_even; 
	input [7:0] Load_Data; 
    
	output reg 	b10, b9; 
	
	wire OP, EP; 

	assign EP = (Load_Data^^Load_Data) ? 1'b0: 1'b1; 
	assign OP = (Load_Data^^Load_Data) ? 1'b1: 1'b0; 
		
	always @ (*)
		case({bit_8, parity_en, odd_n_even})
			3'b000 : {b10, b9} = 2'b11; 
			3'b001 : {b10, b9} = 2'b11; 
			3'b010 : {b10, b9} = {1'b1,EP}; 
			3'b011 : {b10, b9} = {1'b1,OP}; 
			3'b100 : {b10, b9} = {1'b1,Load_Data[7]}; 
			3'b101 : {b10, b9} = {1'b1,Load_Data[7]}; 
			3'b110 : {b10, b9} = {EP,Load_Data[7]}; 
			3'b111 : {b10, b9} = {OP,Load_Data[7]};		
			default: {b10, b9} = 2'b00;
		endcase
		
endmodule
