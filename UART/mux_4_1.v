`timescale 1ns / 100ps
/*************************************************************************** 
* File Name: mux_4_1.v
* Project: Universal Shift Register
* Designer: Steven Phan
* Rev.Date: Sept. 18, 2017
*
* Purpose: Module acts as a data selector wtih a 2-bit wide 
* 			  mode input to determine the 4- bit binary input 
* 			  of D.
*
* Notes
***************************************************************************/ 
module mux_4_1(D, M, Y);

// inputs 
input [3:0] D; // 4 bit wide input 
input [1:0] M; // 2 bit wide input

// outputs
output Y;

// boolean statement for deciding output from the data selector
// if the MSB of M is a "1" then the condition is true
//	Second boolean statement says if the LSB is true then its D[3]
// if MSB is true but LSB of M is false then its D[2]
// if MSB is false but LSB is true then D[1]
// if MSB is false and LSB is false then D[0]

assign Y = M[1]?(M[0]?D[3]:D[2]):(M[0]?D[1]:D[0]);


endmodule
