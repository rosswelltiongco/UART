`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//========================================================================
// 	File name: <debounce.v>															//
//																								//	
// 	Created by Steven Phan on 9/18/18											//
//		Copyright 2018 Steven Phan. All rights reserved.						//
//																								//
//																								//
//		In submitting this file for class work at CSULB							//	
//		I am confirming that this is my work and the work						//	
// 	of no one else. In subinmitting this code I acknowledge that		//
//		plagiarism in student project work is subject to dismissal 			//
// 	from the class.																	//
//////////////////////////////////////////////////////////////////////////////////
module debounce(clk_in, reset, sw, PO);
 input   clk_in, reset, sw;
 output reg  PO;
 reg [2:0]  PS, NS;
 reg    NO;
 
 parameter [2:0]  S0_0 = 3'b000, 
     S0_1 = 3'b001,
     S0_2 = 3'b010,
     S0_3 = 3'b011,
     S1_0 = 3'b100,
     S1_1 = 3'b101,
     S1_2 = 3'b110,
     S1_3 = 3'b111;    
 
 
 //=============Generating Tick====================
 //count
 wire tick;
 reg [19:0] count;

 assign tick = (count == 999999) ? 1'b1: 1'b0;
 
	always @ (posedge clk_in, posedge reset)
		if (reset)
			count <= 20'b0;
			else if (tick)
				count <= 20'b0;
				else 
					count <= count + 20'b1;
// ================================================	

 always@(posedge clk_in, posedge reset)
  if(reset)begin
   {PS, PO} = {3'b0, 1'b0};
  end else begin
   {PS, PO} = {NS, NO};
  end
   
   
 always@(*) begin 
  case(PS) 
   S0_0: {NS, NO} = (sw)  ? {S0_1, 1'b0} : {S0_0, 1'b0};
   S0_1: {NS, NO} = (sw)  ? ( (tick) ? {S0_2, 1'b0} : {S0_1, 1'b0} ) : {S0_0, 1'b0};
   S0_2: {NS, NO} = (sw)  ? ( (tick) ? {S0_3, 1'b0} : {S0_2, 1'b0} ) : {S0_0, 1'b0};
   S0_3: {NS, NO} = (sw)  ? ( (tick) ? {S1_0, 1'b1} : {S0_3, 1'b0} ) : {S0_0, 1'b0};
   
   S1_0: {NS, NO} = (~sw)          ? {S1_1, 1'b1} : {S1_0, 1'b1};
   S1_1: {NS, NO} = (~sw) ? ( (tick) ? {S1_2, 1'b1} : {S1_1, 1'b1} ) : {S1_0, 1'b1};
   S1_2: {NS, NO} = (~sw) ? ( (tick) ? {S1_3, 1'b1} : {S1_2, 1'b1} ) : {S1_0, 1'b1};
   S1_3: {NS, NO} = (~sw) ? ( (tick) ? {S0_0, 1'b0} : {S1_3, 1'b1} ) : {S1_0, 1'b1};
  endcase
 end 
endmodule
