//****************************************************************//
// File name: transmit_top_tf.v
//
// Created by       Rosswell Tiongco on <12/19/18>.
// Copyright © 2018 Rosswell Tiongco. All rights reserved.
//
//
// In submitting this file for class work at CSULB
// I am confirming that this is my work and the work
// of no one else. In submitting this code I acknowledge that
// plagiarism in student project work is subject to dismissal
// from the class.
//****************************************************************//
`timescale 1ns / 1ps

module transmit_top_tf;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg ohel;

	// Outputs
	wire Tx;
	wire [15:0] led;

	// Instantiate the Unit Under Test (UUT)
	transmit_top uut (
		.clk(clk),
		.rst(rst),
		.baud(baud),
		.eight(eight),
		.parity_en(parity_en),
		.ohel(ohel),
		.Tx(Tx),
		.led(led)
	);

   always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		baud = 1011;
		eight = 0;
		parity_en = 0;
		ohel = 0;

		// Wait 100 ns for global reset to finish
		#100;

      rst = 0;


		// Add stimulus here

	end

endmodule
