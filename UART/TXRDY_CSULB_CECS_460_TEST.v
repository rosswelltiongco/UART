`timescale 1ns / 1ps
//****************************************************************//
// File name: TXRDY_CSULB_CECS_460_TEST.v
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
module TXRDY_CSULB_CECS_460_TEST;

	// Inputs
	reg CLK;
	reg reset;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg odd_n_even;

	// Outputs
	wire [15:0] led;
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	TXRDY_CSULB_CECS_460 uut (
		.CLK(CLK), 
		.reset(reset), 
		.baud(baud), 
		.eight(eight), 
		.parity_en(parity_en), 
		.odd_n_even(odd_n_even), 
		.led(led), 
		.tx(tx)
	);

always #5 CLK = ~CLK; 

	initial begin
		// Initialize Inputs
		CLK = 0;
		reset = 1;
		baud = 0;
		eight = 0;
		parity_en = 0;
		odd_n_even = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;
		// Add stimulus here

	end
      
endmodule

