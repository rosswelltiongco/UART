//****************************************************************//
// File name: aiso_rst.v
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

module aiso_rst(clk, reset, reset_s);
   input    clk, reset;
   output   reset_s;
   reg      buff_reg, good_reg;

   always @ (posedge clk, posedge reset)
      if (reset)
         {buff_reg, good_reg} <= {1'b0, 1'b0};

      else // synchronize the output
         {buff_reg, good_reg} <= {1'b1, buff_reg};

   assign reset_s = ~good_reg; //make the reset HIGH active


endmodule
