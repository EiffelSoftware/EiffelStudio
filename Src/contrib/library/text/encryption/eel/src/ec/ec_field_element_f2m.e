note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The power to tax is the power to destroy. - John Marshall"

class
	EC_FIELD_ELEMENT_F2M

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

	F2M_REPRESENTATIONS
		undefine
			is_equal,
			copy
		end

	INTEGER_X_FACILITIES
		undefine
			is_equal,
			copy
		end

	LIMB_MANIPULATION
		undefine
			is_equal,
			copy
		end

	SPECIAL_UTILITY
		undefine
			is_equal,
			copy
		end

create
	make

convert
	make ({INTEGER_X})

feature {NONE}

	make (x_a: INTEGER_X)
		require
			non_negative_x: not x_a.is_negative
		do
			x := x_a
		end

feature -- Field element components

	multZModF (a: INTEGER_X; m_limb_position: INTEGER m_bit_position: INTEGER k1_limb_position: INTEGER k1_bit_position: INTEGER)
		require
			a.is_positive
		local
			special: SPECIAL [NATURAL_32]
			limb: NATURAL_32
		do
			a.bit_shift_left (1)
			special := a.item
			limb := special [m_limb_position]
			if
				limb.bit_test (m_bit_position)
			then
				special [m_limb_position] := limb.set_bit (False, m_bit_position)
				special [0] := special [0].bit_xor (1)
				special [k1_limb_position] := special [k1_limb_position].bit_xor ((1).to_natural_32 |<< k1_bit_position)
			end
		ensure
			a.is_positive
		end


	multZModF_p (a: INTEGER_X; m_limb_position: INTEGER m_bit_position: INTEGER k1_limb_position: INTEGER k1_bit_position: INTEGER k2_limb_position: INTEGER k2_bit_position: INTEGER k3_limb_position: INTEGER k3_bit_position: INTEGER)
		require
			a.is_positive
		local
			special: SPECIAL [NATURAL_32]
			limb: NATURAL_32
		do
			a.bit_shift_left (1)
			special := a.item
			limb := special [m_limb_position]
			if
				limb.bit_test (m_bit_position)
			then
				special [m_limb_position] := limb.set_bit (False, m_bit_position)
				special [0] := special [0].bit_xor (1)
				special [k1_limb_position] := special [k1_limb_position].bit_xor ((1).to_natural_32 |<< k1_bit_position)
				special [k2_limb_position] := special [k2_limb_position].bit_xor ((1).to_natural_32 |<< k2_bit_position)
				special [k3_limb_position] := special [k3_limb_position].bit_xor ((1).to_natural_32 |<< k3_bit_position)
			end
		ensure
			a.is_positive
		end

feature

	encoded_field_size (curve: EC_CURVE_F2M): INTEGER_32
			--
		obsolete
			"Needs implementation"
		do

		end

feature -- Implementing features of ECFIELDELEMENT

	plus_value (other: like Current; curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (other, curve)
		end

	plus (other: like Current; curve: EC_CURVE_F2M)
		do
			x.bit_xor (other.x)
		end

	minus_value (other: like Current; curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (other, curve)
		end

	minus (other: like Current; curve: EC_CURVE_F2M)
		do
			plus (other, curve)
		end

	product_value (b: like Current; curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (b, curve)
		end

	product (b: like Current; curve: EC_CURVE_F2M)
		local
			m: INTEGER
			m_bit_position: INTEGER
			m_limb_position: INTEGER
			k1_bit_position: INTEGER
			k1_limb_position: INTEGER
			k2_bit_position: INTEGER
			k2_limb_position: INTEGER
			k3_bit_position: INTEGER
			k3_limb_position: INTEGER
			bz: INTEGER_X
			cz: INTEGER_X
			special: SPECIAL [NATURAL_32]
			limb: NATURAL_32
			limb_position: INTEGER
			bit_position: INTEGER
			new_bit_position: INTEGER
		do
			m := curve.m
			m_limb_position := bit_index_to_limb_index (m)
			m_bit_position := m \\ limb_bits
			k1_limb_position := bit_index_to_limb_index (curve.k1)
			k1_bit_position := curve.k1 \\ limb_bits
			k2_limb_position := bit_index_to_limb_index (curve.k2)
			k2_bit_position := curve.k2 \\ limb_bits
			k3_limb_position := bit_index_to_limb_index (curve.k3)
			k3_bit_position := curve.k3 \\ limb_bits
			create bz.make_bits (m + m)
			bz.copy (b.x)
			limb_position := 0
			bit_position := 0
			special := x.item
			x.resize (bits_to_limbs (m))
			limb := special [limb_position]
			create cz.make_bits (m + m)
			from
				bit_position := 0
			until
				limb_position * limb_bits + bit_position >= m
			loop
				if
					limb.bit_test (bit_position)
				then
					cz.bit_xor (bz)
				end
				new_bit_position := (bit_position + 1) \\ limb_bits
				if new_bit_position < bit_position then
					limb_position := limb_position + 1
					limb := special [limb_position]
				end
				bit_position := new_bit_position
				if curve.representation = PPB then
					multZmodF_p (bz, m_limb_position, m_bit_position, k1_limb_position, k1_bit_position, k2_limb_position, k2_bit_position, k3_limb_position, k3_bit_position)
				else
					multZmodF (bz, m_limb_position, m_bit_position, k1_limb_position, k1_bit_position)
				end
			end
			x := cz
		end

	quotient_value (other: like Current; curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (other, curve)
		end

	quotient (other: like Current; curve: EC_CURVE_F2M)
		local
			bInv: like Current
		do
			bInv := other.inverse_value (curve)
			product (bInv, curve)
		end

	opposite_value (curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (curve)
		end

	opposite (curve: EC_CURVE_F2M)
		do
			do_nothing
		end

	square_value (curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (curve)
		end

	square (curve: EC_CURVE_F2M)
		local
			i: INTEGER_32
			limb_position: INTEGER
			bit_position: INTEGER
			new_bit_position: INTEGER
			square_limb_position: INTEGER
			square_bit_position: INTEGER
			limb: NATURAL_32
			square_limb: NATURAL_32
			special: SPECIAL [NATURAL_32]
		do
			from
				i := curve.m
				x.resize (bits_to_limbs (i + i))
				special := x.item
				limb_position := bit_index_to_limb_index (i)
				bit_position := i \\ limb_bits
				square_limb_position := bit_index_to_limb_index (i + i)
				square_bit_position := (i + i) \\ limb_bits
				limb := special [limb_position]
				square_limb := special [square_limb_position]
			invariant
				i = limb_position * limb_bits + bit_position
			until
				i < 0
			loop
				if
					limb.bit_test (bit_position)
				then
--					x.set_bit (True, i + i)
					square_limb := square_limb.set_bit (True, square_bit_position)
				else
--					x.set_bit (False, i + i)
					square_limb := square_limb.set_bit (False, square_bit_position)
				end
--				x.set_bit (False, i + i + 1)
				square_limb := square_limb.set_bit (False, square_bit_position + 1)
				new_bit_position := bit_position - 1
				if new_bit_position < 0 and limb_position > 0 then
					new_bit_position := new_bit_position + limb_bits
					limb_position := limb_position - 1
					limb := special [limb_position]
				end
				bit_position := new_bit_position
				new_bit_position := square_bit_position - 2
				if new_bit_position < 0 and square_limb_position > 0 then
					new_bit_position := new_bit_position + limb_bits
					special [square_limb_position] := square_limb
					square_limb_position := square_limb_position - 1
					square_limb := special [square_limb_position]
				end
				square_bit_position := new_bit_position
				i := i - 1
			variant
				i + 3
			end
			if square_bit_position /= limb_bits - 2 then
				special [square_limb_position] := square_limb
			else
				do_nothing
			end
			reduce (x, curve)
			x.count := x.normalize (special, 0, bits_to_limbs (curve.m))
		end

	reduce (in: INTEGER_X; curve: EC_CURVE_F2M)
		local
			m: INTEGER
			i: INTEGER
			k1: INTEGER
			k1_limb_position: INTEGER
			k1_limb_diff: NATURAL_32
			k1_bit_position: INTEGER
			k2: INTEGER
			k2_limb_position: INTEGER
			k2_limb_diff: NATURAL_32
			k2_bit_position: INTEGER
			k3: INTEGER
			k3_limb_position: INTEGER
			k3_limb_diff: NATURAL_32
			k3_bit_position: INTEGER
			low_limb_position: INTEGER
			low_limb_diff: NATURAL_32
			low_bit_position: INTEGER
			special: SPECIAL [NATURAL_32]
			limb: NATURAL_32
			limb_diff: NATURAL_32
			limb_position: INTEGER
			bit_position: INTEGER
			new_bit_position: INTEGER
		do
			m := curve.m
			k1 := curve.k1
			k2 := curve.k2
			k3 := curve.k3
			special := in.item
			from
				i := m + m - 1
				limb_position := bit_index_to_limb_index (i)
				low_limb_position := bit_index_to_limb_index (i - m)
				k1_limb_position := bit_index_to_limb_index (k1 + i - m)
				bit_position := i \\ limb_bits
				low_bit_position := (i - m) \\ limb_bits
				k1_bit_position := (k1 + i - m) \\ limb_bits
				if curve.representation = PPB then
					k2_limb_position := bit_index_to_limb_index (k2 + i - m)
					k3_limb_position := bit_index_to_limb_index (k3 + i - m)
					k2_bit_position := (k2 + i - m) \\ limb_bits
					k3_bit_position := (k3 + i - m) \\ limb_bits
				end
				limb := special [limb_position]
			invariant
				i = limb_position * limb_bits + bit_position
			until
				i < m
			loop
				if
					limb.bit_test (bit_position)
				then
					limb_diff := limb_diff.set_bit (True, bit_position)
					low_limb_diff := low_limb_diff.set_bit (True, low_bit_position)
					k1_limb_diff := k1_limb_diff.set_bit (True, k1_bit_position)
					if
						curve.representation = PPB
					then
						k2_limb_diff := k2_limb_diff.set_bit (True, k2_bit_position)
						k3_limb_diff := k3_limb_diff.set_bit (True, k3_bit_position)
					end
				end
				new_bit_position := bit_position - 1
				if new_bit_position < 0 then
					new_bit_position := new_bit_position + limb_bits
					special [limb_position] := special [limb_position].bit_xor (limb_diff)
					limb_position := limb_position - 1
					limb := special [limb_position]
					limb_diff := 0
				end
				bit_position := new_bit_position
				new_bit_position := low_bit_position - 1
				if new_bit_position < 0 then
					new_bit_position := new_bit_position + limb_bits
					special [low_limb_position] := special [low_limb_position].bit_xor (low_limb_diff)
					low_limb_position := low_limb_position - 1
					low_limb_diff := 0
				end
				low_bit_position := new_bit_position
				new_bit_position := k1_bit_position - 1
				if new_bit_position < 0 then
					new_bit_position := new_bit_position + limb_bits
					special [k1_limb_position] := special [k1_limb_position].bit_xor (k1_limb_diff)
					k1_limb_position := k1_limb_position - 1
					k1_limb_diff := 0
				end
				k1_bit_position := new_bit_position
				if curve.representation = PPB then
					new_bit_position := k2_bit_position - 1
					if new_bit_position < 0 then
						new_bit_position := new_bit_position + limb_bits
						special [k2_limb_position] := special [k2_limb_position].bit_xor (k2_limb_diff)
						k2_limb_position := k2_limb_position - 1
						k2_limb_diff := 0
					end
					k2_bit_position := new_bit_position
					new_bit_position := k3_bit_position - 1
					if new_bit_position < 0 then
						new_bit_position := new_bit_position + limb_bits
						special [k3_limb_position] := special [k3_limb_position].bit_xor (k3_limb_diff)
						k3_limb_position := k3_limb_position - 1
						k3_limb_diff := 0
					end
					k3_bit_position := new_bit_position
				end
				i := i - 1
			end
			if bit_position /= limb_bits - 1 then
				special [limb_position] := special [limb_position].bit_xor (limb_diff)
			end
			if low_bit_position /= limb_bits - 1 then
				special [low_limb_position] := special [low_limb_position].bit_xor (low_limb_diff)
			end
			if k1_bit_position /= limb_bits - 1 then
				special [k1_limb_position] := special [k1_limb_position].bit_xor (k1_limb_diff)
			end
			if curve.representation = PPB then
				if k2_bit_position /= limb_bits - 1 then
					special [k2_limb_position] := special [k2_limb_position].bit_xor (k2_limb_diff)
				end
				if k3_bit_position /= limb_bits - 1 then
					special [k3_limb_position] := special [k3_limb_position].bit_xor (k3_limb_diff)
				end
			end
			in.count := in.normalize (special, 0, in.count)
		end

	inverse_value (curve: EC_CURVE_F2M): EC_FIELD_ELEMENT_F2M
		do
			Result := Precursor (curve)
		end

	inverse (curve: EC_CURVE_F2M)
		local
			uz: INTEGER_X
			vz: INTEGER_X
--			g1z: INTEGER_X
--			g2z: INTEGER_X
--			j: INTEGER_32
--			tmp_int: INTEGER_X
			m: INTEGER
--			uz_bits: INTEGER
--			vz_bits: INTEGER
--			tmp_int2: INTEGER
--			uz_old: INTEGER_X
--			gz_old: INTEGER_X
		do
			m := curve.m
			create uz.make_bits (m + m)
			uz.copy (x)
			create vz.make_bits (m + m)
			vz.set_bit (True, m)
			vz.set_bit (True, 0)
			vz.set_bit (True, curve.k1)
			if
				curve.representation = PPB
			then
				vz.set_bit (True, curve.k2)
				vz.set_bit (True, curve.k3)
			end
			vz.count := normalize (vz.item, 0, bits_to_limbs (m))

			x.invert_gf (vz)
--			create g1z.make_bits (m + m)
--			g1z.set_from_integer (1)
--			create g2z.make_bits (m + m)
--			from
--			until
--				uz.is_zero
--			loop
--				uz_bits := uz.bits
--				vz_bits := vz.bits
--				if
--					uz_bits < vz_bits
--				then
--					tmp_int := uz
--					uz := vz
--					vz := tmp_int
--					tmp_int := g1z
--					g1z := g2z
--					g2z := tmp_int
--					tmp_int2 := uz_bits
--					uz_bits := vz_bits
--					vz_bits := tmp_int2
--				end
--				if uz_bits /= vz_bits then
--					j := uz_bits - vz_bits
----					vz.bit_shift_left (j)
----					uz_old := uz.bit_xor_value (vz)
----					vz.bit_shift_right (j)
----					g2z.bit_shift_left (j)
----					gz_old := g1z.bit_xor_value (g2z)
----					g2z.bit_shift_right (j)
--					uz.bit_xor_left_shift (vz, j)
--					g1z.bit_xor_left_shift (g2z, j)
--				else
--					uz.bit_xor (vz)
--					g1z.bit_xor (g2z)
--				end
--			end
--			x := g2z
		end

	sqrt (curve: EC_CURVE_F2M): like Current
			-- Not implemented
		do
			create Result.make (create {INTEGER_X}.default_create)
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := x ~ other.x
		end

end
