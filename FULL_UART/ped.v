//****************************************************************//
// File name: ped.v
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

module ped(clk, rst, ped_in, ped_out);
     input     clk, rst;
     input     ped_in;
     output    ped_out;

     reg       reg_1, reg_2;

     always @(posedge clk, posedge rst)
          if(rst) {reg_1,reg_2} <= 2'b0;
          else    {reg_1,reg_2} <= {ped_in, reg_1};
     assign ped_out = ~reg_2 & reg_1;


endmodule
