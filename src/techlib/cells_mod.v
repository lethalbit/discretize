// SPDX-License-Identifier: BSD-3-Clause

module \NFET (G, S, D);
	input G;
	input S;
	inout D;

	assign D = (G == 1'b1) ? S : 1'b0;

	`ifdef TIMING
	specify
		// TODO: Real-world generic-ish timing info
	endspecify
	`endif
endmodule

module \DUAL_NFET (G0, S0, D0, G1, S1, D1);
	input G0;
	input S0;
	inout D0;
	input G1;
	input S1;
	inout D1;

	assign D0 = (G0 == 1'b1) ? S0 : 1'b0;
	assign D1 = (G1 == 1'b1) ? S1 : 1'b0;

	`ifdef TIMING
	specify
		// TODO: Real-world generic-ish timing info
	endspecify
	`endif
endmodule

module \PFET (G, S, D);
	input G;
	input S;
	inout D;

	assign D = (G == 1'b0) ? S : 1'b0;

	`ifdef TIMING
	specify
		// TODO: Real-world generic-ish timing info
	endspecify
	`endif
endmodule


module \DUAL_PFET (G0, S0, D0, G1, S1, D1);
	input G0;
	input S0;
	inout D0;

	input G1;
	input S1;
	inout D1;

	assign D0 = (G0 == 1'b0) ? S0 : 1'b0;
	assign D1 = (G1 == 1'b0) ? S1 : 1'b0;

	`ifdef TIMING
	specify
		// TODO: Real-world generic-ish timing info
	endspecify
	`endif
endmodule


module \NFET_PFET_PAIR (Gn, Sn, Dn, Gp, Sp, Dp);
	input Gn;
	input Sn;
	inout Dn;
	input Gp;
	input Sp;
	inout Dp;

	assign Dn = (Gn == 1'b1) ? Sn : 1'b0;
	assign Dp = (Gp == 1'b0) ? Sp : 1'b0;

	`ifdef TIMING
	specify
		// TODO: Real-world generic-ish timing info
	endspecify
	`endif
endmodule
