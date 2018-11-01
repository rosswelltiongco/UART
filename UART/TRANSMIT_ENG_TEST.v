`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:59:49 10/19/2018
// Design Name:   TRANSMIT_ENG
// Module Name:   D:/SCHOOL WORK/CECS 460 Labs/UART/TRANSMIT_ENG_TEST.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TRANSMIT_ENG
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TRANSMIT_ENG_TEST;

	// Inputs
	reg CLK;
	reg RESET;
	reg [3:0] BAUD;
	reg EIGHT;
	reg PARITY_EN;
	reg ODD_N_EVEN;
	reg [7:0] OUT_PORT;
	reg WRITE_0;

	// Outputs
	wire TXRDY;
	wire TX;

	// Instantiate the Unit Under Test (UUT)
	TRANSMIT_ENG uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.BAUD(BAUD), 
		.EIGHT(EIGHT), 
		.PARITY_EN(PARITY_EN), 
		.ODD_N_EVEN(ODD_N_EVEN), 
		.OUT_PORT(OUT_PORT), 
		.TXRDY(TXRDY), 
		.TX(TX), 
		.WRITE_0(WRITE_0)
	);
always #5 CLK = ~CLK; 

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		BAUD = 0;
		EIGHT = 0;
		PARITY_EN = 0;
		ODD_N_EVEN = 0;
		OUT_PORT = 0;
		WRITE_0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		RESET = 0; 
		
		
        
		// Add stimulus here

	end
      
endmodule

