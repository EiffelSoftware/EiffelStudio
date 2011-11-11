note
	description: "Summary description for {LIMB_MANIPULATION}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIMB_MANIPULATION

inherit
	LIMB_BIT_SCANNING
	LIMB_DEFINITION

feature

	limb_low_bit: INTEGER = 0
			-- Index of the low bit of a limb

	limb_max: NATURAL_32 = 0xffffffff
			-- Maximum value of limb type

	integer_to_limb (integer: INTEGER): NATURAL_32
		require
			integer >= 0
		do
			Result := integer.to_natural_32
		end

	boolean_to_integer (boolean: BOOLEAN): INTEGER
		do
			Result := boolean.to_integer
		ensure
			boolean implies Result = 1
			not boolean implies Result = 0
		end

	boolean_to_limb (boolean: BOOLEAN): NATURAL_32
		do
			Result := boolean_to_integer (boolean).to_natural_32
		ensure
			boolean implies Result = 1
			not boolean implies Result = 0
		end

	extract_limb (count: INTEGER; xh: NATURAL_32; xl: NATURAL_32): NATURAL_32
		require
			count < limb_bits
			count >= 0
		do
			if count = 0 then
				Result := xh
			else
				Result := (xh |<< count).bit_or (xl |>> (limb_bits - count))
			end
		end

	write_limb (limb_a: NATURAL_32; target: SPECIAL [NATURAL_8]; target_offset: INTEGER)
		do
			target [target_offset] := limb_a.to_natural_8
			target [target_offset + 1] := (limb_a |>> 8).to_natural_8
			target [target_offset + 2] := (limb_a |>> 16).to_natural_8
			target [target_offset + 3] := (limb_a |>> 24).to_natural_8
		end

	write_limb_be (limb_a: NATURAL_32; target: SPECIAL [NATURAL_8]; target_offset: INTEGER)
		do
			target [target_offset] := (limb_a |>> 24).to_natural_8
			target [target_offset + 1] := (limb_a |>> 16).to_natural_8
			target [target_offset + 2] := (limb_a |>> 8).to_natural_8
			target [target_offset + 3] := limb_a.to_natural_8
		end

	read_limb (source: SPECIAL [NATURAL_8]; source_offset: INTEGER): NATURAL_32
		do
			Result := source [source_offset + 3].to_natural_32 |<< 24
			Result := Result.bit_or (source [source_offset + 2].to_natural_32 |<< 16)
			Result := Result.bit_or (source [source_offset + 1].to_natural_32 |<< 8)
			Result := Result.bit_or (source [source_offset].to_natural_32)
		end

	read_limb_be (source: SPECIAL [NATURAL_8]; source_offset: INTEGER): NATURAL_32
		do
			Result := source [source_offset].to_natural_32 |<< 24
			Result := Result.bit_or (source [source_offset + 1].to_natural_32 |<< 16)
			Result := Result.bit_or (source [source_offset + 2].to_natural_32 |<< 8)
			Result := Result.bit_or (source [source_offset + 3].to_natural_32)
		end

	udiv_qrnnd (q: TUPLE [q: NATURAL_32]; r: TUPLE [r: NATURAL_32]; n1: NATURAL_32; n0: NATURAL_32; d: NATURAL_32)
		require
			d /= 0
			n1 < d
		local
			d1: NATURAL_32
			d0: NATURAL_32
			q1: NATURAL_32
			q0: NATURAL_32
			r1: NATURAL_32
			r0: NATURAL_32
			m: NATURAL_32
		do
			d1 := d.bit_shift_right (16)
			d0 := d.bit_and (0xffff)
			q1 := n1 // d1
			r1 := n1 - q1 * d1
			m := q1 * d0
			r1 := (r1 * 0x10000).bit_or (n0.bit_shift_right (16))
			if r1 < m then
				q1 := q1 - 1
				r1 := r1 + d
				if r1 >= d then
					if r1 < m then
						q1 := q1 - 1
						r1 := r1 + d
					end
				end
			end
			r1 := r1 - m
			q0 := r1 // d1
			r0 := r1 - q0 * d1
			m := q0 * d0
			r0 := (r0 * 0x10000).bit_or (n0.bit_and (0xffff))
			if r0 < m then
				q0 := q0 - 1
				r0 := r0 + d
				if r0 >= d then
					if r0 < m then
						q0 := q0 - 1
						r0 := r0 + d
					end
				end
			end
			r0 := r0 - m
			q.q := (q1 * 0x10000).bit_or (q0)
			r.r := r0
		end

	limb_inverse (limb_a: NATURAL_32): NATURAL_32
		local
			q: TUPLE [q: NATURAL_32]
			r: TUPLE [r: NATURAL_32]
		do
			create q
			create r
			udiv_qrnnd (q, r, limb_a.bit_not, limb_max, limb_a)
			Result := q.q
		end

	modlimb_invert (limb_a: NATURAL_32): NATURAL_32
		require
			limb_a.bit_test (0)
		do
			Result := modlimb_invert_table ((limb_a // 2).bit_and (0x7f).to_natural_8).to_natural_32
			Result := 2 * Result - Result * Result * limb_a
			Result := 2 * Result - Result * Result * limb_a
		end

	modlimb_invert_table (in: NATURAL_8): NATURAL_8
		require
			in >= 0
			in <= 0x7f
		do
			inspect in
			when 0 then
				Result := 0x01
			when 1 then
				Result := 0xab
			when 2 then
				Result := 0xcd
			when 3 then
				Result := 0xb7
			when 4 then
				Result := 0x39
			when 5 then
				Result := 0xa3
			when 6 then
				Result := 0xc5
			when 7 then
				Result := 0xef
			when 8 then
				Result := 0xf1
			when 9 then
				Result := 0x1b
			when 10 then
				Result := 0x3d
			when 11 then
				Result := 0xa7
			when 12 then
				Result := 0x29
			when 13 then
				Result := 0x13
			when 14 then
				Result := 0x35
			when 15 then
				Result := 0xdf
			when 16 then
				Result := 0xe1
			when 17 then
				Result := 0x8b
			when 18 then
				Result := 0xad
			when 19 then
				Result := 0x97
			when 20 then
				Result := 0x19
			when 21 then
				Result := 0x83
			when 22 then
				Result := 0xa5
			when 23 then
				Result := 0xcf
			when 24 then
				Result := 0xd1
			when 25 then
				Result := 0xfb
			when 26 then
				Result := 0x1d
			when 27 then
				Result := 0x87
			when 28 then
				Result := 0x09
			when 29 then
				Result := 0xf4
			when 30 then
				Result := 0x15
			when 31 then
				Result := 0xbf
			when 32 then
				Result := 0xc1
			when 33 then
				Result := 0x6b
			when 34 then
				Result := 0x8d
			when 35 then
				Result := 0x77
			when 36 then
				Result := 0xf9
			when 37 then
				Result := 0x63
			when 38 then
				Result := 0x85
			when 39 then
				Result := 0xaf
			when 40 then
				Result := 0xb1
			when 41 then
				Result := 0xdb
			when 42 then
				Result := 0xfd
			when 43 then
				Result := 0x67
			when 44 then
				Result := 0xe9
			when 45 then
				Result := 0xd3
			when 46 then
				Result := 0xf5
			when 47 then
				Result := 0x9f
			when 48 then
				Result := 0xa1
			when 49 then
				Result := 0x4b
			when 50 then
				Result := 0x6d
			when 51 then
				Result := 0x57
			when 52 then
				Result := 0xd9
			when 53 then
				Result := 0x43
			when 54 then
				Result := 0x65
			when 55 then
				Result := 0x8f
			when 56 then
				Result := 0x91
			when 57 then
				Result := 0xbb
			when 58 then
				Result := 0xdd
			when 59 then
				Result := 0x47
			when 60 then
				Result := 0xc9
			when 61 then
				Result := 0xb3
			when 62 then
				Result := 0xd5
			when 63 then
				Result := 0x7f
			when 64 then
				Result := 0x81
			when 65 then
				Result := 0x2b
			when 66 then
				Result := 0x4d
			when 67 then
				Result := 0x37
			when 68 then
				Result := 0xb9
			when 69 then
				Result := 0x23
			when 70 then
				Result := 0x45
			when 71 then
				Result := 0x6f
			when 72 then
				Result := 0x71
			when 73 then
				Result := 0x9b
			when 74 then
				Result := 0xbd
			when 75 then
				Result := 0x27
			when 76 then
				Result := 0xa9
			when 77 then
				Result := 0x93
			when 78 then
				Result := 0xb5
			when 79 then
				Result := 0x5f
			when 80 then
				Result := 0x61
			when 81 then
				Result := 0x0b
			when 82 then
				Result := 0x2d
			when 83 then
				Result := 0x17
			when 84 then
				Result := 0x99
			when 85 then
				Result := 0x03
			when 86 then
				Result := 0x25
			when 87 then
				Result := 0x4f
			when 88 then
				Result := 0x51
			when 89 then
				Result := 0x7b
			when 90 then
				Result := 0x9d
			when 91 then
				Result := 0x07
			when 92 then
				Result := 0x89
			when 93 then
				Result := 0x73
			when 94 then
				Result := 0x95
			when 95 then
				Result := 0x3f
			when 96 then
				Result := 0x41
			when 97 then
				Result := 0xeb
			when 98 then
				Result := 0x0d
			when 99 then
				Result := 0xf7
			when 100 then
				Result := 0x79
			when 101 then
				Result := 0xe3
			when 102 then
				Result := 0x05
			when 103 then
				Result := 0x2f
			when 104 then
				Result := 0x31
			when 105 then
				Result := 0x5b
			when 106 then
				Result := 0x7d
			when 107 then
				Result := 0xe7
			when 108 then
				Result := 0x69
			when 109 then
				Result := 0x53
			when 110 then
				Result := 0x75
			when 111 then
				Result := 0x1f
			when 112 then
				Result := 0x21
			when 113 then
				Result := 0xcb
			when 114 then
				Result := 0xed
			when 115 then
				Result := 0xd7
			when 116 then
				Result := 0x59
			when 117 then
				Result := 0xc3
			when 118 then
				Result := 0xe5
			when 119 then
				Result := 0x0f
			when 120 then
				Result := 0x11
			when 121 then
				Result := 0x3b
			when 122 then
				Result := 0x5d
			when 123 then
				Result := 0xc7
			when 124 then
				Result := 0x49
			when 125 then
				Result := 0x33
			when 126 then
				Result := 0x55
			when 127 then
				Result := 0xff
			end
		end

	bit_index_to_limb_index (bit_a: INTEGER): INTEGER
		do
			Result := bit_a // limb_bits
		end

	umul_ppmm (xh: CELL [NATURAL_32]; xl: CELL [NATURAL_32]; m0: NATURAL_32; m1: NATURAL_32)
		local
			t: NATURAL_64
		do
			t := limb_multiply (m0, m1)
			xl.put (t.to_natural_32)
			xh.put (t.bit_shift_right (limb_bits).to_natural_32)
		end

	bits_to_limbs (n: INTEGER): INTEGER
		do
			Result := (n + limb_bits - 1) // limb_bits
		end

	bits_top_limb (n: INTEGER): INTEGER
			-- How many bits of the top limb would be occupied with n bits total
		do
			Result := (n + limb_bits - 1) \\ limb_bits
		end

	pow2_p (in: NATURAL_32): BOOLEAN
		do
			Result := in.bit_and (in - 1) = 0
		end

	limb_multiply (one: NATURAL_32 two: NATURAL_32): NATURAL_64
			-- Return the lossless multiplication of `one' and `two'
		do
			Result := one.to_natural_64 * two.to_natural_64
		end
end
