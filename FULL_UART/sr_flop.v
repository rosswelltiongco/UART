//****************************************************************//
// File name: sr_flop.v
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
`timescale 1ns / 1ps

module sr_flop(clk, rst_s, S, R, Q);

   input    clk, rst_s, S, R;
   output   Q;

   reg Q;

   always @ (posedge clk, posedge rst_s)
      if      (rst_s)  Q <= 1'b0;
      else if (S)      Q <= 1'b1;
      else if (R)      Q <= 1'b0; 
      else             Q <= Q;

endmodule
