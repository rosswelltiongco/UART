`timescale 1ns / 1ps
//****************************************************************//
// File name: UART_tf.v
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

module UART_tf;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg ohel;
	reg rx;

	// Outputs
	wire tx;
	wire [15:0] led;

	// Instantiate the Unit Under Test (UUT)
	UART uut (
		.clk(clk),
		.rst(rst),
		.baud(baud),
		.eight(eight),
		.parity_en(parity_en),
		.ohel(ohel),
		.rx(rx),
		.tx(tx),
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
		rx = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
      rx = 0; //start

      //Receive 0xAE

      //d0
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b0;

      //d1
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b1;

      //d2
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b1;

      //d3
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b1;

      //d4
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b0;

      //d5
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b1;

      //d6
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b0;

/*
      //d7
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;

      //parity
      wait (uut.btu == 1);
      wait (uut.btu == 0);
      rx = 1'b1;
      */
      //Stop
      wait (uut.u4.btu == 1);
      wait (uut.u4.btu == 0);
      rx = 1'b1;


      wait (uut.u4.done == 1);  //wait until byte is done being received.
      #200
      $stop;

		// Add stimulus here


		// Add stimulus here

	end

endmodule
