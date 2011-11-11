note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "What this country needs are more unemployed politicians. - Edward Langley"

class
	EC_POINT_F2M

inherit
	EC_POINT
		redefine
			x,
			y,
			opposite_value,
			twice_value,
			product_value,
			minus_value,
			plus_value
		end
	EC_CONSTANTS
		undefine
			is_equal
		end
	STANDARD_CURVES
		undefine
			is_equal
		end
	INTEGER_X_FACILITIES
		undefine
			is_equal
		end

create
	make_curve_x_y,
	make_infinity,
	make_from_bytes,
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

feature
	make_infinity
		do
			set_infinity
		end

feature -- SEC points
	make_sec_t113r1
		do
			create x.make (sec_t113r1_gx)
			create y.make (sec_t113r1_gy)
		end

	make_sec_t113r2
		do
			create x.make (sec_t113r2_gx)
			create y.make (sec_t113r2_gy)
		end

	make_sec_t131r1
		do
			create x.make (sec_t131r1_gx)
			create y.make (sec_t131r1_gy)
		end

	make_sec_t131r2
		do
			create x.make (sec_t131r2_gx)
			create y.make (sec_t131r2_gy)
		end

	make_sec_t163k1
		do
			create x.make (sec_t163k1_gx)
			create y.make (sec_t163k1_gy)
		end

	make_sec_t163r1
		do
			create x.make (sec_t163r1_gx)
			create y.make (sec_t163r1_gy)
		end

	make_sec_t163r2
		do
			create x.make (sec_t163r2_gx)
			create y.make (sec_t163r2_gy)
		end

	make_sec_t193r1
		do
			create x.make (sec_t193r1_gx)
			create y.make (sec_t193r1_gy)
		end

	make_sec_t193r2
		do
			create x.make (sec_t193r2_gx)
			create y.make (sec_t193r2_gy)
		end

	make_sec_t233k1
		do
			create x.make (sec_t233k1_gx)
			create y.make (sec_t233k1_gy)
		end

	make_sec_t233r1
		do
			create x.make (sec_t233r1_gx)
			create y.make (sec_t233r1_gy)
		end

	make_sec_t239k1
		do
			create x.make (sec_t239k1_gx)
			create y.make (sec_t239k1_gy)
		end

	make_sec_t283k1
		do
			create x.make (sec_t283k1_gx)
			create y.make (sec_t283k1_gy)
		end

	make_sec_t283r1
		do
			create x.make (sec_t283r1_gx)
			create y.make (sec_t283r1_gy)
		end

	make_sec_t409k1
		do
			create x.make (sec_t409k1_gx)
			create y.make (sec_t409k1_gy)
		end

	make_sec_t409r1
		do
			create x.make (sec_t409r1_gx)
			create y.make (sec_t409r1_gy)
		end

	make_sec_t571k1
		do
			create x.make (sec_t571k1_gx)
			create y.make (sec_t571k1_gy)
		end

	make_sec_t571r1
		do
			create x.make (sec_t571r1_gx)
			create y.make (sec_t571r1_gy)
		end

feature -- FIPS points
	make_k163
		do
			create x.make (k163_gx)
			create y.make (k163_gy)
		end

	make_k233
		do
			create x.make (k233_gx)
			create y.make (k233_gy)
		end

	make_k283
		do
			create x.make (k283_gx)
			create y.make (k283_gy)
		end

	make_k409
		do
			create x.make (k409_gx)
			create y.make (k409_gy)
		end

	make_k571
		do
			create x.make (k571_gx)
			create y.make (k571_gy)
		end

	make_b163
		do
			create x.make (b163_gx)
			create y.make (b163_gy)
		end

	make_b233
		do
			create x.make (b233_gx)
			create y.make (b233_gy)
		end

	make_b283
		do
			create x.make (b283_gx)
			create y.make (b283_gy)
		end

	make_b409
		do
			create x.make (b409_gx)
			create y.make (b409_gy)
		end

	make_b571
		do
			create x.make (b571_gx)
			create y.make (b571_gy)
		end

	make_curve_x_y (x_a: EC_FIELD_ELEMENT_F2M; y_a: EC_FIELD_ELEMENT_F2M)
		do
			x := x_a
			y := y_a
		end

	make_from_bytes (bytes: SPECIAL[NATURAL_8]; curve: EC_CURVE_F2M)
		do
			decodepoint (bytes, curve)
		end

feature

	x: EC_FIELD_ELEMENT_F2M
	y: EC_FIELD_ELEMENT_F2M

	set_from_other (other: like Current)
		do
			x.copy (other.x)
			y.copy (other.y)
		end

feature -- Decode/encode

	set_infinity
		do
			create x.make (create {INTEGER_X}.default_create)
			create y.make (create {INTEGER_X}.default_create)
			infinity := True
		end

	decodePoint (source: SPECIAL [NATURAL_8] curve: EC_CURVE_F2M)
		require
			Source_too_small: source.capacity > 0
		local
			enc: SPECIAL [NATURAL_8]
		do
			create enc.make_filled (0, source.count - 1)
			enc.copy_data (source, 1, 0, enc.count)
			inspect
				source[0]
			when 0x02 then
				decodeCompressedPoint (enc, 0, curve)
			when 0x03 then
				decodeCompressedPoint (enc, 1, curve)
			when 0x04 then
				decodeUncompressedPoint (enc)
			end
		end

	decodeCompressedPoint (source: SPECIAL [NATURAL_8] ypBit: INTEGER curve: EC_CURVE_F2M)
		local
			xp: EC_FIELD_ELEMENT_F2M
			yp: EC_FIELD_ELEMENT_F2M
			i: INTEGER_32
			beta: EC_FIELD_ELEMENT_F2M
			z: EC_FIELD_ELEMENT_F2M
			oneEC: EC_FIELD_ELEMENT_F2M
			zBit: INTEGER
		do
			create xp.make (create {INTEGER_X}.make_from_bytes (source, source.lower, source.upper))
			if
				xp.x.is_zero
			then
				yp := curve.b
				from
					i := 0
				until
					i = curve.m - 1
				loop
					yp := yp.square_value (curve)
					i := i + 1
				end
			else
				beta := xp.plus_value (curve.a, curve).plus_value (curve.b.product_value (xp.square_value (curve).inverse_value (curve), curve), curve)
				--z := solveQuadraticEquation(beta)
				create z.make (create {INTEGER_X}.default_create)
				zBit := 0
				if
					z.x.bit_test (0)
				then
					zBit := 1
				end
				if
					zBit /= ypBit
				then
					create oneEC.make (ONE)
					z := z.plus_value (oneEC, curve)
				end
				yp := xp.product_value (z, curve)
			end
			x := xp
			y := yp
		end

	decodeUncompressedPoint (source: SPECIAL [NATURAL_8])
		require
			X_and_y_different_sizes: source.capacity \\ 2 = 0
		local
			xEnc: SPECIAL [NATURAL_8]
			yEnc: SPECIAL [NATURAL_8]
			x_mpz: INTEGER_X
			y_mpz: INTEGER_X
		do
			create xEnc.make_filled (0, source.count // 2)
			xEnc.copy_data (source, 0, 0, xEnc.count)
			create yEnc.make_filled (0, source.count // 2)
			yEnc.copy_data (source, source.count // 2, 0, yEnc.count)
			check -- Field elements should be same size
				xEnc.capacity = yEnc.capacity
			end
			create x_mpz.make_from_bytes (xEnc, xEnc.lower, xEnc.upper)
			create y_mpz.make_from_bytes (yEnc, yEnc.lower, yEnc.upper)
			create x.make (x_mpz)
			create y.make (y_mpz)
		end

	to_byte_array_uncompressed (curve: EC_CURVE_F2M): SPECIAL [NATURAL_8]
		local
			byteCount: INTEGER_32
			y_array: SPECIAL [NATURAL_8]
			x_array: SPECIAL [NATURAL_8]
			p0: SPECIAL [NATURAL_8]
		do
			bytecount := x.x.bytes
			x_array := x.x.as_bytes
			y_array := y.x.as_fixed_width_byte_array (byteCount)
			create p0.make_filled (0, byteCount + byteCount + 1)
			p0.put (0x04, 0)
			check
				x_array.capacity = y_array.capacity
			end
			p0.copy_data (x_array, 0, x_array.upper, 1)
			p0.copy_data (y_array, 0, y_array.upper, x_array.upper + 1)
			result := p0
		end

	to_byte_array_compressed (curve: EC_CURVE_F2M): SPECIAL [NATURAL_8]
		local
			byteCount: INTEGER_32
			x_array: SPECIAL [NATURAL_8]
			P0: SPECIAL [NATURAL_8]
		do
			x_array := x.x.as_bytes
			byteCount := x.x.bytes
			-- See X9.62 4.3.6 and 4.2.2
			create P0.make_filled (0, byteCount + 1)
			p0.put (0x02, 0)

			-- X9.62 4.2.2 and 4.3.6:
			-- if x = 0 then ypTilde := 0, else ypTilde is the rightmost
			-- bit of y * x^(-1)
			-- if ypTilde = 0, then PC := 02, else PC := 03
			-- Note: PC === PO[0]
			if
				(not (x.x.is_zero)) and ((y.product_value (x.inverse_value (curve), curve)).x.bit_test(0))
			then
				-- ypTilde = 1, hence PC = 03
				p0.put (0x03, 0)
			end
			p0.copy_data (x_array, 0, x_array.upper, 1)
			result := p0
		end

feature -- Implement ECPOINT

	plus_value (other: like Current; curve: EC_CURVE_F2M): EC_POINT_F2M
		do
			Result := Precursor (other, curve)
		end

	plus (other: like Current; curve: EC_CURVE_F2M)
		do
			if
				infinity
			then
				copy (other)
			elseif
				other.infinity
			then

			else
				add_not_infinity (other, curve)
			end
		end

	minus_value (other: like Current; curve: EC_CURVE_F2M): EC_POINT_F2M
		do
			Result := Precursor (other, curve)
		end

	minus (other: like Current; curve: EC_CURVE_F2M)
		do
			if
				other.infinity
			then
			else
				add_minus_b (other, curve)
			end
		end

	product_value (b: INTEGER_X; curve: EC_CURVE_F2M): EC_POINT_F2M
		do
			Result := Precursor (b, curve)
		end

	product (b: INTEGER_X; curve: EC_CURVE_F2M)
		local
			p: like Current
			q: like Current
			t: INTEGER_32
--			i: INTEGER_32
			special: SPECIAL [NATURAL_32]
			limb: NATURAL_32
			limb_position: INTEGER
			new_bit_position: INTEGER
			bit_position: INTEGER
		do
			p := Current
			create q.make_infinity
			t := b.bits
			from
				special := b.item
				limb := special [limb_position]
				limb_position := 0
				bit_position := 0
			until
				limb_position * 32 + bit_position >= t
			loop
				if limb.bit_test (bit_position) then
					q.plus (p, curve)
				end
				p.twice (curve)
				new_bit_position := (bit_position + 1) \\ 32
				if new_bit_position < bit_position then
					limb_position := limb_position + 1
					limb := special [limb_position]
				end
				bit_position := new_bit_position
			end
--			p := Current
--			create q.make_infinity
--			t := b.bits
--			from
--				i := 0
--			until
--				i = t
--			loop
--				if
--					b.bit_test (i)
--				then
--					q.plus (p, curve)
--				end
--				p.twice (curve)
--				i := i + 1
--			end
			copy (q)
		end

	twice_value (curve: EC_CURVE_F2M): EC_POINT_F2M
		do
			Result := Precursor (curve)
		end

	twice (curve: EC_CURVE_F2M)
		do
			if
				infinity
			then
			elseif
				x.x.is_zero
			then
				set_infinity
			else
				twice_not_infinity (curve)
			end
		end

	opposite_value (curve: EC_CURVE_F2M): EC_POINT_F2M
		do
			Result := Precursor (curve)
		end

	opposite (curve: EC_CURVE_F2M)
		do
			y.plus (x, curve)
		end

feature -- Implementation support features

	twice_not_infinity (curve: EC_CURVE_F2M)
		local
			lambda: EC_FIELD_ELEMENT_F2M
			x3: EC_FIELD_ELEMENT_F2M
			y3: EC_FIELD_ELEMENT_F2M
			one_element: EC_FIELD_ELEMENT_F2M
		do
			create one_element.make (one)
			lambda := y.quotient_value (x, curve)
			lambda.plus (x, curve)
			x3 := lambda.square_value (curve)
			x3.plus (lambda, curve)
			x3.plus (curve.a, curve)
			y3 := x.square_value (curve)
			lambda.plus (one_element, curve)
			lambda.product (x3, curve)
			y3.plus (lambda, curve)
			x := x3
			y := y3
		end

	add_minus_b (other: like Current curve: EC_CURVE_F2M)
		local
			minusB: like Current
		do
			create minusB.make_curve_x_y (other.x, other.x.plus_value (other.y, curve))
			plus (minusB, curve)
		end

	add_not_infinity (other: like Current; curve: EC_CURVE_F2M)
		do
			if
				x ~ other.x
			then
				if
					y ~ other.y
				then
					copy (twice_value (curve))
				else
					set_infinity
				end
			else
				add_normal (other, curve)
			end
		end

	add_normal (other: like Current; curve: EC_CURVE_F2M)
		local
			lambda: EC_FIELD_ELEMENT_F2M
			x3: EC_FIELD_ELEMENT_F2M
			y3: EC_FIELD_ELEMENT_F2M
		do
			lambda := (y.plus_value (other.y, curve)).quotient_value (x.plus_value (other.x, curve), curve)
			x3 := lambda.square_value (curve)
			x3 := x3.plus_value (lambda, curve).plus_value (x, curve).plus_value (other.x, curve).plus_value (curve.a, curve)
			y3 := ((lambda.product_value (x.plus_value (x3, curve), curve)).plus_value (x3, curve)).plus_value (y, curve)
			x := x3
			y := y3
		end
end
