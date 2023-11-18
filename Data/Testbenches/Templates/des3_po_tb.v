/////////////////////////////////////////////////////////////////////
////                                                             ////
////  DES TEST BENCH                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

module test;

reg		clk;
wire	[63:0]	desOut;
wire 	[63:0]  desOut2;
reg	[63:0]	des_in;
reg	[63:0]	key1_e;
reg	[63:0]	key2_e;
reg	[63:0]	key3_e;
reg	[63:0]	key1_d;
reg	[63:0]	key2_d;
reg	[63:0]	key3_d;
reg	[55:0]	delay_key1_d[0:51];
reg	[55:0]	delay_key2_d[0:51];
reg	[55:0]	delay_key3_d[0:51];
reg		decrypt;
wire [55:0] tmp_key1_e;
wire [55:0] tmp_key2_e;
wire [55:0] tmp_key3_e;
wire [55:0] tmp_key1_d;
wire [55:0] tmp_key2_d;
wire [55:0] tmp_key3_d;
integer f;
integer i;

always @(posedge clk) begin
	delay_key1_d[0] <= {key1_d[63:57],key1_d[55:49],key1_d[47:41],key1_d[39:33],
				key1_d[31:25],key1_d[23:17],key1_d[15:9],key1_d[7:1]};
	delay_key2_d[0] <= {key2_d[63:57],key2_d[55:49],key2_d[47:41],key2_d[39:33],
				key2_d[31:25],key2_d[23:17],key2_d[15:9],key2_d[7:1]};
	delay_key3_d[0] <= {key3_d[63:57],key3_d[55:49],key3_d[47:41],key3_d[39:33],
				key3_d[31:25],key3_d[23:17],key3_d[15:9],key3_d[7:1]};
end

always @(posedge clk)
	for(i=0;i<51;i=i+1)	begin
		delay_key1_d[i+1] <= delay_key1_d[i];
		delay_key2_d[i+1] <= delay_key2_d[i];
		delay_key3_d[i+1] <= delay_key3_d[i];
	end

initial
   begin
	f = $fopen("output.txt");
    $fwrite(f, "time,des_in,key1_e,key2_e,key3_e,key1_d,key2_d,key3_d,desOut,desOut2\n");
	$display("\n\n");
	$display("*********************************************************");
	$display("* Performance Optimized DES core simulation started ... *");
	$display("*********************************************************");
	$display("\n");

`ifdef WAVES
	$dumpfile("waves.vcd");
	$dumpvars();
	$display("INFO: Signal dump enabled ...\n\n");
`endif

	clk = 0;
	// Wait for clock edge
	decrypt = 0;
	@(posedge clk);

	$display("");
	$display("**************************************");
	$display("* Starting DES Test ...              *");
	$display("**************************************");
	$display("");
	
	// test data
	// input test data
	// 


	#500;
	$display("");
	$display("**************************************");
	$display("* DES Test done ...                  *");
	$display("**************************************");
	$display("");
	
	$fclose(f);
	$finish;
   end

// DES Clock
always #2 clk=~clk;

always @(posedge clk)
	$fwrite(f,"%g,%h,%h,%h,%h,%h,%h,%h,%h,%h\n", $time, des_in, tmp_key1_e, tmp_key2_e, tmp_key3_e, tmp_key1_d, tmp_key2_d, tmp_key3_d, desOut, desOut2);

assign tmp_key1_e = {key1_e[63:57],key1_e[55:49],key1_e[47:41],key1_e[39:33],
				key1_e[31:25],key1_e[23:17],key1_e[15:9],key1_e[7:1]};
assign tmp_key2_e = {key2_e[63:57],key2_e[55:49],key2_e[47:41],key2_e[39:33],
				key2_e[31:25],key2_e[23:17],key2_e[15:9],key2_e[7:1]};
assign tmp_key3_e = {key3_e[63:57],key3_e[55:49],key3_e[47:41],key3_e[39:33],
				key3_e[31:25],key3_e[23:17],key3_e[15:9],key3_e[7:1]};
assign tmp_key1_d = delay_key1_d[50];
assign tmp_key2_d = delay_key2_d[50];
assign tmp_key3_d = delay_key3_d[50];

// The DES instance
des3 u0(	.clk(		clk		),
	.desOut(	desOut		),
	.desIn(		des_in		),
	.key1(		tmp_key1_e		),
	.key2(		tmp_key2_e		),
	.key3(		tmp_key3_e		),
	.decrypt(	decrypt	)
	);

// The DES instance
des3 u1(	.clk(		clk		),
	.desOut(	desOut2		),
	.desIn(		desOut		),
	.key1(		tmp_key1_d		),
	.key2(		tmp_key2_d		),
	.key3(		tmp_key3_d		),
	.decrypt(	~decrypt	)
	);

endmodule
