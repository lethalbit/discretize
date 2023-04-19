// SPDX-License-Identifier: BSD-3-Clause

(* techmap_celltype = "$_MUX_" *)
module _80_FET_mux (A, B, S, Y);
	input  A;
	input  B;
	input  S;
	output Y;

	wire _0_;
	wire _1_;
	wire _2_;
	wire _3_;

	wire _S_;
	wire _Y_;

	\$_NOT_ not0(
		.A(S),
		.Y(_S_)
	);


	\PFET p0(
		.S(1'b1),
		.G(A),
		.D(_0_)
	);
	\PFET p1(
		.S(_0_),
		.G(S),
		.D(_Y_)
	);
	\PFET p2(
		.S(1'b1),
		.G(B),
		.D(_1_)
	);
	\PFET p3(
		.S(_1_),
		.G(_S_),
		.D(_Y_)
	);

	\NFET n0(
		.S(_Y_),
		.G(_S_),
		.D(_2_),
	);
	\NFET n1(
		.S(_2_),
		.G(A),
		.D(1'b0)
	);
	\NFET n2(
		.S(_Y_),
		.G(S),
		.D(_3_)
	);
	\NFET n3(
		.S(_3_),
		.G(B),
		.D(1'b0)
	);

	assign Y = _Y_;

endmodule

(* techmap_celltype = "$_NMUX_" *)
module _80_FET_nmux (A, B, S, Y);
	input  A;
	input  B;
	input  S;
	output Y;

	wire _0_;


	\$_MUX_ mux0(
		.A(A),
		.B(B),
		.S(S),
		.Y(_0_)
	);

	\$_NOT_ not0(
		.A(_0_),
		.Y(Y)
	);

endmodule
