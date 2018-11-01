`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:04:32 10/18/2018 
// Design Name: 
// Module Name:    TRANSMIT_ENG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TRANSMIT_ENG(CLK, RESET, BAUD, EIGHT, PARITY_EN, ODD_N_EVEN, OUT_PORT,  
						  TXRDY, TX, LOAD);
	
	input CLK,RESET, EIGHT, PARITY_EN, ODD_N_EVEN, LOAD; 
	input [3:0]	BAUD; 
	input [7:0] OUT_PORT; 
	
	output reg TXRDY, TX;  
 
//========================================================
//========================================================
	
	// WIRES FOR LEFT REGSITERS
	reg  doit_w, writeD1_w; 
	reg [7:0] load_data_w; 
	wire doit_net; // combo wire to come from reg
	
	// WIRES FOR THE MISSING BITS DECODER
   reg 	b10, b9; 	
	wire OP, EP;
	
	// WIRES FOR THE SHIFT REGISTERS
	//reg btu_w; 
	reg  [10:0] store;
	wire [10:0] store_wire;
	
	// WIRES FOR THE BIT TIME COUNTER
	reg baud_count; 
	wire btu_w; 
	reg [18:0] n_count, count; 
	
	// WIRES FO THE BIT COUNTER
	reg [3:0] n_tally, tally; 
	reg doneD1_w; 
	wire done_w; 

//========================================================
//========================================================

//******************************************************
//						LEFT HAND FLOPS
//******************************************************
	
	// 8 BIT WIDE LOAD REGISTER
	always @ (posedge CLK, posedge RESET)
		if (RESET)   load_data_w <= 8'b0; else
		if (LOAD) 	 load_data_w <= OUT_PORT; 
		else         load_data_w <= load_data_w; 
		
	// WRITED1 FLOP
	always @(posedge CLK, posedge RESET)
		if (RESET) writeD1_w <= 1'b0; 
		else 		  writeD1_w	 <= LOAD; 
			
	// TXRDY SRQ FLOP	
	always @(posedge CLK, posedge RESET)
		 if (RESET)    TXRDY <= 1'b0; else 
		 if (doneD1_w) TXRDY <= 1'b1; else
		 if (LOAD)     TXRDY <= 1'b0; else
						   TXRDY <= TXRDY; 
	
	// DOIT SRQ FLOP
	always @(posedge CLK, posedge RESET)
		 if (RESET)   doit_w <= 1'b0; else 
		 if (LOAD)    doit_w <= 1'b1; else
		 if (done_w)  doit_w <= 1'b0; else
						  doit_w <= doit_w;	

	assign doit_net = doit_w; 
//******************************************************
//						MISSING BITS DECODER
//******************************************************
	// need to generate a case for parity bit
   // if number of 1's is odd then EP is a one
   /// else if it is even then     EP is a zero
	assign EP = (load_data_w ^^ load_data_w) ? 1'b0: 1'b1; 
	
	// case for odd parity bit
	// when # of 1 is odd then  OP is a zero
	// else # of 1 is even then EP is a one
	assign OP = (load_data_w ^^ load_data_w) ? 1'b1: 1'b0; 
		
	always @(*)
		case({EIGHT, PARITY_EN, ODD_N_EVEN})
			3'b000 : {b10, b9} = 2'b11; 
			3'b001 : {b10, b9} = 2'b11; 
			3'b010 : {b10, b9} = {1,EP}; 
			3'b011 : {b10, b9} = {1,OP}; 
			3'b100 : {b10, b9} = {1,load_data_w[7]}; 
			3'b101 : {b10, b9} = {1,load_data_w[7]}; 
			3'b110 : {b10, b9} = {EP,load_data_w[7]}; 
			3'b111 : {b10, b9} = {OP,load_data_w[7]} ;		
		endcase
		
//******************************************************
//						SHIFT REGISTER
//******************************************************
	always @(posedge CLK, posedge RESET)
		if (RESET)     store <= 11'b1; else 
		if (writeD1_w) store <= {b10,b9,load_data_w[6:0],1'b0,1'b1}; else
		if (btu_w) begin
				  TX <= store[0]; // 10 9 8 7 6 5 4 3 2 1 0 
				  store <= {1'b1, store[10:1]};
				  end
		else store <= store;
		
//******************************************************
//						BIT TIME COUNTER
//******************************************************
	//BAUD VALUE DECODER
	always @ (*)
		case(BAUD)
			4'b0000: baud_count = 333333;
			4'b0001: baud_count = 83333;
			4'b0010: baud_count = 41667;
			4'b0011: baud_count = 20833;
			4'b0100: baud_count = 10417;
			4'b0101: baud_count = 5208;
			4'b0110: baud_count = 2604;
			4'b0111: baud_count = 1736;
			4'b1000: baud_count = 868;
			4'b1001: baud_count = 434;
			4'b1010: baud_count = 217;
			4'b1011: baud_count = 109;
			default : baud_count = 333333; 
		endcase
	
	// COUNTER FLOP
	always @ (posedge CLK, posedge RESET)
		if(RESET) count <= 19'b0; 
		else 		 count <= n_count;
	
	always @(*) 
		case({doit_net, btu_w})
			2'b00 : n_count = 19'b0; 
			2'b01 : n_count = 19'b0; 
			2'b10 : n_count = count + 1'b1; 
			2'b11 : n_count = 19'b0; 
		endcase	
		
	assign btu_w = (count == baud_count) ? 1'b1 : 1'b0; 
	
//******************************************************
//						BIT COUNTER
//******************************************************
	assign done_w = (tally == 4'hB)? 1'b1: 1'b0; 

	always @(posedge CLK, posedge RESET)
		if(RESET) begin
				tally    <= 1'b0; 
				doneD1_w <= 1'b0;
			end else begin
				tally    <= n_tally; 
				doneD1_w <= done_w;
			end
		
	always @ (*)
		case({doit_net, btu_w})
			2'b00 : n_tally = 1'b0; 
			2'b01 : n_tally = 1'b0; 
			2'b10 : n_tally = n_tally; 
			2'b11 : n_tally = tally + 1'b1; 
			default : n_tally = 1'b0; 
		endcase

endmodule
