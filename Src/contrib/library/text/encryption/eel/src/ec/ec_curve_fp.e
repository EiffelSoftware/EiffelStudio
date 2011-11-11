note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Every decent man is ashamed of the government he lives under. - H.L. Mencken"

class
	EC_CURVE_FP

inherit
	EC_CONSTANTS
		undefine
			is_equal
		end
	EC_CURVE
		redefine
			is_equal,
			a,
			b
		end
	STANDARD_CURVES
		undefine
			is_equal
		end

create
	make_q_a_b,
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

create {EC_FIELD_ELEMENT_FP}
	make_zero

feature {EC_FIELD_ELEMENT_FP}
	make_zero
		do
			create q.default_create
			create a.make_zero
			create b.make_zero
		end

feature
	make_q_a_b (q_new: INTEGER_X a_a: INTEGER_X b_a: INTEGER_X)
			-- Create an EC over FP from q, a, and b
		do
			q := q_new
			create a.make_p_x (a_a)
			create b.make_p_x (b_a)
		end

feature -- SEC curves
	make_sec_p112r1
		do
			q := sec_p112r1_p
			create a.make_p_x (sec_p112r1_a)
			create b.make_p_x (sec_p112r1_b)
		end

	make_sec_p112r2
		do
			q := sec_p112r2_p
			create a.make_p_x (sec_p112r2_a)
			create b.make_p_x (sec_p112r2_b)
		end

	make_sec_p128r1
		do
			q := sec_p128r1_p
			create a.make_p_x (sec_p128r1_a)
			create b.make_p_x (sec_p128r1_b)
		end

	make_sec_p128r2
		do
			q := sec_p128r2_p
			create a.make_p_x (sec_p128r2_a)
			create b.make_p_x (sec_p128r2_b)
		end

	make_sec_p160k1
		do
			q := sec_p160k1_p
			create a.make_p_x (sec_p160k1_a)
			create b.make_p_x (sec_p160k1_b)
		end

	make_sec_p160r1
		do
			q := sec_p160r1_p
			create a.make_p_x (sec_p160r1_a)
			create b.make_p_x (sec_p160r1_b)
		end

	make_sec_p160r2
		do
			q := sec_p160r2_p
			create a.make_p_x (sec_p160r2_a)
			create b.make_p_x (sec_p160r2_b)
		end

	make_sec_p192k1
		do
			q := sec_p192k1_p
			create a.make_p_x (sec_p192k1_a)
			create b.make_p_x (sec_p192k1_b)
		end

	make_sec_p192r1
		do
			q := sec_p192r1_p
			create a.make_p_x (sec_p192r1_a)
			create b.make_p_x (sec_p192r1_b)
		end

	make_sec_p224k1
		do
			q := sec_p224k1_p
			create a.make_p_x (sec_p224k1_a)
			create b.make_p_x (sec_p224k1_b)
		end

	make_sec_p224r1
		do
			q := sec_p224r1_p
			create a.make_p_x (sec_p224r1_a)
			create b.make_p_x (sec_p224r1_b)
		end

	make_sec_p256k1
		do
			q := sec_p256k1_p
			create a.make_p_x (sec_p256k1_a)
			create b.make_p_x (sec_p256k1_b)
		end

	make_sec_p256r1
		do
			q := sec_p256r1_p
			create a.make_p_x (sec_p256r1_a)
			create b.make_p_x (sec_p256r1_b)
		end

	make_sec_p384r1
		do
			q := sec_p384r1_p
			create a.make_p_x (sec_p384r1_a)
			create b.make_p_x (sec_p384r1_b)
		end

	make_sec_p521r1
		do
			q := sec_p521r1_p
			create a.make_p_x (sec_p521r1_a)
			create b.make_p_x (sec_p521r1_b)
		end

feature
	make_p192
		do
			q := p192_p
			create a.make_p_x (p192_a)
			create b.make_p_x (p192_b)
		end

	make_p224
		do
			q := p224_p
			create a.make_p_x (p224_a)
			create b.make_p_x (p224_b)
		end

	make_p256
		do
			q := p256_p
			create a.make_p_x (p256_a)
			create b.make_p_x (p256_b)
		end

	make_p384
		do
			q := p384_p
			create a.make_p_x (p384_a)
			create b.make_p_x (p384_b)
		end

	make_p521
		do
			q := p521_p
			create a.make_p_x (p521_a)
			create b.make_p_x (p521_b)
		end

feature
	q: INTEGER_X
	a: EC_FIELD_ELEMENT_FP
		attribute
			create result.make_zero
		end
	b: EC_FIELD_ELEMENT_FP
		attribute
			create result.make_zero
		end

	is_equal (other: like current): BOOLEAN
			-- Is current equal to other
		do
			result := q ~ other.q and a.x ~ other.a.x and b.x ~ other.b.x
		ensure then
			q /~ other.q implies not result
		end
end
