//****************************************************************//
// File name: TOP.v
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

 module TOP(clk, rst, baud, eight, parity_en, ohel, rx, tx, led );

   input    clk, rst;
   input    [3:0] baud;
   input    eight, parity_en, ohel;
   input    rx;

   output   tx;
   output   [15:0] led;

   wire     clk_w, rst_w, eight_w, parity_en_w, ohel_w, rx_w;
   wire     [3:0] baud_w;
   wire     [15:0] led_w;


   tsi   buffer   (.clk_i(clk),.rst_i(rst),.baud_i(baud), .eight_i(eight),
                   .parity_en_i(parity_e.ohel_i(ohel), .rx_i(rx),
                   .tx_i(tx_w), .led_i(led_w), .clk_o(clk_w),
                   .rst_o(rst_w), .baud_o(baud_w),  .eight_o(eight_w),
                   .parity_en_o(parity_en_w), .ohel_o(ohel_w),
                   .rx_o(rx_w), .tx_o(tx),  .led_o(led));

   UART  core     (.clk(clk_w), .rst(rst_w), .baud(baud_w), .eight(eight_w),
                   .parity_en(parity_en_w), .ohel(ohel_w), .rx(rx_w), .tx(tx_w),
                   .led(led_w));


endmodule
