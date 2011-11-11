note
	description: "Summary description for {NUMBER_ARITHMETIC}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Dependence leads to subservience. -  Thomas Jefferson"

deferred class
	SPECIAL_ARITHMETIC

inherit
	LIMB_BIT_SCANNING
	LIMB_MANIPULATION
	SPECIAL_LOGIC

feature

	add (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; op2_count: INTEGER_32; carry: CELL [NATURAL_32])
		require
			op2_count >= 0
			op1_count >= op2_count
			op2_count = 0 or target.valid_index (target_offset)
			op2_count = 0 or target.valid_index (target_offset + op1_count - 1)
			op2_count = 0 or op1.valid_index (op1_offset)
			op2_count = 0 or op1.valid_index (op1_offset + op1_count - 1)
			op2_count = 0 or op2.valid_index (op2_offset)
			op2_count = 0 or op2.valid_index (op2_offset + op2_count - 1)
		local
			i: INTEGER_32
			x: NATURAL_32
			add_carry: NATURAL_32
			j: INTEGER_32
			done: BOOLEAN
		do
			i := op2_count
			add_n (target, target_offset, op1, op1_offset, op2, op2_offset, i, carry)
			add_carry := carry.item
			if add_carry /= 0 then
				from
					x := 0
				until
					done or x /= 0
				loop
					if i >= op1_count then
						carry.put (1)
						done := True
					else
						x := op1 [op1_offset + i]
						x := x + 1
						target [target_offset + i] := x
						i := i + 1
					end
				end
			end
			if not done then
				if target /= op1 then
					from
						j := i
					until
						j >= op1_count
					loop
						target [target_offset + j] := op1 [op1_offset + j]
						j := j + 1
					end
				end
				carry.put (0)
			end
		end

	add_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; size: INTEGER_32; op2: NATURAL_32; carry: CELL [NATURAL_32])
			-- Adds number in SPECIAL `op1' at `op1_offset' of length `size' to the single limb `op2' storing the result in `target' at `target_offset' and carry in `carry'
		local
			i: INTEGER_32
			r: NATURAL_32
		do
			r := op1 [op1_offset] + op2
			target [target_offset] := r
			if r < op2 then
				from
					i := 1
					r := 0
				until
					i >= size or r /= 0
				loop
					r := op1 [op1_offset + i] + 1
					target [target_offset + i] := r
					i := i + 1
				end
				target.copy_data (op1, op1_offset + i, target_offset + i, size - i)
				carry.put ((i = size and r = 0).to_integer.to_natural_32)
			else
				if target /= op1 then
					target.copy_data (op1, op1_offset + 1, target_offset + 1, size - 1)
				end
				carry.put (0)
			end
		ensure
			carry.item = 0 or carry.item = 1
		end

	add_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32; carry: CELL [NATURAL_32])
			-- Add two numbers in SPECIAL `op1' at `op1_offset' and `op2' at `op2_offset' both of length `n' putting result in `target' at `target_offset' and carry in `carry'
		require
			n >= 0
			n = 0 or op1.valid_index (op1_offset)
			n = 0 or op1.valid_index (op1_offset + n - 1)
			n = 0 or op2.valid_index (op2_offset)
			n = 0 or op2.valid_index (op2_offset + n - 1)
			n = 0 or target.valid_index (target_offset)
			n = 0 or target.valid_index (target_offset + n - 1)
		local
			ul: NATURAL_32
			vl: NATURAL_32
			sl: NATURAL_32
			rl: NATURAL_32
			cy1: NATURAL_32
			cy2: NATURAL_32
			cursor: INTEGER_32
			carry_l: NATURAL_32
		do
			from
				cursor := 0
			until
				cursor = n
			loop
				ul := op1 [cursor + op1_offset]
				vl := op2 [cursor + op2_offset]
				sl := ul + vl
				cy1 := (sl < ul).to_integer.to_natural_32
				rl := sl + carry_l
				cy2 := (rl < sl).to_integer.to_natural_32
				carry_l := cy1.bit_or (cy2)
				target [cursor + target_offset] := rl
				cursor := cursor + 1
			variant
				n - cursor + 1
			end
			carry.put (carry_l)
		end

	addmul_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; n: INTEGER_32; vl: NATURAL_32; carry: CELL [NATURAL_32])
		require
			n >= 0
		local
			ul: NATURAL_32
			hpl: CELL [NATURAL_32]
			lpl: CELL [NATURAL_32]
			rl: NATURAL_32
			cursor: INTEGER_32
			carry_l: NATURAL_32
		do
			create hpl.put (0)
			create lpl.put (0)
			from
				cursor := 0
			until
				n - cursor = 0
			loop
				ul := op1 [op1_offset + cursor]
				umul_ppmm (hpl, lpl, ul, vl)
				lpl.put (lpl.item + carry_l)
				carry_l := (lpl.item < carry_l).to_integer.to_natural_32 + hpl.item
				rl := target [target_offset + cursor]
				lpl.put (rl + lpl.item)
				carry_l := carry_l + (lpl.item < rl).to_integer.to_natural_32
				target [target_offset + cursor] := lpl.item
				cursor := cursor + 1
			variant
				n - cursor + 1
			end
			carry.put (carry_l)
		end

	decr_u (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; decr: NATURAL_32)
		local
			x: NATURAL_32
			cursor: INTEGER_32
		do
			cursor := target_offset
			x := target [target_offset]
			target [target_offset] := x - decr
			if x < decr then
				from
					cursor := target_offset + 1
					x := 0
				until
					x /= 0
				loop
					x := target [cursor]
					x := x - 1
					target [cursor] := x
					cursor := cursor + 1
				end
			end
		end

	incr_u (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; incr: NATURAL_32)
		local
			x: NATURAL_32
			cursor: INTEGER_32
		do
			x := target [target_offset] + incr
			target [target_offset] := x
			if x < incr then
				from
					cursor := target_offset + 1
					x := 0
				until
					x /= 0
				loop
					x := target [cursor]
					x := x + 1
					target [cursor] := x
					cursor := cursor + 1
				end
			end
		end

	mul (target: SPECIAL [NATURAL_32]; target_offset_a: INTEGER_32; op1_a: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER_32; op1_count_a: INTEGER_32; op2_a: SPECIAL [NATURAL_32]; op2_offset_a: INTEGER_32; op2_count_a: INTEGER_32; carry: CELL [NATURAL_32])
		require
			target.valid_index (target_offset_a)
			target.valid_index (target_offset_a + op2_count_a - 1)
			op1_a.valid_index (op1_offset_a)
			op1_a.valid_index (op1_offset_a + op2_count_a - 1)
			op1_count_a >= op2_count_a
			op2_count_a >= 1
		local
			l: INTEGER_32
			t: NATURAL_32
			ws: SPECIAL [NATURAL_32]
			op1: SPECIAL [NATURAL_32]
			op2: SPECIAL [NATURAL_32]
			int_temp: INTEGER_32
			special_temp: SPECIAL [NATURAL_32]
			op1_count: INTEGER_32
			op2_count: INTEGER_32
			op1_offset: INTEGER_32
			op2_offset: INTEGER_32
			target_offset: INTEGER_32
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			cy: NATURAL_32
			c: NATURAL_32
		do
			op1 := op1_a
			op2 := op2_a
			op1_count := op1_count_a
			op2_count := op2_count_a
			op1_offset := op1_offset_a
			op2_offset := op2_offset_a
			target_offset := target_offset_a
			if op1_count = op2_count then
				if op1 = op2 and op1_offset = op2_offset then
					sqr_n (target, target_offset, op1, op1_offset, op1_count)
					carry.put (target [target_offset + 2 * op1_count - 1])
				else
					mul_n (target, target_offset, op1, op1_offset, op2, op2_offset, op1_count)
					carry.put (target [target_offset + 2 * op1_count - 1])
				end
			else
				if op2_count < 32 then
					if op1_count <= 500 then
						mul_basecase (target, target_offset, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
					else
						create tp.make_filled (0, 32)
						mul_basecase (target, target_offset, op1, op1_offset, 500, op2, op2_offset, op2_count)
						target_offset := target_offset + 500
						tp.copy_data (target, target_offset, tp_offset, op2_count)
						op1_offset := op1_offset + 500
						op1_count := op1_count - 500
						from
						until
							op1_count <= 500
						loop
							mul_basecase (target, target_offset, op1, op1_offset, 500, op2, op2_offset, op2_count)
							add_n (target, target_offset, target, target_offset, tp, tp_offset, op2_count, carry)
							cy := carry.item
							incr_u (target, target_offset + op2_count, cy)
							target_offset := target_offset + 500
							tp.copy_data (target, target_offset, tp_offset, op2_count)
							op1_offset := op1_offset + 500
							op1_count := op1_count - 500
						end
						if op1_count > op2_count then
							mul_basecase (target, target_offset, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
						else
							mul_basecase (target, target_offset, op2, op2_offset, op2_count, op1, op1_offset, op1_count)
						end
						add_n (target, target_offset, target, target_offset, tp, tp_offset, op2_count, carry)
						cy := carry.item
						incr_u (target, target_offset + op2_count, cy)
					end
					carry.put (target [target_offset + op1_count + op2_count - 1])
				else
					mul_n (target, target_offset, op1, op1_offset, op2, op2_offset, op2_count)
					if op1_count /= op2_count then
						target_offset := target_offset + op2_count
						l := op2_count
						op1_offset := op1_offset + op2_count
						op1_count := op1_count - op2_count
						if op1_count < op2_count then
							special_temp := op1
							op1 := op2
							op2 := special_temp
							int_temp := op1_offset
							op1_offset := op2_offset
							op2_offset := int_temp
							int_temp := op1_count
							op1_count := op2_count
							op2_count := int_temp
						end
						if op2_count >= 32 then
							create ws.make_filled (0, op2_count + op2_count)
						else
							create ws.make_filled (0, op1_count + op2_count)
						end
						from
							t := 0
						until
							op2_count < 32
						loop
							mul_n (ws, 0, op1, op1_offset, op2, op2_offset, op2_count)
							if l <= 2 * op2_count then
								add_n (target, target_offset, target, target_offset, ws, 0, 1, carry)
								t := t + carry.item
								if l /= 2 * op2_count then
									add_1 (target, target_offset + 1, ws, 1, 2 * op2_count - 1, t, carry)
									t := carry.item
									l := 2 * op2_count
								end
							else
								add_n (target, target_offset, target, target_offset, ws, 0, 2 * op2_count, carry)
								c := carry.item
								add_1 (target, target_offset + 2 * op2_count, target, target_offset + 2 * op2_count, 1 - 2 * op2_count, c, carry)
								t := t + carry.item
							end
							target_offset := target_offset + op2_count
							l := l - op2_count
							op1_offset := op1_offset + op2_count
							op1_count := op1_count - op2_count
							if op1_count < op2_count then
								special_temp := op1
								op1 := op2
								op2 := special_temp
								int_temp := op1_count
								op1_count := op2_count
								op2_count := int_temp
								int_temp := op1_offset
								op1_offset := op2_offset
								op2_offset := int_temp
							end
						end
						if op2_count /= 0 then
							mul_basecase (ws, 0, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
							if l <= op1_count + op2_count then
								add_n (target, target_offset, target, target_offset, ws, 0, l, carry)
								t := t + carry.item
								if l /= op1_count + op2_count then
									add_1 (target, target_offset + l, ws, l, op1_count + op2_count - l, t, carry)
									t := carry.item
								else
									add_n (target, target_offset, target, target_offset, ws, 0, op1_count + op2_count, carry)
									c := carry.item
									add_1 (target, target_offset + op1_count + op2_count, target, target_offset + op1_count + op2_count, l - op1_count - op2_count, c, carry)
									t := t + carry.item
								end
							end
						end
					end
					carry.put (target [op1_count + op2_count - 1])
				end
			end
		end

	mul_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; n: INTEGER_32; vl: NATURAL_32; carry: CELL [NATURAL_32])
		require
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + n - 1)
			target.valid_index (target_offset)
			target.valid_index (target_offset + n - 1)
		local
			ul: NATURAL_32
			hpl: CELL [NATURAL_32]
			lpl: CELL [NATURAL_32]
			cursor: INTEGER_32
			carry_l: NATURAL_32
		do
			create hpl.put (0)
			create lpl.put (0)
			from
			until
				n = cursor
			loop
				ul := op1 [op1_offset + cursor]
				umul_ppmm (hpl, lpl, ul, vl)
				lpl.put (lpl.item + carry_l)
				carry_l := (lpl.item < carry_l).to_integer.to_natural_32
				carry_l := carry_l + hpl.item
				target [target_offset + cursor] := lpl.item
				cursor := cursor + 1
			end
			carry.put (carry_l)
		end

	mul_basecase (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; op2_count: INTEGER_32)
		require
			op2_count >= 1
			op1_count >= op2_count
			target.valid_index (target_offset)
			target.valid_index (target_offset + op1_count - 1)
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + op1_count - 1)
		local
			cursor: INTEGER_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			mul_1 (target, target_offset, op1, op1_offset, op1_count, op2 [op2_offset], carry)
			target [target_offset + op1_count] := carry.item
			cursor := 1
			from
			until
				op2_count = cursor
			loop
				addmul_1 (target, target_offset + cursor, op1, op1_offset, op1_count, op2 [op2_offset + cursor], carry)
				target [target_offset + op1_count + cursor] := carry.item
				cursor := cursor + 1
			end
		end

	mul_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32)
		require
			n >= 1
			target.valid_index (target_offset)
			target.valid_index (target_offset + n - 1)
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + n - 1)
		local
			ws: SPECIAL [NATURAL_32]
		do
			if n < 32 then
				mul_basecase (target, target_offset, op1, op1_offset, n, op2, op2_offset, n)
			else
				create ws.make_filled (0, 2 * n + 2 * 32)
				kara_mul_n (target, target_offset, op1, op1_offset, op2, op2_offset, n, ws, 0)
			end
		end

	kara_mul_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; a: SPECIAL [NATURAL_32]; a_offset: INTEGER_32; b: SPECIAL [NATURAL_32]; b_offset: INTEGER_32; n: INTEGER_32; ws: SPECIAL [NATURAL_32]; w_offset: INTEGER_32)
		require
			n >= 2
		local
			w: NATURAL_32
			w0: NATURAL_32
			w1: NATURAL_32
			c: NATURAL_32
			n2: INTEGER_32
			x: INTEGER_32
			y: INTEGER_32
			i: INTEGER_32
			sign: INTEGER_32
			n1: INTEGER_32
			n3: INTEGER_32
			nm1: INTEGER_32
			junk: NATURAL_32
			xlimb: NATURAL_32
			cursor: INTEGER_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n2 := n |>> 1
			if n.bit_and (0x1) /= 0 then
				n3 := n - n2
				sign := 0
				w := a [a_offset + n2]
				if w /= 0 then
					sub_n (target, target_offset, a, a_offset, a, a_offset + n3, n2, carry)
					w := w - carry.item
				else
					i := n2
					from
						w0 := w1
					until
						w0 /= w1 or else i = 0
					loop
						i := i - 1
						w0 := a [a_offset + i]
						w1 := a [a_offset + n3 + i]
					end
					if w0 < w1 then
						x := a_offset + n3
						y := a_offset
						sign := -1
					else
						x := a_offset
						y := a_offset + n3
					end
					sub_n (target, target_offset, a, x, a, y, n2, carry)
					junk := carry.item
				end
				target [target_offset + n2] := w
				w := b [b_offset + n2]
				if w /= 0 then
					sub_n (target, target_offset + n3, b, b_offset, b, b_offset + n3, n2, carry)
					w := w - carry.item
				else
					i := n2
					from
						w0 := w1
					until
						w0 /= w1 or else i = 0
					loop
						i := i - 1
						w0 := b [b_offset + i]
						w1 := b [b_offset + n3 + i]
					end
					if w0 < w1 then
						x := b_offset + n3
						y := b_offset
						sign := sign.bit_not
					else
						x := b_offset
						y := b_offset + n3
					end
					sub_n (target, target_offset + n3, b, x, b, y, n2, carry)
					junk := carry.item
				end
				target [target_offset + n] := w
				n1 := n + 1
				if n2 < 32 then
					if n3 < 32 then
						mul_basecase (ws, w_offset, target, target_offset, n3, target, target_offset + n3, n3)
						mul_basecase (target, target_offset, a, a_offset, n3, b, b_offset, n3)
					else
						kara_mul_n (ws, w_offset, target, target_offset, target, target_offset + n3, n3, ws, w_offset + n1)
						kara_mul_n (target, target_offset, a, a_offset, b, b_offset, n3, ws, w_offset + n1)
					end
					mul_basecase (target, target_offset + n1, a, a_offset + n3, n2, b, b_offset + n3, n2)
				else
					kara_mul_n (ws, w_offset, target, target_offset, target, target_offset + n3, n3, ws, w_offset + n1)
					kara_mul_n (target, target_offset, a, a_offset, b, b_offset, n3, ws, w_offset + n1)
					kara_mul_n (target, target_offset + n1, a, a_offset + n3, b, b_offset + n3, n2, ws, w_offset + n1)
				end
				nm1 := n - 1
				if sign /= 0 then
					add_n (ws, w_offset, target, target_offset, ws, w_offset, n1, carry)
					junk := carry.item
					add_n (ws, w_offset, target, target_offset + n1, ws, w_offset, nm1, carry)
					c := carry.item
					if c /= 0 then
						xlimb := ws [w_offset + nm1] + 1
						ws [w_offset + nm1] := xlimb
						if xlimb = 0 then
							ws [w_offset + n] := ws [w_offset + n] + 1
						end
					end
				else
					sub_n (ws, w_offset, target, target_offset, ws, w_offset, n1, carry)
					junk := carry.item
					add_n (ws, w_offset, target, target_offset + n1, ws, w_offset, nm1, carry)
					c := carry.item
					if c /= 0 then
						xlimb := ws [w_offset + nm1] + 1
						ws [w_offset + nm1] := xlimb
						if xlimb = 0 then
							ws [w_offset + n] := ws [w_offset + n] + 1
						end
					end
				end
				add_n (target, target_offset + n3, target, target_offset + n3, ws, w_offset, n1, carry)
				xlimb := carry.item
				if xlimb /= 0 then
					xlimb := target [target_offset + n1 + n3] + 1
					target [target_offset + n1 + n3] := xlimb
					from
						cursor := 1
					until
						xlimb /= 0
					loop
						xlimb := target [target_offset + n1 + n3 + cursor] + 1
						target [target_offset + n1 + n3 + cursor] := xlimb
						cursor := cursor + 1
					end
				end
			else
				i := n2
				from
					w0 := w1
				until
					w0 /= w1 or i = 0
				loop
					i := i - 1
					w0 := a [a_offset + i]
					w1 := a [a_offset + n2 + i]
				end
				sign := 0
				if w0 < w1 then
					x := a_offset + n2
					y := a_offset
					sign := -1
				else
					x := a_offset
					y := a_offset + n2
				end
				sub_n (target, target_offset, a, x, a, y, n2, carry)
				junk := carry.item
				i := n2
				from
					w0 := w1
				until
					w0 /= w1 or i = 0
				loop
					i := i - 1
					w0 := b [b_offset + i]
					w1 := b [b_offset + n2 + i]
				end
				if w0 < w1 then
					x := b_offset + n2
					y := b_offset
					sign := sign.bit_not
				else
					x := b_offset
					y := b_offset + n2
				end
				sub_n (target, target_offset + n2, b, x, b, y, n2, carry)
				junk := carry.item
				if n2 < 32 then
					mul_basecase (ws, w_offset, target, target_offset, n2, target, target_offset + n2, n2)
					mul_basecase (target, target_offset, a, a_offset, n2, b, b_offset, n2)
					mul_basecase (target, target_offset + n, a, a_offset + n2, n2, b, b_offset + n2, n2)
				else
					kara_mul_n (ws, w_offset, target, target_offset, target, target_offset + n2, n2, ws, w_offset + n)
					kara_mul_n (target, target_offset, a, a_offset, b, b_offset, n2, ws, w_offset + n)
					kara_mul_n (target, target_offset + n, a, a_offset + n2, b, b_offset + n2, n2, ws, w_offset + n)
				end
				if sign /= 0 then
					add_n (ws, w_offset, target, target_offset, ws, w_offset, n, carry)
					w := carry.item
					add_n (ws, w_offset, target, target_offset + n, ws, w_offset, n, carry)
					w := w + carry.item
				else
					sub_n (ws, w_offset, target, target_offset, ws, w_offset, n, carry)
					w := (0).to_natural_32 - carry.item
					add_n (ws, w_offset, target, target_offset + n, ws, w_offset, n, carry)
					w := w + carry.item
				end
				add_n (target, target_offset + n2, target, target_offset + n2, ws, w_offset, n, carry)
				w := w + carry.item
				xlimb := target [target_offset + n2 + n] + w
				target [target_offset + n2 + n] := xlimb
				if xlimb < w then
					from
						xlimb := 0
						cursor := 1
					until
						xlimb /= 0
					loop
						xlimb := target [target_offset + n2 + n + cursor] + 1
						target [target_offset + n2 + n + cursor] := xlimb
						cursor := cursor + 1
					end
				end
			end
		end

	kara_sqr_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER; ws: SPECIAL [NATURAL_32]; ws_offset: INTEGER)
		require
			op1_count >= 2
		local
			w: NATURAL_32
			w0: NATURAL_32
			w1: NATURAL_32
			c: NATURAL_32
			n2: INTEGER
			x: SPECIAL [NATURAL_32]
			x_offset: INTEGER
			y: SPECIAL [NATURAL_32]
			y_offset: INTEGER
			i: INTEGER
			n1: INTEGER
			n3: INTEGER
			nm1: INTEGER
			junk: NATURAL_32
			xlimb: NATURAL
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n2 := op1_count |>> 1
			if op1_count.bit_test (0) then
				n3 := op1_count - n2
				w := op1 [op1_offset + n2]
				if w /= 0 then
					sub_n (target, target_offset, op1, op1_offset, op1, op1_offset + n3, n2, carry)
					w := w - carry.item
				else
					i := n2
					from
						w0 := w1
						check i /= 0 end
					until
						w0 /= w1 or i = 0
					loop
						i := i - 1
						w0 := op1 [op1_offset + i]
						w1 := op1 [op1_offset + n3 + i]
					end
					if w0 < w1 then
						x := op1
						x_offset := op1_offset + n3
						y := op1
						y_offset := op1_offset
					else
						x := op1
						x_offset := op1_offset
						y := op1
						y_offset := op1_offset + n3
					end
					sub_n (target, target_offset, x, x_offset, y, y_offset, n2, carry)
					junk := carry.item
				end
				target [target_offset + n2] := w
				n1 := op1_count + 1
				if n3 < 64 then
					sqr_basecase (ws, ws_offset, target, target_offset, n3)
					sqr_basecase (target, target_offset, op1, op1_offset, n3)
				else
					kara_sqr_n (ws, ws_offset, target, target_offset, n3, ws, ws_offset + n1)
					kara_sqr_n (target, target_offset, op1, op1_offset, n3, ws, ws_offset + n1)
				end
				if n2 < 64 then
					sqr_basecase (target, target_offset + n1, op1, op1_offset + n3, n2)
				else
					kara_sqr_n (target, target_offset + n1, op1, op1_offset + n3, n3, ws, ws_offset + n1)
				end
				nm1 := op1_count - 1
				sub_n (ws, ws_offset, target, target_offset, ws, ws_offset, n1, carry)
				junk := carry.item
				add_n (ws, ws_offset, target, target_offset + n1, ws, ws_offset, nm1, carry)
				c := carry.item
				if c /= 0 then
					xlimb := ws [ws_offset + nm1]
					ws [ws_offset + nm1] := xlimb
					if xlimb = 0 then
						ws [ws_offset + op1_count] := ws [ws_offset + op1_count] + 1
					end
				end
				add_n (target, target_offset + n3, target, target_offset + n3, ws, ws_offset, n1, carry)
				if carry.item /= 0 then
					incr_u (target, target_offset + n1 + n3, 1)
				end
			else
				i := n2
				from
					w0 := w1
					check i /= 0 end
				until
					w0 /= w1 or i = 0
				loop
					i := i - 1
					w0 := op1 [op1_offset + i]
					w1 := op1 [op1_offset + n2 + i]
				end
				if w0 < w1 then
					x := op1
					x_offset := op1_offset + n2
					y := op1
					y_offset := op1_offset
				else
					x := op1
					x_offset := op1_offset
					y := op1
					y_offset := op1_offset + n2
				end
				sub_n (target, target_offset, x, x_offset, y, y_offset, n2, carry)
				junk := carry.item
				if n2 < 64 then
					sqr_basecase (ws, ws_offset, target, target_offset, n2)
					sqr_basecase (target, target_offset, op1, op1_offset, n2)
					sqr_basecase (target, target_offset + op1_count, op1, op1_offset + n2, n2)
				else
					kara_sqr_n (ws, ws_offset, target, target_offset, n2, ws, ws_offset + op1_count)
					kara_sqr_n (target, target_offset, op1, op1_offset, n2, ws, ws_offset + op1_count)
					kara_sqr_n (target, target_offset + op1_count, op1, op1_offset + n2, n2, ws, ws_offset + op1_count)
				end
				sub_n (ws, ws_offset, target, target_offset, ws, ws_offset, op1_count, carry)
				w := 0 - carry.item
				add_n (ws, ws_offset, target, target_offset + op1_count, ws, ws_offset, op1_count, carry)
				w := w + carry.item
				add_n (target, target_offset + n2, target, target_offset + n2, ws, ws_offset, op1_count, carry)
				w := w + carry.item
				incr_u (target, target_offset + n2 + op1_count, w)
			end
		end

	sqr_basecase (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER)
		require
			op1_count >= 1
		local
			i: INTEGER
			ul: NATURAL_32
			lpl: CELL [NATURAL_32]
			temp: CELL [NATURAL_32]
			tarr: SPECIAL [NATURAL_32]
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			cy: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create lpl.put (0)
			create temp.put (0)
			ul := op1 [op1_offset]
			umul_ppmm (temp, lpl, ul, ul)
			target [target_offset + 1] := temp.item
			target [target_offset] := lpl.item
			if op1_count > 1 then
				create tarr.make_filled (0, 128)
				tp := tarr
				mul_1 (tp, tp_offset, op1, op1_offset + 1, op1_count - 1, op1 [op1_offset], carry)
				cy := carry.item
				tp [tp_offset + op1_count - 1] := cy
				from
					i := 2
				until
					i >= op1_count
				loop
					addmul_1 (tp, tp_offset + 2 * i - 2, op1, op1_offset + i, op1_count - i, op1 [op1_offset + i - 1], carry)
					cy := carry.item
					tp [tp_offset + op1_count + i - 2] := cy
					i := i + 1
				end
				sqr_diagonal (target, target_offset + 2, op1, op1_offset + 1, op1_count - 1)
				lshift (tp, tp_offset, tp, tp_offset, 2 * op1_count - 2, 1, carry)
				cy := carry.item
				add_n (target, target_offset + 1, target, target_offset + 1, tp, tp_offset, 2 * op1_count - 2, carry)
				cy := cy + carry.item
				target [target_offset + 2 * op1_count - 1] := target [target_offset + 2 * op1_count - 1] + cy
			end
		end

	sqr_diagonal (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER)
		local
			i: INTEGER
			ul: NATURAL_32
			lpl: CELL [NATURAL_32]
			temp: CELL [NATURAL_32]
		do
			create lpl.put (0)
			create temp.put (0)
			from
				i := 0
			until
				i >= op1_count
			loop
				ul := op1 [op1_offset + i]
				umul_ppmm (temp, lpl, ul, ul)
				target [target_offset + 2 * i + 1] := temp.item
				target [target_offset + 2 * i] := lpl.item
				i := i + 1
			end
		end

	sqr_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER)
		require
			op1_count >= 1
		local
			ws: SPECIAL [NATURAL_32]
			ws_offset: INTEGER
		do
			if op1_count < 64 then
				sqr_basecase (target, target_offset, op1, op1_offset, op1_count)
			else
				create ws.make_filled (0, 2 * op1_count + 2 * 32)
				kara_sqr_n (target, target_offset, op1, op1_offset, op1_count, ws, ws_offset)
			end
		end

	sub (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; op2_count: INTEGER_32; carry: CELL [NATURAL_32])
		local
			i: INTEGER_32
			j: INTEGER_32
			x: NATURAL_32
			subtract_borrow: NATURAL_32
			done: BOOLEAN
		do
			i := op2_count
			sub_n (target, target_offset, op1, op1_offset, op2, op2_offset, i, carry)
			subtract_borrow := carry.item
			if subtract_borrow /= 0 then
				from
					x := 0
				until
					done or x /= 0
				loop
					if i >= op1_count then
						carry.put (1)
						done := True
					else
						x := op1 [op1_offset + i]
						target [target_offset + i] := x - 1
						i := i + 1
					end
				end
			end
			if not done then
				if target /= op1 then
					from
						j := i
					until
						j >= op1_count
					loop
						target [target_offset + j] := op1 [op1_offset + j]
						j := j + 1
					end
				end
				carry.put (0)
			end
		end

	sub_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: NATURAL_32; carry: CELL [NATURAL_32])
		require
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + op1_count - 1)
			target.valid_index (target_offset)
			target.valid_index (target_offset + op1_count - 1)
		local
			i: INTEGER_32
			x: NATURAL_32
			r: NATURAL_32
		do
			x := op1 [op1_offset]
			r := x - op2
			target [target_offset] := r
			if x < op2 then
				carry.put (1)
				from
					i := 1
				until
					i >= op1_count
				loop
					x := op1 [op1_offset + i]
					r := x - 1
					target [target_offset + i] := r
					i := i + 1
					if not (x < 1) then
						if op1 /= target then
							target.copy_data (op1, op1_offset + i, target_offset + i, op1_count - i)
						end
						carry.put (0)
						i := op1_count
					end
				end
			else
				if op1 /= target then
					target.copy_data (op1, op1_offset + 1, target_offset + 1, op1_count - 1)
				end
				carry.put (0)
			end
		end

	sub_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32; carry: CELL [NATURAL_32])
		local
			ul: NATURAL_32
			vl: NATURAL_32
			sl: NATURAL_32
			rl: NATURAL_32
			cy1: NATURAL_32
			cy2: NATURAL_32
			cursor: INTEGER_32
			carry_l: NATURAL_32
		do
			from
				cursor := 0
			until
				cursor = n
			loop
				ul := op1 [op1_offset + cursor]
				vl := op2 [op2_offset + cursor]
				sl := ul - vl
				cy1 := (sl > ul).to_integer.to_natural_32
				rl := sl - carry_l
				cy2 := (rl > sl).to_integer.to_natural_32
				carry_l := cy1.bit_or (cy2)
				target [target_offset + cursor] := rl
				cursor := cursor + 1
			end
			carry.put (carry_l)
		end

	submul_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; n: INTEGER_32; op2: NATURAL_32; carry: CELL [NATURAL_32])
		require
			target.valid_index (target_offset)
			target.valid_index (target_offset + n - 1)
			n >= 1
		local
			ul: NATURAL_32
			hpl: CELL [NATURAL_32]
			lpl: CELL [NATURAL_32]
			rl: NATURAL_32
			cursor: INTEGER_32
			carry_l: NATURAL_32
		do
			create hpl.put (0)
			create lpl.put (0)
			from
				cursor := 0
			until
				cursor >= n
			loop
				ul := op1 [op1_offset + cursor]
				umul_ppmm (hpl, lpl, ul, op2)
				lpl.put (lpl.item + carry_l)
				carry_l := (lpl.item < carry_l).to_integer.to_natural_32 + hpl.item
				rl := target [target_offset + cursor]
				lpl.put (rl - lpl.item)
				carry_l := carry_l + (lpl.item > rl).to_integer.to_natural_32
				target [target_offset + cursor] := lpl.item
				cursor := cursor + 1
			end
			carry.put (carry_l)
		end
end
