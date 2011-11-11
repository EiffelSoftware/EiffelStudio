note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Those who expect to reap the benefits of freedom, must, like men, undergo the fatigue of supporting it. - Thomas Paine"

class
	EC_POINT_FP

inherit
	EC_POINT
		redefine
			x,
			y,
			copy,
			opposite_value,
			product_value,
			twice_value,
			minus_value,
			plus_value
		end
	EC_CONSTANTS
		undefine
			is_equal,
			copy
		end
	STANDARD_CURVES
		undefine
			is_equal,
			copy
		end

create
	make_curve_x_y,
	make_from_bytes,
	make_infinity,
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
	make_infinity
		do
			set_infinity
		end

feature -- SEC curves
	make_sec_p112r1
		do
			create x.make_p_x (sec_p112r1_gx)
			create y.make_p_x (sec_p112r1_gy)
		end

	make_sec_p112r2
		do
			create x.make_p_x (sec_p112r2_gx)
			create y.make_p_x (sec_p112r2_gy)
		end

	make_sec_p128r1
		do
			create x.make_p_x (sec_p128r1_gx)
			create y.make_p_x (sec_p128r1_gy)
		end

	make_sec_p128r2
		do
			create x.make_p_x (sec_p128r2_gx)
			create y.make_p_x (sec_p128r2_gy)
		end

	make_sec_p160k1
		do
			create x.make_p_x (sec_p160k1_gx)
			create y.make_p_x (sec_p160k1_gy)
		end

	make_sec_p160r1
		do
			create x.make_p_x (sec_p160r1_gx)
			create y.make_p_x (sec_p160r1_gy)
		end

	make_sec_p160r2
		do
			create x.make_p_x (sec_p160r2_gx)
			create y.make_p_x (sec_p160r2_gy)
		end

	make_sec_p192k1
		do
			create x.make_p_x (sec_p192k1_gx)
			create y.make_p_x (sec_p192k1_gy)
		end

	make_sec_p192r1
		do
			create x.make_p_x (sec_p192r1_gx)
			create y.make_p_x (sec_p192r1_gy)
		end

	make_sec_p224k1
		do
			create x.make_p_x (sec_p224k1_gx)
			create y.make_p_x (sec_p224k1_gy)
		end

	make_sec_p224r1
		do
			create x.make_p_x (sec_p224r1_gx)
			create y.make_p_x (sec_p224r1_gy)
		end

	make_sec_p256k1
		do
			create x.make_p_x (sec_p256k1_gx)
			create y.make_p_x (sec_p256k1_gy)
		end

	make_sec_p256r1
		do
			create x.make_p_x (sec_p256r1_gx)
			create y.make_p_x (sec_p256r1_gy)
		end

	make_sec_p384r1
		do
			create x.make_p_x (sec_p384r1_gx)
			create y.make_p_x (sec_p384r1_gy)
		end

	make_sec_p521r1
		do
			create x.make_p_x (sec_p521r1_gx)
			create y.make_p_x (sec_p521r1_gy)
		end

feature
	make_p192
		do
			create x.make_p_x (p192_gx)
			create y.make_p_x (p192_gy)
		end

	make_p224
		do
			create x.make_p_x (p224_gx)
			create y.make_p_x (p224_gy)
		end

	make_p256
		do
			create x.make_p_x (p256_gx)
			create y.make_p_x (p256_gy)
		end

	make_p384
		do
			create x.make_p_x (p384_gx)
			create y.make_p_x (p384_gy)
		end

	make_p521
		do
			create x.make_p_x (p521_gx)
			create y.make_p_x (p521_gy)
		end

	make_curve_x_y (x_a: EC_FIELD_ELEMENT_FP; y_a: EC_FIELD_ELEMENT_FP)
		do
			x := x_a
			y := y_a
		end

	make_from_bytes (encoded: SPECIAL [NATURAL_8] curve: EC_CURVE_FP)
			-- Decode a point on this curve from its ASN.1 encoding
			-- encodings are taken account of, including point compression for
			-- <code>F<sub>p</sub><code> (X9.62 s 4.2.1 pg 17).
			-- @return The decoded point.
	require
		first_byte_indicator: encoded [0] = 0x02 or encoded [0] = 0x3 or encoded [0] = 0x4
	do
		inspect
			encoded [0]
		when 0x02 then
			decodeCompressedPoint (encoded, 0, curve)
		when 0x03 then
			decodeCompressedPoint (encoded, 1, curve)
		when 0x04 then
			decodeUncompressedPoint (encoded)
		end
	end

feature
	x: EC_FIELD_ELEMENT_FP
	y: EC_FIELD_ELEMENT_FP

	copy (other: like Current)
		do
			x.copy (other.x)
			y.copy (other.y)
		end

feature

	set_infinity
		do
			create x.make_p_x (create {INTEGER_X}.default_create)
			create y.make_p_x (create {INTEGER_X}.default_create)
			infinity := True
		end

	to_byte_array_compressed (curve: EC_CURVE_FP): SPECIAL [NATURAL_8]
			-- Return a compressed encoded version of this point
		local
			x_array: SPECIAL [NATURAL_8]
		do
			x_array := x.x.as_fixed_width_byte_array (x.encoded_field_size (curve))
			create result.make_filled (0, x_array.count + 1)
			result.copy_data (x_array, 0, 1, x_array.count)
			result [0] := compressed_PC_byte (y.x)
		end

	to_byte_array_uncompressed (curve: EC_CURVE_FP): SPECIAL [NATURAL_8]
			-- Return an uncompressed encoded version of this point
		local
			x_array: SPECIAL [NATURAL_8]
			y_array: SPECIAL [NATURAL_8]
			p0: SPECIAL [NATURAL_8]
			qLength: INTEGER_32
		do
			qLength := x.encoded_field_size (curve)
			x_array := x.x.as_fixed_width_byte_array (qlength)
			y_array := y.x.as_fixed_width_byte_array (qLength)
			check
				x_array.capacity = qlength
				y_array.capacity = qlength
			end
			create p0.make_filled (0, x_array.capacity + y_array.capacity + 1)
			p0.copy_data (x_array, 0, x_array.upper, 1)
			p0.copy_data (y_array, 0, y_array.upper, x_array.capacity + 1)
			p0.put (0x04, 0)
			result := p0
		end

	plus_value (other: like Current; curve: EC_CURVE_FP): EC_POINT_FP
		do
			Result := Precursor (other, curve)
		end

	plus (other: like Current; curve: EC_CURVE_FP)
			-- Addition over FP
		local
			gamma: EC_FIELD_ELEMENT_FP
			x3: EC_FIELD_ELEMENT_FP
			y3: EC_FIELD_ELEMENT_FP
		do
			if
				infinity
			then
				copy (other)
			elseif
				other.infinity
			then
			elseif
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
				gamma := (other.y.minus_value (y, curve)).quotient_value (other.x.minus_value (x, curve), curve)
				x3 := (gamma.product_value (gamma, curve)).minus_value (x, curve).minus_value (other.x, curve)
				y3 := (gamma.product_value (x.minus_value (x3, curve), curve)).minus_value (y, curve)
				x := x3
				y := y3
			end
		end

	twice_value (curve: EC_CURVE_FP): EC_POINT_FP
		do
			Result := Precursor (curve)
		end

	twice (curve: EC_CURVE_FP)
			-- Return current * current over FP
		local
			two_element: EC_FIELD_ELEMENT_FP
			three_element: EC_FIELD_ELEMENT_FP
			gamma: EC_FIELD_ELEMENT_FP
			x3: EC_FIELD_ELEMENT_FP
			y3: EC_FIELD_ELEMENT_FP
		do
			if
				infinity
			then
			elseif
				y.x.is_zero
			then
				set_infinity
			else
				create two_element.make_p_x (two)
				create three_element.make_p_x (three)
				gamma := (((x.product_value (x, curve)).product_value (three_element, curve)).plus_value (curve.a, curve)).quotient_value (y.product_value (two_element, curve), curve)
				x3 := (gamma.product_value (gamma, curve)).minus_value (x.product_value (two_element, curve), curve)
				y3 := (gamma.product_value (x.minus_value (x3, curve), curve)).minus_value (y, curve)
				x := x3
				y := y3
			end
		end

	minus_value (other: like Current; curve: EC_CURVE_FP): EC_POINT_FP
		do
			Result := Precursor (other, curve)
		end

	minus (other: like Current; curve: EC_CURVE_FP)
		do
			if
				other.infinity
			then
			else
				plus (other.opposite_value (curve), curve)
			end
		end

	product_value (other: INTEGER_X; curve: EC_CURVE_FP): EC_POINT_FP
		do
			Result := Precursor (other, curve)
		end

	product (other: INTEGER_X; curve: EC_CURVE_FP)
			-- return current * k over FP
		local
			e: INTEGER_X
			h: INTEGER_X
			R: like Current
			i: INTEGER_32
		do
			if
				infinity
			then
			elseif
				other.is_zero
			then
				set_infinity
			else
				e := other
				h := e * three
				R := deep_twin
				from
					i := (h.bits - 2)
				until
					i <= 0
				loop
					R := r.twice_value (curve)
					if
						h.bit_test (i) and not e.bit_test (i)
					then
						r := r.plus_value (Current, curve)
					elseif
						not h.bit_test (i) and e.bit_test (i)
					then
						r := r.minus_value (Current, curve)
					end
					i := i - 1
				end
				copy (r)
			end
		end

	opposite_value (curve: EC_CURVE_FP): like Current
		do
			Result := Precursor (curve)
		end

	opposite (curve: EC_CURVE_FP)
		do
			y.opposite (curve)
		end

feature {NONE} -- support features
	ytilde_set (source: INTEGER_X): BOOLEAN
			-- Test the least significant bit, this is ytilde
			-- X9.62 4.2.1
		do
			result := source.bit_test (0)
		end

	compressed_PC_byte (source: INTEGER_X): NATURAL_8
			-- Return the PC byte depending on if ytilde is set
			-- X9.62 4.3.6
		do
			if
				ytilde_set (source)
			then
				result := 0x03
			else
				result := 0x02
			end
		end

feature {NONE}
	decodeCompressedPoint (encoded: SPECIAL [NATURAL_8] ytilde: INTEGER curve: EC_CURVE_FP)
			-- Decode a compressed point
		require
			encoded.lower = 0
		local
			i: SPECIAL [NATURAL_8]
			x_new: EC_FIELD_ELEMENT_FP
			alpha: EC_FIELD_ELEMENT_FP
			beta: EC_FIELD_ELEMENT_FP
			x_int: INTEGER_X
			bit0: INTEGER
			q_minus_beta: EC_FIELD_ELEMENT_FP
		do
			create i.make_filled (0, encoded.count - 1)
			i.copy_data (encoded, 1, 0, i.count)
			create x_int.make_from_bytes (i, i.lower, i.upper)
			create x_new.make_p_x (x_int)
			alpha := (x_new.product_value (x_new.square_value (curve).plus_value (curve.a, curve), curve)).plus_value (curve.b, curve)
			beta := alpha.sqrt (curve)
			if
				beta.x.bit_test (0)
			then
				bit0 := 1
			else
				bit0 := 0
			end
			if
				bit0 = ytilde
			then
				make_curve_x_y (x_new, beta)
			else
				create q_minus_beta.make_p_x (curve.q - beta.x)
				make_curve_x_y (x_new, q_minus_beta)
			end
		end

	decodeUncompressedPoint (encoded: SPECIAL [NATURAL_8])
			-- Decode an uncompressed point
		require
			encoded_not_split_even: (encoded.count \\ 2) = 1
		local
			xEnc: SPECIAL [NATURAL_8]
			yEnc: SPECIAL [NATURAL_8]
			x_new: EC_FIELD_ELEMENT_FP
			y_new: EC_FIELD_ELEMENT_FP
		do
			create xEnc.make_filled (0, (encoded.capacity - 1) // 2)
			create yEnc.make_filled (0, (encoded.capacity - 1) // 2)
			encoded.copy_data (xEnc, 1, 0, xEnc.capacity)
			encoded.copy_data (yEnc, xEnc.capacity, 0, yEnc.capacity)
			create x_new.make_p_x (create {INTEGER_X}.make_from_bytes (xEnc, xEnc.lower, xEnc.upper))
			create y_new.make_p_x (create {INTEGER_X}.make_from_bytes (yEnc, yEnc.lower, yEnc.upper))
			x := x_new
			y := y_new
		end
end
