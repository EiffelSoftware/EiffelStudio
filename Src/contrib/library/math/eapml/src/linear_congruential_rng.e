note
	description: "A Linear congruential random number generator"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "To limit the press is to insult a nation; to prohibit reading of certain books is to declare the inhabitants to be either fools or knaves. -  Claude-Adrien Helvetius"

class
	LINEAR_CONGRUENTIAL_RNG

inherit
	RANDOM_NUMBER_GENERATOR
	LIMB_MANIPULATION
	SPECIAL_UTILITY
	SPECIAL_ARITHMETIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special
		export
			{NONE}
				all
		end
	INTEGER_X_DIVISION

create
	make

feature

	make (size: INTEGER)
		require
			size >= 0
			size <= 128
		local
			a: INTEGER_X
			m2exp: INTEGER
			number: STRING_8
		do
			inspect size
			when 0..16 then
				m2exp := 32
				number := "29cf535"
			when 17 then
				m2exp := 34
				number := "A3D73AD"
			when 18 then
				m2exp := 36
				number := "28f825c5"
			when 19 then
				m2exp := 38
				number := "a3dd4cdd"
			when 20 then
				m2exp := 40
				number := "28f5da175"
			when 21..28 then
				m2exp := 56
				number := "AA7D735234C0DD"
			when 29..32 then
				m2exp := 64
				number := "BAECD515DAF0B49D"
			when 33..50 then
				m2exp := 100
				number := "292787EBD3329AD7E7575E2FD"
			when 51..64 then
				m2exp := 128
				number := "48A74F367FA7B5C8ACBB36901308FA85"
			when 65..78 then
				m2exp := 156
				number := "78A7FDDDC43611B527C3F1D760F36E5D7FC7C45"
			when 79..98 then
				m2exp := 196
				number := "41BA2E104EE34C66B3520CE706A56498DE6D44721E5E24F5"
			when 99..100 then
				m2exp := 200
				number := "4E5A24C38B981EAFE84CD9D0BEC48E83911362C114F30072C5"
			when 101..238 then
				m2exp := 256
				number := "AF66BA932AAF58A071FD8F0742A99A0C76982D648509973DB802303128A14CB5"
			end
			create a.make_from_string_base (number, 16)
			randinit_lc_2exp (a, 1, m2exp)
		end

feature

	randinit_lc_2exp (a: READABLE_INTEGER_X; c: NATURAL_32; m2exp: INTEGER)
		local
			seedn: INTEGER
		do
			seedn := bits_to_limbs (m2exp)
			create seed.make (m2exp, a, seedn, c)
		end

	seed: RAND_LC_STRUCT

	randseed (seed_a: READABLE_INTEGER_X)
		local
			seedz: READABLE_INTEGER_X
			seedn: INTEGER
		do
			seedz := seed.seed
			seedn := bits_to_limbs (seed.m2exp)
			fdiv_r_2exp (seedz, seed_a, seed.m2exp)
			seedz.item.fill_with (0, seedz.count, seedz.count - (seedn - seedz.count))
			seedz.count := seedn
		end

	randget (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; nbits: INTEGER)
		local
			rbitpos: INTEGER
			chunk_nbits: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			tn: INTEGER
			r2p: SPECIAL [NATURAL_32]
			r2p_offset: INTEGER
			rcy: NATURAL_32
			junk: INTEGER
			last_nbits: INTEGER
			savelimb: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			chunk_nbits := seed.m2exp // 2
			tn := bits_to_limbs (chunk_nbits)
			create tp.make_filled (0, tn)
			from
				rbitpos := 0
			until
				rbitpos + chunk_nbits > nbits
			loop
				r2p := target
				r2p_offset := target_offset + rbitpos // limb_bits
				if rbitpos \\ limb_bits /= 0 then
					junk := lc (tp, tp_offset)
					savelimb := r2p [r2p_offset]
					lshift (r2p, r2p_offset, tp, tp_offset, tn, rbitpos \\ limb_bits, carry)
					rcy := carry.item
					r2p [r2p_offset] := r2p [r2p_offset].bit_or (savelimb)
					if (chunk_nbits \\ limb_bits + rbitpos \\ limb_bits) > limb_bits then
						r2p [r2p_offset + tn] := rcy
					end
				else
					junk := lc (r2p, r2p_offset)
				end
				rbitpos := rbitpos + chunk_nbits
			end
			if rbitpos /= nbits then
				r2p := target
				r2p_offset := target_offset + rbitpos // limb_bits
				last_nbits := nbits - rbitpos
				tn := bits_to_limbs (last_nbits)
				junk := lc (tp, tp_offset)
				if rbitpos \\ limb_bits /= 0 then
					savelimb := r2p [r2p_offset]
					lshift (r2p, r2p_offset, tp, tp_offset, tn, rbitpos \\ limb_bits, carry)
					rcy := carry.item
					r2p [r2p_offset] := r2p [r2p_offset].bit_or (savelimb)
					if rbitpos + tn * limb_bits - rbitpos \\ limb_bits < nbits then
						r2p [r2p_offset + tn] := rcy
					end
				else
					r2p.copy_data (tp, tp_offset, r2p_offset, tn)
				end
				if nbits \\ limb_bits /= 0 then
					target [target_offset + nbits // limb_bits] := target [target_offset + nbits // limb_bits].bit_and (((0).to_natural_32.bit_not |<< (nbits \\ limb_bits)).bit_not)
				end
			end
		end

	lc (target: SPECIAL [NATURAL_32]; target_offset: INTEGER): INTEGER
		local
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			seedp: SPECIAL [NATURAL_32]
			seedp_offset: INTEGER
			ap: SPECIAL [NATURAL_32]
			ap_offset: INTEGER
			ta: INTEGER
			tn: INTEGER
			seedn: INTEGER
			an: INTEGER
			m2exp: INTEGER
			bits: INTEGER
			cy: INTEGER
			xn: INTEGER
			tmp: INTEGER
			i: INTEGER
			x: NATURAL_32
			limb: NATURAL_32
			count: INTEGER
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			m2exp := seed.m2exp
			seedp := seed.seed.item
			seedn := seed.seed.count
			ap := seed.a.item
			an := seed.a.count
			ta := an + seedn + 1
			tn := bits_to_limbs (m2exp)
			if ta <= tn then
				tmp := an + seedn
				ta := tn + 1
			end
			create tp.make_filled (0, ta)
			mul_special (tp, tp_offset, seedp, seedp_offset, seedn, ap, ap_offset, an, carry)
			junk := carry.item
			i := seed.cn
			if i /= 0 then
				add_n (tp, tp_offset, tp, tp_offset, seed.cp, 0, i, carry)
				if carry.item /= 0 then
					from
						cy := 0
						limb := 1
					until
						cy /= 0 or limb = 0
					loop
						if i >= tn then
							cy := 1
						else
							x := tp [tp_offset + i]
							limb := x + 1
							tp [tp_offset + i] := limb
							i := i + 1
						end
					end
				end
			end
			tp [tp_offset + m2exp // limb_bits] := tp [tp_offset + m2exp // limb_bits].bit_and ((integer_to_limb (1) |<< m2exp \\ integer_to_limb (limb_bits)) - 1)
			seed.seed.item.copy_data (tp, tp_offset, 0, tn)
			bits := m2exp // 2
			xn := bits // limb_bits
			tn := tn - xn
			if tn > 0 then
				count := bits \\ limb_bits
				if count /= 0 then
					rshift (tp, tp_offset, tp, tp_offset + xn, tn, count, carry)
					junk := carry.item
					target.copy_data (tp, tp_offset, target_offset, xn + 1)
				else
					target.copy_data (tp, tp_offset + xn, target_offset, tn)
				end
			end
			Result := (m2exp + 1) // 2
		end
end
