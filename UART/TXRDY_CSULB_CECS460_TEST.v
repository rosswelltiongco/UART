`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:45:28 10/19/2018
// Design Name:   TXRDY_CSULB_CECS_460
// Module Name:   D:/SCHOOL WORK/CECS 460 Labs/UART/TXRDY_CSULB_CECS460_TEST.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TXRDY_CSULB_CECS_460
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TXRDY_CSULB_CECS460_TEST;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg odd_n_even;

	// Outputs
	wire ;
	wire [15:0] led;
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	TXRDY_CSULB_CECS_460 uut (
		.clk(clk), 
		.reset(reset), 
		.baud(baud), 
		.eight(eight), 
		.parity_en(parity_en), 
		.odd_n_even(odd_n_even), 
		.(), 
		.led(led), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		baud = 0;
		eight = 0;
		parity_en = 0;
		odd_n_even = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

