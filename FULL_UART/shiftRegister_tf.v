`timescale 1ns / 1ps
//****************************************************************//
// File name: shiftRegister_tf.v
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
module shiftRegister_tf;

	// Inputs
	reg clk;
	reg rst;
	reg load;
	reg [7:0] data;
	reg shift;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg ohel;

	// Outputs
	wire Tx;

	// Instantiate the Unit Under Test (UUT)
	transmit uut (
		.clk(clk),
		.rst(rst),
		.load(load),
		.data(data),
		.shift(shift),
		.baud(baud),
		.eight(eight),
		.parity_en(parity_en),
		.ohel(ohel),
		.Tx(Tx)
	);

   always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		load = 0;
		data = 0;
		shift = 0;
		baud = 0;
		eight = 0;
		parity_en = 0;
		ohel = 0;

		#10;

      rst         = 0;

      data        = 8'b1101_0011;
      parity_en   = 0;              // No Parity
      eight       = 0;              // 7-bits
      ohel        = 0;              // Don't Care
      load        = 1;
      #10;
      load = 0;
      shift = 1;
      #150;
      $stop;


      data        = 8'b1101_0011;
      parity_en   = 1;              // Parity
      eight       = 0;              // 7-bits
      ohel        = 0;              // Even Parity
      load        = 1;
      #10;
      load = 0;
      shift = 1;
      #150;
      $stop;


      data        = 8'b1101_0011;
      parity_en   = 0;              // NO Parity
      eight       = 1;              // 7-bits
      ohel        = 0;              // Don't Care
      load        = 1;
      #10;
      load = 0;
      shift = 1;
      #150;
      $stop;

	end
endmodule
