note
	description: "Summary description for {NUMBER_GCD}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "My reading of history convinces me that most bad government results from too much government. -  Thomas Jefferson."

deferred class
	SPECIAL_GCD

inherit
	SPECIAL_LOGIC
	LIMB_MANIPULATION
	SPECIAL_ARITHMETIC
	SPECIAL_DIVISION
	SPECIAL_UTILITY

feature

	find_a (cp0: NATURAL_32; cp1: NATURAL_32): NATURAL_32
		local
			leading_zero_bits: INTEGER
			n1_l: NATURAL_32
			n1_h: NATURAL_32
			n2_l: NATURAL_32
			n2_h: NATURAL_32
			i: INTEGER
			tmp: NATURAL_32
		do
			n1_l := cp0
			n1_h := cp1
			n2_l := 0 - n1_l
			n2_h := n1_h.bit_not
			from
			until
				n2_h = 0
			loop
				if not n2_h.bit_test (limb_high_bit - leading_zero_bits) then
					i := leading_zeros (n2_h)
					i := i - leading_zero_bits
					leading_zero_bits := leading_zero_bits + i
					n2_h := (n2_h |<< i).bit_or (n2_l |>> (limb_bits - i))
					n2_l := n2_l |<< i
					from
					until
						i = 0
					loop
						if n1_h > n2_h or (n1_h = n2_h and n1_l >= n2_l) then
							n1_h := n1_h - (n2_h + (n1_l < n2_l).to_integer.to_natural_32)
							n1_l := (n1_l - n2_l)
						end
						n2_l := (n2_l |>> 1).bit_or (n2_h |<< (limb_bits - 1))
						n2_h := n2_h |>> 1
						i := i - 1
					end
				end
				if n1_h > n2_h or (n1_h = n2_h and n1_l >= n2_l) then
					n1_h := n1_h - (n2_h + (n1_l < n2_l).to_integer.to_natural_32)
					n1_l := n1_l - n2_l
				end
				tmp := n1_h
				n1_h := n2_h
				n2_h := tmp
				tmp := n1_l
				n1_l := n2_l
				n2_l := tmp
			end
			Result := n2_l
		end

	gcd_2 (vp: SPECIAL [NATURAL_32]; vp_offset: INTEGER; up: SPECIAL [NATURAL_32]; up_offset: INTEGER): INTEGER
		local
			u0: NATURAL_32
			u1: NATURAL_32
			v0: NATURAL_32
			v1: NATURAL_32
			vsize: INTEGER
			r: INTEGER
		do
			u0 := up [0]
			u1 := up [1]
			v0 := vp [0]
			v1 := vp [1]
			from
			until
				u1 = v1 or u0 = v0
			loop
				if u1 > v1 then
					u1 := u1 - (v1 + (u0 < v0).to_integer.to_natural_32)
					u0 := u0 - v0
					r := trailing_zeros (u0)
					u0 := (u1 |<< (limb_bits - r)).bit_or (u0 |>> r)
					u1 := u1 |>> r
				else
					v1 := v1 - (u1 + (v0 < u0).to_integer.to_natural_32)
					v0 := v0 - u0
					r := trailing_zeros (v0)
					v0 := (v1 |<< (limb_bits - r)).bit_or (v0 |>> r)
					v1 := v1 |>> r
				end
			end
			vp [vp_offset] := v0
			vp [vp_offset + 1] := v1
			vsize := 1 + (v1 /= 0).to_integer
			if u1 = v1 and u0 = v0 then
				Result := vsize
			else
				if u0 = v0 then
					if v1 > v1 then
						v0 := u1 - v1
					else
						v0 := v1 - u1
					end
				else
					if u0 > v0 then
						v0 := u0 - v0
					else
						v0 := v0 - u0
					end
				end
				vp [vp_offset] := gcd_1 (vp, vp_offset, vsize, v0)
				Result := 1
			end
		end

	gcd (gp: SPECIAL [NATURAL_32]; gp_offset: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; ap_count: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER; n: INTEGER): INTEGER
		do
			Result := basic_gcd (gp, gp_offset, ap, ap_offset, ap_count, bp, bp_offset, n)
		ensure
			Result > 0
			Result <= ap_count
			Result <= n
		end

	gcd_1 (up: SPECIAL [NATURAL_32]; up_offset: INTEGER; size: INTEGER; vlimb_a: NATURAL_32): NATURAL_32
		require
			size >= 1
			vlimb_a /= 0
		local
			remainder: CELL [NATURAL_32]
			ulimb: NATURAL_32
			zero_bits: INTEGER
			u_low_zero_bits: INTEGER
			tmp: NATURAL_32
			vlimb: NATURAL_32
			maybe: BOOLEAN
			done: BOOLEAN
		do
			create remainder.put (0)
			vlimb := vlimb_a
			ulimb := up [up_offset]
			zero_bits := trailing_zeros (vlimb)
			vlimb := vlimb |>> zero_bits
			if size > 1 then
				if ulimb /= 0 then
					u_low_zero_bits := trailing_zeros (ulimb)
					zero_bits := zero_bits.min (u_low_zero_bits)
				end
				mod_1 (up, up_offset, size, vlimb, remainder)
				ulimb := remainder.item
				if ulimb = 0 then
					done := True
				else
					maybe := True
				end
			else
				u_low_zero_bits := trailing_zeros (ulimb)
				ulimb := ulimb |>> u_low_zero_bits
				zero_bits := zero_bits.min (u_low_zero_bits)
				if vlimb > ulimb then
					tmp := ulimb
					ulimb := vlimb
					vlimb := tmp
				end
				if (ulimb |>> 16) > vlimb then
					ulimb := ulimb \\ vlimb
					if ulimb = 0 then
						done := True
					else
						maybe := True
					end
				end
			end
			if not done then
				from
				until
					ulimb = vlimb and not maybe
				loop
					if ulimb > vlimb or maybe then
						if not maybe then
							ulimb := ulimb - vlimb
						end
						from
							if not maybe then
								ulimb := ulimb |>> 1
							end
						until
							not maybe and ulimb.bit_test (0)
						loop
							if not maybe then
								ulimb := ulimb |>> 1
							else
								maybe := False
							end
						end
					else
						vlimb := vlimb - ulimb
						from
							vlimb := vlimb |>> 1
						until
							vlimb.bit_test (0)
						loop
							vlimb := vlimb |>> 1
						end
					end
				end
			end
			Result := vlimb |<< zero_bits
		end

	basic_gcd (gp: SPECIAL [NATURAL_32]; gp_offset: INTEGER; up_a: SPECIAL [NATURAL_32]; up_offset_a: INTEGER; usize_a: INTEGER; vp_a: SPECIAL [NATURAL_32]; vp_offset_a: INTEGER; vsize_a: INTEGER): INTEGER
		require
			usize_a >= 1
			vsize_a >= 1
			usize_a >= vsize_a
			vp_a.valid_index (vp_offset_a)
			vp_a.valid_index (vp_offset_a + vsize_a - 1)
			up_a.valid_index (up_offset_a)
			up_a.valid_index (up_offset_a + usize_a - 1)
			vp_a [vp_offset_a].bit_test (0)
			up_a [up_offset_a + usize_a - 1] /= 0
			vp_a [vp_offset_a + vsize_a - 1] /= 0
		local
			orig_vp: SPECIAL [NATURAL_32]
			orig_vp_offset: INTEGER
			orig_vsize: INTEGER
			binary_gcd_ctr: INTEGER
			scratch: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			vbitsize: INTEGER
			d: INTEGER
			orig_up: SPECIAL [NATURAL_32]
			orig_up_offset: INTEGER
			orig_usize: INTEGER
			anchor_up: SPECIAL [NATURAL_32]
			anchor_up_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			usize: INTEGER
			i: INTEGER
			vp: SPECIAL [NATURAL_32]
			vp_offset: INTEGER
			vsize: INTEGER
			r: INTEGER
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			junk: NATURAL_32
			bp0: NATURAL_32
			bp1: NATURAL_32
			cp0: NATURAL_32
			cp1: NATURAL_32
			u_inv: NATURAL_32
			hi: CELL [NATURAL_32]
			lo: CELL [NATURAL_32]
			v_inv: NATURAL_32
			c: NATURAL_32
			b: NATURAL_32
			rsize: INTEGER
			done: BOOLEAN
			continue: BOOLEAN
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create hi.put (0)
			create lo.put (0)
			up := up_a
			up_offset := up_offset_a
			usize := usize_a
			vp := vp_a
			vp_offset := vp_offset_a
			vsize := vsize_a
			orig_vp := vp
			orig_vp_offset := vp_offset
			orig_vsize := vsize
			if vsize >= 5 then
				orig_up := up
				orig_up_offset := up_offset
				orig_usize := usize
				create anchor_up.make_filled (0, usize + 2)
				anchor_up.copy_data (orig_up, orig_up_offset, anchor_up_offset, usize)
				up := anchor_up
				d := leading_zeros (up [up_offset + usize - 1])
				d := usize * limb_bits - d
				vbitsize := leading_zeros (vp [vp_offset + vsize - 1])
				vbitsize := vsize * limb_bits - vbitsize
				d := d - vbitsize + 1
				up [up_offset + usize] := 0
				usize := usize + 1
				junk := bdivmod (up, up_offset, up, up_offset, usize, vp, vp_offset, vsize, d)
				d := d // limb_bits
				up_offset := up_offset + d
				usize := usize - d
				from
				until
					usize = 0 or up [up_offset] /= 0
				loop
					up_offset := up_offset + 1
					usize := usize - 1
				end
				if usize = 0 then
					done := True
				else
					create vp.make_filled (0, vsize + 2)
					vp_offset := 0
					vp.copy_data (orig_vp, orig_vp_offset, 0, vsize)
					from
					until
						usize = 0
					loop
						if up [up_offset + usize - 1].bit_test (limb_high_bit) then
							anchor_up [anchor_up_offset] := 0 - up [up_offset]
							from
								i := 1
							until
								i >= usize
							loop
								anchor_up [anchor_up_offset + i] := up [up_offset + i].bit_not
								i := i + 1
							end
							up := anchor_up
							up_offset := anchor_up_offset
						end
						usize := normalize (up, up_offset, usize)
						if not up [up_offset].bit_test (0) then
							r := trailing_zeros (up [up_offset])
							rshift (anchor_up, anchor_up_offset, up, up_offset, usize, r, carry)
							junk := carry.item
							usize := usize - (anchor_up [anchor_up_offset + usize - 1] = 0).to_integer
						else
							anchor_up.copy_data (up, up_offset, anchor_up_offset, usize)
						end
						tmp_special := anchor_up
						anchor_up := vp
						vp := tmp_special
						tmp_integer := anchor_up_offset
						anchor_up_offset := vp_offset
						vp_offset := tmp_integer
						tmp_integer := usize
						usize := vsize
						vsize := tmp_integer
						up := anchor_up
						up_offset := anchor_up_offset
						if vsize <= 2 then
							usize := 0
						else
							d := vbitsize
							vbitsize := leading_zeros (vp [vp_offset + vsize - 1])
							vbitsize := vsize * limb_bits - vbitsize
							d := d - vbitsize + 1
							if d > 16 then
								up [up_offset + usize] := 0
								usize := usize + 1
								junk := bdivmod (up, up_offset, up, up_offset, usize, vp, vp_offset, vsize, d)
								d := d // limb_bits
								up_offset := up_offset + d
								usize := usize - d
							else
								u_inv := modlimb_invert (up [up_offset])
								cp0 := vp [vp_offset] * u_inv
								umul_ppmm (hi, lo, cp0, up [up_offset])
								cp1 := (vp [vp_offset + 1] - hi.item - cp0 * up [up_offset + 1]) * u_inv
								mul_1 (up, up_offset, up, up_offset, usize, find_a (cp0, cp1), carry)
								up [up_offset + usize] := carry.item
								usize := usize + 1
								v_inv := modlimb_invert (vp [vp_offset])
								bp0 := (up [up_offset] * v_inv)
								umul_ppmm (hi, lo, bp0, vp [vp_offset])
								bp1 := (up [up_offset + 1] + hi.item + (bp0.bit_and (vp [vp_offset + 1]))).bit_and (0x1)
								up [up_offset + usize] := 0
								usize := usize + 1
								if bp1 /= 0 then
									addmul_1 (up, up_offset, vp, vp_offset, vsize, 0 - bp0, carry)
									c := carry.item
									add_1 (up, up_offset + vsize, up, up_offset + vsize, usize - vsize, c, carry)
									junk := carry.item
								else
									submul_1 (up, up_offset, vp, vp_offset, vsize, bp0, carry)
									b := carry.item
									sub_1 (up, up_offset + vsize, up, up_offset + vsize, usize - vsize, b, carry)
									junk := carry.item
								end
								up_offset := up_offset + 2
								usize := usize - 2
							end
							from
							until
								usize = 0 or up [up_offset] /= 0
							loop
								up_offset := up_offset + 1
								usize := usize - 1
							end
						end
					end
					up := orig_up
					up_offset := orig_up_offset
					usize := orig_usize
					binary_gcd_ctr := 2
				end
			else
				binary_gcd_ctr := 1
			end
			if not done then
				scratch := (2 * vsize).max (vsize + 1)
				if usize + 1 > scratch then
					scratch := usize + 1
				end
				create tp.make_filled (0, scratch)
				tp_offset := 0
				from
				until
					binary_gcd_ctr = 0
				loop
					continue := False
					binary_gcd_ctr := binary_gcd_ctr - 1
					if usize > vsize then
						tdiv_qr (tp, tp_offset + vsize, tp, tp_offset, up, up_offset, usize, vp, vp_offset, vsize)
						rsize := vsize
						rsize := normalize (tp, tp_offset, rsize)
						if rsize = 0 then
							continue := True
						else
							up.copy_data (tp, tp_offset, up_offset, vsize)
						end
					end
					if not continue then
						vsize := ngcd_lehmer (vp, vp_offset, up, up_offset, vp, vp_offset, vsize, tp, tp_offset)
					end
					up := orig_vp
					up_offset := orig_vp_offset
					usize := orig_vsize
				end
			end
			if vp /= gp then
				gp.copy_data (vp, vp_offset, gp_offset, vsize)
			end
			Result := vsize
		ensure
			Result > 0
			Result <= usize_a
			Result <= vsize_a
		end

	ngcd_matrix1_vector (m: SPECIAL [NATURAL_32]; n_a: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER; tp: SPECIAL [NATURAL_32]; tp_offset: INTEGER): INTEGER
		local
			h0: NATURAL_32
			h1: NATURAL_32
			n: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n := n_a
			tp.copy_data (ap, ap_offset, tp_offset, n)
			mul_1 (ap, ap_offset, ap, ap_offset, n, m [3], carry)
			h0 := carry.item
			submul_1 (ap, ap_offset, bp, bp_offset, n, m [1], carry)
			h1 := carry.item
			mul_1 (bp, bp_offset, bp, bp_offset, n, m [0], carry)
			h0 := carry.item
			submul_1 (bp, bp_offset, tp, tp_offset, n, m [2], carry)
			h1 := carry.item
			n := n - (ap [ap_offset + n - 1].bit_or (bp [bp_offset + n - 1]) = 0).to_integer
			Result := n
		end

	ngcd_subdiv_step (gp: SPECIAL [NATURAL_32]; gp_offset: INTEGER; gn: TUPLE [gn: INTEGER]; ap_a: SPECIAL [NATURAL_32]; ap_offset_a: INTEGER; bp_a: SPECIAL [NATURAL_32]; bp_offset_a: INTEGER; n: INTEGER; tp: SPECIAL [NATURAL_32]; tp_offset: INTEGER): INTEGER
		local
			an: INTEGER
			bn: INTEGER
			ap: SPECIAL [NATURAL_32]
			ap_offset: INTEGER
			bp: SPECIAL [NATURAL_32]
			bp_offset: INTEGER
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			junk: NATURAL_32
			c: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			ap := ap_a
			ap_offset := ap_offset_a
			bp := bp_a
			bp_offset := bp_offset_a
			from
				an := n
			until
				an <= 0 or else ap [ap_offset + an - 1] /= bp [bp_offset + an - 1]
			loop
				an := an - 1
			end
			if an = 0 then
				gp.copy_data (ap, ap_offset, gp_offset, n)
				gn.gn := n
				Result := 0
			else
				if ap [ap_offset + an - 1] < bp [bp_offset + an - 1] then
					tmp_special := ap
					ap := bp
					bp := tmp_special
					tmp_integer := ap_offset
					ap_offset := bp_offset
					bp_offset := tmp_integer
					bn := n
					bn := normalize (bp, bp_offset, bn)
					if bn = 0 then
						gp.copy_data (ap, ap_offset, gp_offset, n)
						gn.gn := n
						Result := 0
					else
						sub_n (ap, ap_offset, ap, ap_offset, bp, bp_offset, an, carry)
						junk := carry.item
						an := normalize (ap, ap_offset, an)
						if an < bn then
							tmp_special := ap
							ap := bp
							bp := tmp_special
							tmp_integer := ap_offset
							ap_offset := bp_offset
							bp_offset := tmp_integer
							tmp_integer := an
							an := bn
							bn := tmp_integer
						elseif an = bn then
							c := cmp (ap, ap_offset, bp, bp_offset, an)
							if c < 0 then
								tmp_special := ap
								ap := bp
								bp := tmp_special
								tmp_integer := ap_offset
								ap_offset := bp_offset
								bp_offset := tmp_integer
							end
						end
						tdiv_qr (tp, tp_offset + bn, tp, tp_offset, ap, ap_offset, an, bp, bp_offset, bn)
						an := bn
						an := normalize (tp, tp_offset, an)
						if an = 0 then
							gp.copy_data (bp, bp_offset, gp_offset, bn)
							gn.gn := bn
							Result := 0
						else
							ap.copy_data (tp, tp_offset, ap_offset, bn)
							Result := bn
						end
					end
				end
			end
		end

	nhgcd2 (ah_a: NATURAL_32; al_a: NATURAL_32; bh_a: NATURAL_32; bl_a: NATURAL_32; m: SPECIAL [NATURAL_32]): BOOLEAN
		local
			u00: NATURAL_32
			u01: NATURAL_32
			u10: NATURAL_32
			u11: NATURAL_32
			al: CELL [NATURAL_32]
			ah: CELL [NATURAL_32]
			bl: CELL [NATURAL_32]
			bh: CELL [NATURAL_32]
			done: BOOLEAN
			subtract_a: BOOLEAN
			r0: CELL [NATURAL_32]
			r1: CELL [NATURAL_32]
			q: NATURAL_32
		do
			create r0.put (0)
			create r1.put (0)
			create al.put (al_a)
			create ah.put (ah_a)
			create bl.put (bl_a)
			create bh.put (bh_a)
			if ah.item < 2 or bh.item < 2 then
				Result := False
			else
				if ah.item > bh.item or (ah.item = bh.item and al.item > bl.item) then
					sub_ddmmss (ah, al, ah.item, al.item, bh.item, bl.item)
					if ah.item < 2 then
						Result := False
						done := True
					else
						u11 := 1
						u01 := u11
						u00 := u01
						u10 := 0
					end
				else
					sub_ddmmss (bh, bl, bh.item, bl.item, ah.item, al.item)
					if bh.item < 2 then
						Result := False
						done := True
					else
						u11 := 1
						u10 := u11
						u00 := u10
						u01 := 0
					end
				end
				if not done then
					if ah.item < bh.item then
						subtract_a := True
					end
					from
					until
						not subtract_a and done
					loop
						if not subtract_a then
							if ah.item = bh.item then
								done := True
							else
								sub_ddmmss (ah, al, ah.item, al.item, bh.item, bl.item)
								if ah.item < 2 then
									done := True
								else
									if ah.item <= bh.item then
										u01 := u01 + u00
										u11 := u11 + u10
									else
										q := div2 (r0, r1, ah.item, al.item, bh.item, bl.item)
										al.put (r0.item)
										ah.put (r1.item)
										if ah.item < 2 then
											u01 := u01 + q * u00
											u11 := u11 + q * u10
											done := True
										else
											q := q + 1
											u01 := u01 + q * u00
											u11 := u11 + q * u10
										end
									end
								end
							end
						end
						if not done then
							subtract_a := False
							if ah.item = bh.item then
								done := True
							else
								sub_ddmmss (bh, bl, bh.item, bl.item, ah.item, al.item)
								if bh.item < 2 then
									done := True
								else
									if bh.item <= ah.item then
										u00 := u00 + u01
										u10 := u10 + u11
									else
										q := div2 (r0, r1, bh.item, bl.item, ah.item, al.item)
										bl.put (r0.item)
										bh.put (r1.item)
										if bh.item < 2 then
											u00 := u00 + q * u01
											u10 := u10 + q * u11
											done := True
										else
											q := q + 1
											u00 := u00 + q * u01
											u10 := u10 + q * u11
										end
									end
								end
							end
						end
					end
					m [0] := u00
					m [1] := u01
					m [2] := u10
					m [3] := u11
					Result := True
				end
			end
		end

	div2 (r0: CELL [NATURAL_32]; r1: CELL [NATURAL_32]; nh_a: NATURAL_32; nl_a: NATURAL_32; dh_a: NATURAL_32; dl_a: NATURAL_32): NATURAL_32
		require
			dh_a /= 0 or dl_a /= 0
		local
			q: NATURAL_32
			count: INTEGER_32
			dh: NATURAL_32
			dl: NATURAL_32
			nh: CELL [NATURAL_32]
			nl: CELL [NATURAL_32]
		do
			create nh.put (0)
			create nl.put (0)
			nh.put (nh_a)
			nl.put (nl_a)
			dh := dh_a
			dl := dl_a
			if nh.item.bit_test (limb_high_bit) then
				from
					count := 1
				invariant
					dh /= 0 or dl /= 0
				until
					dh.bit_test (limb_high_bit)
				loop
					dh := (dh |<< 1).bit_or (dl |>> (limb_bits - 1))
					dl := (dl |<< 1)
					count := count + 1
				end
				from
				until
					count = 0
				loop
					q := q |<< 1
					if nh.item > dh or (nh.item = dh and nl.item >= dl) then
						sub_ddmmss (nh, nl, nh.item, nl.item, dh, dl)
						q := q.bit_or (1)
					end
					dl := (dh |<< (limb_bits - 1)).bit_or (dl |>> 1)
					dh := dh |>> 1
					count := count - 1
				end
			else
				from
				until
					not (nh.item > dh or (nh.item = dh and nl.item >= dl))
				loop
					dh := (dh |<< 1).bit_or (dl |>> (limb_bits - 1))
					dl := dl |<< 1
					count := count + 1
				end
				from
				until
					count = 0
				loop
					dl := (dh |<< (limb_bits - 1)).bit_or (dl |>> 1)
					dh := dh |>> 1
					q := q |<< 1
					if nh.item > dh or (nh.item = dh and nl.item >= dl) then
						sub_ddmmss (nh, nl, nh.item, nl.item, dh, dl)
						q := q.bit_or (1)
					end
					count := count - 1
				end
			end
			r0.put (nl.item)
			r1.put (nh.item)
			Result := q
		end

	mul_2 (rp: SPECIAL [NATURAL_32]; rp_offset: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; n: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER)
		local
			bh: NATURAL_32
			bl: NATURAL_32
			cy: NATURAL_32
			hi: CELL [NATURAL_32]
			lo: CELL [NATURAL_32]
			sh: CELL [NATURAL_32]
			sl: CELL [NATURAL_32]
			th: CELL [NATURAL_32]
			tl: CELL [NATURAL_32]
			i: INTEGER
		do
			create hi.put (0)
			create lo.put (0)
			create sh.put (0)
			create sl.put (0)
			create tl.put (0)
			create th.put (0)
			bl := bp [bp_offset]
			umul_ppmm (hi, lo, bl, ap [ap_offset])
			rp [rp_offset] := lo.item
			bh := bp [bp_offset + 1]
			from
				i := 1
				cy := 0
			until
				i >= n
			loop
				umul_ppmm (sh, sl, bh, ap [ap_offset + i - 1])
				umul_ppmm (th, tl, bl, ap [ap_offset + i])
				add_ssaaaa (sh, sl, sh.item, sl.item, cy, hi.item)
				add_ssaaaa (hi, lo, th.item, tl.item, sh.item, sl.item)
				rp [rp_offset + i] := lo.item
				cy := (hi.item < th.item).to_integer.to_natural_32
				i := i + 1
			end
			umul_ppmm (sh, sl, bh, ap [ap_offset + n - 1])
			add_ssaaaa (hi, lo, sh.item, sl.item, cy, hi.item)
			rp [rp_offset + n + 1] := hi.item
			rp [rp_offset + n] := lo.item
		end

	ngcd_matrix1_adjust (m: SPECIAL [NATURAL_32]; n_a: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER; p: INTEGER; tp: SPECIAL [NATURAL_32]; tp_offset: INTEGER): INTEGER
		local
			ah: NATURAL_32
			bh: NATURAL_32
			cy: NATURAL_32
			n: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n := n_a
			tp.copy_data (ap, ap_offset, tp_offset, p)
			mul_1 (ap, ap_offset, ap, ap_offset, p, m [3], carry)
			ah := carry.item
			submul_1 (ap, ap_offset, bp, bp_offset, p, m [1], carry)
			cy := carry.item
			if cy > ah then
				decr_u (ap, ap_offset + p, cy - ah)
				ah := 0
			else
				ah := ah - cy
				if ah > 0 then
					add_1 (ap, ap_offset + p, ap, ap_offset + p, n, ah, carry)
					ah := carry.item
				end
			end
			mul_1 (bp, bp_offset, bp, bp_offset, p, m [0], carry)
			bh := carry.item
			submul_1 (bp, bp_offset, tp, tp_offset, p, m [2], carry)
			cy := carry.item
			if cy > bh then
				decr_u (bp, bp_offset + p, cy - bh)
				bh := 0
			else
				bh := bh - cy
				if bh > 0 then
					add_1 (bp, bp_offset + p, bp, bp_offset + p, n, bh, carry)
					bh := carry.item
				end
			end
			n := n + p
			if ah > 0 or bh > 0 then
				ap [ap_offset + n] := ah
				bp [bp_offset + n] := bh
				n := n + 1
			else
				if ap [ap_offset + n - 1] = 0 and bp [bp_offset + n - 1] = 0 then
					n := n - 1
				end
			end
			Result := n
		end

	ngcd_matrix2_adjust (m: SPECIAL [NATURAL_32]; n_a: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER; p: INTEGER; tp: SPECIAL [NATURAL_32]; tp_offset: INTEGER): INTEGER
		local
			t0: SPECIAL [NATURAL_32]
			t0_offset: INTEGER
			t1: SPECIAL [NATURAL_32]
			t1_offset: INTEGER
			ah: NATURAL_32
			bh: NATURAL_32
			cy: NATURAL_32
			n: INTEGER
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			n := n_a
			t0 := tp
			t0_offset := tp_offset
			t1 := tp
			t1_offset := tp_offset + p + 2
			mul_2 (t0, t0_offset, ap, ap_offset, p, m, 3)
			mul_2 (t1, t1_offset, ap, ap_offset, p, m, 2)
			ap.copy_data (t0, t0_offset, ap_offset, p)
			add (ap, ap_offset + p, ap, ap_offset + p, n, t0, t0_offset + p, 2, carry)
			ah := carry.item
			mul (t0, t0_offset, bp, bp_offset, p, m, 1, 2, carry)
			junk := carry.item
			sub (ap, ap_offset, ap, ap_offset, n + p, t0, t0_offset, p + 2, carry)
			cy := carry.item
			ah := ah - cy
			mul (t0, t0_offset, bp, bp_offset, p, m, 0, 2, carry)
			junk := carry.item
			bp.copy_data (t0, t0_offset, bp_offset, p)
			add (bp, bp_offset + p, bp, bp_offset + p, n, t0, t0_offset + p, 2, carry)
			bh := carry.item
			sub (bp, bp_offset, bp, bp_offset, n + p, t1, t1_offset, p + 2, carry)
			cy := carry.item
			bh := bh - cy
			n := n + p
			if ah > 0 or bh > 0 then
				ap [ap_offset + n] := ah
				bp [bp_offset + n] := bh
				n := n + 1
			else
				if ap [ap_offset + n - 1] = 0 and bp [bp_offset + n - 1] = 0 then
					n := n - 1
				end
			end
			Result := n
		end

	ngcd_lehmer (gp: SPECIAL [NATURAL_32]; gp_offset: INTEGER; ap_a: SPECIAL [NATURAL_32]; ap_offset_a: INTEGER; bp_a: SPECIAL [NATURAL_32]; bp_offset_a: INTEGER; n_a: INTEGER; tp: SPECIAL [NATURAL_32]; tp_offset: INTEGER): INTEGER
		local
			gn: TUPLE [gn: INTEGER]
			n: INTEGER
			m1: SPECIAL [NATURAL_32]
			m2: SPECIAL [NATURAL_32]
			p: INTEGER
			res: TUPLE [res: INTEGER]
			nn: INTEGER
			m: SPECIAL [NATURAL_32]
			ah: NATURAL_32
			al: NATURAL_32
			bh: NATURAL_32
			bl: NATURAL_32
			mask: NATURAL_32
			shift: INTEGER
			tmp_special: SPECIAL [NATURAL_32]
			tmp_integer: INTEGER
			r: INTEGER
			ap: SPECIAL [NATURAL_32]
			ap_offset: INTEGER
			bp: SPECIAL [NATURAL_32]
			bp_offset: INTEGER
			done: BOOLEAN
		do
			ap := ap_a
			ap_offset := ap_offset_a
			bp := bp_a
			bp_offset := bp_offset_a
			create gn
			create res
			n := n_a
			create m1.make_filled (0, 4)
			create m2.make_filled (0, 4)
			create m.make_filled (0, 4)
			from
			until
				n < 7
			loop
				p := n - 5
				nn := nhgcd5 (ap, ap_offset + p, bp, bp_offset + p, res, m1, m2)
				inspect res.res
				when 0 then
					n := ngcd_subdiv_step (gp, gp_offset, gn, ap, ap_offset, bp, bp_offset, n, tp, tp_offset)
				when 1 then
					n := ngcd_matrix1_adjust (m1, nn, ap, ap_offset, bp, bp_offset, p, tp, tp_offset)
				when 2 then
					n := ngcd_matrix2_adjust (m2, nn, ap, ap_offset, bp, bp_offset, p, tp, tp_offset)
				end
			end
			from
			until
				n <= 2 or done
			loop
				mask := ap [ap_offset + n - 1].bit_or (bp [bp_offset + n - 1])
				if mask.bit_test (limb_high_bit) then
					ah := ap [ap_offset + n - 1]
					al := ap [ap_offset + n - 2]
					bh := bp [bp_offset + n - 1]
					bl := bp [bp_offset + n - 2]
				else
					shift := leading_zeros (mask)
					ah := extract_limb (shift, ap [ap_offset + n - 1], ap [ap_offset + n - 2])
					al := extract_limb (shift, ap [ap_offset + n - 2], ap [ap_offset + n - 3])
					bh := extract_limb (shift, bp [bp_offset + n - 1], bp [bp_offset + n - 2])
					bl := extract_limb (shift, bp [bp_offset + n - 2], bp [bp_offset + n - 3])
				end
				if nhgcd2 (ah, al, bh, bl, m) then
					n := ngcd_matrix1_vector (m, n, ap, ap_offset, bp, bp_offset, tp, tp_offset)
				else
					n := ngcd_subdiv_step (gp, gp_offset, gn, ap, ap_offset, bp, bp_offset, n, tp, tp_offset)
					if n = 0 then
						Result := gn.gn
						done := True
					end
				end
			end
			if not done then
				if n = 1 then
					gp [gp_offset] := gcd_1 (ap, ap_offset, 1, bp [bp_offset])
					Result := 1
				else
					if not ap [ap_offset].bit_test (0) then
						tmp_special := ap
						ap := bp
						bp := tmp_special
						tmp_integer := ap_offset
						ap_offset := bp_offset
						bp_offset := tmp_integer
					end
					if bp [bp_offset] = 0 then
						gp [gp_offset] := gcd_1 (ap, ap_offset, 2, bp [bp_offset + 1])
						Result := 1
					else
						if not bp [bp_offset].bit_test (0) then
							r := trailing_zeros (bp [bp_offset])
							bp [bp_offset] := (bp [bp_offset + 1] |<< (limb_bits - r)).bit_or (bp [bp_offset] |>> r)
							bp [bp_offset + 1] := bp [bp_offset + 1] |>> r
						end
						n := gcd_2 (ap, ap_offset, bp, bp_offset)
						gp.copy_data (ap, ap_offset, gp_offset, n)
						Result := n
					end
				end
			end
		ensure
			Result > 0
			Result <= n_a
		end

	nhgcd5 (ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; bp: SPECIAL [NATURAL_32]; bp_offset: INTEGER; res: TUPLE [res: INTEGER]; m1: SPECIAL [NATURAL_32]; m: SPECIAL [NATURAL_32]): INTEGER_32
		local
			m2: SPECIAL [NATURAL_32]
			t: SPECIAL [NATURAL_32]
			n: INTEGER
			ah: NATURAL_32
			al: NATURAL_32
			bh: NATURAL_32
			bl: NATURAL_32
			mask: NATURAL_32
			shift: INTEGER
			ph: CELL [NATURAL_32]
			pl: CELL [NATURAL_32]
		do
			create ph.put (0)
			create pl.put (0)
			create t.make_filled (0, 5)
			create m2.make_filled (0, 4)
			mask := ap [ap_offset + 4].bit_or (bp [bp_offset + 4])
			if mask.bit_test (31) then
				ah := ap [ap_offset + 4]
				al := ap [ap_offset + 3]
				bh := bp [bp_offset + 4]
				bl := bp [bp_offset + 3]
			else
				shift := leading_zeros (mask)
				ah := extract_limb (shift, ap [ap_offset + 4], ap [ap_offset + 3])
				al := extract_limb (shift, ap [ap_offset + 3], ap [ap_offset + 2])
				bh := extract_limb (shift, bp [bp_offset + 4], bp [bp_offset + 3])
				bl := extract_limb (shift, bp [bp_offset + 3], bp [bp_offset + 2])
			end
			if nhgcd2 (ah, al, bh, bl, m1) then
				res.res := 0
				Result := 0
			else
				n := ngcd_matrix1_vector (m1, 5, ap, ap_offset, bp, bp_offset, t, 0)
				mask := ap [ap_offset + n - 1].bit_or (bp [bp_offset + n - 1])
				if mask.bit_test (31) then
					ah := ap [ap_offset + n - 1]
					al := ap [ap_offset + n - 2]
					bh := bp [bp_offset + n - 1]
					bl := bp [bp_offset + n - 2]
				else
					shift := leading_zeros (mask)
					ah := extract_limb (shift, ap [ap_offset + n - 1], ap [ap_offset + n - 2])
					al := extract_limb (shift, ap [ap_offset + n - 2], ap [ap_offset + n - 3])
					bh := extract_limb (shift, bp [bp_offset + n - 1], bp [bp_offset + n - 2])
					bl := extract_limb (shift, bp [bp_offset + n - 2], bp [bp_offset + n - 3])
				end
				if not nhgcd2 (ah, al, bh, bl, m2) then
					res.res := 1
					Result := n
				else
					n := ngcd_matrix1_vector (m2, n, ap, ap_offset, bp, bp_offset, t, 0)
					dotmul_ppxxyy (ph, pl, m1 [0], m1 [1], m2 [0], m2 [2])
					m [1] := ph.item
					m [0] := pl.item
					dotmul_ppxxyy (ph, pl, m1 [0], m1 [1], m2 [1], m2 [3])
					m [3] := ph.item
					m [2] := pl.item
					dotmul_ppxxyy (ph, pl, m1 [2], m1 [3], m2 [0], m2 [2])
					m [5] := ph.item
					m [4] := pl.item
					dotmul_ppxxyy (ph, pl, m1 [2], m1 [3], m2 [1], m2 [3])
					m [7] := ph.item
					m [6] := pl.item
					res.res := 2
					Result := n
				end
			end
		end

	dotmul_ppxxyy (ph: CELL [NATURAL_32]; pl: CELL [NATURAL_32]; x1: NATURAL_32; x2: NATURAL_32; y1: NATURAL_32; y2: NATURAL_32)
		local
			dotmul_sh: CELL [NATURAL_32]
			dotmul_sl: CELL [NATURAL_32]
			dotmul_th: CELL [NATURAL_32]
			dotmul_tl: CELL [NATURAL_32]
			sh: CELL [NATURAL_32]
			sl: CELL [NATURAL_32]
		do
			create dotmul_sh.put (0)
			create dotmul_sl.put (0)
			create dotmul_th.put (0)
			create dotmul_tl.put (0)
			create sh.put (0)
			create sl.put (0)

			umul_ppmm (dotmul_sh, dotmul_sl, x1, y1)
			umul_ppmm (dotmul_th, dotmul_tl, x2, y2)
			add_ssaaaa (sh, sl, dotmul_sh.item, dotmul_sl.item, dotmul_th.item, dotmul_tl.item)
			ph.put (sh.item)
			pl.put (sl.item)
		end
end
