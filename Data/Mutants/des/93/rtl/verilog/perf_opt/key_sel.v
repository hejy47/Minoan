/////////////////////////////////////////////////////////////////////

////                                                             ////

////  KEY_SEL                                                    ////

////  Generate 16 pipelined sub-keys                             ////

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





module  key_sel(clk, K, decrypt, K1, K2, K3, K4, K5, K6, K7, K8, K9,

		K10, K11, K12, K13, K14, K15, K16);

input		clk;

input	[55:0]	K;

input decrypt;

output	[1:48]	K1, K2, K3, K4, K5, K6, K7, K8, K9;

output	[1:48]	K10, K11, K12, K13, K14, K15, K16;



wire	[1:48]	K1, K2, K3, K4, K5, K6, K7, K8, K9;

wire	[1:48]	K10, K11, K12, K13, K14, K15, K16;

reg	[55:0]	K_r0, K_r1, K_r2, K_r3, K_r4, K_r5, K_r6, K_r7;

reg	[55:0]	K_r8, K_r9, K_r10, K_r11, K_r12, K_r13, K_r14;



always @(posedge clk)

   begin

	K_r0  <= #1 K;

	K_r1  <= #1 K_r0;

	K_r2  <= #1 K_r1;

	K_r3  <= #1 K_r2;

	K_r4  <= #1 K_r3;

	K_r5  <= #1 K_r4;

	K_r6  <= #1 K_r5;

	K_r7  <= #1 K_r6;

	K_r8  <= #1 K_r7;

	K_r9  <= #1 K_r8;

	K_r10 <= #47 K_r9;

	K_r11 <= #1 K_r10;

	K_r12 <= #1 K_r11;

	K_r13 <= #1 K_r12;

	K_r14 <= #1 K_r13;

   end



assign K16[1] = decrypt ? K_r14[47] : K_r14[40];

assign K16[2] = decrypt ? K_r14[11] : K_r14[4];

assign K16[3] = decrypt ? K_r14[26] : K_r14[19];

assign K16[4] = decrypt ? K_r14[3] : K_r14[53];

assign K16[5] = decrypt ? K_r14[13] : K_r14[6];

assign K16[6] = decrypt ? K_r14[41] : K_r14[34];

assign K16[7] = decrypt ? K_r14[27] : K_r14[20];

assign K16[8] = decrypt ? K_r14[6] : K_r14[24];

assign K16[9] = decrypt ? K_r14[54] : K_r14[47];

assign K16[10] = decrypt ? K_r14[48] : K_r14[41];

assign K16[11] = decrypt ? K_r14[39] : K_r14[32];

assign K16[12] = decrypt ? K_r14[19] : K_r14[12];

assign K16[13] = decrypt ? K_r14[53] : K_r14[46];

assign K16[14] = decrypt ? K_r14[25] : K_r14[18];

assign K16[15] = decrypt ? K_r14[33] : K_r14[26];

assign K16[16] = decrypt ? K_r14[34] : K_r14[27];

assign K16[17] = decrypt ? K_r14[17] : K_r14[10];

assign K16[18] = decrypt ? K_r14[5] : K_r14[55];

assign K16[19] = decrypt ? K_r14[4] : K_r14[54];

assign K16[20] = decrypt ? K_r14[55] : K_r14[48];

assign K16[21] = decrypt ? K_r14[24] : K_r14[17];

assign K16[22] = decrypt ? K_r14[32] : K_r14[25];

assign K16[23] = decrypt ? K_r14[40] : K_r14[33];

assign K16[24] = decrypt ? K_r14[20] : K_r14[13];

assign K16[25] = decrypt ? K_r14[36] : K_r14[29];

assign K16[26] = decrypt ? K_r14[31] : K_r14[51];

assign K16[27] = decrypt ? K_r14[21] : K_r14[14];

assign K16[28] = decrypt ? K_r14[8] : K_r14[1];

assign K16[29] = decrypt ? K_r14[23] : K_r14[16];

assign K16[30] = decrypt ? K_r14[52] : K_r14[45];

assign K16[31] = decrypt ? K_r14[14] : K_r14[7];

assign K16[32] = decrypt ? K_r14[29] : K_r14[22];

assign K16[33] = decrypt ? K_r14[51] : K_r14[44];

assign K16[34] = decrypt ? K_r14[9] : K_r14[2];

assign K16[35] = decrypt ? K_r14[35] : K_r14[28];

assign K16[36] = decrypt ? K_r14[30] : K_r14[23];

assign K16[37] = decrypt ? K_r14[2] : K_r14[50];

assign K16[38] = decrypt ? K_r14[37] : K_r14[30];

assign K16[39] = decrypt ? K_r14[22] : K_r14[15];

assign K16[40] = decrypt ? K_r14[0] : K_r14[52];

assign K16[41] = decrypt ? K_r14[42] : K_r14[35];

assign K16[42] = decrypt ? K_r14[38] : K_r14[31];

assign K16[43] = decrypt ? K_r14[16] : K_r14[9];

assign K16[44] = decrypt ? K_r14[43] : K_r14[36];

assign K16[45] = decrypt ? K_r14[44] : K_r14[37];

assign K16[46] = decrypt ? K_r14[1] : K_r14[49];

assign K16[47] = decrypt ? K_r14[7] : K_r14[0];

assign K16[48] = decrypt ? K_r14[28] : K_r14[21];



assign K15[1] = decrypt ? K_r13[54] : K_r13[33];

assign K15[2] = decrypt ? K_r13[18] : K_r13[54];

assign K15[3] = decrypt ? K_r13[33] : K_r13[12];

assign K15[4] = decrypt ? K_r13[10] : K_r13[46];

assign K15[5] = decrypt ? K_r13[20] : K_r13[24];

assign K15[6] = decrypt ? K_r13[48] : K_r13[27];

assign K15[7] = decrypt ? K_r13[34] : K_r13[13];

assign K15[8] = decrypt ? K_r13[13] : K_r13[17];

assign K15[9] = decrypt ? K_r13[4] : K_r13[40];

assign K15[10] = decrypt ? K_r13[55] : K_r13[34];

assign K15[11] = decrypt ? K_r13[46] : K_r13[25];

assign K15[12] = decrypt ? K_r13[26] : K_r13[5];

assign K15[13] = decrypt ? K_r13[3] : K_r13[39];

assign K15[14] = decrypt ? K_r13[32] : K_r13[11];

assign K15[15] = decrypt ? K_r13[40] : K_r13[19];

assign K15[16] = decrypt ? K_r13[41] : K_r13[20];

assign K15[17] = decrypt ? K_r13[24] : K_r13[3];

assign K15[18] = decrypt ? K_r13[12] : K_r13[48];

assign K15[19] = decrypt ? K_r13[11] : K_r13[47];

assign K15[20] = decrypt ? K_r13[5] : K_r13[41];

assign K15[21] = decrypt ? K_r13[6] : K_r13[10];

assign K15[22] = decrypt ? K_r13[39] : K_r13[18];

assign K15[23] = decrypt ? K_r13[47] : K_r13[26];

assign K15[24] = decrypt ? K_r13[27] : K_r13[6];

assign K15[25] = decrypt ? K_r13[43] : K_r13[22];

assign K15[26] = decrypt ? K_r13[38] : K_r13[44];

assign K15[27] = decrypt ? K_r13[28] : K_r13[7];

assign K15[28] = decrypt ? K_r13[15] : K_r13[49];

assign K15[29] = decrypt ? K_r13[30] : K_r13[9];

assign K15[30] = decrypt ? K_r13[0] : K_r13[38];

assign K15[31] = decrypt ? K_r13[21] : K_r13[0];

assign K15[32] = decrypt ? K_r13[36] : K_r13[15];

assign K15[33] = decrypt ? K_r13[31] : K_r13[37];

assign K15[34] = decrypt ? K_r13[16] : K_r13[50];

assign K15[35] = decrypt ? K_r13[42] : K_r13[21];

assign K15[36] = decrypt ? K_r13[37] : K_r13[16];

assign K15[37] = decrypt ? K_r13[9] : K_r13[43];

assign K15[38] = decrypt ? K_r13[44] : K_r13[23];

assign K15[39] = decrypt ? K_r13[29] : K_r13[8];

assign K15[40] = decrypt ? K_r13[7] : K_r13[45];

assign K15[41] = decrypt ? K_r13[49] : K_r13[28];

assign K15[42] = decrypt ? K_r13[45] : K_r13[51];

assign K15[43] = decrypt ? K_r13[23] : K_r13[2];

assign K15[44] = decrypt ? K_r13[50] : K_r13[29];

assign K15[45] = decrypt ? K_r13[51] : K_r13[30];

assign K15[46] = decrypt ? K_r13[8] : K_r13[42];

assign K15[47] = decrypt ? K_r13[14] : K_r13[52];

assign K15[48] = decrypt ? K_r13[35] : K_r13[14];



assign K14[1] = decrypt ? K_r12[11] : K_r12[19];

assign K14[2] = decrypt ? K_r12[32] : K_r12[40];

assign K14[3] = decrypt ? K_r12[47] : K_r12[55];

assign K14[4] = decrypt ? K_r12[24] : K_r12[32];

assign K14[5] = decrypt ? K_r12[34] : K_r12[10];

assign K14[6] = decrypt ? K_r12[5] : K_r12[13];

assign K14[7] = decrypt ? K_r12[48] : K_r12[24];

assign K14[8] = decrypt ? K_r12[27] : K_r12[3];

assign K14[9] = decrypt ? K_r12[18] : K_r12[26];

assign K14[10] = decrypt ? K_r12[12] : K_r12[20];

assign K14[11] = decrypt ? K_r12[3] : K_r12[11];

assign K14[12] = decrypt ? K_r12[40] : K_r12[48];

assign K14[13] = decrypt ? K_r12[17] : K_r12[25];

assign K14[14] = decrypt ? K_r12[46] : K_r12[54];

assign K14[15] = decrypt ? K_r12[54] : K_r12[5];

assign K14[16] = decrypt ? K_r12[55] : K_r12[6];

assign K14[17] = decrypt ? K_r12[13] : K_r12[46];

assign K14[18] = decrypt ? K_r12[26] : K_r12[34];

assign K14[19] = decrypt ? K_r12[25] : K_r12[33];

assign K14[20] = decrypt ? K_r12[19] : K_r12[27];

assign K14[21] = decrypt ? K_r12[20] : K_r12[53];

assign K14[22] = decrypt ? K_r12[53] : K_r12[4];

assign K14[23] = decrypt ? K_r12[4] : K_r12[12];

assign K14[24] = decrypt ? K_r12[41] : K_r12[17];

assign K14[25] = decrypt ? K_r12[2] : K_r12[8];

assign K14[26] = decrypt ? K_r12[52] : K_r12[30];

assign K14[27] = decrypt ? K_r12[42] : K_r12[52];

assign K14[28] = decrypt ? K_r12[29] : K_r12[35];

assign K14[29] = decrypt ? K_r12[44] : K_r12[50];

assign K14[30] = decrypt ? K_r12[14] : K_r12[51];

assign K14[31] = decrypt ? K_r12[35] : K_r12[45];

assign K14[32] = decrypt ? K_r12[50] : K_r12[1];

assign K14[33] = decrypt ? K_r12[45] : K_r12[23];

assign K14[34] = decrypt ? K_r12[30] : K_r12[36];

assign K14[35] = decrypt ? K_r12[1] : K_r12[7];

assign K14[36] = decrypt ? K_r12[51] : K_r12[2];

assign K14[37] = decrypt ? K_r12[23] : K_r12[29];

assign K14[38] = decrypt ? K_r12[31] : K_r12[9];

assign K14[39] = decrypt ? K_r12[43] : K_r12[49];

assign K14[40] = decrypt ? K_r12[21] : K_r12[31];

assign K14[41] = decrypt ? K_r12[8] : K_r12[14];

assign K14[42] = decrypt ? K_r12[0] : K_r12[37];

assign K14[43] = decrypt ? K_r12[37] : K_r12[43];

assign K14[44] = decrypt ? K_r12[9] : K_r12[15];

assign K14[45] = decrypt ? K_r12[38] : K_r12[16];

assign K14[46] = decrypt ? K_r12[22] : K_r12[28];

assign K14[47] = decrypt ? K_r12[28] : K_r12[38];

assign K14[48] = decrypt ? K_r12[49] : K_r12[0];



assign K13[1] = decrypt ? K_r11[25] : K_r11[5];

assign K13[2] = decrypt ? K_r11[46] : K_r11[26];

assign K13[3] = decrypt ? K_r11[4] : K_r11[41];

assign K13[4] = decrypt ? K_r11[13] : K_r11[18];

assign K13[5] = decrypt ? K_r11[48] : K_r11[53];

assign K13[6] = decrypt ? K_r11[19] : K_r11[24];

assign K13[7] = decrypt ? K_r11[5] : K_r11[10];

assign K13[8] = decrypt ? K_r11[41] : K_r11[46];

assign K13[9] = decrypt ? K_r11[32] : K_r11[12];

assign K13[10] = decrypt ? K_r11[26] : K_r11[6];

assign K13[11] = decrypt ? K_r11[17] : K_r11[54];

assign K13[12] = decrypt ? K_r11[54] : K_r11[34];

assign K13[13] = decrypt ? K_r11[6] : K_r11[11];

assign K13[14] = decrypt ? K_r11[3] : K_r11[40];

assign K13[15] = decrypt ? K_r11[11] : K_r11[48];

assign K13[16] = decrypt ? K_r11[12] : K_r11[17];

assign K13[17] = decrypt ? K_r11[27] : K_r11[32];

assign K13[18] = decrypt ? K_r11[40] : K_r11[20];

assign K13[19] = decrypt ? K_r11[39] : K_r11[19];

assign K13[20] = decrypt ? K_r11[33] : K_r11[13];

assign K13[21] = decrypt ? K_r11[34] : K_r11[39];

assign K13[22] = decrypt ? K_r11[10] : K_r11[47];

assign K13[23] = decrypt ? K_r11[18] : K_r11[55];

assign K13[24] = decrypt ? K_r11[55] : K_r11[3];

assign K13[25] = decrypt ? K_r11[16] : K_r11[49];

assign K13[26] = decrypt ? K_r11[7] : K_r11[16];

assign K13[27] = decrypt ? K_r11[1] : K_r11[38];

assign K13[28] = decrypt ? K_r11[43] : K_r11[21];

assign K13[29] = decrypt ? K_r11[31] : K_r11[36];

assign K13[30] = decrypt ? K_r11[28] : K_r11[37];

assign K13[31] = decrypt ? K_r11[49] : K_r11[31];

assign K13[32] = decrypt ? K_r11[9] : K_r11[42];

assign K13[33] = decrypt ? K_r11[0] : K_r11[9];

assign K13[34] = decrypt ? K_r11[44] : K_r11[22];

assign K13[35] = decrypt ? K_r11[15] : K_r11[52];

assign K13[36] = decrypt ? K_r11[38] : K_r11[43];

assign K13[37] = decrypt ? K_r11[37] : K_r11[15];

assign K13[38] = decrypt ? K_r11[45] : K_r11[50];

assign K13[39] = decrypt ? K_r11[2] : K_r11[35];

assign K13[40] = decrypt ? K_r11[35] : K_r11[44];

assign K13[41] = decrypt ? K_r11[22] : K_r11[0];

assign K13[42] = decrypt ? K_r11[14] : K_r11[23];

assign K13[43] = decrypt ? K_r11[51] : K_r11[29];

assign K13[44] = decrypt ? K_r11[23] : K_r11[1];

assign K13[45] = decrypt ? K_r11[52] : K_r11[2];

assign K13[46] = decrypt ? K_r11[36] : K_r11[14];

assign K13[47] = decrypt ? K_r11[42] : K_r11[51];

assign K13[48] = decrypt ? K_r11[8] : K_r11[45];



assign K12[1] = decrypt ? K_r10[39] : K_r10[48];

assign K12[2] = decrypt ? K_r10[3] : K_r10[12];

assign K12[3] = decrypt ? K_r10[18] : K_r10[27];

assign K12[4] = decrypt ? K_r10[27] : K_r10[4];

assign K12[5] = decrypt ? K_r10[5] : K_r10[39];

assign K12[6] = decrypt ? K_r10[33] : K_r10[10];

assign K12[7] = decrypt ? K_r10[19] : K_r10[53];

assign K12[8] = decrypt ? K_r10[55] : K_r10[32];

assign K12[9] = decrypt ? K_r10[46] : K_r10[55];

assign K12[10] = decrypt ? K_r10[40] : K_r10[17];

assign K12[11] = decrypt ? K_r10[6] : K_r10[40];

assign K12[12] = decrypt ? K_r10[11] : K_r10[20];

assign K12[13] = decrypt ? K_r10[20] : K_r10[54];

assign K12[14] = decrypt ? K_r10[17] : K_r10[26];

assign K12[15] = decrypt ? K_r10[25] : K_r10[34];

assign K12[16] = decrypt ? K_r10[26] : K_r10[3];

assign K12[17] = decrypt ? K_r10[41] : K_r10[18];

assign K12[18] = decrypt ? K_r10[54] : K_r10[6];

assign K12[19] = decrypt ? K_r10[53] : K_r10[5];

assign K12[20] = decrypt ? K_r10[47] : K_r10[24];

assign K12[21] = decrypt ? K_r10[48] : K_r10[25];

assign K12[22] = decrypt ? K_r10[24] : K_r10[33];

assign K12[23] = decrypt ? K_r10[32] : K_r10[41];

assign K12[24] = decrypt ? K_r10[12] : K_r10[46];

assign K12[25] = decrypt ? K_r10[30] : K_r10[35];

assign K12[26] = decrypt ? K_r10[21] : K_r10[2];

assign K12[27] = decrypt ? K_r10[15] : K_r10[51];

assign K12[28] = decrypt ? K_r10[2] : K_r10[7];

assign K12[29] = decrypt ? K_r10[45] : K_r10[22];

assign K12[30] = decrypt ? K_r10[42] : K_r10[23];

assign K12[31] = decrypt ? K_r10[8] : K_r10[44];

assign K12[32] = decrypt ? K_r10[23] : K_r10[28];

assign K12[33] = decrypt ? K_r10[14] : K_r10[50];

assign K12[34] = decrypt ? K_r10[31] : K_r10[8];

assign K12[35] = decrypt ? K_r10[29] : K_r10[38];

assign K12[36] = decrypt ? K_r10[52] : K_r10[29];

assign K12[37] = decrypt ? K_r10[51] : K_r10[1];

assign K12[38] = decrypt ? K_r10[0] : K_r10[36];

assign K12[39] = decrypt ? K_r10[16] : K_r10[21];

assign K12[40] = decrypt ? K_r10[49] : K_r10[30];

assign K12[41] = decrypt ? K_r10[36] : K_r10[45];

assign K12[42] = decrypt ? K_r10[28] : K_r10[9];

assign K12[43] = decrypt ? K_r10[38] : K_r10[15];

assign K12[44] = decrypt ? K_r10[37] : K_r10[42];

assign K12[45] = decrypt ? K_r10[7] : K_r10[43];

assign K12[46] = decrypt ? K_r10[50] : K_r10[0];

assign K12[47] = decrypt ? K_r10[1] : K_r10[37];

assign K12[48] = decrypt ? K_r10[22] : K_r10[31];



assign K11[1] = decrypt ? K_r9[53] : K_r9[34];

assign K11[2] = decrypt ? K_r9[17] : K_r9[55];

assign K11[3] = decrypt ? K_r9[32] : K_r9[13];

assign K11[4] = decrypt ? K_r9[41] : K_r9[47];

assign K11[5] = decrypt ? K_r9[19] : K_r9[25];

assign K11[6] = decrypt ? K_r9[47] : K_r9[53];

assign K11[7] = decrypt ? K_r9[33] : K_r9[39];

assign K11[8] = decrypt ? K_r9[12] : K_r9[18];

assign K11[9] = decrypt ? K_r9[3] : K_r9[41];

assign K11[10] = decrypt ? K_r9[54] : K_r9[3];

assign K11[11] = decrypt ? K_r9[20] : K_r9[26];

assign K11[12] = decrypt ? K_r9[25] : K_r9[6];

assign K11[13] = decrypt ? K_r9[34] : K_r9[40];

assign K11[14] = decrypt ? K_r9[6] : K_r9[12];

assign K11[15] = decrypt ? K_r9[39] : K_r9[20];

assign K11[16] = decrypt ? K_r9[40] : K_r9[46];

assign K11[17] = decrypt ? K_r9[55] : K_r9[4];

assign K11[18] = decrypt ? K_r9[11] : K_r9[17];

assign K11[19] = decrypt ? K_r9[10] : K_r9[48];

assign K11[20] = decrypt ? K_r9[4] : K_r9[10];

assign K11[21] = decrypt ? K_r9[5] : K_r9[11];

assign K11[22] = decrypt ? K_r9[13] : K_r9[19];

assign K11[23] = decrypt ? K_r9[46] : K_r9[27];

assign K11[24] = decrypt ? K_r9[26] : K_r9[32];

assign K11[25] = decrypt ? K_r9[44] : K_r9[21];

assign K11[26] = decrypt ? K_r9[35] : K_r9[43];

assign K11[27] = decrypt ? K_r9[29] : K_r9[37];

assign K11[28] = decrypt ? K_r9[16] : K_r9[52];

assign K11[29] = decrypt ? K_r9[0] : K_r9[8];

assign K11[30] = decrypt ? K_r9[1] : K_r9[9];

assign K11[31] = decrypt ? K_r9[22] : K_r9[30];

assign K11[32] = decrypt ? K_r9[37] : K_r9[14];

assign K11[33] = decrypt ? K_r9[28] : K_r9[36];

assign K11[34] = decrypt ? K_r9[45] : K_r9[49];

assign K11[35] = decrypt ? K_r9[43] : K_r9[51];

assign K11[36] = decrypt ? K_r9[7] : K_r9[15];

assign K11[37] = decrypt ? K_r9[38] : K_r9[42];

assign K11[38] = decrypt ? K_r9[14] : K_r9[22];

assign K11[39] = decrypt ? K_r9[30] : K_r9[7];

assign K11[40] = decrypt ? K_r9[8] : K_r9[16];

assign K11[41] = decrypt ? K_r9[50] : K_r9[31];

assign K11[42] = decrypt ? K_r9[42] : K_r9[50];

assign K11[43] = decrypt ? K_r9[52] : K_r9[1];

assign K11[44] = decrypt ? K_r9[51] : K_r9[28];

assign K11[45] = decrypt ? K_r9[21] : K_r9[29];

assign K11[46] = decrypt ? K_r9[9] : K_r9[45];

assign K11[47] = decrypt ? K_r9[15] : K_r9[23];

assign K11[48] = decrypt ? K_r9[36] : K_r9[44];



assign K10[1] = decrypt ? K_r8[10] : K_r8[20];

assign K10[2] = decrypt ? K_r8[6] : K_r8[41];

assign K10[3] = decrypt ? K_r8[46] : K_r8[24];

assign K10[4] = decrypt ? K_r8[55] : K_r8[33];

assign K10[5] = decrypt ? K_r8[33] : K_r8[11];

assign K10[6] = decrypt ? K_r8[4] : K_r8[39];

assign K10[7] = decrypt ? K_r8[47] : K_r8[25];

assign K10[8] = decrypt ? K_r8[26] : K_r8[4];

assign K10[9] = decrypt ? K_r8[17] : K_r8[27];

assign K10[10] = decrypt ? K_r8[11] : K_r8[46];

assign K10[11] = decrypt ? K_r8[34] : K_r8[12];

assign K10[12] = decrypt ? K_r8[39] : K_r8[17];

assign K10[13] = decrypt ? K_r8[48] : K_r8[26];

assign K10[14] = decrypt ? K_r8[20] : K_r8[55];

assign K10[15] = decrypt ? K_r8[53] : K_r8[6];

assign K10[16] = decrypt ? K_r8[54] : K_r8[32];

assign K10[17] = decrypt ? K_r8[12] : K_r8[47];

assign K10[18] = decrypt ? K_r8[25] : K_r8[3];

assign K10[19] = decrypt ? K_r8[24] : K_r8[34];

assign K10[20] = decrypt ? K_r8[18] : K_r8[53];

assign K10[21] = decrypt ? K_r8[19] : K_r8[54];

assign K10[22] = decrypt ? K_r8[27] : K_r8[5];

assign K10[23] = decrypt ? K_r8[3] : K_r8[13];

assign K10[24] = decrypt ? K_r8[40] : K_r8[18];

assign K10[25] = decrypt ? K_r8[31] : K_r8[7];

assign K10[26] = decrypt ? K_r8[49] : K_r8[29];

assign K10[27] = decrypt ? K_r8[43] : K_r8[23];

assign K10[28] = decrypt ? K_r8[30] : K_r8[38];

assign K10[29] = decrypt ? K_r8[14] : K_r8[49];

assign K10[30] = decrypt ? K_r8[15] : K_r8[50];

assign K10[31] = decrypt ? K_r8[36] : K_r8[16];

assign K10[32] = decrypt ? K_r8[51] : K_r8[0];

assign K10[33] = decrypt ? K_r8[42] : K_r8[22];

assign K10[34] = decrypt ? K_r8[0] : K_r8[35];

assign K10[35] = decrypt ? K_r8[2] : K_r8[37];

assign K10[36] = decrypt ? K_r8[21] : K_r8[1];

assign K10[37] = decrypt ? K_r8[52] : K_r8[28];

assign K10[38] = decrypt ? K_r8[28] : K_r8[8];

assign K10[39] = decrypt ? K_r8[44] : K_r8[52];

assign K10[40] = decrypt ? K_r8[22] : K_r8[2];

assign K10[41] = decrypt ? K_r8[9] : K_r8[44];

assign K10[42] = decrypt ? K_r8[1] : K_r8[36];

assign K10[43] = decrypt ? K_r8[7] : K_r8[42];

assign K10[44] = decrypt ? K_r8[38] : K_r8[14];

assign K10[45] = decrypt ? K_r8[35] : K_r8[15];

assign K10[46] = decrypt ? K_r8[23] : K_r8[31];

assign K10[47] = decrypt ? K_r8[29] : K_r8[9];

assign K10[48] = decrypt ? K_r8[50] : K_r8[30];



assign K9[1] = decrypt ? K_r7[24] : K_r7[6];

assign K9[2] = decrypt ? K_r7[20] : K_r7[27];

assign K9[3] = decrypt ? K_r7[3] : K_r7[10];

assign K9[4] = decrypt ? K_r7[12] : K_r7[19];

assign K9[5] = decrypt ? K_r7[47] : K_r7[54];

assign K9[6] = decrypt ? K_r7[18] : K_r7[25];

assign K9[7] = decrypt ? K_r7[4] : K_r7[11];

assign K9[8] = decrypt ? K_r7[40] : K_r7[47];

assign K9[9] = decrypt ? K_r7[6] : K_r7[13];

assign K9[10] = decrypt ? K_r7[25] : K_r7[32];

assign K9[11] = decrypt ? K_r7[48] : K_r7[55];

assign K9[12] = decrypt ? K_r7[53] : K_r7[3];

assign K9[13] = decrypt ? K_r7[5] : K_r7[12];

assign K9[14] = decrypt ? K_r7[34] : K_r7[41];

assign K9[15] = decrypt ? K_r7[10] : K_r7[17];

assign K9[16] = decrypt ? K_r7[11] : K_r7[18];

assign K9[17] = decrypt ? K_r7[26] : K_r7[33];

assign K9[18] = decrypt ? K_r7[39] : K_r7[46];

assign K9[19] = decrypt ? K_r7[13] : K_r7[20];

assign K9[20] = decrypt ? K_r7[32] : K_r7[39];

assign K9[21] = decrypt ? K_r7[33] : K_r7[40];

assign K9[22] = decrypt ? K_r7[41] : K_r7[48];

assign K9[23] = decrypt ? K_r7[17] : K_r7[24];

assign K9[24] = decrypt ? K_r7[54] : K_r7[4];

assign K9[25] = decrypt ? K_r7[45] : K_r7[52];

assign K9[26] = decrypt ? K_r7[8] : K_r7[15];

assign K9[27] = decrypt ? K_r7[2] : K_r7[9];

assign K9[28] = decrypt ? K_r7[44] : K_r7[51];

assign K9[29] = decrypt ? K_r7[28] : K_r7[35];

assign K9[30] = decrypt ? K_r7[29] : K_r7[36];

assign K9[31] = decrypt ? K_r7[50] : K_r7[2];

assign K9[32] = decrypt ? K_r7[38] : K_r7[45];

assign K9[33] = decrypt ? K_r7[1] : K_r7[8];

assign K9[34] = decrypt ? K_r7[14] : K_r7[21];

assign K9[35] = decrypt ? K_r7[16] : K_r7[23];

assign K9[36] = decrypt ? K_r7[35] : K_r7[42];

assign K9[37] = decrypt ? K_r7[7] : K_r7[14];

assign K9[38] = decrypt ? K_r7[42] : K_r7[49];

assign K9[39] = decrypt ? K_r7[31] : K_r7[38];

assign K9[40] = decrypt ? K_r7[36] : K_r7[43];

assign K9[41] = decrypt ? K_r7[23] : K_r7[30];

assign K9[42] = decrypt ? K_r7[15] : K_r7[22];

assign K9[43] = decrypt ? K_r7[21] : K_r7[28];

assign K9[44] = decrypt ? K_r7[52] : K_r7[0];

assign K9[45] = decrypt ? K_r7[49] : K_r7[1];

assign K9[46] = decrypt ? K_r7[37] : K_r7[44];

assign K9[47] = decrypt ? K_r7[43] : K_r7[50];

assign K9[48] = decrypt ? K_r7[9] : K_r7[16];



assign K8[1] = decrypt ? K_r6[6] : K_r6[24];

assign K8[2] = decrypt ? K_r6[27] : K_r6[20];

assign K8[3] = decrypt ? K_r6[10] : K_r6[3];

assign K8[4] = decrypt ? K_r6[19] : K_r6[12];

assign K8[5] = decrypt ? K_r6[54] : K_r6[47];

assign K8[6] = decrypt ? K_r6[25] : K_r6[18];

assign K8[7] = decrypt ? K_r6[11] : K_r6[4];

assign K8[8] = decrypt ? K_r6[47] : K_r6[40];

assign K8[9] = decrypt ? K_r6[13] : K_r6[6];

assign K8[10] = decrypt ? K_r6[32] : K_r6[25];

assign K8[11] = decrypt ? K_r6[55] : K_r6[48];

assign K8[12] = decrypt ? K_r6[3] : K_r6[53];

assign K8[13] = decrypt ? K_r6[12] : K_r6[5];

assign K8[14] = decrypt ? K_r6[41] : K_r6[34];

assign K8[15] = decrypt ? K_r6[17] : K_r6[10];

assign K8[16] = decrypt ? K_r6[18] : K_r6[11];

assign K8[17] = decrypt ? K_r6[33] : K_r6[26];

assign K8[18] = decrypt ? K_r6[46] : K_r6[39];

assign K8[19] = decrypt ? K_r6[20] : K_r6[13];

assign K8[20] = decrypt ? K_r6[39] : K_r6[32];

assign K8[21] = decrypt ? K_r6[40] : K_r6[33];

assign K8[22] = decrypt ? K_r6[48] : K_r6[41];

assign K8[23] = decrypt ? K_r6[24] : K_r6[17];

assign K8[24] = decrypt ? K_r6[4] : K_r6[54];

assign K8[25] = decrypt ? K_r6[52] : K_r6[45];

assign K8[26] = decrypt ? K_r6[15] : K_r6[8];

assign K8[27] = decrypt ? K_r6[9] : K_r6[2];

assign K8[28] = decrypt ? K_r6[51] : K_r6[44];

assign K8[29] = decrypt ? K_r6[35] : K_r6[28];

assign K8[30] = decrypt ? K_r6[36] : K_r6[29];

assign K8[31] = decrypt ? K_r6[2] : K_r6[50];

assign K8[32] = decrypt ? K_r6[45] : K_r6[38];

assign K8[33] = decrypt ? K_r6[8] : K_r6[1];

assign K8[34] = decrypt ? K_r6[21] : K_r6[14];

assign K8[35] = decrypt ? K_r6[23] : K_r6[16];

assign K8[36] = decrypt ? K_r6[42] : K_r6[35];

assign K8[37] = decrypt ? K_r6[14] : K_r6[7];

assign K8[38] = decrypt ? K_r6[49] : K_r6[42];

assign K8[39] = decrypt ? K_r6[38] : K_r6[31];

assign K8[40] = decrypt ? K_r6[43] : K_r6[36];

assign K8[41] = decrypt ? K_r6[30] : K_r6[23];

assign K8[42] = decrypt ? K_r6[22] : K_r6[15];

assign K8[43] = decrypt ? K_r6[28] : K_r6[21];

assign K8[44] = decrypt ? K_r6[0] : K_r6[52];

assign K8[45] = decrypt ? K_r6[1] : K_r6[49];

assign K8[46] = decrypt ? K_r6[44] : K_r6[37];

assign K8[47] = decrypt ? K_r6[50] : K_r6[43];

assign K8[48] = decrypt ? K_r6[16] : K_r6[9];



assign K7[1] = decrypt ? K_r5[20] : K_r5[10];

assign K7[2] = decrypt ? K_r5[41] : K_r5[6];

assign K7[3] = decrypt ? K_r5[24] : K_r5[46];

assign K7[4] = decrypt ? K_r5[33] : K_r5[55];

assign K7[5] = decrypt ? K_r5[11] : K_r5[33];

assign K7[6] = decrypt ? K_r5[39] : K_r5[4];

assign K7[7] = decrypt ? K_r5[25] : K_r5[47];

assign K7[8] = decrypt ? K_r5[4] : K_r5[26];

assign K7[9] = decrypt ? K_r5[27] : K_r5[17];

assign K7[10] = decrypt ? K_r5[46] : K_r5[11];

assign K7[11] = decrypt ? K_r5[12] : K_r5[34];

assign K7[12] = decrypt ? K_r5[17] : K_r5[39];

assign K7[13] = decrypt ? K_r5[26] : K_r5[48];

assign K7[14] = decrypt ? K_r5[55] : K_r5[20];

assign K7[15] = decrypt ? K_r5[6] : K_r5[53];

assign K7[16] = decrypt ? K_r5[32] : K_r5[54];

assign K7[17] = decrypt ? K_r5[47] : K_r5[12];

assign K7[18] = decrypt ? K_r5[3] : K_r5[25];

assign K7[19] = decrypt ? K_r5[34] : K_r5[24];

assign K7[20] = decrypt ? K_r5[53] : K_r5[18];

assign K7[21] = decrypt ? K_r5[54] : K_r5[19];

assign K7[22] = decrypt ? K_r5[5] : K_r5[27];

assign K7[23] = decrypt ? K_r5[13] : K_r5[3];

assign K7[24] = decrypt ? K_r5[18] : K_r5[40];

assign K7[25] = decrypt ? K_r5[7] : K_r5[31];

assign K7[26] = decrypt ? K_r5[29] : K_r5[49];

assign K7[27] = decrypt ? K_r5[23] : K_r5[43];

assign K7[28] = decrypt ? K_r5[38] : K_r5[30];

assign K7[29] = decrypt ? K_r5[49] : K_r5[14];

assign K7[30] = decrypt ? K_r5[50] : K_r5[15];

assign K7[31] = decrypt ? K_r5[16] : K_r5[36];

assign K7[32] = decrypt ? K_r5[0] : K_r5[51];

assign K7[33] = decrypt ? K_r5[22] : K_r5[42];

assign K7[34] = decrypt ? K_r5[35] : K_r5[0];

assign K7[35] = decrypt ? K_r5[37] : K_r5[2];

assign K7[36] = decrypt ? K_r5[1] : K_r5[21];

assign K7[37] = decrypt ? K_r5[28] : K_r5[52];

assign K7[38] = decrypt ? K_r5[8] : K_r5[28];

assign K7[39] = decrypt ? K_r5[52] : K_r5[44];

assign K7[40] = decrypt ? K_r5[2] : K_r5[22];

assign K7[41] = decrypt ? K_r5[44] : K_r5[9];

assign K7[42] = decrypt ? K_r5[36] : K_r5[1];

assign K7[43] = decrypt ? K_r5[42] : K_r5[7];

assign K7[44] = decrypt ? K_r5[14] : K_r5[38];

assign K7[45] = decrypt ? K_r5[15] : K_r5[35];

assign K7[46] = decrypt ? K_r5[31] : K_r5[23];

assign K7[47] = decrypt ? K_r5[9] : K_r5[29];

assign K7[48] = decrypt ? K_r5[30] : K_r5[50];



assign K6[1] = decrypt ? K_r4[34] : K_r4[53];

assign K6[2] = decrypt ? K_r4[55] : K_r4[17];

assign K6[3] = decrypt ? K_r4[13] : K_r4[32];

assign K6[4] = decrypt ? K_r4[47] : K_r4[41];

assign K6[5] = decrypt ? K_r4[25] : K_r4[19];

assign K6[6] = decrypt ? K_r4[53] : K_r4[47];

assign K6[7] = decrypt ? K_r4[39] : K_r4[33];

assign K6[8] = decrypt ? K_r4[18] : K_r4[12];

assign K6[9] = decrypt ? K_r4[41] : K_r4[3];

assign K6[10] = decrypt ? K_r4[3] : K_r4[54];

assign K6[11] = decrypt ? K_r4[26] : K_r4[20];

assign K6[12] = decrypt ? K_r4[6] : K_r4[25];

assign K6[13] = decrypt ? K_r4[40] : K_r4[34];

assign K6[14] = decrypt ? K_r4[12] : K_r4[6];

assign K6[15] = decrypt ? K_r4[20] : K_r4[39];

assign K6[16] = decrypt ? K_r4[46] : K_r4[40];

assign K6[17] = decrypt ? K_r4[4] : K_r4[55];

assign K6[18] = decrypt ? K_r4[17] : K_r4[11];

assign K6[19] = decrypt ? K_r4[48] : K_r4[10];

assign K6[20] = decrypt ? K_r4[10] : K_r4[4];

assign K6[21] = decrypt ? K_r4[11] : K_r4[5];

assign K6[22] = decrypt ? K_r4[19] : K_r4[13];

assign K6[23] = decrypt ? K_r4[27] : K_r4[46];

assign K6[24] = decrypt ? K_r4[32] : K_r4[26];

assign K6[25] = decrypt ? K_r4[21] : K_r4[44];

assign K6[26] = decrypt ? K_r4[43] : K_r4[35];

assign K6[27] = decrypt ? K_r4[37] : K_r4[29];

assign K6[28] = decrypt ? K_r4[52] : K_r4[16];

assign K6[29] = decrypt ? K_r4[8] : K_r4[0];

assign K6[30] = decrypt ? K_r4[9] : K_r4[1];

assign K6[31] = decrypt ? K_r4[30] : K_r4[22];

assign K6[32] = decrypt ? K_r4[14] : K_r4[37];

assign K6[33] = decrypt ? K_r4[36] : K_r4[28];

assign K6[34] = decrypt ? K_r4[49] : K_r4[45];

assign K6[35] = decrypt ? K_r4[51] : K_r4[43];

assign K6[36] = decrypt ? K_r4[15] : K_r4[7];

assign K6[37] = decrypt ? K_r4[42] : K_r4[38];

assign K6[38] = decrypt ? K_r4[22] : K_r4[14];

assign K6[39] = decrypt ? K_r4[7] : K_r4[30];

assign K6[40] = decrypt ? K_r4[16] : K_r4[8];

assign K6[41] = decrypt ? K_r4[31] : K_r4[50];

assign K6[42] = decrypt ? K_r4[50] : K_r4[42];

assign K6[43] = decrypt ? K_r4[1] : K_r4[52];

assign K6[44] = decrypt ? K_r4[28] : K_r4[51];

assign K6[45] = decrypt ? K_r4[29] : K_r4[21];

assign K6[46] = decrypt ? K_r4[45] : K_r4[9];

assign K6[47] = decrypt ? K_r4[23] : K_r4[15];

assign K6[48] = decrypt ? K_r4[44] : K_r4[36];



assign K5[1] = decrypt ? K_r3[48] : K_r3[39];

assign K5[2] = decrypt ? K_r3[12] : K_r3[3];

assign K5[3] = decrypt ? K_r3[27] : K_r3[18];

assign K5[4] = decrypt ? K_r3[4] : K_r3[27];

assign K5[5] = decrypt ? K_r3[39] : K_r3[5];

assign K5[6] = decrypt ? K_r3[10] : K_r3[33];

assign K5[7] = decrypt ? K_r3[53] : K_r3[19];

assign K5[8] = decrypt ? K_r3[32] : K_r3[55];

assign K5[9] = decrypt ? K_r3[55] : K_r3[46];

assign K5[10] = decrypt ? K_r3[17] : K_r3[40];

assign K5[11] = decrypt ? K_r3[40] : K_r3[6];

assign K5[12] = decrypt ? K_r3[20] : K_r3[11];

assign K5[13] = decrypt ? K_r3[54] : K_r3[20];

assign K5[14] = decrypt ? K_r3[26] : K_r3[17];

assign K5[15] = decrypt ? K_r3[34] : K_r3[25];

assign K5[16] = decrypt ? K_r3[3] : K_r3[26];

assign K5[17] = decrypt ? K_r3[18] : K_r3[41];

assign K5[18] = decrypt ? K_r3[6] : K_r3[54];

assign K5[19] = decrypt ? K_r3[5] : K_r3[53];

assign K5[20] = decrypt ? K_r3[24] : K_r3[47];

assign K5[21] = decrypt ? K_r3[25] : K_r3[48];

assign K5[22] = decrypt ? K_r3[33] : K_r3[24];

assign K5[23] = decrypt ? K_r3[41] : K_r3[32];

assign K5[24] = decrypt ? K_r3[46] : K_r3[12];

assign K5[25] = decrypt ? K_r3[35] : K_r3[30];

assign K5[26] = decrypt ? K_r3[2] : K_r3[21];

assign K5[27] = decrypt ? K_r3[51] : K_r3[15];

assign K5[28] = decrypt ? K_r3[7] : K_r3[2];

assign K5[29] = decrypt ? K_r3[22] : K_r3[45];

assign K5[30] = decrypt ? K_r3[23] : K_r3[42];

assign K5[31] = decrypt ? K_r3[44] : K_r3[8];

assign K5[32] = decrypt ? K_r3[28] : K_r3[23];

assign K5[33] = decrypt ? K_r3[50] : K_r3[14];

assign K5[34] = decrypt ? K_r3[8] : K_r3[31];

assign K5[35] = decrypt ? K_r3[38] : K_r3[29];

assign K5[36] = decrypt ? K_r3[29] : K_r3[52];

assign K5[37] = decrypt ? K_r3[1] : K_r3[51];

assign K5[38] = decrypt ? K_r3[36] : K_r3[0];

assign K5[39] = decrypt ? K_r3[21] : K_r3[16];

assign K5[40] = decrypt ? K_r3[30] : K_r3[49];

assign K5[41] = decrypt ? K_r3[45] : K_r3[36];

assign K5[42] = decrypt ? K_r3[9] : K_r3[28];

assign K5[43] = decrypt ? K_r3[15] : K_r3[38];

assign K5[44] = decrypt ? K_r3[42] : K_r3[37];

assign K5[45] = decrypt ? K_r3[43] : K_r3[7];

assign K5[46] = decrypt ? K_r3[0] : K_r3[50];

assign K5[47] = decrypt ? K_r3[37] : K_r3[1];

assign K5[48] = decrypt ? K_r3[31] : K_r3[22];



assign K4[1] = decrypt ? K_r2[5] : K_r2[25];

assign K4[2] = decrypt ? K_r2[26] : K_r2[46];

assign K4[3] = decrypt ? K_r2[41] : K_r2[4];

assign K4[4] = decrypt ? K_r2[18] : K_r2[13];

assign K4[5] = decrypt ? K_r2[53] : K_r2[48];

assign K4[6] = decrypt ? K_r2[24] : K_r2[19];

assign K4[7] = decrypt ? K_r2[10] : K_r2[5];

assign K4[8] = decrypt ? K_r2[46] : K_r2[41];

assign K4[9] = decrypt ? K_r2[12] : K_r2[32];

assign K4[10] = decrypt ? K_r2[6] : K_r2[26];

assign K4[11] = decrypt ? K_r2[54] : K_r2[17];

assign K4[12] = decrypt ? K_r2[34] : K_r2[54];

assign K4[13] = decrypt ? K_r2[11] : K_r2[6];

assign K4[14] = decrypt ? K_r2[40] : K_r2[3];

assign K4[15] = decrypt ? K_r2[48] : K_r2[11];

assign K4[16] = decrypt ? K_r2[17] : K_r2[12];

assign K4[17] = decrypt ? K_r2[32] : K_r2[27];

assign K4[18] = decrypt ? K_r2[20] : K_r2[40];

assign K4[19] = decrypt ? K_r2[19] : K_r2[39];

assign K4[20] = decrypt ? K_r2[13] : K_r2[33];

assign K4[21] = decrypt ? K_r2[39] : K_r2[34];

assign K4[22] = decrypt ? K_r2[47] : K_r2[10];

assign K4[23] = decrypt ? K_r2[55] : K_r2[18];

assign K4[24] = decrypt ? K_r2[3] : K_r2[55];

assign K4[25] = decrypt ? K_r2[49] : K_r2[16];

assign K4[26] = decrypt ? K_r2[16] : K_r2[7];

assign K4[27] = decrypt ? K_r2[38] : K_r2[1];

assign K4[28] = decrypt ? K_r2[21] : K_r2[43];

assign K4[29] = decrypt ? K_r2[36] : K_r2[31];

assign K4[30] = decrypt ? K_r2[37] : K_r2[28];

assign K4[31] = decrypt ? K_r2[31] : K_r2[49];

assign K4[32] = decrypt ? K_r2[42] : K_r2[9];

assign K4[33] = decrypt ? K_r2[9] : K_r2[0];

assign K4[34] = decrypt ? K_r2[22] : K_r2[44];

assign K4[35] = decrypt ? K_r2[52] : K_r2[15];

assign K4[36] = decrypt ? K_r2[43] : K_r2[38];

assign K4[37] = decrypt ? K_r2[15] : K_r2[37];

assign K4[38] = decrypt ? K_r2[50] : K_r2[45];

assign K4[39] = decrypt ? K_r2[35] : K_r2[2];

assign K4[40] = decrypt ? K_r2[44] : K_r2[35];

assign K4[41] = decrypt ? K_r2[0] : K_r2[22];

assign K4[42] = decrypt ? K_r2[23] : K_r2[14];

assign K4[43] = decrypt ? K_r2[29] : K_r2[51];

assign K4[44] = decrypt ? K_r2[1] : K_r2[23];

assign K4[45] = decrypt ? K_r2[2] : K_r2[52];

assign K4[46] = decrypt ? K_r2[14] : K_r2[36];

assign K4[47] = decrypt ? K_r2[51] : K_r2[42];

assign K4[48] = decrypt ? K_r2[45] : K_r2[8];



assign K3[1] = decrypt ? K_r1[19] : K_r1[11];

assign K3[2] = decrypt ? K_r1[40] : K_r1[32];

assign K3[3] = decrypt ? K_r1[55] : K_r1[47];

assign K3[4] = decrypt ? K_r1[32] : K_r1[24];

assign K3[5] = decrypt ? K_r1[10] : K_r1[34];

assign K3[6] = decrypt ? K_r1[13] : K_r1[5];

assign K3[7] = decrypt ? K_r1[24] : K_r1[48];

assign K3[8] = decrypt ? K_r1[3] : K_r1[27];

assign K3[9] = decrypt ? K_r1[26] : K_r1[18];

assign K3[10] = decrypt ? K_r1[20] : K_r1[12];

assign K3[11] = decrypt ? K_r1[11] : K_r1[3];

assign K3[12] = decrypt ? K_r1[48] : K_r1[40];

assign K3[13] = decrypt ? K_r1[25] : K_r1[17];

assign K3[14] = decrypt ? K_r1[54] : K_r1[46];

assign K3[15] = decrypt ? K_r1[5] : K_r1[54];

assign K3[16] = decrypt ? K_r1[6] : K_r1[55];

assign K3[17] = decrypt ? K_r1[46] : K_r1[13];

assign K3[18] = decrypt ? K_r1[34] : K_r1[26];

assign K3[19] = decrypt ? K_r1[33] : K_r1[25];

assign K3[20] = decrypt ? K_r1[27] : K_r1[19];

assign K3[21] = decrypt ? K_r1[53] : K_r1[20];

assign K3[22] = decrypt ? K_r1[4] : K_r1[53];

assign K3[23] = decrypt ? K_r1[12] : K_r1[4];

assign K3[24] = decrypt ? K_r1[17] : K_r1[41];

assign K3[25] = decrypt ? K_r1[8] : K_r1[2];

assign K3[26] = decrypt ? K_r1[30] : K_r1[52];

assign K3[27] = decrypt ? K_r1[52] : K_r1[42];

assign K3[28] = decrypt ? K_r1[35] : K_r1[29];

assign K3[29] = decrypt ? K_r1[50] : K_r1[44];

assign K3[30] = decrypt ? K_r1[51] : K_r1[14];

assign K3[31] = decrypt ? K_r1[45] : K_r1[35];

assign K3[32] = decrypt ? K_r1[1] : K_r1[50];

assign K3[33] = decrypt ? K_r1[23] : K_r1[45];

assign K3[34] = decrypt ? K_r1[36] : K_r1[30];

assign K3[35] = decrypt ? K_r1[7] : K_r1[1];

assign K3[36] = decrypt ? K_r1[2] : K_r1[51];

assign K3[37] = decrypt ? K_r1[29] : K_r1[23];

assign K3[38] = decrypt ? K_r1[9] : K_r1[31];

assign K3[39] = decrypt ? K_r1[49] : K_r1[43];

assign K3[40] = decrypt ? K_r1[31] : K_r1[21];

assign K3[41] = decrypt ? K_r1[14] : K_r1[8];

assign K3[42] = decrypt ? K_r1[37] : K_r1[0];

assign K3[43] = decrypt ? K_r1[43] : K_r1[37];

assign K3[44] = decrypt ? K_r1[15] : K_r1[9];

assign K3[45] = decrypt ? K_r1[16] : K_r1[38];

assign K3[46] = decrypt ? K_r1[28] : K_r1[22];

assign K3[47] = decrypt ? K_r1[38] : K_r1[28];

assign K3[48] = decrypt ? K_r1[0] : K_r1[49];



assign K2[1] = decrypt ? K_r0[33] : K_r0[54];

assign K2[2] = decrypt ? K_r0[54] : K_r0[18];

assign K2[3] = decrypt ? K_r0[12] : K_r0[33];

assign K2[4] = decrypt ? K_r0[46] : K_r0[10];

assign K2[5] = decrypt ? K_r0[24] : K_r0[20];

assign K2[6] = decrypt ? K_r0[27] : K_r0[48];

assign K2[7] = decrypt ? K_r0[13] : K_r0[34];

assign K2[8] = decrypt ? K_r0[17] : K_r0[13];

assign K2[9] = decrypt ? K_r0[40] : K_r0[4];

assign K2[10] = decrypt ? K_r0[34] : K_r0[55];

assign K2[11] = decrypt ? K_r0[25] : K_r0[46];

assign K2[12] = decrypt ? K_r0[5] : K_r0[26];

assign K2[13] = decrypt ? K_r0[39] : K_r0[3];

assign K2[14] = decrypt ? K_r0[11] : K_r0[32];

assign K2[15] = decrypt ? K_r0[19] : K_r0[40];

assign K2[16] = decrypt ? K_r0[20] : K_r0[41];

assign K2[17] = decrypt ? K_r0[3] : K_r0[24];

assign K2[18] = decrypt ? K_r0[48] : K_r0[12];

assign K2[19] = decrypt ? K_r0[47] : K_r0[11];

assign K2[20] = decrypt ? K_r0[41] : K_r0[5];

assign K2[21] = decrypt ? K_r0[10] : K_r0[6];

assign K2[22] = decrypt ? K_r0[18] : K_r0[39];

assign K2[23] = decrypt ? K_r0[26] : K_r0[47];

assign K2[24] = decrypt ? K_r0[6] : K_r0[27];

assign K2[25] = decrypt ? K_r0[22] : K_r0[43];

assign K2[26] = decrypt ? K_r0[44] : K_r0[38];

assign K2[27] = decrypt ? K_r0[7] : K_r0[28];

assign K2[28] = decrypt ? K_r0[49] : K_r0[15];

assign K2[29] = decrypt ? K_r0[9] : K_r0[30];

assign K2[30] = decrypt ? K_r0[38] : K_r0[0];

assign K2[31] = decrypt ? K_r0[0] : K_r0[21];

assign K2[32] = decrypt ? K_r0[15] : K_r0[36];

assign K2[33] = decrypt ? K_r0[37] : K_r0[31];

assign K2[34] = decrypt ? K_r0[50] : K_r0[16];

assign K2[35] = decrypt ? K_r0[21] : K_r0[42];

assign K2[36] = decrypt ? K_r0[16] : K_r0[37];

assign K2[37] = decrypt ? K_r0[43] : K_r0[9];

assign K2[38] = decrypt ? K_r0[23] : K_r0[44];

assign K2[39] = decrypt ? K_r0[8] : K_r0[29];

assign K2[40] = decrypt ? K_r0[45] : K_r0[7];

assign K2[41] = decrypt ? K_r0[28] : K_r0[49];

assign K2[42] = decrypt ? K_r0[51] : K_r0[45];

assign K2[43] = decrypt ? K_r0[2] : K_r0[23];

assign K2[44] = decrypt ? K_r0[29] : K_r0[50];

assign K2[45] = decrypt ? K_r0[30] : K_r0[51];

assign K2[46] = decrypt ? K_r0[42] : K_r0[8];

assign K2[47] = decrypt ? K_r0[52] : K_r0[14];

assign K2[48] = decrypt ? K_r0[14] : K_r0[35];



assign K1[1] = decrypt ? K[40] : K[47];

assign K1[2] = decrypt ? K[4] : K[11];

assign K1[3] = decrypt ? K[19] : K[26];

assign K1[4] = decrypt ? K[53] : K[3];

assign K1[5] = decrypt ? K[6] : K[13];

assign K1[6] = decrypt ? K[34] : K[41];

assign K1[7] = decrypt ? K[20] : K[27];

assign K1[8] = decrypt ? K[24] : K[6];

assign K1[9] = decrypt ? K[47] : K[54];

assign K1[10] = decrypt ? K[41] : K[48];

assign K1[11] = decrypt ? K[32] : K[39];

assign K1[12] = decrypt ? K[12] : K[19];

assign K1[13] = decrypt ? K[46] : K[53];

assign K1[14] = decrypt ? K[18] : K[25];

assign K1[15] = decrypt ? K[26] : K[33];

assign K1[16] = decrypt ? K[27] : K[34];

assign K1[17] = decrypt ? K[10] : K[17];

assign K1[18] = decrypt ? K[55] : K[5];

assign K1[19] = decrypt ? K[54] : K[4];

assign K1[20] = decrypt ? K[48] : K[55];

assign K1[21] = decrypt ? K[17] : K[24];

assign K1[22] = decrypt ? K[25] : K[32];

assign K1[23] = decrypt ? K[33] : K[40];

assign K1[24] = decrypt ? K[13] : K[20];

assign K1[25] = decrypt ? K[29] : K[36];

assign K1[26] = decrypt ? K[51] : K[31];

assign K1[27] = decrypt ? K[14] : K[21];

assign K1[28] = decrypt ? K[1] : K[8];

assign K1[29] = decrypt ? K[16] : K[23];

assign K1[30] = decrypt ? K[45] : K[52];

assign K1[31] = decrypt ? K[7] : K[14];

assign K1[32] = decrypt ? K[22] : K[29];

assign K1[33] = decrypt ? K[44] : K[51];

assign K1[34] = decrypt ? K[2] : K[9];

assign K1[35] = decrypt ? K[28] : K[35];

assign K1[36] = decrypt ? K[23] : K[30];

assign K1[37] = decrypt ? K[50] : K[2];

assign K1[38] = decrypt ? K[30] : K[37];

assign K1[39] = decrypt ? K[15] : K[22];

assign K1[40] = decrypt ? K[52] : K[0];

assign K1[41] = decrypt ? K[35] : K[42];

assign K1[42] = decrypt ? K[31] : K[38];

assign K1[43] = decrypt ? K[9] : K[16];

assign K1[44] = decrypt ? K[36] : K[43];

assign K1[45] = decrypt ? K[37] : K[44];

assign K1[46] = decrypt ? K[49] : K[1];

assign K1[47] = decrypt ? K[0] : K[7];

assign K1[48] = decrypt ? K[21] : K[28];



endmodule
