/*
 * Copyright 2013, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

`timescale 1ns / 1ps
`define P 20

module test_keccak;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] in;
    reg in_ready;
    reg is_last;
    reg [1:0] byte_num;

    // Outputs
    wire buffer_full;
    wire [511:0] out;
    wire out_ready;

    // Var
    integer i;
    integer f;

    // Instantiate the Unit Under Test (UUT)
    keccak uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .in_ready(in_ready),
        .is_last(is_last),
        .byte_num(byte_num),
        .buffer_full(buffer_full),
        .out(out),
        .out_ready(out_ready)
    );

    initial begin
	    f = $fopen("output.txt");
        $fwrite(f, "time,in,buffer_full,out,out_ready\n");

        // Initialize Inputs
        clk = 0;
        reset = 0;
        in = 0;
        in_ready = 0;
        is_last = 0;
        byte_num = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        @ (negedge clk);

        // test data
        // input test data
#80;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "The "; #(`P);
in = "quic"; #(`P);
in = "k br"; #(`P);
in = "own "; #(`P);
in = "fox "; #(`P);
in = "jump"; #(`P);
in = "s ov"; #(`P);
in = "er t"; #(`P);
in = "he l"; #(`P);
in = "azy "; #(`P);
in = "dog "; byte_num = 3; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#0;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "The "; #(`P);
in = "quic"; #(`P);
in = "k br"; #(`P);
in = "own "; #(`P);
in = "fox "; #(`P);
in = "jump"; #(`P);
in = "s ov"; #(`P);
in = "er t"; #(`P);
in = "he l"; #(`P);
in = "azy "; #(`P);
in = "dog."; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#40;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Hell"; #(`P);
in = "o, w"; #(`P);
in = "orld"; #(`P);
in = "!   "; byte_num = 1; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#0;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Hell"; #(`P);
in = "o, w"; #(`P);
in = "orld"; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#120;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Hell"; #(`P);
in = "o Wo"; #(`P);
in = "rld "; byte_num = 3; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#20;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "This"; #(`P);
in = " is "; #(`P);
in = "a te"; #(`P);
in = "st m"; #(`P);
in = "essa"; #(`P);
in = "ge. "; byte_num = 3; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#40;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Lore"; #(`P);
in = "m ip"; #(`P);
in = "sum "; #(`P);
in = "dolo"; #(`P);
in = "r si"; #(`P);
in = "t am"; #(`P);
in = "et, "; #(`P);
in = "cons"; #(`P);
in = "ecte"; #(`P);
in = "tur "; #(`P);
in = "adip"; #(`P);
in = "isci"; #(`P);
in = "ng e"; #(`P);
in = "lit."; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#0;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "1234"; #(`P);
in = "5678"; #(`P);
in = "90  "; byte_num = 2; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#160;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "pass"; #(`P);
in = "word"; #(`P);
in = "123 "; byte_num = 3; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#40;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "The "; #(`P);
in = "quic"; #(`P);
in = "k br"; #(`P);
in = "own "; #(`P);
in = "fox "; #(`P);
in = "jump"; #(`P);
in = "s ov"; #(`P);
in = "er t"; #(`P);
in = "he l"; #(`P);
in = "azy "; #(`P);
in = "dog."; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#0;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Test"; #(`P);
in = "ing "; #(`P);
in = "1, 2"; #(`P);
in = ", 3."; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#20;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "Toda"; #(`P);
in = "y is"; #(`P);
in = " a s"; #(`P);
in = "unny"; #(`P);
in = " day"; #(`P);
in = ".   "; byte_num = 1; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#0;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "I lo"; #(`P);
in = "ve c"; #(`P);
in = "odin"; #(`P);
in = "g an"; #(`P);
in = "d pr"; #(`P);
in = "ogra"; #(`P);
in = "mmin"; #(`P);
in = "g.  "; byte_num = 2; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
#100;
reset = 1; #(`P); reset = 0;
in_ready = 1; is_last = 0;
in = "The "; #(`P);
in = "quic"; #(`P);
in = "k br"; #(`P);
in = "own "; #(`P);
in = "fox."; #(`P);
in = 0; byte_num = 0; is_last = 1; #(`P);
in_ready = 0; is_last = 0;
while (out_ready !== 1)
    #(`P);
        //

        $display("Good!");
        #100;
	      $fclose(f);
        $finish;
    end

    always #(`P/2) clk = ~ clk;

    always @(posedge clk)
        $fwrite(f,"%g,%s,%b,%b,%b\n", $time, in, buffer_full, out, out_ready);

  
endmodule

`undef P
