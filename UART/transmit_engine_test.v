`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:53:02 10/24/2018
// Design Name:   transmit_engine
// Module Name:   D:/SCHOOL WORK/CECS 460 Labs/UART - Copy/transmit_engine_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: transmit_engine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module transmit_engine_test;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] baud;
	reg eight;
	reg parity_en;
	reg odd_n_even;
	reg [7:0] out_port;
	reg load;

	// Outputs
	wire tx;
	wire txrdy;

	// Instantiate the Unit Under Test (UUT)
	transmit_engine uut (
		.clk(clk), 
		.reset(reset), 
		.baud(baud), 
		.eight(eight), 
		.parity_en(parity_en), 
		.odd_n_even(odd_n_even), 
		.tx(tx), 
		.txrdy(txrdy), 
		.out_port(out_port), 
		.load(load)
	);

always #5 clk = ~clk; 

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		baud = 4'b1011;
		eight = 1;
		parity_en = 1;
		odd_n_even = 1;
		out_port = 8'b00001111;
		load = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0; 
		#100; 
		load = 1; 
		#10; 
		load = 0; 
		
        
		// Add stimulus here

	end
      
endmodule

