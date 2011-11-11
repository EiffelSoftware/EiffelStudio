note
	description: "Summary description for {INTEGER_X_NUMBER_THEORY}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Gun registration is a gateway drug. - Mark Gilmore"

deferred class
	INTEGER_X_NUMBER_THEORY

inherit
	INTEGER_X_FACILITIES
	SPECIAL_ARITHMETIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		end
	SPECIAL_DIVISION
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			tdiv_qr as tdiv_qr_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		end
	SPECIAL_NUMBER_THEORETIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			tdiv_qr as tdiv_qr_special,
			gcdext as gcdext_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special,
			invert_gf as invert_gf_special
		export
			{NONE}
				all
		end
	INTEGER_X_ACCESS
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			tdiv_qr as tdiv_qr_special,
			sizeinbase as sizeinbase_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_ARITHMETIC
		rename
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_ASSIGNMENT
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_COMPARISON
	INTEGER_X_LOGIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special
		end
	INTEGER_X_DIVISION
		rename
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_RANDOM
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_GCD
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			tdiv_qr as tdiv_qr_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		end
	INTEGER_X_SIZING

feature

	millerrabin_test (n: READABLE_INTEGER_X; nm1: READABLE_INTEGER_X; x: READABLE_INTEGER_X; y: READABLE_INTEGER_X; q: READABLE_INTEGER_X; k: INTEGER): INTEGER
		local
			i: INTEGER
		do
			powm (y, x, q, n)
			if cmp_ui (y, 1) = 0 or compare (y, nm1) = 0 then
				Result := 1
			else
				from
					i := 1
					Result := -1
				until
					Result /= -1 or i >= k
				loop
					powm_ui (y, y, 2, n)
					if compare (y, nm1) = 0 then
						Result := 1
					elseif cmp_ui (y, 1) = 0 then
						Result := 0
					end
					i := i + 1
				end
				if Result = -1 then
					Result := 0
				end
			end
		end

	bin_uiui (target: READABLE_INTEGER_X; n_a: NATURAL_32; k_a: NATURAL_32)
			-- Compute the binomial coefficient `n' over `k' and store the result in `rop'.
		local
			i: NATURAL_32
			j: NATURAL_32
			cnt: NATURAL_32
			n1: CELL [NATURAL_32]
			n0: CELL [NATURAL_32]
			k0: NATURAL_32
--			t: NATURAL_64
			k: NATURAL_32
			n: NATURAL_32
			rsize: CELL [INTEGER]
			ralloc: CELL [INTEGER]
			nacc: CELL [NATURAL_32]
			kacc: CELL [NATURAL_32]
		do
			create n0.put (0)
			create n1.put (0)
			create rsize.put (0)
			create ralloc.put (0)
			create nacc.put (0)
			create kacc.put (0)
			n := n_a
			k := k_a
			if n < k then
				target.count := 0
			else
				k := k.min (n - k)
				if k = 0 then
					target.count := 1
					target.item [0] := 1
				else
					j := n - k + 1
					target.item [0] := j
					target.count := 1
					ralloc.put (target.capacity)
					nacc.put (1)
					kacc.put (1)
					cnt := 0
					from
						i := 2
					until
						i > k
					loop
						j := j + 1
						cnt := nacc.item.bit_or (kacc.item).bit_and (1).bit_xor (1)
						nacc.put (nacc.item |>> cnt.to_integer_32)
						kacc.put (kacc.item |>> cnt.to_integer_32)
						umul_ppmm (n1, n0, nacc.item, j)
						k0 := kacc.item * i
						if n1.item /= 0 then
							muldiv (target, 32, rsize, ralloc, nacc, kacc)
							nacc.put (j)
							kacc.put (i)
						else
							nacc.put (n0.item)
							kacc.put (k0)
						end
						i := i + 1
					end
					muldiv (target, 1, rsize, ralloc, nacc, kacc)
					target.count := rsize.item
				end
			end
		end

	gcdext (g: READABLE_INTEGER_X; s: detachable READABLE_INTEGER_X; t: detachable READABLE_INTEGER_X; a: READABLE_INTEGER_X; b: READABLE_INTEGER_X)
			-- Set `g' to the greatest common divisor of `a' and `b', and in addition set `s' and `t' to
			-- coefficients satisfying `a*s + b*t = g'.
			-- `g' is always positive, even if one or both of `a' and `b' are negative.
			-- If `t' is NULL then that value is not computed.
		local
			asize: INTEGER
			bsize: INTEGER
			usize: INTEGER
			vsize: INTEGER
			ap: SPECIAL [NATURAL_32]
			ap_offset: INTEGER
			bp: SPECIAL [NATURAL_32]
			bp_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			vp: SPECIAL [NATURAL_32]
			vp_offset: INTEGER
			gsize: INTEGER
			ssize: INTEGER
			tmp_ssize: TUPLE [tmp_ssize: INTEGER]
			gp: SPECIAL [NATURAL_32]
			sp: SPECIAL [NATURAL_32]
			tmp_gp: SPECIAL [NATURAL_32]
			tmp_gp_offset: INTEGER
			tmp_sp: SPECIAL [NATURAL_32]
			tmp_sp_offset: INTEGER
			u: READABLE_INTEGER_X
			v: READABLE_INTEGER_X
			ss: detachable READABLE_INTEGER_X
			tt: detachable READABLE_INTEGER_X
			gtmp: INTEGER_X
			stmp: INTEGER_X
			x: INTEGER_X
		do
			create tmp_ssize
			asize := a.count.abs
			bsize := b.count.abs
			ap := a.item
			bp := b.item
			if asize > bsize or (asize = bsize and cmp_special (ap, ap_offset, bp, bp_offset, asize) > 0) then
				usize := asize
				vsize := bsize
				create up.make_filled (0, usize + 1)
				create vp.make_filled (0, vsize + 1)
				up.copy_data (ap, ap_offset, up_offset, usize)
				vp.copy_data (bp, bp_offset, vp_offset, vsize)
				u := a
				v := b
				ss := s
				tt := t
			else
				usize := bsize
				vsize := asize
				create up.make_filled (0, usize + 1)
				create vp.make_filled (0, vsize + 1)
				up.copy_data (bp, bp_offset, up_offset, usize)
				vp.copy_data (ap, ap_offset, vp_offset, vsize)
				u := b
				v := a
				ss := t
				tt := s
			end
			create tmp_gp.make_filled (0, usize + 1)
			create tmp_sp.make_filled (0, usize + 1)
			if vsize = 0 then
				tmp_sp [tmp_sp_offset] := 1
				tmp_ssize.tmp_ssize := 1
				tmp_gp.copy_data (up, up_offset, tmp_gp_offset, usize)
				gsize := usize
			else
				gsize := gcdext_special (tmp_gp, tmp_gp_offset, tmp_sp, tmp_sp_offset, tmp_ssize, up, up_offset, usize, vp, vp_offset, vsize)
			end
			ssize := tmp_ssize.tmp_ssize.abs
			create gtmp
			gtmp.item := tmp_gp
			gtmp.count := gsize
			create stmp
			stmp.item := tmp_sp
			if tmp_ssize.tmp_ssize.bit_xor (u.count) >= 0 then
				stmp.count := ssize
			else
				stmp.count := -ssize
			end
			if attached {READABLE_INTEGER_X} tt as tt_l then
				if v.count = 0 then
					tt_l.count := 0
				else
					create x.make_limbs (ssize + usize + 1)
					mul (x, stmp, u)
					sub (x, gtmp, x)
					tdiv_q (tt_l, x, v)
				end
			end
			if attached {READABLE_INTEGER_X} ss as ss_l then
				ss_l.resize (ssize)
				sp := ss_l.item
				sp.copy_data (tmp_sp, tmp_sp_offset, 0, ssize)
				ss_l.count := stmp.count
			end
			g.resize (gsize)
			gp := g.item
			gp.copy_data (tmp_gp, tmp_gp_offset, 0, gsize)
			g.count := gsize
		end

	invert (target: READABLE_INTEGER_X; x: READABLE_INTEGER_X; n: READABLE_INTEGER_X): BOOLEAN
		local
			gcd_l: INTEGER_X
			tmp: INTEGER_X
			xsize: INTEGER_32
			nsize: INTEGER_32
			size: INTEGER_32
		do
			xsize := x.count.abs
			nsize := n.count.abs
			size := xsize.max (nsize) + 1
			if xsize = 0 or (nsize = 1 and n.item [0] = 1) then
				Result := False
			else
				create gcd_l.make_limbs (size)
				create tmp.make_limbs (size)
				gcdext (gcd_l, tmp, void, x, n)
				if gcd_l.count /= 1 or gcd_l.item [0] /= 1 then
					Result := False
				else
					if tmp.count < 0 then
						if n.count < 0 then
							sub (target, tmp, n)
						else
							add (target, tmp, n)
						end
					else
						target.copy (tmp)
					end
					Result := True
				end
			end
		end

	millerrabin (source: READABLE_INTEGER_X; reps: INTEGER): INTEGER
		local
			r: INTEGER
			nm1: INTEGER_X
			nm3: INTEGER_X
			x: INTEGER_X
			y: INTEGER_X
			q: INTEGER_X
			k: INTEGER
			is_prime: INTEGER
			rstate: MERSENNE_TWISTER_RNG
		do
			create nm1.make_limbs (source.count + 1)
			sub_ui (nm1, source, 1)
			create x.make_limbs (source.count + 1)
			create y.make_limbs (2 * source.count)
			x.set_from_natural_32 (210)
			powm (y, x, nm1, source)
			if cmp_ui (y, 1) /= 0 then
				Result := 0
			else
				create q.make_limbs (source.count)
				k := bit_scan_1 (nm1, 0)
				tdiv_q_2exp (q, nm1, k)
				create nm3.make_limbs (source.count + 1)
				sub_ui (nm3, source, 3)
				create rstate.make
				is_prime := 1
				from
					r := 0
				until
					r >= reps or is_prime = 0
				loop
					urandomm (x, rstate, nm3)
					add_ui (x, x, 2)
					is_prime := millerrabin_test (source, nm1, x, y, q, k)
					r := r + 1
				end
				Result := is_prime
			end
		end

	powm (r: READABLE_INTEGER_X; b_a: READABLE_INTEGER_X; e: READABLE_INTEGER_X; m: READABLE_INTEGER_X)
		local
			xp: SPECIAL [NATURAL_32]
			xp_offset: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			qp: SPECIAL [NATURAL_32]
			qp_offset: INTEGER
			gp: SPECIAL [NATURAL_32]
			gp_offset: INTEGER
			this_gp: SPECIAL [NATURAL_32]
			this_gp_offset: INTEGER
			bp: SPECIAL [NATURAL_32]
			bp_offset: INTEGER
			ep: SPECIAL [NATURAL_32]
			ep_offset: INTEGER
			mp: SPECIAL [NATURAL_32]
			mp_offset: INTEGER
			bn: INTEGER
			es: INTEGER
			en: INTEGER
			mn: INTEGER
			xn: INTEGER
			invm: NATURAL_32
			c: NATURAL_32
			enb: INTEGER
			i: INTEGER
			big_k: INTEGER
			j: INTEGER
			l: INTEGER
			small_k: INTEGER
			m_zero_cnt: INTEGER
			e_zero_cnt: INTEGER
			sh: INTEGER
			use_redc: BOOLEAN
			new_b: INTEGER_X
			b: READABLE_INTEGER_X
			new_mp: SPECIAL [NATURAL_32]
			new_mp_offset: INTEGER
			junk: NATURAL_32
			cy: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			b := b_a
			mp := m.item
			mn := m.count.abs
			if mn = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			es := e.count
			if es = 0 then
				if mn = 1 and mp [mp_offset] = 1 then
					r.count := 0
				else
					r.count := 1
				end
				r.item [0] := 1
			else
				if es < 0 then
					create new_b.make_limbs (mn + 1)
					if not invert (new_b, b, m) then
						(create {INVERSE_EXCEPTION}).raise
					end
					b := new_b
					es := -es
				end
				en := es
				use_redc := (mn < 170) and (mp [mp_offset] \\ 2 /= 0)
				if use_redc then
					invm := modlimb_invert (mp [mp_offset])
					invm := 0 - invm
				else
					m_zero_cnt := leading_zeros (mp [mp_offset + mn - 1])
					if m_zero_cnt /= 0 then
						create new_mp.make_filled (0, mn)
						lshift (new_mp, new_mp_offset, mp, mp_offset, mn, m_zero_cnt, carry)
						junk := carry.item
						mp := new_mp
						mp_offset := new_mp_offset
					end
				end
				e_zero_cnt := leading_zeros (e.item [en - 1])
				enb := en * limb_bits - e_zero_cnt
				small_k := 1
				big_k := 2
				from
				until
					small_k = 10 or 2 * enb <= big_k * (2 + small_k * (3 + small_k))
				loop
					small_k := small_k + 1
					big_k := big_k * 2
				end
				create tp.make_filled (0, 2 * mn)
				create qp.make_filled (0, mn + 1)
				create gp.make_filled (0, big_k // 2 * mn)
				bn := b.count.abs
				bp := b.item
				if bn > mn or (bn = mn and cmp_special (bp, bp_offset, mp, mp_offset, mn) >= 0) then
					if use_redc then
						reduce (tp, tp_offset + mn, bp, bp_offset, bn, mp, mp_offset, mn)
						tp.fill_with (0, tp_offset, mn - tp_offset - 1)
						tdiv_qr_special (qp, qp_offset, gp, gp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
					else
						reduce (gp, gp_offset, bp, bp_offset, bn, mp, mp_offset, mn)
					end
				else
					if use_redc then
						tp.copy_data (bp, bp_offset, tp_offset + mn, bn)
						tdiv_qr_special (qp, qp_offset, gp, gp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
					else
						gp.copy_data (bp, bp_offset, gp_offset, bn)
						gp.fill_with (0, gp_offset + bn, mn - bn - gp_offset - 1)
					end
				end
				create xp.make_filled (0, mn)
				sqr_n (tp, tp_offset, gp, gp_offset, mn)
				if use_redc then
					redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
				else
					tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
				end
				this_gp := gp
				this_gp_offset := gp_offset
				from
					i := 1
				until
					i >= big_k // 2
				loop
					mul_n (tp, tp_offset, this_gp, this_gp_offset, xp, xp_offset, mn)
					this_gp_offset := this_gp_offset + mn
					if use_redc then
						redc_basecase (this_gp, this_gp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
					else
						tdiv_qr_special (qp, qp_offset, this_gp, this_gp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
					end
					i := i + 1
				end
				ep := e.item
				i := en - 1
				c := ep [ep_offset + i]
				sh := limb_bits - e_zero_cnt
				sh := sh - small_k
				if sh < 0 then
					if i > 0 then
						i := i - 1
						c := c |<< (-sh)
						sh := sh + limb_bits
						c := c.bit_or (ep [ep_offset + i] |>> sh)
					end
				else
					c := c |>> sh
				end
				from
					j := 0
				until
					c \\ 2 /= 0
				loop
					c := c |>> 1
					j := j + 1
				end
				xp.copy_data (gp, gp_offset + mn * (c |>> 1).to_integer_32, xp_offset, mn)
				from
					j := j - 1
				until
					j < 0
				loop
					sqr_n (tp, tp_offset, xp, xp_offset, mn)
					if use_redc then
						redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
					else
						tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
					end
					j := j - 1
				end
				from
				until
					i <= 0 and sh <= 0
				loop
					c := ep [ep_offset + i]
					l := small_k
					sh := sh - l
					if sh < 0 then
						if i > 0 then
							i := i - 1
							c := c |<< (-sh)
							sh := sh + limb_bits
							c := c.bit_or (ep [ep_offset + i] |>> sh)
						else
							l := l + sh
						end
					else
						c := c |>> sh
					end
					c := c.bit_and (((1).to_natural_32 |<< l) - 1)
					from
					until
						(c |>> (l - 1)) /= 0 or (i <= 0 and sh <= 0)
					loop
						sqr_n (tp, tp_offset, xp, xp_offset, mn)
						if use_redc then
							redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
						else
							tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
						end
						if sh /= 0 then
							sh := sh - 1
							c := (c |<< 1) + ((ep [ep_offset + i] |>> sh).bit_and (1))
						else
							i := i - 1
							sh := limb_bits - 1
							c := (c |<< 1) + (ep [ep_offset + i] |>> sh)
						end
					end
					if c /= 0 then
						from
							j := 0
						until
							c \\ 2 /= 0
						loop
							c := c |>> 1
							j := j + 1
						end
						l := l - j
						from
							l := l - 1
						until
							l < 0
						loop
							sqr_n (tp, tp_offset, xp, xp_offset, mn)
							if use_redc then
								redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
							else
								tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
							end
							l := l - 1
						end
						mul_n (tp, tp_offset, xp, xp_offset, gp, gp_offset + mn * (c |>> 1).to_integer_32, mn)
						if use_redc then
							redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
						else
							tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
						end
					else
						j := l
					end
					from
						j := j - 1
					until
						j < 0
					loop
						sqr_n (tp, tp_offset, xp, xp_offset, mn)
						if use_redc then
							redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
						else
							tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, 2 * mn, mp, mp_offset, mn)
						end
						j := j - 1
					end
				end
				if use_redc then
					tp.copy_data (xp, xp_offset, tp_offset, mn)
					tp.fill_with (0, tp_offset + mn, tp_offset + mn + mn - 1)
					redc_basecase (xp, xp_offset, mp, mp_offset, mn, invm, tp, tp_offset)
					if cmp_special (xp, xp_offset, mp, mp_offset, mn) >= 0 then
						sub_n (xp, xp_offset, xp, xp_offset, mp, mp_offset, mn, carry)
						junk := carry.item
					end
				else
					if m_zero_cnt /= 0 then
						lshift (tp, tp_offset, xp, xp_offset, mn, m_zero_cnt, carry)
						cy := carry.item
						tp [tp_offset + mn] := cy
						tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, mn + (cy /= 0).to_integer, mp, mp_offset, mn)
						rshift (xp, xp_offset, xp, xp_offset, mn, m_zero_cnt, carry)
						junk := carry.item
					end
				end
				xn := mn
				xn := normalize (xp, xp_offset, xn)
				if ep [ep_offset].bit_and (1) /= 0 and b.count < 0 and xn /= 0 then
					mp := m.item
					sub_special (xp, xp_offset, mp, mp_offset, mn, xp, xp_offset, xn, carry)
					junk := carry.item
					xn := mn
					xn := normalize (xp, xp_offset, xn)
				end
				r.resize (xn)
				r.count := xn
				r.item.copy_data (xp, xp_offset, 0, xn)
			end
		end

	powm_ui (target: READABLE_INTEGER_X; b: READABLE_INTEGER_X; el: NATURAL_32; m: READABLE_INTEGER_X)
		local
			xp: SPECIAL [NATURAL_32]
			xp_offset: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			qp: SPECIAL [NATURAL_32]
			qp_offset: INTEGER
			mp: SPECIAL [NATURAL_32]
			mp_offset: INTEGER
			bp: SPECIAL [NATURAL_32]
			bp_offset: INTEGER
			xn: INTEGER
			tn: INTEGER
			mn: INTEGER
			bn: INTEGER
			m_zero_count: INTEGER
			c: INTEGER
			e: NATURAL_32
			new_mp: SPECIAL [NATURAL_32]
			junk: NATURAL_32
			new_bp: SPECIAL [NATURAL_32]
			cy: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			mp := m.item
			mn := m.count.abs
			if mn = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			if el = 0 then
				target.count := (not (mn = 1 and then mp [mp_offset] = 1)).to_integer
				target.item [0] := 1
			else
				m_zero_count := leading_zeros (mp [mp_offset + mn - 1])
				if m_zero_count /= 0 then
					create new_mp.make_filled (0, mn)
					lshift (new_mp, 0, mp, mp_offset, mn, m_zero_count, carry)
					junk := carry.item
					mp := new_mp
				end
				bn := b.count.abs
				bp := b.item
				if bn > mn then
					create new_bp.make_filled (0, mn)
					reduce (new_bp, 0, bp, bp_offset, bn, mp, mp_offset, mn)
					bp := new_bp
					bn := mn
					bn := normalize (bp, 0, bn)
				end
				if bn = 0 then
					target.count := 0
				else
					create tp.make_filled (0, 2 * mn + 1)
					create xp.make_filled (0, mn)
					create qp.make_filled (0, mn + 1)
					xp.copy_data (bp, bp_offset, xp_offset, bn)
					xn := bn
					e := el
					c := leading_zeros (e)
					e := (e |<< c) |<< 1
					c := limb_bits - 1 - c
					if c = 0 and then xn = mn and cmp_special (xp, xp_offset, mp, mp_offset, mn) >= 0 then
						sub_n (xp, xp_offset, xp, xp_offset, mp, mp_offset, mn, carry)
						junk := carry.item
					else
						from
						until
							c = 0
						loop
							sqr_n (tp, tp_offset, xp, xp_offset, xn)
							tn := 2 * xn
							tn := tn - (tp [tp_offset + tn - 1] = 0).to_integer
							if tn < mn then
								xp.copy_data (tp, tp_offset, xp_offset, tn)
								xn := tn
							else
								tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, tn, mp, mp_offset, mn)
								xn := mn
							end
							if e.to_integer_32 < 0 then
								mul_special (tp, tp_offset, xp, xp_offset, xn, bp, bp_offset, bn, carry)
								junk := carry.item
								tn := xn + bn
								tn := tn - (tp [tp_offset + tn - 1] = 0).to_integer
								if tn < mn then
									xp.copy_data (tp, tp_offset, xp_offset, tn)
									xn := tn
								else
									tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, tn, mp, mp_offset, mn)
									xn := mn
								end
							end
							e := e |<< 1
							c := c - 1
						end
					end
					if m_zero_count /= 0 then
						lshift (tp, tp_offset, xp, xp_offset, xn, m_zero_count, carry)
						cy := carry.item
						tp [tp_offset + xn] := cy
						xn := xn + (cy /= 0).to_integer
						if xn < mn then
							xp.copy_data (tp, tp_offset, xp_offset, xn)
						else
							tdiv_qr_special (qp, qp_offset, xp, xp_offset, tp, tp_offset, xn, mp, mp_offset, mn)
							xn := mn
						end
						rshift (xp, xp_offset, xp, xp_offset, xn, m_zero_count, carry)
						junk := carry.item
					end
					xn := normalize (xp, xp_offset, xn)
					if el.bit_test (0) and b.count < 0 and xn /= 0 then
						mp := m.item
						mp_offset := 0
						sub_special (xp, xp_offset, mp, mp_offset, mn, xp, xp_offset, xn, carry)
						junk := carry.item
						xn := mn
						xn := normalize (xp, xp_offset, xn)
					end
					target.resize (xn)
					target.count := xn
					target.item.copy_data (xp, xp_offset, 0, xn)
				end
			end
		end

	probab_prime_isprime (t: NATURAL_32): BOOLEAN
		local
			q: NATURAL_32
			r: NATURAL_32
			d: NATURAL_32
		do
			if t < 3 or not t.bit_test (0) then
				Result := t = 2
			else
				from
					d := 3
					r := 1
					q := d
				until
					Result or r = 0
				loop
					q := t // d
					r := t - q * d
					Result := (q < d)
					d := d + 2
				end
			end
		end

	probab_prime_p (op1_a: READABLE_INTEGER_X; reps: INTEGER): INTEGER
		local
			r: NATURAL_32
			n2: INTEGER_X
			is_prime: BOOLEAN
			op1: READABLE_INTEGER_X
			done: BOOLEAN
			ln2: NATURAL_32
			q: NATURAL_32
			p1: CELL [NATURAL_32]
			p0: CELL [NATURAL_32]
			p: NATURAL_32
			primes: SPECIAL [NATURAL_32]
			nprimes: INTEGER
		do
			create p1.put (0)
			create p0.put (0)
			create primes.make_filled (0, 15)
			op1 := op1_a
			create n2
			if cmp_ui (op1, 1_000_000) <= 0 then
				if cmpabs_ui (op1, 1_000_000) <= 0 then
					is_prime := probab_prime_isprime (op1.as_natural_32)
					if is_prime then
						Result := 2
					else
						Result := 0
					end
					done := True
				else
					n2.item := op1.item
					n2.count := -op1.count
					op1 := n2
				end
			end
			if not done then
				if not op1.as_natural_32.bit_test (0) then
					done := True
				end
			end
			if not done then
				r := preinv_mod_1 (op1.item, 0, op1.count, pp, pp_inverted)
				if r \\ 3 = 0 or r \\ 5 = 0 or r \\ 7 = 0 or r \\ 11 = 0 or r \\ 13 = 0 or r \\ 17 = 0 or r \\ 19 = 0 or r \\ 23 = 0 or r \\ 29 = 0 then
					Result := 0
					done := True
				end
			end
			if not done then
				nprimes := 0
				p := 1
				ln2 := sizeinbase (op1, 2).to_natural_32
				from
					q := pp_first_omitted.to_natural_32
				until
					q >= ln2 or done
				loop
					if probab_prime_isprime (q) then
						umul_ppmm (p1, p0, p, q)
						if p1.item /= 0 then
							r := modexact_1c_odd (op1.item, 0, op1.count, p, 0)
							from
								nprimes := nprimes - 1
							until
								nprimes < 0 or done
							loop
								if r \\ primes [nprimes] = 0 then
									Result := 0
									done := True
								end
								nprimes := nprimes - 1
							end
							p := q
							nprimes := 0
						else
							p := p0.item
						end
						primes [nprimes] := q
						nprimes := nprimes + 1
					end
					q := q + 2
				end
			end
			if not done then
				Result := millerrabin (op1, reps)
			end
		end

	pp: NATURAL_32 = 0xC0CFD797
	pp_inverted: NATURAL_32 = 0x53E5645C
	pp_first_omitted: INTEGER = 31

	reduce (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; ap: SPECIAL [NATURAL_32]; ap_offset: INTEGER; ap_count: INTEGER; mp: SPECIAL [NATURAL_32]; mp_offset: INTEGER; mp_count: INTEGER)
		local
			tmp: SPECIAL [NATURAL_32]
		do
			create tmp.make_filled (0, ap_count - mp_count + 1)
			tdiv_qr_special (tmp, 0, target, target_offset, ap, ap_offset, ap_count, mp, mp_offset, mp_count)
		end

	muldiv (target: READABLE_INTEGER_X; inc: INTEGER_32; rsize: CELL [INTEGER_32]; ralloc: CELL [INTEGER_32]; nacc: CELL [NATURAL_32]; kacc: CELL [NATURAL_32])
		local
			new_ralloc: INTEGER_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			if rsize.item <= ralloc.item then
				new_ralloc := ralloc.item + inc
				target.resize (new_ralloc)
				ralloc.put (new_ralloc)
			end
			mul_1 (target.item, 0, target.item, 0, rsize.item, nacc.item, carry)
			target.item [rsize.item] := carry.item
			divexact_1 (target.item, 0, target.item, 0, rsize.item + 1, kacc.item)
			if target.item [rsize.item] /= 0 then
				rsize.put (rsize.item + 1)
			end
		end

	invert_gf (target: READABLE_INTEGER_X op1: READABLE_INTEGER_X op2: READABLE_INTEGER_X)
		require
			not op1.is_negative
			not op2.is_negative
		local
			target_special: SPECIAL [NATURAL_32]
			op2_count: INTEGER
		do
			target.resize (op2.count)
			op2_count := op2.count
			target_special := target.item
			invert_gf_special (target_special, 0, op1.item, 0, op1.count, op2.item, 0, op2_count)
			target.count := normalize (target_special, 0, op2_count)
		end
end
