note
	description: "Summary description for {NUMBER_LOGIC}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "It is a free market that makes monopolies impossible. -  Ayn Rand"

deferred class
	SPECIAL_LOGIC

inherit
	LIMB_MANIPULATION

feature

	com_n (target: SPECIAL [NATURAL_32]; target_offset_a: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER; op1_count_a: INTEGER)
		require
			op1_count_a >= 1
		local
			target_offset: INTEGER
			op1_offset: INTEGER
			op1_count: INTEGER
		do
			target_offset := target_offset_a
			op1_offset := op1_offset_a
			op1_count := op1_count_a
			from
			until
				op1_count = 0
			loop
				target [target_offset] := op1 [op1_offset].bit_not
				target_offset := target_offset + 1
				op1_offset := op1_offset + 1
				op1_count := op1_count - 1
			end
		end

	hamdist (op1: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER; op2: SPECIAL [NATURAL_32]; op2_offset_a: INTEGER; n_a: INTEGER): INTEGER
		local
			p0: NATURAL_32
			p1: NATURAL_32
			p2: NATURAL_32
			p3: NATURAL_32
			x: NATURAL_32
			p01: NATURAL_32
			p23: NATURAL_32
			i: INTEGER
			op1_offset: INTEGER
			n: INTEGER
			op2_offset: INTEGER
		do
			op2_offset := op2_offset_a
			n := n_a
			op1_offset := op1_offset_a
			from
				i := n |>> 2
			until
				i = 0
			loop
				p0 := op1 [op1_offset].bit_xor (op2 [op2_offset])
				p0 := p0 - (p0 |>> 1).bit_and (limb_max // 3)
				p0 := (p0 |>> 2).bit_and (limb_max // 5) + p0.bit_and (limb_max // 5)

				p1 := op1 [op1_offset + 1].bit_xor (op2 [op2_offset + 1])
				p1 := p1 - (p1 |>> 1).bit_and (limb_max // 3)
				p1 := (p1 |>> 2).bit_and (limb_max // 5) + p1.bit_and (limb_max // 5)

				p01 := p0 + p1
				p01 := (p01 |>> 4).bit_and (limb_max // 17) + p01.bit_and (limb_max // 17)

				p2 := op1 [op1_offset + 2].bit_xor (op2 [op2_offset + 2])
				p2 := p2 - (p2 |>> 1).bit_and (limb_max // 3)
				p2 := (p2 |>> 2).bit_and (limb_max // 5) + p2.bit_and (limb_max // 5)

				p3 := op1 [op1_offset + 3].bit_xor (op2 [op2_offset + 3])
				p3 := p3 - (p3 |>> 1).bit_and (limb_max // 3)
				p3 := (p3 |>> 2).bit_and (limb_max // 5) + p3.bit_and (limb_max // 5)

				p23 := p2 + p3
				p23 := (p23 |>> 4).bit_and (limb_max // 17) + p23.bit_and (limb_max // 17)

				x := p01 + p23
				x := (x |>> 8) + x
				x := (x |>> 16) + x
				Result := Result + x.bit_and (0xff).to_integer_32
				op1_offset := op1_offset + 4
				op2_offset := op2_offset + 4
				i := i - 1
			end
			n := n.bit_and (3)
			if n /= 0 then
				x := 0
				from
				until
					n = 0
				loop
					p0 := op1 [op1_offset].bit_xor (op2 [op2_offset])
					p0 := p0 - (p0 |>> 1).bit_and (limb_max // 3)
					p0 := (p0 |>> 2).bit_and (limb_max // 5) + p0.bit_and (limb_max // 5)
					p0 := ((p0 |>> 4) | p0).bit_and (limb_max // 17)
					x := x + p0
					op1_offset := op1_offset + 1
					op2_offset := op2_offset + 1
					n := n - 1
				end
				x := (x |>> 8) + x
				x := (x |>> 16) + x
				Result := Result + x.bit_and (0xff).to_integer_32
			end
		end

	lshift (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; n: INTEGER_32; count: INTEGER_32; carry: CELL [NATURAL_32])
		require
			target.valid_index (target_offset)
			target.valid_index (target_offset + n - 1)
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + n - 1)
			count > 0
			count < 32
		local
			high_limb: NATURAL_32
			low_limb: NATURAL_32
			tnc: INTEGER_32
			i: INTEGER_32
			up: INTEGER_32
			rp: INTEGER_32
		do
			up := op1_offset + n
			rp := target_offset + n
			tnc := 32 - count
			up := up - 1
			low_limb := op1 [up]
			carry.put (low_limb |>> tnc)
			high_limb := low_limb |<< count
			from
				i := n - 1
			until
				i = 0
			loop
				up := up - 1
				low_limb := op1 [up]
				rp := rp - 1
				target [rp] := high_limb.bit_or (low_limb |>> tnc)
				high_limb := low_limb |<< count
				i := i - 1
			end
			rp := rp - 1
			target [rp] := high_limb
		end

	rshift (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; n: INTEGER_32; count: INTEGER_32; carry: CELL [NATURAL_32])
		local
			high_limb: NATURAL_32
			low_limb: NATURAL_32
			tnc: INTEGER_32
			i: INTEGER_32
			op1_cursor: INTEGER_32
			target_cursor: INTEGER_32
		do
			tnc := 32 - count
			op1_cursor := op1_offset
			high_limb := op1 [op1_cursor]
			op1_cursor := op1_cursor + 1
			carry.put (high_limb |<< tnc)
			low_limb := high_limb |>> count
			from
				i := n - 1
			until
				i = 0
			loop
				high_limb := op1 [op1_cursor]
				op1_cursor := op1_cursor + 1
				target [target_cursor] := low_limb.bit_or (high_limb |<< tnc)
				target_cursor := target_cursor + 1
				low_limb := high_limb |>> count
				i := i - 1
			end
			target [target_cursor] := low_limb
		end

	popcount (op1: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER; n_a: INTEGER): INTEGER
		local
			p0: NATURAL_32
			p1: NATURAL_32
			p2: NATURAL_32
			p3: NATURAL_32
			x: NATURAL_32
			p01: NATURAL_32
			p23: NATURAL_32
			i: INTEGER
			op1_offset: INTEGER
			n: INTEGER
		do
			n := n_a
			op1_offset := op1_offset_a
			from
				i := n |>> 2
			until
				i = 0
			loop
				p0 := op1 [op1_offset]
				p0 := p0 - (p0 |>> 1).bit_and (limb_max // 3)
				p0 := (p0 |>> 2).bit_and (limb_max // 5) + p0.bit_and (limb_max // 5)

				p1 := op1 [op1_offset + 1]
				p1 := p1 - (p1 |>> 1).bit_and (limb_max // 3)
				p1 := (p1 |>> 2).bit_and (limb_max // 5) + p1.bit_and (limb_max // 5)

				p01 := p0 + p1
				p01 := (p01 |>> 4).bit_and (limb_max // 17) + p01.bit_and (limb_max // 17)

				p2 := op1 [op1_offset + 2]
				p2 := p2 - (p2 |>> 1).bit_and (limb_max // 3)
				p2 := (p2 |>> 2).bit_and (limb_max // 5) + p2.bit_and (limb_max // 5)

				p3 := op1 [op1_offset + 3]
				p3 := p3 - (p3 |>> 1).bit_and (limb_max // 3)
				p3 := (p3 |>> 2).bit_and (limb_max // 5) + p3.bit_and (limb_max // 5)

				p23 := p2 + p3
				p23 := (p23 |>> 4).bit_and (limb_max // 17) + p23.bit_and (limb_max // 17)

				x := p01 + p23
				x := (x |>> 8) + x
				x := (x |>> 16) + x
				Result := Result + x.bit_and (0xff).to_integer_32
				op1_offset := op1_offset + 4
				i := i - 1
			end
			n := n.bit_and (3)
			if n /= 0 then
				x := 0
				from
				until
					n = 0
				loop
					p0 := op1 [op1_offset]
					p0 := p0 - (p0 |>> 1).bit_and (limb_max // 3)
					p0 := (p0 |>> 2).bit_and (limb_max // 5) + p0.bit_and (limb_max // 5)
					p0 := ((p0 |>> 4) | p0).bit_and (limb_max // 17)
					x := x + p0
					op1_offset := op1_offset + 1
					n := n - 1
				end
				x := (x |>> 8) + x
				x := (x |>> 16) + x
				Result := Result + x.bit_and (0xff).to_integer_32
			end
		end

	bit_xor_lshift (target: SPECIAL [NATURAL_32] target_offset: INTEGER op1: SPECIAL [NATURAL_32] op1_offset: INTEGER op1_count: INTEGER op2: SPECIAL [NATURAL_32] op2_offset: INTEGER op2_count: INTEGER op2_lshift: INTEGER)
		require
			op2_lshift >= 0
			op1 /= op2
			target /= op2
			op1_count = 0 or op1.valid_index (op1_offset)
			op1_count = 0 or op1.valid_index (op1_offset + op1_count - 1)
			op2_count = 0 or op2.valid_index (op2_offset)
			op2_count = 0 or op2.valid_index (op2_offset + op2_count - 1)
			(op1_count = 0 and op2_count = 0) or target.valid_index (target_offset)
			(op1_count = 0 and op2_count = 0) or target.valid_index (target_offset + op1_count.max (op2_count + bits_to_limbs (op2_lshift)) - 1)
		local
			op2_limb_high: NATURAL_32
			op2_limb_low: NATURAL_32
			op2_limb: NATURAL_32
			cursor: INTEGER
			shift_limbs: INTEGER
			shift_bits: INTEGER
		do
			shift_limbs := op2_lshift // limb_bits
			shift_bits := op2_lshift \\ limb_bits
			target.copy_data (op1, op1_offset, target_offset, shift_limbs)
			from
			until
				cursor >= op2_count or cursor >= op1_count - shift_limbs
			loop
				op2_limb_low := op2_limb_high
				op2_limb_high := op2 [op2_offset + cursor]
				op2_limb := extract_limb (shift_bits, op2_limb_high, op2_limb_low)
				target [target_offset + shift_limbs + cursor] := op2_limb.bit_xor (op1 [op1_offset + shift_limbs + cursor])
				cursor := cursor + 1
			end
			if cursor >= op2_count then
				op2_limb_low := op2_limb_high
				op2_limb := extract_limb (shift_bits, 0, op2_limb_low)
				if cursor >= op1_count - shift_limbs then
					target [target_offset + shift_limbs + cursor] := op2_limb
				else
					target [target_offset + shift_limbs + cursor] := op2_limb.bit_xor (op1 [op1_offset + shift_limbs + cursor])
					cursor := cursor + 1
					target.copy_data (op1, op1_offset + shift_limbs + cursor, target_offset + shift_limbs + cursor, op1_count - cursor - shift_limbs)
				end
			else
				from
				until
					cursor >= op2_count
				loop
					op2_limb_low := op2_limb_high
					op2_limb_high := op2 [op2_offset + cursor]
					op2_limb := extract_limb (shift_bits, op2_limb_high, op2_limb_low)
					target [target_offset + shift_limbs + cursor] := op2_limb
					cursor := cursor + 1
				end
				op2_limb_low := op2_limb_high
				op2_limb := extract_limb (shift_bits, 0, op2_limb_low)
				target [target_offset + shift_limbs + cursor] := op2_limb
			end
		end

	bit_xor (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER; op2_count: INTEGER)
		require
			(op1_count = 0 and op2_count = 0) or target.valid_index (target_offset)
			(op1_count = 0 and op2_count = 0) or target.valid_index (target_offset + op1_count.max (op2_count) - 1)
		local
			cursor: INTEGER
			min: INTEGER
		do
			from
				min := op1_count.min (op2_count)
			until
				cursor >= min
			loop
				target [target_offset + cursor] := op1 [op1_offset + cursor].bit_xor (op2 [op2_offset + cursor])
				cursor := cursor + 1
			end
			if op1_count > op2_count then
				target.copy_data (op1, op1_offset + cursor, target_offset + cursor, op1_count - cursor)
			elseif op2_count > op1_count then
				target.copy_data (op2, op2_offset + cursor, target_offset + cursor, op2_count - cursor)
			end
		end
end
