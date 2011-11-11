note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Where morality is present, laws are unnecessary. Without morality, laws are unenforceable. - Anonymous"

class
	EC_DOMAIN_PARAMETERS_F2M

inherit
	EC_DOMAIN_PARAMETERS
		redefine
			curve,
			g
		end
	STANDARD_CURVES

create
	make_curve_g_n,
	make_curve_g_n_h,
	make_sec_t113r1,
	make_sec_t113r2,
	make_sec_t131r1,
	make_sec_t131r2,
	make_sec_t163k1,
	make_sec_t163r1,
	make_sec_t163r2,
	make_sec_t193r1,
	make_sec_t193r2,
	make_sec_t233k1,
	make_sec_t233r1,
	make_sec_t239k1,
	make_sec_t283k1,
	make_sec_t283r1,
	make_sec_t409k1,
	make_sec_t409r1,
	make_sec_t571k1,
	make_sec_t571r1,
	make_k163,
	make_k233,
	make_k283,
	make_k409,
	make_k571,
	make_b163,
	make_b233,
	make_b283,
	make_b409,
	make_b571

feature --SEC recommended polynomial curves
	make_sec_t113r1
		do
			create curve.make_sec_t113r1
			create g.make_sec_t113r1
			n := sec_t113r1_r
			h := sec_t113r1_h
		end

	make_sec_t113r2
		do
			create curve.make_sec_t113r2
			create g.make_sec_t113r2
			n := sec_t113r2_r
			h := sec_t113r2_h
		end

	make_sec_t131r1
		do
			create curve.make_sec_t131r1
			create g.make_sec_t131r1
			n := sec_t131r1_r
			h := sec_t131r1_h
		end

	make_sec_t131r2
		do
			create curve.make_sec_t131r2
			create g.make_sec_t131r2
			n := sec_t131r2_r
			h := sec_t131r2_h
		end

	make_sec_t163k1
		do
			create curve.make_sec_t163k1
			create g.make_sec_t163k1
			n := sec_t163k1_r
			h := sec_t163k1_h
		end

	make_sec_t163r1
		do
			create curve.make_sec_t163r1
			create g.make_sec_t163r1
			n := sec_t163r1_r
			h := sec_t163r1_h
		end

	make_sec_t163r2
		do
			create curve.make_sec_t163r2
			create g.make_sec_t163r2
			n := sec_t163r2_r
			h := sec_t163r2_h
		end

	make_sec_t193r1
		do
			create curve.make_sec_t193r1
			create g.make_sec_t193r1
			n := sec_t193r1_r
			h := sec_t193r1_h
		end

	make_sec_t193r2
		do
			create curve.make_sec_t193r2
			create g.make_sec_t193r2
			n := sec_t193r2_r
			h := sec_t193r2_h
		end

	make_sec_t233k1
		do
			create curve.make_sec_t233k1
			create g.make_sec_t233k1
			n := sec_t233k1_r
			h := sec_t233k1_h
		end

	make_sec_t233r1
		do
			create curve.make_sec_t233r1
			create g.make_sec_t233r1
			n := sec_t233r1_r
			h := sec_t233r1_h
		end

	make_sec_t239k1
		do
			create curve.make_sec_t239k1
			create g.make_sec_t239k1
			n := sec_t239k1_r
			h := sec_t239k1_h
		end

	make_sec_t283k1
		do
			create curve.make_sec_t283k1
			create g.make_sec_t283k1
			n := sec_t283k1_r
			h := sec_t283k1_h
		end

	make_sec_t283r1
		do
			create curve.make_sec_t283r1
			create g.make_sec_t283r1
			n := sec_t283r1_r
			h := sec_t283r1_h
		end

	make_sec_t409k1
		do
			create curve.make_sec_t409k1
			create g.make_sec_t409k1
			n := sec_t409k1_r
			h := sec_t409k1_h
		end

	make_sec_t409r1
		do
			create curve.make_sec_t409r1
			create g.make_sec_t409r1
			n := sec_t409r1_r
			h := sec_t409r1_h
		end

	make_sec_t571k1
		do
			create curve.make_sec_t571k1
			create g.make_sec_t571k1
			n := sec_t571k1_r
			h := sec_t571k1_h
		end

	make_sec_t571r1
		do
			create curve.make_sec_t571r1
			create g.make_sec_t571r1
			n := sec_t571r1_r
			h := sec_t571r1_h
		end

feature --FIPS curves
	make_k163
		do
			create curve.make_k163
			create g.make_k163
			n := k163_r
			h := k163_h
		end

	make_k233
		do
			create curve.make_k233
			create g.make_k233
			n := k233_r
			h := k233_h
		end

	make_k283
		do
			create curve.make_k283
			create g.make_k283
			n := k283_r
			h := k283_h
		end

	make_k409
		do
			create curve.make_k409
			create g.make_k409
			n := k409_r
			h := k409_h
		end

	make_k571
		do
			create curve.make_k571
			create g.make_k571
			n := k571_r
			h := k571_h
		end

	make_b163
		do
			create curve.make_b163
			create g.make_b163
			n := b163_r
			h := b163_h
		end

	make_b233
		do
			create curve.make_b233
			create g.make_b233
			n := b233_r
			h := b233_h
		end

	make_b283
		do
			create curve.make_b283
			create g.make_b283
			n := b283_r
			h := b283_h
		end

	make_b409
		do
			create curve.make_b409
			create g.make_b409
			n := b409_r
			h := b409_h
		end

	make_b571
		do
			create curve.make_b571
			create g.make_b571
			n := b571_r
			h := b571_h
		end

	curve: EC_CURVE_F2M
	g: EC_POINT_F2M
end
