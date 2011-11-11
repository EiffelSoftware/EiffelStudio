note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Liberty lies in the hearts of men and women. When it dies there, no constitution, no law, no court can save it. - Justice Learned Hand"

class
	EC_FIELD_ELEMENT_FP

inherit
	EC_FIELD_ELEMENT
		redefine
			is_equal,
			plus_value,
			minus_value,
			product_value,
			quotient_value,
			opposite_value,
			square_value,
			inverse_value
		end

create
	make_p_x,
	make_q_x_hex

create {EC_POINT, EC_CURVE_FP}
	make_zero

feature {EC_POINT_FP, EC_CURVE_FP}
	make_zero
		do
			create x.default_create
		end

feature
	make_p_x (x_new: INTEGER_X)
			-- create a new ECFIELDELEMENTFP based on q and x
		do
			x := x_new
		end

	make_q_x_hex(curve_a: EC_CURVE_FP x_hex_a: STRING)
		do
			make_p_x (create {INTEGER_X}.make_from_hex_string (x_hex_a))
		end

feature {EC_FIELD_ELEMENT_FP}

	W (n: INTEGER_X r: INTEGER_X x_new: INTEGER_X p_a: INTEGER_X): INTEGER_X
			-- I'm not sure what this does
		local
			w_one: INTEGER_X
			w_two: INTEGER_X
		do
			if
				n ~ (ONE)
			then
				result := ((r * r * x_new.powm_value ((p_a - TWO), p_a)) - TWO) \\ p_a
			elseif
				not n.bit_test(0)
			then
				w_one := W (n / TWO, r, x, p_a)
				result := ((w_one * w_one) - TWO) \\ p_a
			else
				w_one := W ((n + ONE) / TWO, r, x, p_a)
				w_two := W ((n - ONE) / TWO, r, x, p_a)
				result := ((w_one * w_two) - W (ONE, r, x, p_a)) \\ p_a
			end
		end

feature
	encoded_field_size (curve: EC_CURVE_FP): INTEGER_32
			-- Return the encoded field size for FP field elements
		local
			p: INTEGER_X
		do
			p := curve.q
			result := p.bytes
		end

	plus_value (other: like Current; curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (other, curve)
		end

	plus (other: like Current; curve: EC_CURVE_FP)
		do
			x.plus (other.x)
			x.modulo (curve.q)
		end

	minus_value (other: like Current; curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (other, curve)
		end

	minus (other: like Current; curve: EC_CURVE_FP)
		do
			x.minus (other.x)
			x.modulo (curve.q)
		end

	product_value (other: like Current; curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (other, curve)
		end

	product (other: like Current; curve: EC_CURVE_FP)
		do
			x.product (other.x)
			x.modulo (curve.q)
		end

	quotient_value (other: like Current; curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (other, curve)
		end

	quotient (other: like Current; curve: EC_CURVE_FP)
		local
			p: INTEGER_X
		do
			p := curve.q
			x.product (other.x.inverse_value (p))
			x.modulo (p)
		end

	opposite_value (curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (curve)
		end

	opposite (curve: EC_CURVE_FP)
		do
			x.opposite
			x.modulo (curve.q)
		end

	square_value (curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (curve)
		end

	square (curve: EC_CURVE_FP)
		do
			x.product (x)
			x.modulo (curve.q)
		end

	inverse_value (curve: EC_CURVE_FP): EC_FIELD_ELEMENT_FP
		do
			Result := Precursor (curve)
		end

	inverse (curve: EC_CURVE_FP)
		do
			x.inverse (curve.q)
		end

	sqrt (curve: EC_CURVE_FP): like Current
			-- Implement sqrt over FP
		local
			z: EC_FIELD_ELEMENT_FP
			legendreExponent: INTEGER_X
			fourX: INTEGER_X
			r: INTEGER_X
			n1: INTEGER_X
			n2: INTEGER_X
			root: INTEGER_X
			exponent: INTEGER_X
			p: INTEGER_X
		do
			p := curve.q
			if
				p.bit_test (1)
			then
				create z.make_p_x (x.powm_value (p.bit_shift_right_value (2) + one, p))
				Result := z
			elseif
				p.bit_test (0)
			then
				legendreExponent := (p - ONE) / TWO
				exponent := x.powm_value (legendreExponent, p)
				check exponent ~ one end
				fourX := FOUR * x
				r := TWO
				from
				until
					not ((r * r - fourx).powm_value (legendreExponent, p) ~ (p - ONE))
				loop
					--Is this correct?  There's a slightly higher chance that the
					-- number is in the range 0 - q than q - 2^q.bits
					create r.make_random (p.bits)
					r := r \\ p
				end
				n1 := (p - ONE) / FOUR
				n2 := (p + THREE) / FOUR
				root := (x * (TWO * r).powm_value (p - TWO, p) * (W (n1, r, x, p) + W (n2, r, x, p))) \\ p
				create z.make_p_x (root)
				Result := z
			else
				create Result.make_p_x (create {INTEGER_X}.default_create)
				(create {EXCEPTION}.default_create).raise
			end
		end

	is_equal (other: like current): BOOLEAN
			-- Is this FP = other
		do
			result := x ~ other.x
		end
end
