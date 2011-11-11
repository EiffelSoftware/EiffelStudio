note
	description: "Summary description for {INTEGER_X_LOGIC}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The politicians don't just want your money. They want your soul. They want you to be worn down by taxes until you are dependent and helpless. -  James Dale Davidson, National Taxpayers Union"

deferred class
	INTEGER_X_LOGIC

inherit
	INTEGER_X_FACILITIES
	SPECIAL_ARITHMETIC
		rename
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	SPECIAL_UTILITY

feature

	bit_and (target: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X)
		local
			op1_ptr: SPECIAL [NATURAL_32]
			op1_ptr_offset: INTEGER
			op2_ptr: SPECIAL [NATURAL_32]
			op2_ptr_offset: INTEGER
			op1_size: INTEGER
			op2_size: INTEGER
			res_ptr: SPECIAL [NATURAL_32]
			res_ptr_offset: INTEGER
			res_size: INTEGER
			i: INTEGER
			junk: NATURAL_32
			done: BOOLEAN
			opx: SPECIAL [NATURAL_32]
			opx_offset: INTEGER
			cy: NATURAL_32
			res_alloc: INTEGER
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			tmp_integer_x: READABLE_INTEGER_X
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			op1_size := op1.count
			op2_size := op2.count
			op1_ptr := op1.item
			op2_ptr := op2.item
			res_ptr := target.item
			if op1_size >= 0 then
				if op2_size >= 0 then
					res_size := op1_size.min (op2_size)
					from
						i := res_size - 1
					until
						i < 0 or else op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i]) /= 0
					loop
						i := i - 1
					end
					res_size := i + 1
					target.resize (res_size)
					res_ptr := target.item
					op1_ptr := op1.item
					op2_ptr := op2.item
					target.count := res_size
					if res_size /= 0 then
						add_n (res_ptr, res_ptr_offset, op1_ptr, op1_ptr_offset, op2_ptr, op2_ptr_offset, res_size, carry)
						junk := carry.item
					end
					done := True
				end
			else
				if op2_size < 0 then
					op1_size := -op1_size
					op2_size := -op2_size
					res_alloc := 1 + op1_size.max (op2_size)
					create opx.make_filled (0, op1_size)
					sub_1 (opx, opx_offset, op1_ptr, op1_ptr_offset, op1_size, 1, carry)
					junk := carry.item
					op1_ptr := opx
					create opx.make_filled (0, op2_size)
					sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, op2_size, 1, carry)
					junk := carry.item
					op2_ptr := opx
					target.resize (res_alloc)
					res_ptr := target.item
					if op1_size >= op2_size then
						res_ptr.copy_data (op1_ptr, op1_ptr_offset + op2_size, res_ptr_offset + op2_size, op1_size - op2_size)
						from
							i := op2_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_or (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						res_size := op1_size
					else
						res_ptr.copy_data (op2_ptr, op2_ptr_offset + op1_size, res_ptr_offset + op1_size, op2_size - op1_size)
						from
							i := op1_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_or (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						res_size := op2_size
					end
					add_1 (res_ptr, res_ptr_offset, res_ptr, res_ptr_offset, res_size, 1, carry)
					cy := carry.item
					if cy /= 0 then
						res_ptr [res_ptr_offset + res_size] := cy
						res_size := res_size + 1
					end
					target.count := -res_size
					done := True
				else
					tmp_integer_x := op1
					op1 := op2
					op2 := tmp_integer_x
					tmp_special := op1_ptr
					op1_ptr := op2_ptr
					op2_ptr := tmp_special
					tmp_integer := op1_ptr_offset
					op1_ptr_offset := op2_ptr_offset
					op2_ptr_offset := tmp_integer
				end
			end
			if not done then
				op2_size := -op2_size
				create opx.make_filled (0, op2_size)
				sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, op2_size, 1, carry)
				junk := carry.item
				op2_ptr := opx
				if op1_size > op2_size then
					res_size := op1_size
					target.resize (res_size)
					res_ptr := target.item
					op1_ptr := op1.item
					res_ptr.copy_data (op1_ptr, op1_ptr_offset + op2_size, res_ptr_offset + op2_size, res_size - op2_size)
					from
						i := op2_size - 1
					until
						i < 0
					loop
						res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i].bit_not)
						i := i - 1
					end
					target.count := res_size
				else
					from
						i := op1_size - 1
					until
						i < 0 or else op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i].bit_not) /= 0
					loop
						i := i - 1
					end
					res_size := i + 1
					target.resize (res_size)
					res_ptr := target.item
					op1_ptr := op1.item
					from
						i := res_size - 1
					until
						i < 0
					loop
						res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i].bit_not)
						i := i - 1
					end
					target.count := res_size
				end
			end
		end

	bit_clear (op: READABLE_INTEGER_X; bit_index: INTEGER_32)
			-- Clear bit `bit_index' in `rop'.
		local
			dsize: INTEGER_32
			dp: SPECIAL [NATURAL_32]
			dp_offset: INTEGER
			limb_index: INTEGER
			dlimb: NATURAL_32
			zero_bound: INTEGER
			i: INTEGER_32
			done: BOOLEAN
		do
			dsize := op.count
			dp := op.item
			limb_index := bit_index // limb_bits
			if dsize >= 0 then
				if limb_index < dsize then
					dlimb := dp [dp_offset + limb_index]
					dlimb := dlimb.bit_and (((1) |<< (bit_index \\ limb_bits)).bit_not.to_natural_32)
					dp [dp_offset + limb_index] := dlimb
					if dlimb = 0 and limb_index = dsize - 1 then
						from
							dsize := dsize - 1
						until
							dsize <= 0 or dp [dp_offset + dsize - 1] /= 0
						loop
							dsize := dsize - 1
						end
						op.count := dsize
					end
				end
			else
				dsize := -dsize
				from
					zero_bound := 0
				until
					dp [dp_offset + zero_bound] /= 0
				loop
					zero_bound := zero_bound + 1
				end
				if limb_index > zero_bound then
					if limb_index < dsize then
						dp [dp_offset + limb_index] := dp [dp_offset + limb_index].bit_or (((1) |<< (bit_index \\ limb_bits)).to_natural_32)
					else
						op.resize (limb_index + 1)
						dp := op.item
						dp.fill_with (0, dp_offset + dsize, dp_offset + dsize + (limb_index - dsize) - 1)
						dp [dp_offset + limb_index] := ((1) |<< (bit_index \\ (limb_bits))).to_natural_32
						op.count := - (limb_index + 1)
					end
				elseif limb_index = zero_bound then
					dp [dp_offset + limb_index] := (dp [dp_offset + limb_index] - 1).bit_or (((1) |<< (bit_index \\ limb_bits)).to_natural_32)
					if dp [dp_offset + limb_index] = 0 then
						from
							i := limb_index + 1
						until
							i >= dsize or done
						loop
							dp [dp_offset + 1] := dp [dp_offset + 1] + 1
							if dp [dp_offset + i] = 0 then
								done := True
							else
								i := i + 1
							end
						end
						if not done then
							dsize := dsize + 1
							op.resize (dsize)
							dp [dp_offset + i] := 1
							op.count := -dsize
						end
					end
				end
			end
		end

	bit_one_complement (target: READABLE_INTEGER_X; op: READABLE_INTEGER_X)
			-- Set `rop' to the one's complement of `op'.
		local
			src: READABLE_INTEGER_X
			size: INTEGER_32
			cy: NATURAL_32
			junk2: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			src := op
			size := src.count
			if size >= 0 then
				target.resize (size + 1)
				if size = 0 then
					target.item [0] := 1
					target.count := -1
				else
					add_1 (target.item, 0, src.item, 0, size, 1, carry)
					cy := carry.item
					if cy /= 0 then
						target.item [size] := cy
						size := size + 1
					end
					target.count := -size
				end
			else
				size := -size
				target.resize (size)
				sub_1 (target.item, 0, src.item, 0, size, 1, carry)
				junk2 := carry.item
				if target.item [size - 1] = 0 then
					size := size - 1
				end
				target.count := size
			end
		end

	bit_complement (d: READABLE_INTEGER_X; bit_index: INTEGER_32)
		local
			dsize: INTEGER
			dp: SPECIAL [NATURAL_32]
			limb_index: INTEGER
			bit_l: NATURAL_32
			x: NATURAL_32
			i: INTEGER
			c: NATURAL_32
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			dsize := d.count.abs
			dp := d.item
			limb_index := bit_index // limb_bits
			bit_l := (1).to_natural_32 |<< (bit_index \\ limb_bits)
			if limb_index >= dsize then
				d.resize (limb_index + 1)
				dp := d.item
				dsize := limb_index + 1
			end
			if d.count >= 0 then
				dp [limb_index] := dp [limb_index].bit_xor (bit_l)
				dsize := normalize (dp, 0, dsize)
				d.count := dsize
			else
				x := 0 - dp [limb_index]
				from
					i := limb_index - 1
				until
					i < 0
				loop
					if dp [i] /= 0 then
						x := x - 1
						i := 0
					end
					i := i - 1
				end
				if x.bit_and (bit_l) /= 0 then
					d.resize (dsize + 1)
					dp := d.item
					add_1 (dp, limb_index, dp, limb_index, dsize - limb_index, bit_l, carry)
					c := carry.item
					dp [dsize] := c
					dsize := dsize + c.to_integer_32
				else
					sub_1 (dp, limb_index, dp, limb_index, dsize + limb_index, bit_l, carry)
					junk := carry.item
					dsize := normalize (dp, 0, dsize)
					d.count := -dsize
				end
			end
		end

	bit_or (res: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X)
		local
			op1_ptr: SPECIAL [NATURAL_32]
			op1_ptr_offset: INTEGER
			op2_ptr: SPECIAL [NATURAL_32]
			op2_ptr_offset: INTEGER
			op1_size: INTEGER
			op2_size: INTEGER
			res_ptr: SPECIAL [NATURAL_32]
			res_ptr_offset: INTEGER
			res_size: INTEGER
			i: INTEGER
			done: BOOLEAN
			opx: SPECIAL [NATURAL_32]
			opx_offset: INTEGER
			cy: NATURAL_32
			junk: NATURAL_32
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			tmp_integer_x: READABLE_INTEGER_X
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			res_alloc: INTEGER
			count: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			op1_size := op1.count
			op2_size := op2.count
			op1_ptr := op1.item
			op2_ptr := op2.item
			res_ptr := res.item
			if op1_size >= 0 then
				if op2_size >= 0 then
					if op1_size >= op2_size then
						res.resize (op1_size)
						op1_ptr := op1.item
						op2_ptr := op2.item
						res_ptr := res.item
						if res_ptr /= op1_ptr then
							res_ptr.copy_data (op1_ptr, op1_ptr_offset + op2_size, res_ptr_offset + op2_size, op1_size - op2_size)
						end
						from
							i := op2_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_or (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						res_size := op1_size
					else
						res.resize (op2_size)
						op1_ptr := op1.item
						op2_ptr := op2.item
						res_ptr := res.item
						if res_ptr /= op2_ptr then
							res_ptr.copy_data (op2_ptr, op2_ptr_offset + op1_size, res_ptr_offset + op1_size, op2_size - op1_size)
						end
						from
							i := op1_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_or (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
					end
					res_size := op2_size
					done := True
				end
			else
				if op2_size < 0 then
					op1_size := -op1_size
					op2_size := -op2_size
					res_size := op1_size.min (op2_size)
					create opx.make_filled (0, res_size)
					sub_1 (opx, opx_offset, op1_ptr, op1_ptr_offset, res_size, 1, carry)
					junk := carry.item
					op1_ptr := opx
					create opx.make_filled (0, res_size)
					sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, res_size, 1, carry)
					junk := carry.item
					op2_ptr := opx
					res.resize (res_size)
					res_ptr := res.item
					from
						i := res_size - 1
					until
						i < 0 or else op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i]) /= 0
					loop
						i := i - 1
					end
					res_size := i + 1
					if res_size /= 0 then
						from
							i := res_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_and (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						add_1 (res_ptr, res_ptr_offset, res_ptr, res_ptr_offset, res_size, 1, carry)
						cy := carry.item
						if cy /= 0 then
							res_ptr [res_ptr_offset + res_size] := cy
							res_size := res_size + 1
						end
					else
						res_ptr [res_ptr_offset] := 1
						res_size := 1
					end
					res.count := -res_size
					done := True
				else
					tmp_integer_x := op1
					op1 := op2
					op2 := tmp_integer_x
					tmp_special := op1_ptr
					op1_ptr := op2_ptr
					op2_ptr := tmp_special
					tmp_integer := op1_ptr_offset
					op1_ptr_offset := op2_ptr_offset
					op2_ptr_offset := tmp_integer
				end
			end
			if not done then
				op2_size := -op2_size
				res_alloc := op2_size
				create opx.make_filled (0, op2_size)
				sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, op2_size, 1, carry)
				junk := carry.item
				op2_ptr := opx
				op2_size := op2_size - (op2_ptr [op2_ptr_offset + op2_size - 1] = 0).to_integer
				res.resize (res_alloc)
				op1_ptr := op1.item
				res_ptr := res.item
				if op1_size >= op2_size then
					from
						i := op2_size - 1
					until
						i < 0 or else op1_ptr [op1_ptr_offset + i].bit_not.bit_and (op2_ptr [op2_ptr_offset + i]) /= 0
					loop
						i := i - 1
					end
					res_size := i + 1
					count := res_size
				else
					res_size := op2_size
					res_ptr.copy_data (op2_ptr, op2_ptr_offset + op1_size, res_ptr_offset + op1_size, op2_size - op1_size)
					count := op1_size
				end
				if res_size /= 0 then
					from
						i := count - 1
					until
						i < 0
					loop
						res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_not.bit_and (op2_ptr [op2_ptr_offset + i])
						i := i - 1
					end
					add_1 (res_ptr, res_ptr_offset, res_ptr, res_ptr_offset, res_size, 1, carry)
					cy := carry.item
					if cy /= 0 then
						res_ptr [res_ptr_offset + res_size] := cy
						res_size := res_size + 1
					else
						res_ptr [res_ptr_offset] := 1
						res_size := 1
					end
					res.count := -res_size
				end
			end
		end

	bit_scan_0 (op: READABLE_INTEGER_X; starting_bit: INTEGER_32): INTEGER
			-- Scan `op', starting from bit `starting_bit', towards more significant bits, until the first 0
			-- bit is found.
			-- Return the index of the found bit.
			-- The least significant bit is number 0.
			-- If the bit at `starting_bit' is already what's sought, then `starting_bit' is returned.
			-- If there's no bit found, then ULONG_MAX is returned.
			-- This will happen past the end of a negative number.
		local
			u_ptr: INTEGER_32
			size: INTEGER_32
			abs_size: INTEGER_32
			u_end: INTEGER_32
			starting_limb: INTEGER_32
			p: INTEGER_32
			limb: NATURAL_32
			cnt: INTEGER_32
			done: BOOLEAN
			q: INTEGER_32
		do
			size := op.count
			abs_size := size.abs
			u_end := abs_size
			starting_limb := starting_bit // (4 |<< 3)
			p := starting_limb
			if starting_limb >= abs_size then
				if size >= 0 then
					Result := starting_bit
				else
					Result := Result.max_value
				end
			else
				limb := op.item [p]
				if size >= 0 then
					limb := limb.bit_or (((1) |<< (starting_bit \\ (4 |<< 3))).to_natural_32)
					from
					until
						limb /= (0).to_natural_32.bit_not or done
					loop
						p := p + 1
						if p = u_end then
							done := true
							Result := (abs_size * 4 |<< 3)
						else
							limb := op.item [p]
						end
					end
					if not done then
						limb := limb.bit_not
					end
				else
					q := p
					from
					until
						q = u_ptr or done
					loop
						q := q - 1
						if op.item [q] /= 0 then
							done := true
						end
					end
					if not done then
						limb := limb - 1
					end
					limb := limb.bit_and (((0).to_natural_32.bit_not |<< (starting_bit \\ (4 |<< 3))))
					if limb = 0 then
						p := p + 1
						if p = u_end then
							Result := Result.max_value
						else
							from
								limb := op.item [p]
							until
								limb /= 0
							loop
								p := p + 1
							end
						end
					end
				end
				cnt := trailing_zeros (op.item [limb.to_integer_32])
				Result := p - u_ptr + cnt
			end
		end

	bit_scan_1 (op1: READABLE_INTEGER_X; starting_bit: INTEGER): INTEGER
		local
			u_ptr: SPECIAL [NATURAL_32]
			u_ptr_offset: INTEGER
			size: INTEGER
			abs_size: INTEGER
			u_end: INTEGER
			starting_limb: INTEGER
			p: INTEGER
			limb: NATURAL_32
			count: INTEGER
			q: INTEGER
			inverted: NATURAL_32
			got_limb: BOOLEAN
		do
			u_ptr := op1.item
			size := op1.count
			abs_size := size.abs
			u_end := u_ptr_offset + abs_size
			starting_limb := starting_bit // limb_bits
			p := u_ptr_offset + starting_limb
			if starting_limb >= abs_size then
				if size >= 0 then
					Result := Result.max_value
				else
					Result := starting_bit
				end
			end
			limb := u_ptr [p]
			if size >= 0 and limb.bit_and (limb.max_value |<< (starting_bit \\ limb_bits)) = 0 and p + 1 = u_end then
				Result := Result.max_value
			else
				if size >= 0 then
					limb := limb.bit_and (limb.max_value |<< (starting_bit \\ limb_bits))
					if limb = 0 then
						p := p + 1
						from
							limb := u_ptr [p]
							p := p + 1
						until
							limb /= 0
						loop
							limb := u_ptr [p]
							p := p + 1
						end
					end
				else
					q := p
					from
						inverted := 0
					until
						q = u_ptr_offset or inverted /= 0
					loop
						q := q - 1
						inverted := u_ptr [q]
					end
					if inverted = 0 then
						if limb = 0 then
							from
								limb := 1
							until
								limb = 0
							loop
								p := p + 1
								limb := u_ptr [p]
							end
							limb := 0 - limb
							got_limb := True
						else
							limb := limb - 1
						end
					end
					if not got_limb then
						limb := limb.bit_or ((1).to_natural_32 |<< (starting_bit \\ limb_bits) - 1)
						from
							limb := 0
							p := p + 1
							if p /= u_end then
								limb := u_ptr [p]
							end
						until
							p = u_end or limb = limb.max_value
						loop
							p := p + 1
							if p /= u_end then
								limb := u_ptr [p]
							end
						end
						if p = u_end then
							Result := abs_size * limb_bits
						else
							limb := limb.bit_not
							count := trailing_zeros (limb)
							Result := (p - u_ptr_offset) * limb_bits + count
						end
					else
						count := trailing_zeros (limb)
						Result := (p - u_ptr_offset) * limb_bits + count
					end
				end
			end
		end

	bit_set (op: READABLE_INTEGER_X; bit_index: INTEGER_32)
			-- Set bit `bit_index' in `rop'.
		local
			dsize: INTEGER_32
			dp: INTEGER_32
			limb_index: INTEGER_32
			dst: INTEGER_32
			n: INTEGER_32
			zero_bound: INTEGER_32
			dlimb: NATURAL_32
			i: INTEGER_32
			done: BOOLEAN
			x: NATURAL_32
			p: INTEGER_32
			last_p: NATURAL_32
		do
			dsize := op.count
			dp := 0
			limb_index := bit_index // limb_bits
			if dsize >= 0 then
				if limb_index < dsize then
					op.item [dp + limb_index] := op.item [dp + limb_index].bit_or ((1).to_natural_32 |<< (bit_index \\ limb_bits))
					op.count := dsize
				else
					op.resize (limb_index + 1)
					if limb_index - dsize /= 0 then
						dst := dp + dsize
						n := limb_index - dsize
						from
							op.item [dst] := 0
							dst := dst + 1
							n := n - 1
						until
							n = 0
						loop
							op.item [dst] := 0
							dst := dst + 1
							n := n - 1
						end
					end
					op.item [dp + limb_index] := ((1) |<< (bit_index \\ limb_bits)).to_natural_32
					op.count := limb_index + 1
				end
			else
				dsize := -dsize
				from
					zero_bound := 0
				until
					op.item [dp + zero_bound] /= 0
				loop
					zero_bound := zero_bound + 1
				end
				if limb_index > zero_bound then
					if limb_index < dsize then
						dlimb := op.item [dp + limb_index]
						dlimb := dlimb.bit_and (((1) |<< (bit_index \\ limb_bits)).bit_not.to_natural_32)
						op.item [dp + limb_index] := dlimb
						if dlimb = 0 and limb_index = dsize - 1 then
							from
								dsize := dsize - 1
							until
								dsize <= 0 or op.item [dp + dsize - 1] /= 0
							loop
								dsize := dsize - 1
							end
							op.count := -dsize
						end
					end
				elseif limb_index = zero_bound then
					op.item [dp + limb_index] := (op.item [dp + limb_index] - 1).bit_and (((1).to_natural_32 |<< (bit_index \\ limb_bits)).bit_not) - 1
					if op.item [dp + limb_index] = 0 then
						from
							i := limb_index + 1
						until
							i >= dsize or done
						loop
							op.item [dp + i] := op.item [dp + i] + 1
							if op.item [dp + i] /= 0 then
								done := true
							else
								i := i + 1
							end
						end
						if not done then
							dsize := dsize + 1
							op.resize (dsize)
							op.item [dp + i] := 1
							op.count := -dsize
						end
					end
				else
					p := dp + limb_index
					x := op.item [p]
					op.item [p] := x - ((1) |<< (bit_index \\ limb_bits)).to_natural_32
					if x < ((1) |<< (bit_index \\ limb_bits)).to_natural_32 then
						from
							p := p + 1
							last_p := op.item [p]
							op.item [p] := last_p - 1
						until
							last_p = 0
						loop
							p := p + 1
							last_p := op.item [p]
							op.item [p] := last_p - 1
						end
					end
					if op.item [dp + dsize - 1] = 0 then
						dsize := dsize - 1
					end
					op.count := -dsize
				end
			end
		end

	bit_test (op: READABLE_INTEGER_X; bit_index: INTEGER): BOOLEAN
		local
			u_ptr: SPECIAL [NATURAL_32]
			size: INTEGER
			abs_size: INTEGER
			limb_index: INTEGER
			p_offset: INTEGER
			limb: NATURAL_32
		do
			u_ptr := op.item
			size := op.count
			abs_size := size.abs
			limb_index := bit_index // limb_bits
			p_offset := 0 + limb_index
			if limb_index >= abs_size then
				Result := size < 0
			else
				limb := u_ptr [p_offset]
				if size < 0 then
					limb := 0 - limb
					from
					until
						p_offset = 0
					loop
						p_offset := p_offset - 1
						if u_ptr [p_offset] /= 0 then
							limb := limb - 1
							p_offset := 0
						end
					end
				end
				Result := limb.bit_test (bit_index \\ limb_bits)
			end
		end

	bit_xor (res: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X op2_a: READABLE_INTEGER_X)
		local
			op1_ptr: SPECIAL [NATURAL_32]
			op1_ptr_offset: INTEGER
			op2_ptr: SPECIAL [NATURAL_32]
			op2_ptr_offset: INTEGER
			op1_size: INTEGER
			op2_size: INTEGER
			res_ptr: SPECIAL [NATURAL_32]
			res_ptr_offset: INTEGER
			res_size: INTEGER
			res_alloc: INTEGER
			i: INTEGER
			opx: SPECIAL [NATURAL_32]
			opx_offset: INTEGER
			junk: NATURAL_32
			done: BOOLEAN
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			tmp_integer_x: READABLE_INTEGER_X
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			cy: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			op1_size := op1.count
			op2_size := op2.count
			op1_ptr := op1.item
			op2_ptr := op2.item
			res_ptr := res.item
			if op1_size >= 0 then
				if op2_size >= 0 then
					res_size := op1_size.max (op2_size)
					res.resize (res_size)
					res_ptr := res.item
					op1_ptr := op1.item
					op2_ptr := op2.item
					bit_xor_special (res_ptr, 0, op1_ptr, 0, op1_size, op2_ptr, 0, op2_size)
					res_size := normalize (res_ptr, res_ptr_offset, res_size)
					res.count := res_size
					done := True
				end
			else
				if op2_size < 0 then
					op1_size := -op1_size
					op2_size := -op2_size
					create opx.make_filled (0, op1_size)
					sub_1 (opx, opx_offset, op1_ptr, op1_ptr_offset, op1_size, 1, carry)
					junk := carry.item
					op1_ptr := opx
					op1_ptr_offset := opx_offset
					create opx.make_filled (0, op2_size)
					sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, op2_size, 1, carry)
					junk := carry.item
					op2_ptr := opx
					op2_ptr_offset := opx_offset
					res_alloc := op1_size.max (op2_size)
					res.resize (res_alloc)
					res_ptr := res.item
					if op1_size > op2_size then
						res_ptr.copy_data (op1_ptr, op1_ptr_offset + op2_size, res_ptr_offset + op2_size, op1_size - op2_size)
						from
							i := op2_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_xor (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						res_size := op1_size
					else
						res_ptr.copy_data (op2_ptr, op2_ptr_offset + op1_size, res_ptr_offset + op1_size, op2_size - op1_size)
						from
							i := op1_size - 1
						until
							i < 0
						loop
							res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_xor (op2_ptr [op2_ptr_offset + i])
							i := i - 1
						end
						res_size := op2_size
					end
					res_size := normalize (res_ptr, res_ptr_offset, res_size)
					res.count := res_size
					done := True
				else
					tmp_integer_x := op1
					op1 := op2
					op2 := tmp_integer_x
					tmp_special := op1_ptr
					op1_ptr := op2_ptr
					op2_ptr := tmp_special
					tmp_integer := op1_ptr_offset
					op1_ptr_offset := op2_ptr_offset
					op2_ptr_offset := tmp_integer
					tmp_integer := op1_size
					op1_size := op2_size
					op2_size := tmp_integer
				end
			end
			if not done then
				op2_size := -op2_size
				create opx.make_filled (0, op2_size)
				sub_1 (opx, opx_offset, op2_ptr, op2_ptr_offset, op2_size, 1, carry)
				junk := carry.item
				op2_ptr := opx
				op2_ptr_offset := opx_offset
				res_alloc := op1_size.max (op2_size) + 1
				res.resize (res_alloc)
				res_ptr := res.item
				if op1_size > op2_size then
					res_ptr.copy_data (op1_ptr, op1_ptr_offset + op2_size, res_ptr_offset + op2_size, op1_size - op2_size)
					from
						i := op2_size - 1
					until
						i < 0
					loop
						res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_xor (op2_ptr [op2_ptr_offset + i])
						i := i - 1
					end
					res_size := op1_size
				else
					res_ptr.copy_data (op2_ptr, op2_ptr_offset + op1_size, res_ptr_offset + op1_size, op2_size - op1_size)
					from
						i := op1_size - 1
					until
						i < 0
					loop
						res_ptr [res_ptr_offset + i] := op1_ptr [op1_ptr_offset + i].bit_xor (op2_ptr [op2_ptr_offset + i])
						i := i - 1
					end
					res_size := op2_size
				end
				add_1 (res_ptr, res_ptr_offset, res_ptr, res_ptr_offset, res_size, 1, carry)
				cy := carry.item
				if cy /= 0 then
					res_ptr [res_ptr_offset + res_size] := cy
					res_size := res_size + 1
				end
				res_size := normalize (res_ptr, res_ptr_offset, res_size)
				res.count := - res_size
			end
		end

	bit_xor_lshift (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X op2_a: READABLE_INTEGER_X left_shift_bits: INTEGER)
			-- Bit XOR `op1' with (`op2' left shifted `left_shift_bits' bits)
		local
			op2: READABLE_INTEGER_X
			target_special: SPECIAL [NATURAL_32]
			op1_special: SPECIAL [NATURAL_32]
			op1_count: INTEGER
			op2_count: INTEGER
			target_count_max: INTEGER
		do
			if target = op2_a or op1 = op2_a then
				op2 := op2_a.identity
			else
				op2 := op2_a
			end
			op1_special := op1.item
			op1_count := op1.count
			op2_count := op2.count
			target_count_max := op1_count + op2_count + bits_to_limbs (left_shift_bits)
			target.resize (target_count_max)
			target_special := target.item
			bit_xor_lshift_special (target_special, 0, op1_special, 0, op1_count, op2.item, 0, op2_count, left_shift_bits)
			target.count := normalize (target_special, 0, target_count_max)
		end
end
