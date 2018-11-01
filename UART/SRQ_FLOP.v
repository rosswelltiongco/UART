`timescale 1ns / 1ps
//****************************************************************//
// File name: SRQ_FLOP.v
//
// Created by       Rosswell Tiongco on <11/01/18>. 
// Copyright © 2018 Rosswell Tiongco. All rights reserved.
// 
// 
// In submitting this file for class work at CSULB
// I am confirming that this is my work and the work
// of no one else. In submitting this code I acknowledge that
// plagiarism in student project work is subject to dismissal
// from the class. 
//****************************************************************//
module SRQ_FLOP(clk, reset,S, R, Q);
input      clk, reset, S, R; 
output reg Q; 

always @ (posedge clk, posedge reset)
	if      (reset) Q <= 1'b1;
    else if (S)  	Q <= 1'b1;
    else if (R)	    Q <= 1'b0;
    else    		Q <=    Q; 

endmodule

