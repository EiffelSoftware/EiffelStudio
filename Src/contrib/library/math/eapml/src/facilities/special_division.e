note
	description: "Summary description for {NUMBER_DIVISION}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Freedom is the emancipation from the arbitrary rule of other men. -  Mortimer Adler (1902-2001)"

deferred class
	SPECIAL_DIVISION

inherit
	SPECIAL_ARITHMETIC
	SPECIAL_COMPARISON
	LIMB_MANIPULATION
	SPECIAL_LOGIC

feature

	bdivmod (qp: SPECIAL [NATURAL_32]; qp_offset_a: INTEGER; up: SPECIAL [NATURAL_32]; up_offset_a: INTEGER; usize_a: INTEGER; vp: SPECIAL [NATURAL_32]; vp_offset: INTEGER; vsize: INTEGER; d_a: INTEGER): NATURAL_32
			-- Computes (`up' / `vp') mod (2 ^ `d')
		require
			usize_a >= 1
			vsize >= 1
			usize_a * limb_bits >= d_a
			vp.valid_index (vp_offset)
			vp.valid_index (vp_offset + vsize - 1)
			up.valid_index (up_offset_a)
			up.valid_index (up_offset_a + usize_a - 1)
			vp [vp_offset].bit_test (0)
		local
			v_inv: NATURAL_32
			hi: CELL [NATURAL_32]
			lo: CELL [NATURAL_32]
			q: NATURAL_32
			b: NATURAL_32
			junk: NATURAL_32
			d: INTEGER
			up_offset: INTEGER
			usize: INTEGER
			qp_offset: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			qp_offset := qp_offset_a
			up_offset := up_offset_a
			usize := usize_a
			d := d_a
			create hi.put (0)
			create lo.put (0)
			v_inv := modlimb_invert (vp [vp_offset])
			if usize = 2 and vsize = 2 and (d = limb_bits or d = 2 * limb_bits) then
				q := up [up_offset] * v_inv
				umul_ppmm (hi, lo, q, vp [vp_offset])
				up [up_offset] := 0
				up [up_offset + 1] := up [up_offset + 1] - hi.item + q * vp [vp_offset + 1]
				qp [qp_offset] := q
				if d = 2 * limb_bits then
					q := up [up_offset + 1] * v_inv
					up [up_offset + 1] := 0
					qp [qp_offset + 1] := q
				end
				Result := 0
			else
				from
				until
					d < limb_bits
				loop
					q := up [up_offset] * v_inv
					submul_1 (up, up_offset, vp, vp_offset, usize.min (vsize), q, carry)
					b := carry.item
					if usize > vsize then
						sub_1 (up, up_offset + vsize, up, up_offset + vsize, usize - vsize, b, carry)
						junk := carry.item
					end
					d := d - limb_bits
					up_offset := up_offset + 1
					usize := usize - 1
					qp [qp_offset] := q
					qp_offset := qp_offset + 1
				end
				if d /= 0 then
					q := (up [up_offset] * v_inv).bit_and (((1).to_natural_32 |<< d) - 1)
					if q <= 1 then
						if q = 0 then
							Result := 0
						else
							sub_n (up, up_offset, up, up_offset, vp, vp_offset, usize.min (vsize), carry)
							b := carry.item
							if usize > vsize then
								sub_1 (up, up_offset + vsize, up, up_offset + vsize, usize - vsize, b, carry)
								junk := carry.item
							end
							Result := q
						end
					else
						submul_1 (up, up_offset, vp, vp_offset, usize.min (vsize), q, carry)
						b := carry.item
						if usize > vsize then
							sub_1 (up, up_offset + vsize, up, up_offset + vsize, usize - vsize, b, carry)
							junk := carry.item
							Result := q
						end
					end
				else
					Result := 0
				end
			end
		end

	dc_divrem_n (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32): NATURAL_32
		local
			scratch: SPECIAL [NATURAL_32]
		do
			create scratch.make_filled (0, n)
			Result := dc_div_2_by_1 (target, target_offset, op1, op1_offset, op2, op2_offset, n, scratch, 0)
		end

	dc_div_2_by_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32; scratch: SPECIAL [NATURAL_32]; scratch_offset: INTEGER_32): NATURAL_32
		local
			qhl: NATURAL_32
			cc: NATURAL_32
			n2: INTEGER_32
			target_cursor: INTEGER_32
			div_result: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n2 := n // 2
			if n \\ 2 /= 0 then
				target_cursor := target_offset + 1
				qhl := dc_div_3_by_2 (target, target_cursor + n2, op1, op1_offset + 2 + n2, op2, op2_offset + 1, n2, scratch, scratch_offset)
				div_result := dc_div_3_by_2 (target, target_cursor, op1, op1_offset + 2, op2, op2_offset + 1, n2, scratch, scratch_offset)
				add_1 (target, target_cursor + n2, target, target_cursor + n2, n2, div_result, carry)
				qhl := qhl + carry.item
				submul_1 (op1, op1_offset + 1, target, target_cursor, n - 1, op2 [op2_offset], carry)
				cc := carry.item
				sub_1 (op1, op1_offset + n, op1, op1_offset + n, 1, cc, carry)
				cc := carry.item
				if qhl /= 0 then
					sub_1 (op1, op1_offset + n, op1, op1_offset + n, 1, op2 [op2_offset], carry)
					cc := cc + carry.item
				end
				from
				until
					cc = 0
				loop
					sub_1 (target, target_cursor, target, target_cursor, n - 1, 1, carry)
					qhl := qhl - carry.item
					add_n (op1, op1_offset + 1, op1, op1_offset + 1, op2, op2_offset, n, carry)
					cc := cc - carry.item
				end
				div_result := sb_divrem_mn (target, target_offset, op1, op1_offset, n + 1, op2, op2_offset, n)
				add_1 (target, target_cursor, target, target_cursor, n - 1, div_result, carry)
				qhl := qhl + carry.item
			else
				qhl := dc_div_3_by_2 (target, target_offset + n2, op1, op1_offset + n2, op2, op2_offset, n2, scratch, scratch_offset)
				div_result := dc_div_3_by_2 (target, target_offset, op1, op1_offset, op2, op2_offset, n2, scratch, scratch_offset)
				add_1 (target, target_offset + n2, target, target_offset + n2, n2, div_result, carry)
				qhl := qhl + carry.item
			end
			Result := qhl
		end

	dc_div_3_by_2 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; n: INTEGER_32; scratch: SPECIAL [NATURAL_32]; scratch_offset: INTEGER_32): NATURAL_32
		local
			twon: INTEGER_32
			qhl: NATURAL_32
			cc: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			twon := n + n
			if n < 3 * 32 then
				qhl := sb_divrem_mn (target, target_offset, op1, op1_offset + n, twon, op2, op2_offset + n, n)
			else
				qhl := dc_div_2_by_1 (target, target_offset, op1, op1_offset + n, op2, op2_offset + n, n, scratch, scratch_offset)
			end
			mul_n (scratch, scratch_offset, target, target_offset, op2, op2_offset, n)
			sub_n (op1, op1_offset, op1, op1_offset, scratch, scratch_offset, twon, carry)
			cc := carry.item
			if qhl /= 0 then
				sub_n (op1, op1_offset + n, op1, op1_offset + n, op2, op2_offset, n, carry)
				cc := cc + carry.item
			end
			from
			until
				cc = 0
			loop
				sub_1 (target, target_offset, target, target_offset, n, 1, carry)
				qhl := qhl - carry.item
				add_n (op1, op1_offset, op1, op1_offset, op2, op2_offset, twon, carry)
				cc := cc - carry.item
			end
			Result := qhl
		end

	divexact_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; src: SPECIAL [NATURAL_32]; src_offset: INTEGER; size_a: INTEGER; divisor_a: NATURAL_32)
		local
			i: INTEGER
			c: NATURAL_32
			h: CELL [NATURAL_32]
			l: NATURAL_32
			ls: NATURAL_32
			s: NATURAL_32
			s_next: NATURAL_32
			inverse: NATURAL_32
			dummy: CELL [NATURAL_32]
			shift: INTEGER
			divisor: NATURAL_32
			size: INTEGER
		do
			size := size_a
			divisor := divisor_a
			create h.put (0)
			create dummy.put (0)
			s := src [src_offset]
			if size = 1 then
				target [target_offset] := s // divisor
			elseif not divisor.bit_test (0) then
				shift := trailing_zeros (divisor)
				divisor := divisor |>> shift
			else
				shift := 0
			end
			inverse := limb_inverse (divisor)
			if shift /= 0 then
				c := 0
				i := 0
				size := size - 1
				from
				until
					i >= size
				loop
					s_next := src [src_offset + i + 1]
					ls := (s |>> shift).bit_or (s_next |<< (limb_bits - shift))
					s := s_next
					l := ls - c
					c := (l > ls).to_integer.to_natural_32
					l := l * inverse
					target [target_offset + i] := l
					umul_ppmm (h, dummy, l, divisor)
					c := c + h.item
					i := i + 1
				end
				ls := s |>> shift
				l := ls - c
				l := (l * inverse)
				target [target_offset + i] := l
			else
				l := s * inverse
				target [target_offset] := l
				i := 1
				c := 0
				from
				until
					i >= size
				loop
					umul_ppmm (h, dummy, l, divisor)
					c := c + h.item
					s := src [src_offset + i]
					l := s - c
					c := (l > s).to_integer.to_natural_32
					l := l * inverse
					target [target_offset + i] := l
					i := i + 1
				end
			end
		end

	divrem_2 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32): NATURAL_32
		require
			op2.valid_index (op2_offset)
			op2.valid_index (op2_offset + 1)
			op1_count >= 2
			op2 [op2_offset + 1].bit_and (0x80000000) /= 0
		local
			most_significant_q_limb: NATURAL_32
			i: INTEGER_32
			n1: CELL [NATURAL_32]
			n0: CELL [NATURAL_32]
			n2: NATURAL_32
			d1: NATURAL_32
			d0: NATURAL_32
			d1inv: NATURAL_32
			op1_cursor: INTEGER_32
			q: CELL [NATURAL_32]
			r: CELL [NATURAL_32]
			continue: BOOLEAN
		do
			create n1.put (0)
			create n0.put (0)
			create q.put (0)
			create r.put (0)
			op1_cursor := op1_offset + op1_count - 2
			d1 := op2 [op2_offset + 1]
			d0 := op2 [op2_offset]
			n1.put (op1 [op1_cursor + 1])
			n0.put (op1 [op1_cursor])
			if n1.item >= d1 and (n1.item > d1 or n0.item >= d0) then
				sub_ddmmss (n1, n0, n1.item, n0.item, d1, d0)
				most_significant_q_limb := 1
			end
			d1inv := limb_inverse (d1)
			from
				i := op1_count - 2 - 1
			until
				i < 0
			loop
				continue := False
				op1_cursor := op1_cursor - 1
				if n1.item = d1 then
					q.put (0xffffffff)
					r.put (n0.item + d1)
					if r.item < d1 then
						add_ssaaaa (n1, n0, r.item - d0, op1 [op1_cursor], 0, d0)
						target [target_offset + i] := q.item
						continue := True
					else
						n1.put (d0 - (d0 /= 0).to_integer.to_natural_32)
						n0.put (0 - d0)
					end
				else
					udiv_qrnnd_preinv (q, r, n1.item, n0.item, d1, d1inv)
					umul_ppmm (n1, n0, d0, q.item)
				end
				if not continue then
					n2 := op1 [op1_cursor]
					from
						continue := True
					until
						not continue
					loop
						if n1.item > r.item or (n1.item = r.item and n0.item > n2) then
							q.put (q.item - 1)
							sub_ddmmss (n1, n0, n1.item, n0.item, 0, d0)
							r.put (r.item + d1)
							if r.item >= d1 then
							else
								continue := False
							end
						else
							continue := False
						end
					end
					target [target_offset + i] := q.item
					sub_ddmmss (n1, n0, r.item, n2, n1.item, n0.item)
				end
				i := i - 1
			end
			op1 [op1_cursor + 1] := n1.item
			op1 [op1_cursor] := n0.item
			Result := most_significant_q_limb
		end

	sub_ddmmss (sh: CELL [NATURAL_32]; sl: CELL [NATURAL_32]; ah: NATURAL_32; al: NATURAL_32; bh: NATURAL_32; bl: NATURAL_32)
		local
			x: NATURAL_32
		do
			x := al - bl
			sh.put (ah - bh - (al < bl).to_integer.to_natural_32)
			sl.put (x)
		end

	divrem_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; d: NATURAL_32): NATURAL_32
		require
			d /= 0
			op1_count >= 0
		local
			n: INTEGER_32
			i: INTEGER_32
			n1: NATURAL_32
			n0: NATURAL_32
			r: NATURAL_32
			target_cursor: INTEGER_32
			q: NATURAL_32
			norm: INTEGER_32
			un: INTEGER_32
			dinv: NATURAL_32
			d_cursor: NATURAL_32
			q_res: CELL [NATURAL_32]
			r_res: CELL [NATURAL_32]
		do
			create q_res.put (0)
			create r_res.put (0)
			un := op1_count
			n := op1_count
			if n = 0 then
				Result := 0
			else
				target_cursor := target_offset + n - 1
				if d.bit_test (limb_high_bit) then
					r := op1 [op1_count - 1]
					q := (r >= d).to_integer.to_natural_32
					target [target_cursor] := q
					target_cursor := target_cursor - 1
					r := r - d.bit_and (0 - q)
					n := n - 1
					un := un - 1
					dinv := limb_inverse (d)
					from
						i := un - 1
					until
						i < 0
					loop
						n0 := op1 [i]
						udiv_qrnnd_preinv (q_res, r_res, r, n0, d, dinv)
						target [target_cursor] := q_res.item
						r := r_res.item
						target_cursor := target_cursor - 1
						i := i - 1
					end
					Result := r
				else
					n1 := op1 [op1_count - 1]
					Result := r - 1
					if n1 < d then
						r := n1
						target [target_cursor] := 0
						target_cursor := target_cursor - 1
						n := n - 1
						if n = 0 then
							Result := r
						else
							un := un - 1
						end
					end
					if Result /= r then
						norm := leading_zeros (d)
						d_cursor := d |<< norm
						r := r |<< norm
						dinv := limb_inverse (d_cursor)
						if un /= 0 then
							n1 := op1 [un - 1]
							r := r.bit_or (n1.bit_shift_right (-norm))
							from
								i := un - 2
							until
								i < 0
							loop
								n0 := op1 [i]
								udiv_qrnnd_preinv (q_res, r_res, r, n1.bit_shift_left (norm).bit_or (n0.bit_shift_right (0 - norm)), d_cursor, dinv)
								r := r_res.item
								target [target_cursor] := q_res.item
								target_cursor := target_cursor - 1
								n1 := n0
								i := i - 1
							end
							udiv_qrnnd_preinv (q_res, r_res, r, n1.bit_shift_left (norm), d_cursor, dinv)
							r := r_res.item
							target [target_cursor] := q_res.item
							target_cursor := target_cursor - 1
						end
						Result := r.bit_shift_right (norm)
					end
				end
			end
		end

	udiv_qrnnd_preinv (q: CELL [NATURAL_32]; r: CELL [NATURAL_32]; nh: NATURAL_32; nl: NATURAL_32; d: NATURAL_32; di: NATURAL_32)
		local
			n2: NATURAL_32
			n10: NATURAL_32
			nmask: NATURAL_32
			nadj: NATURAL_32
			q1: NATURAL_32
			xh: CELL [NATURAL_32]
			xl: CELL [NATURAL_32]
		do
			create xh.put (0)
			create xl.put (0)
			n2 := nh
			n10 := nl
			nmask := limb_highbit_to_mask (n10)
			nadj := n10 + (nmask.bit_and (d))
			umul_ppmm (xh, xl, di, n2 - nmask)
			add_ssaaaa (xh, xl, xh.item, xl.item, n2, nadj)
			q1 := xh.item.bit_not
			umul_ppmm (xh, xl, q1, d)
			add_ssaaaa (xh, xl, xh.item, xl.item, nh, nl)
			xh.put (xh.item - d)
			r.put (xl.item + d.bit_and (xh.item))
			q.put (xh.item - q1)
		end

	udiv_qrnd_unnorm (q: CELL [NATURAL_32]; r: CELL [NATURAL_32]; n: NATURAL_32; d: NATURAL_32)
		do
			q.put (n // d)
			r.put (n \\ d)
		end

	add_ssaaaa (sh: CELL [NATURAL_32]; sl: CELL [NATURAL_32]; ah: NATURAL_32; al: NATURAL_32; bh: NATURAL_32; bl: NATURAL_32)
		local
			x: NATURAL_32
		do
			x := al + bl
			sh.put (ah + bh + (x < al).to_integer.to_natural_32)
			sl.put (x)
		end

	limb_highbit_to_mask (limb: NATURAL_32): NATURAL_32
		do
			if limb.bit_test (31) then
				Result := Result.bit_not
			end
		end

	mod_1 (op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count_a: INTEGER; d_a: NATURAL_32; remainder: CELL [NATURAL_32])
			-- Divides `op1' by `d_a' and places remainder in `remainder'
		require
			op1_count_a >= 0
			d_a /= 0
		local
			i: INTEGER
			n1: NATURAL_32
			n0: NATURAL_32
			r: CELL [NATURAL_32]
			dummy: CELL [NATURAL_32]
			op1_count: INTEGER
			inv: NATURAL_32
			norm: INTEGER
			d: NATURAL_32
		do
			create r.put (0)
			create dummy.put (0)
			d := d_a
			op1_count := op1_count_a
			if op1_count = 0 then
				remainder.put (0)
			else
				if d.bit_test (limb_high_bit) then
					r.put (op1 [op1_offset - 1])
					if r.item >= d then
						r.put (r.item - d)
					end
					op1_count := op1_count - 1
					if op1_count = 0 then
						remainder.put (r.item)
					else
						inv := limb_inverse (d)
						from
							i := op1_count - 1
						until
							i < 0
						loop
							n0 := op1 [op1_offset + i]
							udiv_qrnnd_preinv (dummy, r, r.item, n0, d, inv)
							i := i - 1
						end
						remainder.put (r.item)
					end
				else
					r.put (op1 [op1_offset + op1_count - 1])
					if r.item < d and op1_count - 1 = 0 then
						remainder.put (r.item)
					else
						if r.item < d then
							op1_count := op1_count - 1
						else
							r.put (0)
						end
						norm := leading_zeros (d)
						d := d |<< norm
						n1 := op1 [op1_offset + op1_count - 1]
						r.put ((r.item |<< norm).bit_or (n1 |>> (limb_bits - norm)))
						inv := limb_inverse (d)
						from
							i := op1_count - 2
						until
							i < 0
						loop
							n0 := op1 [op1_offset + i]
							udiv_qrnnd_preinv (dummy, r, r.item, (n1 |<< norm).bit_or (n0 |>> (limb_bits - norm)), d, inv)
							n1 := n0
							i := i - 1
						end
						udiv_qrnnd_preinv (dummy, r, r.item, n1 |<< norm, d, inv)
						remainder.put (r.item |>> norm)
					end
				end
			end
		end

	preinv_divrem_1 (qp: SPECIAL [NATURAL_32]; qp_offset_a: INTEGER; xsize: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; size_a: INTEGER; d_unnorm: NATURAL_32; dinv: NATURAL_32; shift: INTEGER): NATURAL_32
		require
			xsize >= 0
			size_a >= 1
			d_unnorm /= 0
		local
			ahigh: NATURAL_32
			qhigh: NATURAL_32
			r: CELL [NATURAL_32]
			q: CELL [NATURAL_32]
			i: INTEGER
			n1: NATURAL_32
			n0: NATURAL_32
			d: NATURAL_32
			qp_offset: INTEGER
			size: INTEGER
			done_integer: BOOLEAN
		do
			create r.put (0)
			create q.put (0)
			qp_offset := qp_offset_a
			size := size_a
			ahigh := ap [ap_offset + size - 1]
			d := d_unnorm |<< shift
			qp_offset := qp_offset + (size + xsize - 1)
			if shift = 0 then
				r.put (ahigh)
				qhigh := (r.item >= d).to_integer.to_natural_32
				if qhigh /= 0 then
					r.put (r.item - d)
				end
				qp [qp_offset] := qhigh
				qp_offset := qp_offset - 1
				size := size - 1
				from
					i := size - 1
				until
					i < 0
				loop
					n0 := ap [ap_offset + i]
					udiv_qrnnd_preinv (q, r, r.item, n0, d, dinv)
					qp [qp_offset] := q.item
					qp_offset := qp_offset - 1
					i := i - 1
				end
				done_integer := True
			else
				r.put (0)
				if ahigh < d_unnorm then
					r.put (ahigh |<< shift)
					qp [qp_offset] := 0
					qp_offset := qp_offset - 1
					size := size - 1
					if size = 0 then
						done_integer := True
					end
				end
				if not done_integer then
					n1 := ap [ap_offset + size - 1]
					r.put (r.item.bit_or (n1 |>> (limb_bits - shift)))
					from
						i := size - 2
					until
						i < 0
					loop
						n0 := ap [ap_offset + i]
						udiv_qrnnd_preinv (q, r, r.item, (n1 |<< shift).bit_or (n0 |>> (limb_bits - shift)), d, dinv)
						qp [qp_offset] := q.item
						qp_offset := qp_offset - 1
						n1 := n0
						i := i - 1
					end
					udiv_qrnnd_preinv (q, r, r.item, n1 |<< shift, d, dinv)
					qp [qp_offset] := q.item
					qp_offset := qp_offset - 1
				end
			end
			from
				i := 0
			until
				i >= xsize
			loop
				udiv_qrnnd_preinv (q, r, r.item, 0, d, dinv)
				qp [qp_offset] := q.item
				qp_offset := qp_offset - 1
				i := i + 1
			end
			Result := r.item |>> shift
		end

	sb_divrem_mn (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; op1: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; op2_count: INTEGER_32): NATURAL_32
			-- Base case division
		require
			op2_count > 2
			op1_count >= op2_count
			op2 [op2_offset + op2_count - 1].bit_test (limb_high_bit)
		local
			most_significant_q_limb: NATURAL_32
			qn: INTEGER_32
			i: INTEGER_32
			dx: NATURAL_32
			d1: NATURAL_32
			n0: NATURAL_32
			dxinv: NATURAL_32
			junk: NATURAL_32
			q: CELL [NATURAL_32]
			nx: NATURAL_32
			cy_limb: NATURAL_32
			rx: NATURAL_32
			r1: CELL [NATURAL_32]
			r0: NATURAL_32
			p1: CELL [NATURAL_32]
			p0: CELL [NATURAL_32]
			cy1: NATURAL_32
			cy2: NATURAL_32
			op1_offset: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create q.put (0)
			create r1.put (0)
			create p1.put (0)
			create p0.put (0)
			op1_offset := op1_offset_a
			qn := op1_count - op2_count
			op1_offset := op1_offset + qn
			dx := op2 [op2_offset + op2_count - 1]
			d1 := op2 [op2_offset + op2_count - 2]
			n0 := op1 [op1_offset + op2_count - 1]
			if n0 >= dx then
				if n0 > dx or cmp (op1, op1_offset, op2, op2_offset, op2_count - 1) >= 0 then
					sub_n (op1, op1_offset, op1, op1_offset, op2, op2_offset, op2_count, carry)
					junk := carry.item
					most_significant_q_limb := 1
				end
			end
			dxinv := limb_inverse (dx)
			from
				i := qn - 1
			until
				i < 0
			loop
				nx := op1 [op1_offset + op2_count - 1]
				op1_offset := op1_offset - 1
				if nx = dx then
					q.put (0xffffffff)
					submul_1 (op1, op1_offset, op2, op2_offset, op2_count, q.item, carry)
					cy_limb := carry.item
					if nx /= cy_limb then
						add_n (op1, op1_offset, op1, op1_offset, op2, op2_offset, op2_count, carry)
						junk := carry.item
						q.put (q.item - 1)
					end
					target [target_offset + i] := q.item
				else
					udiv_qrnnd_preinv (q, r1, nx, op1 [op1_offset + op2_count - 1], dx, dxinv)
					umul_ppmm (p1, p0, d1, q.item)
					r0 := op1 [op1_offset + op2_count - 2]
					rx := 0
					if r1.item < p1.item or (r1.item = p1.item and r0 < p0.item) then
						p1.put (p1.item - (p0.item < d1).to_integer.to_natural_32)
						p0.put (p0.item - d1)
						q.put (q.item - 1)
						r1.put (r1.item + dx)
						rx := (r1.item < dx).to_integer.to_natural_32
					end
					p1.put (p1.item + (r0 < p0.item).to_integer.to_natural_32)
					rx := rx - (r1.item < p1.item).to_integer.to_natural_32
					r1.put (r1.item - p1.item)
					r0 := r0 - p0.item
					submul_1 (op1, op1_offset, op2, op2_offset, op2_count - 2, q.item, carry)
					cy_limb := carry.item
					cy1 := (r0 < cy_limb).to_integer.to_natural_32
					r0 := r0 - cy_limb
					cy2 := (r1.item < cy1).to_integer.to_natural_32
					r1.put (r1.item - cy1)
					op1 [op1_offset + op2_count - 1] := r1.item
					op1 [op1_offset + op2_count - 2] := r0
					if cy2 /= rx then
						add_n (op1, op1_offset, op1, op1_offset, op2, op2_offset, op2_count, carry)
						junk := carry.item
						q.put (q.item - 1)
					end
					target [target_offset + i] := q.item
				end
				i := i - 1
			end
			Result := most_significant_q_limb
		end

	tdiv_qr (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32)
		require
			denominator_count >= 0
			numerator_count >= 0
			denominator_count = 0 or denominator [denominator_offset + denominator_count - 1] /= 0
		do
			inspect denominator_count
			when 0 then
				(create {DIVIDE_BY_ZERO}).raise
			when 1 then
				remainder [remainder_offset] := divrem_1 (target, target_offset, numerator, numerator_offset, numerator_count, denominator [denominator_offset])
			when 2 then
				tdiv_qr_two_case (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count)
			else
				tdiv_qr_large_case (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count)
			end
		end

	tdiv_qr_large_numerator (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count_a: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32; adjust: INTEGER_32)
		local
			d2p: SPECIAL [NATURAL_32]
			d2p_offset: INTEGER_32
			cy: NATURAL_32
			cnt: INTEGER_32
			n2p: SPECIAL [NATURAL_32]
			n2p_offset: INTEGER_32
			numerator_count: INTEGER_32
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			numerator_count := numerator_count_a
			target [target_offset + numerator_count - denominator_count] := 0
			if not denominator [denominator_offset + denominator_count - 1].bit_test (31) then
				cnt := leading_zeros (denominator [denominator_offset + denominator_count - 1])
				create d2p.make_filled (0, denominator_count)
				d2p_offset := 0
				lshift (d2p, d2p_offset, denominator, denominator_offset, denominator_count, cnt, carry)
				junk := carry.item
				create n2p.make_filled (0, numerator_count + 1)
				n2p_offset := 0
				lshift (n2p, n2p_offset, numerator, numerator_offset, numerator_count, cnt, carry)
				cy := carry.item
				n2p [n2p_offset + numerator_count] := cy
				numerator_count := numerator_count + adjust
			else
				cnt := 0
				d2p := denominator
				d2p_offset := denominator_offset
				create n2p.make_filled (0, numerator_count + 1)
				n2p_offset := 0
				n2p.copy_data (numerator, numerator_offset, n2p_offset, numerator_count)
				n2p [n2p_offset + numerator_count] := 0
				numerator_count := numerator_count + adjust
			end
			if denominator_count < 3 * 32 then
				junk := sb_divrem_mn (target, target_offset, n2p, n2p_offset, numerator_count, d2p, d2p_offset, denominator_count)
			else
				tdiv_qr_large_denominator (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count, n2p, n2p_offset, d2p, d2p_offset, numerator_count)
			end
			if cnt /= 0 then
				rshift (remainder, remainder_offset, n2p, n2p_offset, denominator_count, cnt, carry)
				junk := carry.item
			else
				remainder.copy_data (n2p, n2p_offset, remainder_offset, denominator_count)
			end
		end

	tdiv_qr_large_denominator (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32; n2p: SPECIAL [NATURAL_32]; n2p_offset_a: INTEGER_32; d2p: SPECIAL [NATURAL_32]; d2p_offset_a: INTEGER_32; nn_a: INTEGER_32)
		local
			q2p: SPECIAL [NATURAL_32]
			q2p_offset: INTEGER_32
			q1: NATURAL_32
			junk: NATURAL_32
			n2p_offset: INTEGER_32
			d2p_offset: INTEGER_32
			nn: INTEGER_32
		do
			nn := nn_a
			n2p_offset := n2p_offset_a
			d2p_offset := d2p_offset_a
			q2p := target
			q2p_offset := target_offset + nn - denominator_count
			n2p_offset := n2p_offset + nn - denominator_count
			from
			until
				nn < 2 * denominator_count
			loop
				q2p_offset := q2p_offset - denominator_count
				n2p_offset := n2p_offset - denominator_count
				junk := dc_divrem_n (q2p, q2p_offset, n2p, n2p_offset, d2p, d2p_offset, denominator_count)
				nn := nn - denominator_count
			end
			if nn /= denominator_count then
				n2p_offset := n2p_offset - nn - denominator_count
				q1 := target [target_offset + nn - denominator_count]
				tdiv_qr (target, target_offset, n2p, n2p_offset, n2p, n2p_offset, nn, d2p, d2p_offset, denominator_count)
				target [target_offset + nn - denominator_count] := q1
			end
		end

	tdiv_qr_large_case (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32)
		local
			adjust: INTEGER_32
		do
			adjust := (numerator [numerator_offset + numerator_count - 1] >= denominator [denominator_offset + denominator_count - 1]).to_integer
			if numerator_count + adjust >= 2 * denominator_count then
				tdiv_qr_large_numerator (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count, adjust)
			else
				tdiv_qr_small_numerator (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count, adjust)
			end
		end

	tdiv_qr_small_numerator (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32; adjust: INTEGER_32)
		local
			qn: INTEGER_32
		do
			qn := numerator_count - denominator_count
			target [target_offset + qn] := 0
			qn := qn + adjust
			if qn = 0 then
				remainder.copy_data (numerator, numerator_offset, remainder_offset, denominator_count)
			else
				tdiv_qr_non_zero_quotient (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count, adjust, qn)
			end
		end

	tdiv_qr_non_zero_quotient (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32; adjust: INTEGER_32; qn: INTEGER_32)
		local
			d2p: SPECIAL [NATURAL_32]
			d2p_offset: INTEGER_32
			cy: NATURAL_32
			cnt: INTEGER_32
			n2p: SPECIAL [NATURAL_32]
			n2p_offset: INTEGER_32
			in: INTEGER_32
			rn: INTEGER_32
			junk: NATURAL_32
			dl: NATURAL_32
			x: NATURAL_32
			h: CELL [NATURAL_32]
			dummy: CELL [NATURAL_32]
			cy1: NATURAL_32
			cy2: NATURAL_32
			quotient_too_large: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			in := denominator_count - qn
			if not denominator [denominator_offset + denominator_count - 1].bit_test (limb_high_bit) then
				cnt := leading_zeros (denominator [denominator_offset + denominator_count - 1])
				create d2p.make_filled (0, qn)
				d2p_offset := 0
				lshift (d2p, d2p_offset, denominator, denominator_offset + in, qn, cnt, carry)
				junk := carry.item
				d2p [d2p_offset] := d2p [d2p_offset].bit_or ((denominator [denominator_offset + in - 1]) |>> (limb_bits - cnt))
				create n2p.make_filled (0, 2 * qn + 1)
				n2p_offset := 0
				lshift (n2p, n2p_offset, numerator, numerator_offset + numerator_count - 2 * qn, 2 * qn, cnt, carry)
				cy := carry.item
				if adjust /= 0 then
					n2p [n2p_offset + 2 * qn] := cy
					n2p_offset := n2p_offset + 1
				else
					n2p [n2p_offset] := n2p [n2p_offset].bit_or ((numerator [numerator_offset + numerator_count - 2 * qn - 1]) |>> (limb_bits - cnt))
				end
			else
				cnt := 0
				d2p := denominator
				d2p_offset := denominator_offset + in
				create n2p.make_filled (0, 2 * qn + 1)
				n2p_offset := 0
				n2p.copy_data (numerator, numerator_offset + numerator_count - 2 * qn, n2p_offset, 2 * qn)
				if adjust /= 0 then
					n2p [n2p_offset + 2 * qn] := 0
					n2p_offset := n2p_offset + 1
				end
			end
			tdiv_qr_internal_divide (target, target_offset, n2p, n2p_offset, d2p, d2p_offset, qn)
			rn := qn
			create h.put (0)
			create dummy.put (0)
			if in - 2 < 0 then
				dl := 0
			else
				dl := denominator [denominator_offset + in - 2]
			end
			x := (denominator [denominator_offset + in - 1] |<< cnt).bit_or ((dl |>> 1) |>> (cnt.bit_not \\ limb_bits))
			umul_ppmm (h, dummy, x, target [target_offset + qn - 1])
			if n2p [n2p_offset + qn - 1] < h.item then
				decr_u (target, target_offset, 1)
				add_n (n2p, n2p_offset, n2p, n2p_offset, d2p, d2p_offset, qn, carry)
				cy := carry.item
				if cy /= 0 then
					n2p [n2p_offset + qn] := cy
					rn := rn + 1
				end
			end
			if cnt /= 0 then
				lshift (n2p, n2p_offset, n2p, n2p_offset, rn, limb_bits - cnt, carry)
				cy1 := carry.item
				n2p [n2p_offset] := n2p [n2p_offset].bit_or (numerator [numerator_offset + in - 1].bit_and ((0xffffffff).to_natural_32 |>> cnt))
				submul_1 (n2p, n2p_offset, target, target_offset, qn, denominator [denominator_offset + in - 1].bit_and ((0xffffffff).to_natural_32 |>> cnt), carry)
				cy2 := carry.item
				if qn /= rn then
					n2p [n2p_offset + qn] := n2p [n2p_offset + qn] - cy2
				else
					n2p [n2p_offset + qn] := cy1 - cy2
					quotient_too_large := (cy1 < cy2).to_integer.to_natural_32
					rn := rn + 1
				end
				in := in - 1
			end
			tdiv_qr_shift_result (target, target_offset, remainder, remainder_offset, numerator, numerator_offset, numerator_count, denominator, denominator_offset, denominator_count, adjust, qn, n2p, n2p_offset, d2p, d2p_offset, rn, in, cnt, quotient_too_large)
		end

	tdiv_qr_internal_divide (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; qn: INTEGER_32)
		local
			junk: NATURAL_32
		do
			if qn = 1 then
				tdiv_qr_internal_divide_1 (target, target_offset, numerator, numerator_offset, denominator, denominator_offset)
			elseif qn = 2 then
				junk := divrem_2 (target, target_offset, numerator, numerator_offset, 4, denominator, denominator_offset)
			elseif qn < 3 * 32 then
				junk := sb_divrem_mn (target, target_offset, numerator, numerator_offset, 2 * qn, denominator, denominator_offset, qn)
			else
				junk := dc_divrem_n (target, target_offset, numerator, numerator_offset, denominator, denominator_offset, qn)
			end
		end

	tdiv_qr_internal_divide_1 (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER)
		local
			q0: TUPLE [q0: NATURAL_32]
			r0: TUPLE [r0: NATURAL_32]
		do
			create q0
			create r0
			udiv_qrnnd (q0, r0, numerator [numerator_offset + 1], numerator [numerator_offset], denominator [denominator_offset])
			numerator [numerator_offset] := r0.r0
			target [target_offset] := q0.q0
		end

	tdiv_qr_shift_result (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32; adjust: INTEGER_32; qn: INTEGER_32; n2p: SPECIAL [NATURAL_32]; n2p_offset: INTEGER_32; d2p: SPECIAL [NATURAL_32]; d2p_offset: INTEGER_32; rn_a: INTEGER_32; in: INTEGER_32; cnt: INTEGER_32; quotient_too_large_a: NATURAL_32)
		local
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER_32
			junk: NATURAL_32
			goto: BOOLEAN
			cy: NATURAL_32
			rn: INTEGER_32
			quotient_too_large: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			quotient_too_large := quotient_too_large_a
			rn := rn_a
			create tp.make_filled (0, denominator_count)
			tp_offset := 0
			if in < qn and in = 0 then
				if in = 0 then
					remainder.copy_data (n2p, n2p_offset, remainder_offset, rn)
					goto := True
				else
					mul (tp, tp_offset, target, target_offset, qn, denominator, denominator_offset, in, carry)
					junk := carry.item
				end
			else
				mul (tp, tp_offset, denominator, denominator_offset, in, target, target_offset, qn, carry)
				junk := carry.item
			end
			if not goto then
				sub (n2p, n2p_offset, n2p, n2p_offset, rn, tp, tp_offset + in, qn, carry)
				cy := carry.item
				remainder.copy_data (n2p, n2p_offset, remainder_offset + in, denominator_count - in)
				quotient_too_large := quotient_too_large.bit_or (cy)
				sub_n (remainder, remainder_offset, numerator, numerator_offset, tp, tp_offset, in, carry)
				cy := carry.item
				sub_1 (remainder, remainder_offset + in, remainder, remainder_offset + in, rn, cy, carry)
				cy := carry.item
				quotient_too_large := quotient_too_large.bit_or (cy)
			end
			if quotient_too_large /= 0 then
				decr_u (target, target_offset, 1)
				add_n (remainder, remainder_offset, remainder, remainder_offset, denominator, denominator_offset, denominator_count, carry)
				junk := carry.item
			end
		end

	tdiv_qr_two_case (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; remainder: SPECIAL [NATURAL_32]; remainder_offset: INTEGER_32; numerator: SPECIAL [NATURAL_32]; numerator_offset: INTEGER_32; numerator_count: INTEGER_32; denominator: SPECIAL [NATURAL_32]; denominator_offset: INTEGER_32; denominator_count: INTEGER_32)
		local
			d2p: SPECIAL [NATURAL_32]
			d2p_offset: INTEGER_32
			qhl: NATURAL_32
			cy: NATURAL_32
			cnt: INTEGER_32
			dtmp: SPECIAL [NATURAL_32]
			n2p: SPECIAL [NATURAL_32]
			n2p_offset: INTEGER_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create dtmp.make_filled (0, 2)
			if not denominator [denominator_offset + 1].bit_test (31) then
				cnt := leading_zeros (denominator [denominator_offset + 1])
				d2p := dtmp
				d2p [d2p_offset + 1] := (denominator [denominator_offset + 1] |<< cnt).bit_or (denominator [denominator_offset] |>> (limb_bits - cnt))
				d2p [d2p_offset] := denominator [denominator_offset] |<< cnt
				create n2p.make_filled (0, numerator_count + 1)
				lshift (n2p, 0, numerator, numerator_offset, numerator_count, cnt, carry)
				cy := carry.item
				n2p [numerator_count] := cy
				qhl := divrem_2 (target, target_offset, n2p, n2p_offset, numerator_count + (cy /= 0).to_integer, d2p, d2p_offset)
				if cy = 0 then
					target [target_offset + numerator_count - 2] := qhl
				end
				remainder [remainder_offset] := (n2p [0] |>> cnt).bit_or (n2p [1] |<< (limb_bits - cnt))
				remainder [remainder_offset + 1] := n2p [1] |>> cnt
			else
				d2p := denominator
				d2p_offset := denominator_offset
				create n2p.make_filled (0, numerator_count)
				n2p.copy_data (numerator, numerator_offset, 0, numerator_count)
				qhl := divrem_2 (target, target_offset, n2p, 0, numerator_count, d2p, d2p_offset)
				target [target_offset + numerator_count - 2] := qhl
				remainder [remainder_offset] := n2p [0]
				remainder [remainder_offset + 1] := n2p [1]
			end
		end
end
