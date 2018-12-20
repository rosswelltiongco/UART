`timescale 1ns / 1ps

//****************************************************************//
// File name: receive_tf.v
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

module receive_tf;

	// Inputs
	reg clk;
	reg rst;
	reg clr;
	reg rx;
	reg eight;
	reg parity_en;
	reg ohel;
	reg [18:0] k;

	// Outputs
	wire [7:0] data;
	wire RXRDY;
	wire PERR;
	wire FERR;
	wire OVF;

	// Instantiate the Unit Under Test (UUT)
	receive uut (
		.clk(clk),
		.rst(rst),
		.clr(clr),
		.rx(rx),
		.eight(eight),
		.parity_en(parity_en),
		.ohel(ohel),
		.k(k),
		.data(data),
		.RXRDY(RXRDY),
		.PERR(PERR),
		.FERR(FERR),
		.OVF(OVF)
	);

   always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		clr = 0;
		rx = 1;
		eight = 1;
		parity_en = 1;
		ohel = 0;
		k = 109 - 1;

		// Wait 100 ns for global reset to finish
		#100;

      rst = 0;
      rx = 0; //start

      //Receive 0xAE

      //d0
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b0;

      //d1
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //d2
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //d3
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //d4
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b0;

      //d5
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //d6
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b0;

      //d7
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //Parity 10101110 *1*
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b0;

      //Stop
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      wait (uut.done == 1);  //wait until byte is done being received.
      #400;
      $stop;

		// Add stimulus here

	end

endmodule
