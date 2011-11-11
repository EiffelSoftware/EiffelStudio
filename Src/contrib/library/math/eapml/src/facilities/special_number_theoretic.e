note
	description: "Summary description for {NUMBER_NUMBER_THEORETIC}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The best argument against democracy is a five-minute conversation with the average voter. -  Winston Churchill"

deferred class
	SPECIAL_NUMBER_THEORETIC

inherit
	SPECIAL_DIVISION
	SPECIAL_UTILITY
	SPECIAL_LOGIC
	LIMB_MANIPULATION

feature

	gcdext_div2 (n1_a: NATURAL_32; n0_a: NATURAL_32; d1_a: NATURAL_32; d0_a: NATURAL_32): NATURAL_32
		require
			d1_a /= 0 or d0_a /= 0
		local
			q: NATURAL_32
			count: INTEGER
			d1: NATURAL_32
			d0: NATURAL_32
			n1: CELL [NATURAL_32]
			n0: CELL [NATURAL_32]
		do
			create n1.put (n1_a)
			create n0.put (n0_a)
			d1 := d1_a
			d0 := d0_a
			if n1.item.bit_test (limb_high_bit) then
				from
					count := 1
				invariant
					d1 /= 0 or d0 /= 0
				until
					d1.bit_test (limb_high_bit)
				loop
					d1 := (d1 |<< 1).bit_or (d0 |>> (limb_bits - 1))
					d0 := d0 |<< 1
					count := count + 1
				end
				q := 0
				from
				until
					count = 0
				loop
					q := q |<< 1
					if n1.item > d1 or (n1.item = d1 and n0.item >= d0) then
						sub_ddmmss (n1, n0, n1.item, n0.item, d1, d0)
						q := q.bit_or (1)
					end
					d0 := (d1 |<< (limb_bits - 1)).bit_or (d0 |>> 1)
					d1 := d1 |>> 1
					count := count - 1
				end
				Result := q
			else
				from
					count := 0
				until
					n1.item <= d1 and (n1.item /= d1 or n0.item < d0)
				loop
					d1 := (d1 |<< 1).bit_or (d0 |>> (limb_bits - 1))
					d0 := d0 |<< 1
					count := count + 1
				end
				q := 0
				from
				until
					count = 0
				loop
					d0 := (d1 |<< (limb_bits - 1)).bit_or (d0 |>> 1)
					d1 := d1 |>> 1
					q := q |<< 1
					if n1.item > d1 or (n1.item = d1 and n0.item >= d0) then
						sub_ddmmss (n1, n0, n1.item, n0.item, d1, d0)
						q := q.bit_or (1)
					end
					count := count - 1
				end
				Result := q
			end
		end

	basic_gcdext (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; cofactor: SPECIAL [NATURAL_32]; cofactor_offset: INTEGER_32; cofactor_count: TUPLE [cofactor_count: INTEGER_32]; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER_32; op1_count: INTEGER_32; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER_32; op2_count: INTEGER_32): INTEGER
		require
			op1_count >= op2_count
			target.valid_index (target_offset)
			target.valid_index (target_offset + op1_count - 1)
			cofactor.valid_index (cofactor_offset)
			cofactor.valid_index (cofactor_offset + op1_count - 1)
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + op1_count - 0)
			op1 [op1_offset + op1_count - 1] /= 0
			op2.valid_index (op2_offset)
			op2.valid_index (op2_offset + op2_count - 0)
			op2 [op2_offset + op2_count - 1] /= 0
			op2_count >= 1
		local
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER_32
			s1p: SPECIAL [NATURAL_32]
			s1p_offset: INTEGER
		do
			create tp.make_filled (0, op1_count + 1)
			tp_offset := 0
			create s1p.make_filled (0, op1_count + 1)
			s1p_offset := 0
			cofactor.fill_with (0, cofactor_offset, cofactor_offset + op1_count - 1)
			s1p.fill_with (0, s1p_offset, s1p_offset + op1_count - 1)
			cofactor [cofactor_offset] := 1
			s1p [s1p_offset] := 0
			if op1_count > op2_count then
				tdiv_qr (tp, tp_offset, op1, op1_offset, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
				cofactor [cofactor_offset] := 0
				s1p [s1p_offset] := 1
				Result := basic_gcdext_arranged (target, target_offset, cofactor, cofactor_offset, cofactor_count, op2, op2_offset, op2_count, op1, op1_offset, op1_count, -1, s1p, s1p_offset, tp, tp_offset)
			else
				Result := basic_gcdext_arranged (target, target_offset, cofactor, cofactor_offset, cofactor_count, op1, op1_offset, op1_count, op2, op2_offset, op2_count, 1, s1p, s1p_offset, tp, tp_offset)
			end
		end

	basic_gcdext_arranged (target: SPECIAL [NATURAL_32]; target_offset: INTEGER_32; cofactor_a: SPECIAL [NATURAL_32]; cofactor_offset_a: INTEGER_32; cofactor_count: TUPLE [cofactor_count: INTEGER_32]; op1_a: SPECIAL [NATURAL_32]; op1_offset_a: INTEGER_32; op1_count_a: INTEGER_32; op2_a: SPECIAL [NATURAL_32]; op2_offset_a: INTEGER_32; op2_count_a: INTEGER_32; sign_a: INTEGER; s1p_a: SPECIAL [NATURAL_32]; s1p_offset_a: INTEGER; tp_a: SPECIAL [NATURAL_32]; tp_offset_a: INTEGER): INTEGER
		local
			a: NATURAL_32
			b: NATURAL_32
			c: NATURAL_32
			d: NATURAL_32
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER_32
			orig_s0p: SPECIAL [NATURAL_32]
			orig_s0p_offset: INTEGER
			use_double_flag: BOOLEAN
			cnt: INTEGER_32
			assign_l: NATURAL_32
			op2_count: INTEGER
			done: BOOLEAN
			done_2: BOOLEAN
			uh: NATURAL_32
			vh: NATURAL_32
			ul: NATURAL_32
			vl: NATURAL_32
			tac: NATURAL_32
			tbd: NATURAL_32
			q1: NATURAL_32
			q2: NATURAL_32
			nh: CELL [NATURAL_32]
			nl: CELL [NATURAL_32]
			dh: CELL [NATURAL_32]
			dl: CELL [NATURAL_32]
			t1: CELL [NATURAL_32]
			t0: CELL [NATURAL_32]
			thigh: CELL [NATURAL_32]
			tlow: CELL [NATURAL_32]
			sign: INTEGER
			q: NATURAL_32
			t: NATURAL_32
			ssize: INTEGER_32
			qsize: INTEGER_32
			i: INTEGER_32
			cy: NATURAL_32
			cofactor: SPECIAL [NATURAL_32]
			cofactor_offset: INTEGER_32
			op1: SPECIAL [NATURAL_32]
			op1_offset: INTEGER_32
			op2: SPECIAL [NATURAL_32]
			op2_offset: INTEGER_32
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER_32
			s1p: SPECIAL [NATURAL_32]
			s1p_offset: INTEGER_32
			temp_special: SPECIAL [NATURAL_32]
			temp_integer: INTEGER_32
			op1_count: INTEGER
			tsize: INTEGER
			wsize: INTEGER
			junk: NATURAL_32
			cy1: NATURAL_32
			cy2: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			cofactor := cofactor_a
			cofactor_offset := cofactor_offset_a
			op1 := op1_a
			op1_offset := op1_offset_a
			op1_count := op1_count_a
			op2 := op2_a
			op2_offset := op2_offset_a
			tp := tp_a
			tp_offset := tp_offset_a
			s1p := s1p_a
			s1p_offset := s1p_offset_a
			ssize := 1
			sign := sign_a
			op2_count := op2_count_a
			orig_s0p := cofactor
			orig_s0p_offset := cofactor_offset
			create wp.make_filled (0, op1_count + 1)
			wp_offset := 0
			use_double_flag := op1_count > 17
			from
			until
				done
			loop
				op2_count := op1_count
				op2_count := normalize (op2, op2_offset, op2_count)
				if op2_count <= 1 then
					done := True
				else
					if use_double_flag then
						uh := op1 [op1_count - 1]
						vh := op2 [op1_count - 1]
						ul := op1 [op1_count - 2]
						vl := op2 [op1_count - 2]
						cnt := leading_zeros (uh)
						if cnt /= 0 then
							uh := (uh |<< cnt).bit_or (ul |>> (32 - cnt))
							vh := (vh |<< cnt).bit_or (vl |>> (32 - cnt))
							vl := vl |<< cnt
							ul := ul |<< cnt
							if op1_count >= 3 then
								ul := ul.bit_or (op1 [op1_offset + op1_count - 3] |>> (32 - cnt))
								vl := vl.bit_or (op2 [op2_offset + op1_count - 3] |>> (32 - cnt))
							end
						end
						a := 1
						b := 0
						c := 0
						d := 1
						assign_l := 0
						from
							done_2 := False
							create nh.put (0)
							create nl.put (0)
							create dh.put (0)
							create dl.put (0)
							create thigh.put (0)
							create tlow.put (0)
							create t1.put (0)
							create t0.put (0)
						until
							done_2
						loop
							sub_ddmmss (dh, dl, vh, vl, 0, c)
							if dh.item = 0 then
								done_2 := True
							else
								add_ssaaaa (nh, nl, uh, ul, 0, a)
								q1 := gcdext_div2 (nh.item, nl.item, dh.item, dl.item)
								add_ssaaaa (dh, dl, vh, vl, 0, d)
								if dh.item = 0 then
									done_2 := True
								else
									sub_ddmmss (nh, nl, uh, ul, 0, b)
									q2 := gcdext_div2 (nh.item, nl.item, dh.item, dl.item)
									if q1 /= q2 then
										done_2 := True
									else
										tac := a + q1 * c
										tbd := b + q1 * d
										a := c
										c := tac
										b := d
										d := tbd
										umul_ppmm (t1, t0, q1, vl)
										t1.put (t1.item + q1 * vh)
										sub_ddmmss (thigh, tlow, uh, ul, t1.item, t0.item)
										uh := vh
										ul := vl
										vh := thigh.item
										vl := tlow.item
										assign_l := assign_l.bit_not
										add_ssaaaa (dh, dl, vh, vl, 0, c)
										sub_ddmmss (nh, nl, uh, ul, 0, a)
										q1 := gcdext_div2 (nh.item, nl.item, dh.item, dl.item)
										sub_ddmmss (dh, dl, vh, vl, 0, d)
										if dh.item = 0 then
											done_2 := True
										else
											add_ssaaaa (nh, nl, uh, ul, 0, b)
											q2 := gcdext_div2 (nh.item, nl.item, dh.item, dl.item)
											if q1 /= q2 then
												done_2 := True
											else
												tac := a + q1 * c
												tbd := b + q1 * d
												a := c
												c := tac
												b := d
												d := tbd
												umul_ppmm (t1, t0, q1, vl)
												t1.put (t1.item + (q1 * vh))
												sub_ddmmss (thigh, tlow, uh, ul, t1.item, t0.item)
												uh := vh
												ul := vl
												vh := thigh.item
												vl := tlow.item
												assign_l := assign_l.bit_not
											end
										end
									end
								end
							end
						end
						if assign_l /= 0 then
							sign := -sign
						end
					else
						uh := op1 [op1_offset + op1_count - 1]
						vh := op2 [op2_offset + op1_count - 1]
						cnt := leading_zeros (uh)
						if cnt /= 0 then
							uh := (uh |<< cnt).bit_or (op1 [op1_offset + op1_count - 2] |>> (limb_bits - cnt))
							vh := (vh |<< cnt).bit_or (op2 [op2_offset + op1_count - 2] |>> (limb_bits - cnt))
						end
						a := 1
						b := 0
						c := 0
						d := 1
						assign_l := 0
						from
							done_2 := False
						until
							done_2
						loop
							if vh - c = 0 or vh + d = 0 then
								done_2 := True
							else
								q := (uh + a) // (vh - c)
								if q /= (uh - b) // (vh + d) then
									done_2 := True
								else
									t := a + q * c
									a := c
									c := t
									t := b + q * d
									b := d
									d := t
									t := uh - q * vh
									uh := vh
									vh := t
									assign_l := assign_l.bit_not
									if vh - d = 0 then
										done_2 := True
									else
										q := (uh - a) // (vh + c)
										if q /= (uh + b) // (vh - d) then
											done_2 := True
										else
											t := a + q * c
											a := c
											c := t
											t := b + q * d
											b := d
											d := t
											t := uh - q * vh
											uh := vh
											vh := t
											assign_l := assign_l.bit_not
										end
									end
								end
							end
						end
						if assign_l /= 0 then
							sign := -sign
						end
					end
					if b = 0 then
						tdiv_qr (wp, wp_offset, op1, op1_offset, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
						tp.copy_data (cofactor, cofactor_offset, tp_offset, ssize)
						qsize := op1_count - op2_count + 1
						s1p.fill_with (0, s1p_offset + ssize, s1p_offset + ssize + qsize - 1)
						from
							i := 0
						until
							i >= qsize
						loop
							addmul_1 (tp, tp_offset + i, s1p, s1p_offset, ssize, wp [wp_offset + i], carry)
							cy := carry.item
							tp [tp_offset + ssize + i] := cy
							i := i + 1
						end
						ssize := ssize + qsize
						ssize := ssize - (tp [tp_offset + ssize - 1] = 0).to_integer
						sign := -sign
						temp_special := cofactor
						temp_integer := cofactor_offset
						cofactor := s1p
						cofactor_offset := s1p_offset
						s1p := temp_special
						s1p_offset := temp_integer
						temp_special := s1p
						temp_integer := s1p_offset
						s1p := tp
						s1p_offset := tp_offset
						tp := temp_special
						tp_offset := temp_integer
						op1_count := op2_count
						temp_special := op1
						temp_integer := op1_offset
						op1 := op2
						op1_offset := op2_offset
						op2 := temp_special
						op2_offset := temp_integer
					else
						if a = 0 then
							tp.copy_data (op2, op2_offset, tp_offset, op1_count)
							wp.copy_data (op1, op1_offset, wp_offset, op1_count)
							submul_1 (wp, wp_offset, op2, op2_offset, op1_count, d, carry)
							junk := carry.item
							temp_special := tp
							temp_integer := tp_offset
							tp := op1
							tp_offset := op1_offset
							op1 := temp_special
							op1_offset := temp_integer
							temp_special := wp
							temp_integer := wp_offset
							wp := op2
							wp_offset := op2_offset
							op2 := temp_special
							op2_offset := temp_integer
							tp.copy_data (s1p, s1p_offset, tp_offset, ssize)
							tsize := ssize
							tp [tp_offset + ssize] := 0
							wp.copy_data (cofactor, cofactor_offset, wp_offset, ssize)
							addmul_1 (wp, wp_offset, s1p, s1p_offset, ssize, d, carry)
							cy := carry.item
							wp [wp_offset + ssize] := cy
							wsize := ssize + (cy /= 0).to_integer
							temp_special := tp
							temp_integer := tp_offset
							tp := cofactor
							tp_offset := cofactor_offset
							cofactor := temp_special
							cofactor_offset := temp_integer
							temp_special := wp
							temp_integer := wp_offset
							wp := s1p
							wp_offset := s1p_offset
							s1p := temp_special
							s1p_offset := temp_integer
							ssize := wsize.max (tsize)
						else
							if assign_l /= 0 then
								mul_1 (tp, tp_offset, op2, op2_offset, op1_count, b, carry)
								junk := carry.item
								submul_1 (tp, tp_offset, op1, op1_offset, op1_count, a, carry)
								junk := carry.item
								mul_1 (wp, wp_offset, op1, op1_offset, op1_count, c, carry)
								junk := carry.item
								submul_1 (wp, wp_offset, op2, op2_offset, op1_count, d, carry)
								junk := carry.item
							else
								mul_1 (tp, tp_offset, op1, op1_offset, op1_count, a, carry)
								junk := carry.item
								submul_1 (tp, tp_offset, op2, op2_offset, op1_count, b, carry)
								junk := carry.item
								mul_1 (wp, wp_offset, op2, op2_offset, op1_count, d, carry)
								junk := carry.item
								submul_1 (wp, wp_offset, op1, op1_offset, op1_count, c, carry)
								junk := carry.item
							end
							temp_special := tp
							temp_integer := tp_offset
							tp := op1
							tp_offset := op1_offset
							op1 := temp_special
							op1_offset := temp_integer
							temp_special := wp
							temp_integer := wp_offset
							wp := op2
							wp_offset := op2_offset
							op2 := temp_special
							op2_offset := temp_integer
							mul_1 (tp, tp_offset, cofactor, cofactor_offset, ssize, a, carry)
							cy1 := carry.item
							addmul_1 (tp, tp_offset, s1p, s1p_offset, ssize, b, carry)
							cy2 := carry.item
							cy := cy1 + cy2
							tp [tp_offset + ssize] := cy
							tsize := ssize + (cy /= 0).to_integer
							if cy < cy1 then
								tp [tp_offset + tsize] := 1
								wp [wp_offset + tsize] := 0
								tsize := tsize + 1
							end
							mul_1 (wp, wp_offset, s1p, s1p_offset, ssize, d, carry)
							cy1 := carry.item
							addmul_1 (wp, wp_offset, cofactor, cofactor_offset, ssize, c, carry)
							cy2 := carry.item
							cy := cy1 + cy2
							wp [wp_offset + ssize] := cy
							wsize := ssize + (cy /= 0).to_integer
							if cy < cy1 then
								wp [wp_offset + wsize] := 1
								if wsize >= tsize then
									tp [tp_offset + wsize] := 0
								end
								wsize := wsize + 1
							end
							temp_special := tp
							temp_integer := tp_offset
							tp := cofactor
							tp_offset := cofactor_offset
							cofactor := temp_special
							cofactor_offset := temp_integer
							temp_special := wp
							temp_integer := wp_offset
							wp := s1p
							wp_offset := s1p_offset
							s1p := temp_special
							s1p_offset := temp_integer
							ssize := wsize.max (tsize)
						end
						op1_count := op1_count - (op1 [op1_offset + op1_count - 1] = 0).to_integer
					end
				end
			end
			if op2_count = 0 then
				if target /= op1 then
					target.copy_data (op1, op1_offset, target_offset, op1_count)
				end
				ssize := normalize (cofactor, cofactor_offset, ssize)
				if orig_s0p /= cofactor then
					orig_s0p.copy_data (cofactor, cofactor_offset, orig_s0p_offset, ssize)
				end
				if sign >= 0 then
					cofactor_count.cofactor_count := ssize
				else
					cofactor_count.cofactor_count := -ssize
				end
				Result := op1_count
			else
				vl := op2 [op2_offset]
				t := divrem_1 (wp, wp_offset, op1, op1_offset, op1_count, vl)
				tp.copy_data (cofactor, cofactor_offset, tp_offset, ssize)
				qsize := op1_count - (wp [wp_offset + op1_count - 1] = 0).to_integer
				if ssize < qsize then
					tp.fill_with (0, tp_offset + ssize, qsize - ssize)
					s1p.fill_with (0, s1p_offset + ssize, qsize)
					from
						i := 0
					until
						i >= ssize
					loop
						addmul_1 (tp, tp_offset + i, wp, wp_offset, qsize, s1p [s1p_offset + i], carry)
						cy := carry.item
						tp [tp_offset + qsize + i] := cy
						i := i + 1
					end
				else
					s1p.fill_with (0, s1p_offset + ssize, s1p_offset + ssize + qsize - 1)
					from
						i := 0
					until
						i >= qsize
					loop
						addmul_1 (tp, tp_offset + i, s1p, s1p_offset, ssize, wp [wp_offset + i], carry)
						cy := carry.item
						tp [tp_offset + ssize + i] := cy
						i := i + 1
					end
				end
				ssize := ssize + qsize
				ssize := ssize - (tp [tp_offset + ssize - 1] = 0).to_integer
				sign := -sign
				temp_special := cofactor
				temp_integer := cofactor_offset
				cofactor := s1p
				cofactor_offset := s1p_offset
				s1p := temp_special
				s1p_offset := temp_integer
				temp_special := s1p
				temp_integer := s1p_offset
				s1p := tp
				s1p_offset := tp_offset
				tp := temp_special
				tp_offset := temp_integer
				ul := vl
				vl := t
				from
				until
					vl = 0
				loop
					q := ul // vl
					t := ul - q * vl
					tp.copy_data (cofactor, cofactor_offset, tp_offset, ssize)
					s1p.fill_with (0, s1p_offset + ssize, s1p_offset + ssize)
					addmul_1 (tp, tp_offset, s1p, s1p_offset, ssize, q, carry)
					cy := carry.item
					tp [tp_offset + ssize] := cy
					ssize := ssize + 1
					ssize := ssize - (tp [tp_offset + ssize - 1] = 0).to_integer
					sign := -sign
					temp_special := cofactor
					temp_integer := cofactor_offset
					cofactor := s1p
					cofactor_offset := s1p_offset
					s1p := temp_special
					s1p_offset := temp_integer
					temp_special := s1p
					temp_integer := s1p_offset
					s1p := tp
					s1p_offset := tp_offset
					tp := temp_special
					tp_offset := temp_integer
					ul := vl
					vl := t
				end
				target [target_offset] := ul
				ssize := normalize (cofactor, cofactor_offset, ssize)
				if orig_s0p /= cofactor then
					orig_s0p.copy_data (cofactor, cofactor_offset, orig_s0p_offset, ssize)
				end
				if sign >= 0 then
					cofactor_count.cofactor_count := ssize
				else
					cofactor_count.cofactor_count := -ssize
				end
				Result := 1
			end
		end

	gcdext (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; cofactor: SPECIAL [NATURAL_32]; cofactor_offset: INTEGER; cofactor_count: TUPLE [cofactor_count: INTEGER]; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER; op2_count: INTEGER): INTEGER
		require
			op1_count >= op2_count
			op2_count >= 0
			op1.valid_index (op1_offset)
			op1.valid_index (op1_offset + op1_count - 0)
			op1 [op1_offset + op1_count - 1] /= 0
			op2.valid_index (op2_offset)
			op2.valid_index (op2_offset + op2_count - 0)
			op1 [op1_offset + op1_count - 1] /= 0
			target.valid_index (target_offset)
			target.valid_index (target_offset + op1_count - 1)
			cofactor.valid_index (cofactor_offset)
			cofactor.valid_index (cofactor_offset + op1_count - 1)
		local
			orig_n: INTEGER
		do
			orig_n := op2_count
			Result := basic_gcdext (target, target_offset, cofactor, cofactor_offset, cofactor_count, op1, op1_offset, op1_count, op2, op2_offset, op2_count)
		end

	modexact_1c_odd (op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER; d: NATURAL_32; orig_c: NATURAL_32): NATURAL_32
		require
			op1_count >= 1
			d.bit_test (0)
		local
			s: NATURAL_32
			h: CELL [NATURAL_32]
			l: CELL [NATURAL_32]
			inverse: NATURAL_32
			dummy: CELL [NATURAL_32]
			dmul: NATURAL_32
			c: CELL [NATURAL_32]
			i: INTEGER
		do
			create l.put (0)
			create c.put (orig_c)
			create h.put (0)
			create dummy.put (0)
			if op1_count = 1 then
				s := op1 [op1_offset]
				if s > c.item then
					l.put (s - c.item)
					h.put (l.item \\ d)
					if h.item /= 0 then
						h.put (d - h.item)
					end
				else
					l.put (c.item - s)
					h.put (l.item \\ d)
				end
				Result := h.item
			else
				inverse := modlimb_invert (d)
				dmul := d
				from
					i := 0
				until
					i >= op1_count - 1
				loop
					s := op1 [op1_offset + i]
					subc_limb (c, l, s, c.item)
					l.put (l.item * inverse)
					umul_ppmm (h, dummy, l.item, dmul)
					c.put (c.item + h.item)
					i := i + 1
				end
				s := op1 [op1_offset + i]
				if s <= d then
					l.put (c.item - s)
					if c.item < s then
						l.put (l.item + d)
					end
					Result := l.item
				else
					subc_limb (c, l, s, c.item)
					l.put (l.item * inverse)
					umul_ppmm (h, dummy, l.item, dmul)
					c.put (c.item + h.item)
					Result := c.item
				end
			end
		ensure
			orig_c < d implies Result < d
			orig_c >= d implies Result <= d
		end

	preinv_mod_1 (up: SPECIAL [NATURAL_32]; up_offset: INTEGER; un: INTEGER; d: NATURAL_32; dinv: NATURAL_32): NATURAL_32
		require
			un >= 1
			d.bit_test (31)
		local
			i: INTEGER
			n0: NATURAL_32
			r: CELL [NATURAL_32]
			dummy: CELL [NATURAL_32]
		do
			create r.put (up [up_offset + un - 1])
			create dummy.put (0)
			if r.item >= d then
				r.put (r.item - d)
			end
			from
				i := un - 2
			until
				i < 0
			loop
				n0 := up [up_offset + i]
				udiv_qrnnd_preinv (dummy, r, r.item, n0, d, dinv)
				i := i - 1
			end
			Result := r.item
		end

	redc_basecase (cp: SPECIAL [NATURAL_32]; cp_offset: INTEGER; mp: SPECIAL [NATURAL_32]; mp_offset: INTEGER; n: INTEGER; n_prim: NATURAL_32; tp: SPECIAL [NATURAL_32]; tp_offset_a: INTEGER)
		local
			cy: NATURAL_32
			q: NATURAL_32
			j: INTEGER
			tp_offset: INTEGER
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			tp_offset := tp_offset_a
			from
				j := 0
			until
				j >= n
			loop
				q := tp [tp_offset] * n_prim
				addmul_1 (tp, tp_offset, mp, mp_offset, n, q, carry)
				tp [tp_offset] := carry.item
				tp_offset := tp_offset + 1
				j := j + 1
			end
			add_n (cp, cp_offset, tp, tp_offset, tp, tp_offset - n, n, carry)
			cy := carry.item
			if cy /= 0 then
				sub_n (cp, cp_offset, cp, cp_offset, mp, mp_offset, n, carry)
				junk := carry.item
			end
		end

	subc_limb (cout: CELL [NATURAL_32]; w: CELL [NATURAL_32]; x: NATURAL_32; y: NATURAL_32)
		do
			w.put (x - y)
			cout.put ((w.item > x).to_integer.to_natural_32)
		end

	invert_gf (target: SPECIAL [NATURAL_32] target_offset: INTEGER op1_a: SPECIAL [NATURAL_32] op1_offset: INTEGER op1_count_a: INTEGER op2_a: SPECIAL [NATURAL_32] op2_offset: INTEGER op2_count_a: INTEGER)
			-- Invert `op1' over `op2' using the extended euclidian algorithm in F2M
		require
			op2_count_a > 0
			op1_count_a >= 0
			op1_count_a <= op2_count_a;
			(op1_count_a = op2_count_a) implies cmp (op1_a, op1_offset, op2_a, op2_offset, op2_count_a) <= 0
		local
			op1: SPECIAL [NATURAL_32]
			op1_count: INTEGER
			op1_leading_zeros: INTEGER
			op2: SPECIAL [NATURAL_32]
			op2_count: INTEGER
			op2_leading_zeros: INTEGER
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			g1: SPECIAL [NATURAL_32]
			g1_count: INTEGER
			g2: SPECIAL [NATURAL_32]
			g2_count: INTEGER
			operand_sizes: INTEGER
			left_shift_amount: INTEGER
		do
			operand_sizes := op2_count_a
			op1_count := op1_count_a
			op2_count := op2_count_a
			create op1.make_filled (0, operand_sizes + operand_sizes)
			create op2.make_filled (0, operand_sizes + operand_sizes)
			op1.copy_data (op1_a, op1_offset, 0, op1_count.min (operand_sizes))
			op2.copy_data (op2_a, op2_offset, 0, op2_count.min (operand_sizes))
			create g1.make_filled (0, operand_sizes + operand_sizes)
			create g2.make_filled (0, operand_sizes + operand_sizes)
			g1 [0] := 1
			g1_count := 1
			g2_count := 0
			from
			until
				op1_count = 0
			loop
				op1_leading_zeros := leading_zeros (op1 [op1_count - 1])
				op2_leading_zeros := leading_zeros (op2 [op2_count - 1])
				if op1_count < op2_count or (op1_count = op2_count and op1_leading_zeros > op2_leading_zeros) then
					tmp_special := op1
					op1 := op2
					op2 := tmp_special
					tmp_special := g1
					g1 := g2
					g2 := tmp_special
					tmp_integer := op1_count
					op1_count := op2_count
					op2_count := tmp_integer
					tmp_integer := op1_leading_zeros
					op1_leading_zeros := op2_leading_zeros
					op2_leading_zeros := tmp_integer
				end
				if op1_count /= op2_count or (op1_count = op2_count and op1_leading_zeros /= op2_leading_zeros) then
					left_shift_amount := (op1_count - op2_count) * limb_bits + op2_leading_zeros - op1_leading_zeros
					bit_xor_lshift (op1, 0, op1, 0, op1_count, op2, 0, op2_count, left_shift_amount)
					bit_xor_lshift (g1, 0, g1, 0, operand_sizes, g2, 0, operand_sizes, left_shift_amount)
				else
					bit_xor (op1, 0, op1, 0, op1_count, op2, 0, op2_count)
					bit_xor (g1, 0, g1, 0, operand_sizes, g2, 0, operand_sizes)
				end
				op1_count := normalize (op1, 0, op1_count)
				op2_count := normalize (op2, 0, op2_count)
			end
			target.copy_data (g2, 0, target_offset, operand_sizes)
		end
end
