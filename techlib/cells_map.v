// SPDX-License-Identifier: BSD-3-Clause

(* techmap_celltype = "$_NOT_" *)
module _80_FET_not (A, Y);
	input  A;
	output Y;

	wire _0_;

	`ifdef DUAL_FETS
		// A more compact gate using a P/N FET pair
		\NFET_PFET_PAIR f0(
			.Gp(A),
			.Sp(1'b1),
			.Dp(_0_),
			.Gn(A),
			.Sn(_0_),
			.D(1'b0)
		)
	`else
		\PFET p0(
			.G(A),
			.S(1'b1),
			.D(_0_)
		);
		\NFET n0(
			.G(A),
			.S(_0_),
			.D(1'b0)
		);
	`endif
	assign Y = _0_;
endmodule

(* techmap_celltype = "$_BUF_" *)
module _80_FET_buf (A, Y);
	input  A;
	output Y;

	wire _0_;

	\$_NOT_ not0(
		.A(A),
		.Y(_0_)
	);
	\$_NOT_ not1(
		.A(_0_),
		.Y(Y)
	);
endmodule

(* techmap_celltype = "$_NAND_" *)
module _80_FET_nand (A, B, Y);
	input  A;
	input  B;
	output Y;
	wire _0_;
	wire _1_;


	\PFET p0(
		.G(A),
		.S(1'b1),
		.D(_0_)
	);

	\PFET p1(
		.G(B),
		.S(1'b1),
		.D(_0_)
	);

	\NFET n0(
		.G(B),
		.S(_0_),
		.D(_1_)
	);

	\NFET n1(
		.G(A),
		.S(_1_),
		.D(1'b0)
	);

	assign Y = _0_;
endmodule


(* techmap_celltype = "$_AND_" *)
module _80_FET_and (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;
	wire _1_;

	\$_NAND_ nand0(
		.A(A),
		.B(B),
		.Y(_0_),
	);

	\$_NOT_ not0(
		.A(_0_),
		.Y(Y)
	);
endmodule

(* techmap_celltype = "$_ANDNOT_" *)
module _80_FET_andnot (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;

	\$_NOT_ not0(
		.A(B),
		.Y(_0_)
	);

	\$_AND_ and0(
		.A(A),
		.B(_0_),
		.Y(Y)
	);
endmodule

(* techmap_celltype = "$_OR_" *)
module _80_FET_or (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;
	wire _1_;

	\NFET n0(
		.G(B),
		.S(_0_),
		.D(_1_)
	);

	\NFET n1(
		.G(A),
		.S(_1_),
		.D(1'b0)
	);
endmodule

(* techmap_celltype = "$_NOR_" *)
module _80_FET_nor (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;

	\$_OR_ or0(
		.A(A),
		.B(B),
		.Y(_0_)
	);

	\$_NOT_ not0(
		.A(_0_),
		.Y(Y)
	);
endmodule

(* techmap_celltype = "$_ORNOT_" *)
module _80_FET_ornot (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;

	\$_NOT_ not0(
		.A(B),
		.Y(_0_)
	);

	\$_OR_ or0(
		.A(A),
		.B(_0_),
		.Y(Y)
	);
endmodule

(* techmap_celltype = "$_XOR_" *)
module _80_FET_xor (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;
	wire _1_;
	wire _2_;
	wire _3_;

	wire _Y_;
	wire _A_;
	wire _B_;

	\$_NOT_ not0(
		.A(A),
		.Y(_A_)
	);

	\$_NOT_ not1(
		.A(B),
		.Y(_B_)
	);


	\PFET p0(
		.S(1'b1),
		.G(_A_),
		.D(_0_)
	);
	\PFET p1(
		.S(_0_),
		.G(B),
		.D(_Y_)
	);
	\PFET p2(
		.S(1'b1),
		.G(A),
		.D(_1_)
	);
	\PFET p3(
		.S(_1_),
		.G(_B_),
		.D(_Y_)
	);

	\NFET n0(
		.S(_Y_),
		.G(_B_),
		.D(_2_)
	);
	\NFET n1(
		.S(_2_),
		.G(_A_),
		.D(1'b0)
	);
	\NFET n2(
		.S(_Y_),
		.G(B),
		.S(_3_)
	);
	\NFET n3(
		.S(_3_),
		.G(A),
		.D(1'b0)
	);

	assign Y = _Y_;
endmodule

(* techmap_celltype = "$_XNOR_" *)
module _80_FET_xnor (A, B, Y);
	input  A;
	input  B;
	output Y;

	wire _0_;

	\$_XOR_ xor0(
		.A(A),
		.B(B),
		.Y(_0_)
	);

	\$_NOT_ not0(
		.A(_0_),
		.Y(Y)
	);
endmodule
