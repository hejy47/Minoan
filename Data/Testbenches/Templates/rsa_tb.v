`timescale 1ns / 1ps
`define WIDTH 128
module tb_main;
    reg [`WIDTH-1:0] p1,q1;
    reg [`WIDTH-1:0] p2,q2;
    reg reset_inverter1,reset_mod_exp1;
    reg reset_inverter2,reset_mod_exp2;
    reg clk,encrypt_decrypt;
    reg [`WIDTH*2-1:0] msg_in;
    wire [`WIDTH*2-1:0] msg_out;
    wire [`WIDTH*2-1:0] msg_out2;
    wire inverter_finish,mod_exp_finish;
    wire inverter_finish2,mod_exp_finish2;
    integer f;
    
    control uut(p1,q1,clk,reset_inverter1,reset_mod_exp1,encrypt_decrypt,msg_in,inverter_finish,msg_out,mod_exp_finish);
    defparam uut.WIDTH = `WIDTH;
    control uut2(p2,q2,clk,reset_inverter2,reset_mod_exp2,~encrypt_decrypt,msg_out,inverter_finish2,msg_out2,mod_exp_finish2);
    defparam uut2.WIDTH = `WIDTH;
    
    initial
    begin
	    f = $fopen("output.txt");
        $fwrite(f, "time,p1,q1,p2,q2,encrypt_decrypt,msg_in,msg_out,mod_exp_finish,msg_out2,mod_exp_finish2\n");
        $display("\n\n");
        $display("*****************************************************");
        $display("* RSA Test bench ...");
        $display("*****************************************************");
        $display("\n");
        `ifdef WAVES
            $dumpfile("waves.vcd");
            $dumpvars();
            $display("INFO: Signal dump enabled ...\n\n");
        `endif
        clk = 0;
        reset_inverter1 =0; reset_mod_exp1=0;
        reset_inverter2 =0; reset_mod_exp2=0;

        // test data
        // input test data
        // 


        #50;
	    $fclose(f);
        $finish;
    end
    
    always #5 clk = ~clk;

    always @(posedge clk)
        $fwrite(f,"%g,%d,%d,%d,%d,%h,%h,%h,%h,%h,%h\n", $time,p1,q1,p2,q2,encrypt_decrypt,msg_in,msg_out,mod_exp_finish,msg_out2,mod_exp_finish2);
    
endmodule
