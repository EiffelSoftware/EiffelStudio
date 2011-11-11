note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Extremism in the defense of liberty is no vice. Moderation in the pursuit of justice is no virtue. - Barry Goldwater (1964)"

class
	EC_DOMAIN_PARAMETERS_FP

inherit
	EC_DOMAIN_PARAMETERS
		redefine
			curve,
			g
		end
	STANDARD_CURVES
		export
			{NONE}
				all
		undefine
			default_create
		end

create
	make_curve_g_n,
	make_curve_g_n_h,
	make_sec_p112r1,
	make_sec_p112r2,
	make_sec_p128r1,
	make_sec_p128r2,
	make_sec_p160k1,
	make_sec_p160r1,
	make_sec_p160r2,
	make_sec_p192k1,
	make_sec_p192r1,
	make_sec_p224k1,
	make_sec_p224r1,
	make_sec_p256k1,
	make_sec_p256r1,
	make_sec_p384r1,
	make_sec_p521r1,
	make_p192,
	make_p224,
	make_p256,
	make_p384,
	make_p521

feature
	make_sec_p112r1
		do
			create curve.make_sec_p112r1
			create g.make_sec_p112r1
			n := sec_p112r1_r
			h := sec_p112r1_h
		end

	make_sec_p112r2
		do
			create curve.make_sec_p112r2
			create g.make_sec_p112r2
			n := sec_p112r2_r
			h := sec_p112r2_h
		end

	make_sec_p128r1
		do
			create curve.make_sec_p128r1
			create g.make_sec_p128r1
			n := sec_p128r1_r
			h := sec_p128r1_h
		end

	make_sec_p128r2
		do
			create curve.make_sec_p128r2
			create g.make_sec_p128r2
			n := sec_p128r2_r
			h := sec_p128r2_h
		end

	make_sec_p160k1
		do
			create curve.make_sec_p160k1
			create g.make_sec_p160k1
			n := sec_p160k1_r
			h := sec_p160k1_h
		end

	make_sec_p160r1
		do
			create curve.make_sec_p160r1
			create g.make_sec_p160r1
			n := sec_p160r1_r
			h := sec_p160r1_h
		end

	make_sec_p160r2
		do
			create curve.make_sec_p160r2
			create g.make_sec_p160r2
			n := sec_p160r2_r
			h := sec_p160r2_h
		end

	make_sec_p192k1
		do
			create curve.make_sec_p192k1
			create g.make_sec_p192k1
			n := sec_p192k1_r
			h := sec_p192k1_h
		end

	make_sec_p192r1
		do
			create curve.make_sec_p192r1
			create g.make_sec_p192r1
			n := sec_p192r1_r
			h := sec_p192r1_h
		end

	make_sec_p224k1
		do
			create curve.make_sec_p224k1
			create g.make_sec_p224k1
			n := sec_p224k1_r
			h := sec_p224k1_h
		end

	make_sec_p224r1
		do
			create curve.make_sec_p224r1
			create g.make_sec_p224r1
			n := sec_p224r1_r
			h := sec_p224r1_h
		end

	make_sec_p256k1
		do
			create curve.make_sec_p256k1
			create g.make_sec_p256k1
			n := sec_p256k1_r
			h := sec_p256k1_h
		end

	make_sec_p256r1
		do
			create curve.make_sec_p256r1
			create g.make_sec_p256r1
			n := sec_p256r1_r
			h := sec_p256r1_h
		end

	make_sec_p384r1
		do
			create curve.make_sec_p384r1
			create g.make_sec_p384r1
			n := sec_p384r1_r
			h := sec_p384r1_h
		end

	make_sec_p521r1
		do
			create curve.make_sec_p521r1
			create g.make_sec_p521r1
			n := sec_p521r1_r
			h := sec_p521r1_h
		end

	make_p192
		do
			create curve.make_p192
			create g.make_p192
			n := p192_r
			h := p192_h
		end

	make_p224
		do
			create curve.make_p224
			create g.make_p224
			n := p224_r
			h := p224_h
		end

	make_p256
		do
			create curve.make_p256
			create g.make_p256
			n := p256_r
			h := p256_h
		end

	make_p384
		do
			create curve.make_p384
			create g.make_p384
			n := p384_r
			h := p384_h
		end

	make_p521
		do
			create curve.make_p521
			create g.make_p521
			n := p521_r
			h := p521_h
		end

feature
	curve: EC_CURVE_FP
	g: EC_POINT_FP

end
