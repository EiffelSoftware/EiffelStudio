note
	description: "Summary description for {NUMBER_ACCESS}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "State-mandated compassion produces, not love for ones fellow man, but hatred and resentment. -  Lizard"

deferred class
	SPECIAL_ACCESS

inherit
	LIMB_MANIPULATION
	MP_BASES
	SPECIAL_ARITHMETIC
	SPECIAL_DIVISION

feature

	dc_get_str (target_a: STRING_8; target_offset_a: INTEGER; len_a: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER; powtab: SPECIAL [POWERS]; powtab_offset: INTEGER; tmp: SPECIAL [NATURAL_32]; tmp_offset: INTEGER): INTEGER
		local
			target: STRING_8
			len: INTEGER
			pwp: SPECIAL [NATURAL_32]
			pwp_offset: INTEGER
			qp: SPECIAL [NATURAL_32]
			qp_offset: INTEGER
			rp: SPECIAL [NATURAL_32]
			rp_offset: INTEGER
			pwn: INTEGER
			qn: INTEGER
			target_offset: INTEGER
		do
			target := target_a
			len := len_a
			target_offset := target_offset_a
			if op1_count < 15 then
				if op1_count /= 0 then
					target_offset := sb_get_str (target, target_offset, len, op1, op1_offset, op1_count, powtab, powtab_offset)
				else
					from
					until
						len /= 0
					loop
						target [target_offset] := '%U'
						target_offset := target_offset + 1
						len := len - 1
					end
				end
			else
				pwp := powtab [powtab_offset].p
				pwn := powtab [powtab_offset].n
				if op1_count < pwn or (op1_count = pwn and cmp (op1, op1_offset, pwp, pwp_offset, op1_count) < 0) then
					target_offset := dc_get_str (target, target_offset, len, op1, op1_offset, op1_count, powtab, powtab_offset - 1, tmp, tmp_offset)
				else
					qp := tmp
					qp_offset := tmp_offset
					rp := op1
					rp_offset := op1_offset
					tdiv_qr (qp, qp_offset, rp, rp_offset, op1, op1_offset, op1_count, pwp, pwp_offset, pwn)
					qn := op1_count - pwn
					qn := qn + (qp [qp_offset + qn] /= 0).to_integer
					if len /= 0 then
						len := len - powtab [powtab_offset].digits_in_base
					end
					target_offset := dc_get_str (target, target_offset, len, qp, qp_offset, qn, powtab, powtab_offset - 1, tmp, tmp_offset + op1_count - pwn + 1)
					target_offset := dc_get_str (target, target_offset, powtab [powtab_offset].digits_in_base, rp, rp_offset, pwn, powtab, powtab_offset - 1, tmp, tmp_offset)
				end
			end
			Result := target_offset
		end

	get_str (target: STRING_8; target_offset: INTEGER; base: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER): INTEGER
		local
			powtab_mem_ptr: SPECIAL [NATURAL_32]
			powtab_mem_ptr_offset: INTEGER
			big_base_l: NATURAL_32
			digits_in_base: INTEGER
			powtab: SPECIAL [POWERS]
			pi: INTEGER
			n: INTEGER
			t: INTEGER
			p: SPECIAL [NATURAL_32]
			p_offset: INTEGER
			n1: NATURAL_32
			n0: NATURAL_32
			bits_per_digit: INTEGER
			count: INTEGER
			bit_pos: INTEGER
			i: INTEGER
			s: INTEGER
			bits: INTEGER
		do
			if op1_count = 0 then
				target [target_offset] := '%U'
				Result := 1
			else
				if pow2_p (base.to_natural_32) then
					bits_per_digit := big_base (base).to_integer_32
					s := target_offset
					n1 := op1 [op1_offset + op1_count - 1]
					count := leading_zeros (n1)
					bits := limb_bits * op1_count - count
					count := bits \\ bits_per_digit
					if count /= 0 then
						bits := bits + bits_per_digit - count
					end
					bit_pos := bits - (op1_count - 1) * limb_bits
					from
						i := op1_count - 1
					until
						i < 0
					loop
						bit_pos := bit_pos - bits_per_digit
						from
						until
							bit_pos < 0
						loop
							target [s] := ((n1 |>> bit_pos).bit_and (((1).to_natural_32 |<< bits_per_digit) - 1)).to_character_8
							s := s + 1
							bit_pos := bit_pos - bits_per_digit
						end
						i := i - 1
						if i >= 0 then
							n0 := (n1 |<< -bit_pos).bit_and (((1).to_natural_32 |<< bits_per_digit) - 1)
							n1 := op1 [op1_offset + i]
							bit_pos := bit_pos + limb_bits
							target [s] := (n0.bit_or (n1 |>> bit_pos)).to_character_8
							s := s + 1
						end
					end
					Result := s - target_offset
				else
					if op1_count < 30 then
						create powtab.make_empty (1)
						create p.make_empty (0)
						powtab.extend (create {POWERS}.make (0, p, 0, 0, base))
						Result := sb_get_str (target, target_offset, 0, op1, op1_offset, op1_count, powtab, 0)
					else
						create powtab_mem_ptr.make_filled (0, 2 * op1_count + 30)
						big_base_l := big_base (base)
						digits_in_base := chars_per_limb (base)
						create powtab.make_empty (30)
						create p.make_filled (0, 0)
						powtab.extend (create {POWERS}.make (0, p, 0, 0, base))
						create p.make_filled (big_base_l, 1)
						powtab.extend (create {POWERS}.make (digits_in_base, p, 0, 1, base))
						create p.make_filled (big_base_l, 1)
						powtab.extend (create {POWERS}.make (digits_in_base, p, 0, 1, base))
						n := 1
						pi := 2
						create p.make_filled (big_base_l, 1)
						p_offset := 0
						from
						until
							2 * n > op1_count
						loop
							pi := pi + 1
							t := powtab_mem_ptr_offset
							powtab_mem_ptr_offset := powtab_mem_ptr_offset + 2 * n
							sqr_n (powtab_mem_ptr, t, p, p_offset, n)
							n := n * 2
							n := n - (powtab_mem_ptr [t + n - 1] = 0).to_integer
							digits_in_base := digits_in_base * 2
							powtab_mem_ptr_offset := t
							powtab.extend (create {POWERS}.make (digits_in_base, p, 0, n, base))
						end
					end
				end
			end
		end

	sb_get_str (target: STRING_8; target_offset_a: INTEGER; len_a: INTEGER; op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count_a: INTEGER; powtab: SPECIAL [POWERS]; powtab_offset: INTEGER): INTEGER
		local
			rl: CELL [NATURAL_32]
			ul: CELL [NATURAL_32]
			s: INTEGER
			base: INTEGER
			l: INTEGER
			buf: SPECIAL [NATURAL_8]
			buf_offset: INTEGER
			rp: SPECIAL [NATURAL_32]
			rp_offset: INTEGER
			buff_alloc: INTEGER
			op1_count: INTEGER
			i: INTEGER
			frac: CELL [NATURAL_32]
			digit: CELL [NATURAL_32]
			junk: NATURAL_32
			chars_per_limb_l: INTEGER
			big_base_l: NATURAL_32
			big_base_inverted_l: NATURAL_32
			normalization_steps: INTEGER
			target_offset: INTEGER
			len: INTEGER
		do
			create digit.put (0)
			create frac.put (0)
			create ul.put (0)
			create rl.put (0)
			len := len_a
			target_offset := target_offset_a
			op1_count := op1_count_a
			buff_alloc := 30 * 8 * 4 * 7 // 11
			create buf.make_filled (0, buff_alloc)
			create rp.make_filled (0, 30)
			base := powtab [powtab_offset].base
			chars_per_limb_l := chars_per_limb (base)
			big_base_l := big_base (base)
			big_base_inverted_l := big_base_inverted (base)
			normalization_steps := leading_zeros (big_base_l)
			rp.copy_data (op1, op1_offset, rp_offset + 1, op1_count)
			s := buf_offset + buff_alloc
			from
			until
				op1_count <= 1
			loop
				junk := preinv_divrem_1 (rp, rp_offset, 1, rp, rp_offset + 1, op1_count, big_base_l, big_base_inverted_l, normalization_steps)
				op1_count := op1_count - (rp [rp_offset + op1_count] = 0).to_integer
				frac.put (rp [rp_offset] + 1)
				s := s - chars_per_limb_l
				i := chars_per_limb_l
				from
				until
					i = 0
				loop
					umul_ppmm (digit, frac, frac.item, base.to_natural_32)
					buf [s] := digit.item.to_natural_8
					s := s + 1
					i := i - 1
				end
				s := s - chars_per_limb_l
			end
			ul.put (rp [rp_offset + 1])
			from
			until
				ul.item = 0
			loop
				udiv_qrnd_unnorm (ul, rl, ul.item, base.to_natural_32)
				s := s - 1
				buf [s] := rl.item.to_natural_8
			end
			l := buf_offset + buff_alloc - s
			from
			until
				l >= len
			loop
				target [target_offset] := '%U'
				target_offset := target_offset + 1
				len := len - 1
			end
			from
			until
				l = 0
			loop
				target [target_offset] := buf [s].to_character_8
				s := s + 1
				target_offset := target_offset + 1
				l := l - 1
			end
			Result := target_offset - target_offset_a
		end
end
