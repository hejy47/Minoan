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
#10;
p1=128'd113680897410347;
q1=128'd7999808077935876437321;
encrypt_decrypt=0;
msg_in=256'h00262d806a3e18f03ab37b2857e7e149;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=8348170468167298049;
q2=4168477127725284707;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
#10;
p1=128'd7999808077935876437321;
q1=128'd113680897410347;
encrypt_decrypt=0;
msg_in=256'h00262d806a3e18f03ab37b2857e7e149;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=149772151147396549;
q2=5901573392758652471;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
#10;
p1=128'd8475698667747010771;
q1=128'd11297384090418420749;
encrypt_decrypt=0;
msg_in=256'h08e2a11b5e2b4d0e3f7795ebe2596d9d;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=2596866756792670493;
q2=4062964908930584621;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
#10;
p1=128'd8786194473250302299;
q1=128'd1974551434103086991;
encrypt_decrypt=0;
msg_in=256'h0000b3ca6ffcf8a314c5e21a9c2dc611;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=5236458650167879367;
q2=8236267094071028197;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
#10;
p1=128'd9005980475000482739;
q1=128'd2627021771666544701;
encrypt_decrypt=0;
msg_in=256'h09d7c61830b9d7db4f384cdd1607481a;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=1630704555822188069;
q2=3352128258314992487;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
#10;
p1=128'd7298496856312456933;
q1=128'd9319994081162235169;
encrypt_decrypt=0;
msg_in=256'h0f6c1e0a32716c128c62c5f1f6ab3c00;
#10 reset_inverter1=1;
#10 reset_inverter1=0;
while (!inverter_finish)    @(posedge clk);
reset_mod_exp1=1;
#10 reset_mod_exp1=0;
while (!mod_exp_finish)    @(posedge clk);
p2=4168477127725284707;
q2=2500197781325741561;
#10 reset_inverter2=1;
#10 reset_inverter2=0;
while (!inverter_finish2)    @(posedge clk);
reset_mod_exp2=1;
#10 reset_mod_exp2=0;
while (!mod_exp_finish2)    @(posedge clk);
        // 


        #50;
	    $fclose(f);
        $finish;
    end
    
    always #5 clk = ~clk;

    always @(posedge clk)
        $fwrite(f,"%g,%d,%d,%d,%d,%h,%h,%h,%h,%h,%h\n", $time,p1,q1,p2,q2,encrypt_decrypt,msg_in,msg_out,mod_exp_finish,msg_out2,mod_exp_finish2);
    
endmodule
