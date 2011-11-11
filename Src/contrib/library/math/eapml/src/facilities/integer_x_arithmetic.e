note
	description: "Summary description for {INTEGER_X_ARITHMETIC}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Every man should know that his conversations, his correspondence, and his personal life are private. -  Lyndon B. Johnson (1908-1973), Remarks, 3/10/67"

deferred class
	INTEGER_X_ARITHMETIC

inherit
	INTEGER_X_FACILITIES
	SPECIAL_ARITHMETIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special
		export
			{NONE}
				all
		end
	SPECIAL_COMPARISON
	SPECIAL_UTILITY

feature

	add (target: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X)
			-- Set `rop' to `op1' + `op2'.
		local
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			vp: SPECIAL [NATURAL_32]
			usize: INTEGER_32
			vsize: INTEGER_32
			wsize: INTEGER_32
			abs_usize: INTEGER_32
			abs_vsize: INTEGER_32
			pointer_temp: READABLE_INTEGER_X
			int_temp: INTEGER_32
			junk2: NATURAL_32
			cy_limb: NATURAL_32
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			usize := op1.count
			vsize := op2.count
			abs_usize := usize.abs
			abs_vsize := vsize.abs
			if abs_usize < abs_vsize then
				pointer_temp := op1
				op1 := op2
				op2 := pointer_temp
				int_temp := usize
				usize := vsize
				vsize := int_temp
				int_temp := abs_usize
				abs_usize := abs_vsize
				abs_vsize := int_temp
			end
			wsize := abs_usize + 1
			target.resize (wsize)
			up := op1.item
			vp := op2.item
			wp := target.item
			if usize.bit_xor (vsize) < 0 then
				if abs_usize /= abs_vsize then
					sub_special (wp, 0, up, 0, abs_usize, vp, 0, abs_vsize, carry)
					junk2 := carry.item
					wsize := abs_usize
					wsize := normalize (wp, wp_offset, wsize)
					if usize < 0 then
						wsize := -wsize
					end
				elseif cmp (up, 0, vp, 0, abs_usize) < 0 then
					sub_n (wp, 0, vp, 0, up, 0, abs_usize, carry)
					junk2 := carry.item
					wsize := abs_usize
					wsize := normalize (wp, wp_offset, wsize)
					if usize >= 0 then
						wsize := -wsize
					end
				else
					sub_n (wp, 0, up, 0, vp, 0, abs_usize, carry)
					junk2 := carry.item
					wsize := abs_usize
					wsize := normalize (wp, wp_offset, wsize)
					if usize < 0 then
						wsize := -wsize
					end
				end
			else
				add_special (wp, 0, up, 0, abs_usize, vp, 0, abs_vsize, carry)
				cy_limb := carry.item
				wp [wp_offset + abs_usize] := cy_limb
				wsize := abs_usize + cy_limb.to_integer_32
				if usize < 0 then
					wsize := -wsize
				end
			end
			target.count := wsize
		end

	add_ui (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL)
			-- Set `rop' to `op1' + `op2'.
		local
			usize: INTEGER_32
			wsize: INTEGER_32
			abs_usize: INTEGER_32
			cy: NATURAL_32
			junk2: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			usize := op1.count
			abs_usize := usize.abs
			wsize := abs_usize + 1
			target.resize (wsize)
			if abs_usize = 0 then
				target.item [0] := op2
				if op2 /= 0 then
					target.count := 1
				else
					target.count := 0
				end
			else
				if usize >= 0 then
					add_1 (target.item, 0, op1.item, 0, abs_usize, op2, carry)
					cy := carry.item
					target.item [abs_usize] := cy
					wsize := abs_usize + cy.to_integer_32
				else
					if abs_usize = 1 and op1.item [0] < op2 then
						target.item [0] := op2 - op1.item [0]
						wsize := 1
					else
						sub_1 (target.item, 0, op1.item, 0, abs_usize, op2, carry)
						junk2 := carry.item
						if target.item [abs_usize - 1] = 0 then
							wsize := - (abs_usize - 1)
						else
							wsize := - (abs_usize)
						end
					end
				end
				target.count := wsize
			end
		end

	aorsmul (target: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X; sub_a: INTEGER_32)
		local
			xsize: INTEGER_32
			ysize: INTEGER_32
			tsize: INTEGER_32
			wsize: INTEGER_32
			wsize_signed: INTEGER_32
			wp: INTEGER_32
			tp: SPECIAL [NATURAL_32]
			c: NATURAL_32
			high: NATURAL_32
			tmp_marker: SPECIAL [NATURAL_32]
			tp_offset: INTEGER_32
			current_temp: READABLE_INTEGER_X
			int_temp: INTEGER_32
			usize: INTEGER_32
			sub_l: INTEGER_32
			junk2: NATURAL_32
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			sub_l := sub_a
			xsize := op1.count
			ysize := op2.count
			if xsize = 0 or ysize = 0 then
			else
				if ysize.abs > xsize.abs then
					current_temp := op1
					op1 := op2
					op2 := current_temp
					int_temp := xsize
					xsize := ysize
					ysize := int_temp
				end
				sub_l := sub_l.bit_xor (ysize)
				ysize := ysize.abs
				if ysize = 1 then
					aorsmul_1 (target, op1, op2.item [0], sub_l)
				else
					sub_l := sub_l.bit_xor (xsize)
					xsize := xsize.abs
					wsize_signed := target.count
					sub_l := sub_l.bit_xor (wsize_signed)
					wsize := wsize_signed.abs
					tsize := xsize + ysize
					if wsize > tsize then
						if wsize + 1 > target.capacity then
							target.resize (wsize)
						end
					else
						if tsize + 1 > target.capacity then
							target.resize (tsize)
						end
					end
					if wsize_signed = 0 then
						mul_special (target.item, 0, op1.item, 0, xsize, op2.item, 0, ysize, carry)
						high := carry.item
						if high = 0 then
							tsize := tsize - 1
						end
						if sub_l >= 0 then
							target.count := tsize
						else
							target.count := -tsize
						end
					else
						create tmp_marker.make_filled (0, tsize)
						tp := tmp_marker
						tp_offset := 0
						mul_special (tmp_marker, 0, op1.item, 0, xsize, op2.item, 0, ysize, carry)
						high := carry.item
						if high = 0 then
							tsize := tsize - 1
						end
						if sub_l >= 0 then
							usize := wsize
							if usize < tsize then
								usize := tsize
								tp_offset := wp
								tsize := wsize
								wsize := usize
							end
							add_special (target.item, wp, op1.item, 0, usize, tp, 0, tsize, carry)
							c := carry.item
							target.item [wp + wsize] := c
							if c /= 0 then
								wsize := wsize + 1
							end
						else
							usize := wsize
							if usize < tsize or usize = tsize and cmp (target.item, wp, tmp_marker, 0, usize) < 0 then
								usize := tsize
								tp_offset := wp
								tsize := wsize
								wsize := usize
								wsize_signed := -wsize_signed
							end
							sub_special (target.item, wp, target.item, wp, usize, tp, tp_offset, tsize, carry)
							junk2 := carry.item
							wsize := usize
							from
							until
								wsize > 0 or target.item [wp + wsize - 1] /= 0
							loop
								wsize := wsize - 1
							end
						end
						if wsize_signed >= 0 then
							target.count := wsize
						else
							target.count := -wsize
						end
					end
				end
			end
		end

	aorsmul_1 (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL_32; sub_a: INTEGER_32)
		local
			xsize: INTEGER_32
			wsize: INTEGER_32
			wsize_signed: INTEGER_32
			new_wsize: INTEGER_32
			min_size: INTEGER_32
			dsize: INTEGER_32
			xp: INTEGER_32
			wp: INTEGER_32
			cy: NATURAL_32
			sub_l: INTEGER_32
			cy2: NATURAL_32
			d: INTEGER_32
			s: INTEGER_32
			n: INTEGER_32
			x: NATURAL_32
			p: INTEGER_32
			cy__: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			sub_l := sub_a
			xsize := op1.count
			if xsize = 0 or op2 = 0 then
			else
				sub_l := sub_l.bit_xor (xsize)
				xsize := xsize.abs
				wsize_signed := target.count
				if wsize_signed = 0 then
					target.resize (xsize + 1)
					wp := 0
					mul_1 (target.item, 0, op1.item, 0, xsize, op2, carry)
					cy := carry.item
					target.item [xsize] := cy
					if cy /= 0 then
						xsize := xsize + 1
					end
					if sub_l >= 0 then
						target.count := xsize
					else
						target.count := -xsize
					end
				else
					sub_l := sub_l.bit_xor (wsize_signed)
					wsize := wsize_signed.abs
					new_wsize := wsize.max (xsize)
					target.resize (new_wsize + 1)
					wp := 0
					xp := 0
					min_size := wsize.min (xsize)
					if sub_l >= 0 then
						addmul_1 (target.item, 0, op1.item, 0, min_size, op2, carry)
						cy := carry.item
						wp := wp + min_size
						xp := xp + min_size
						dsize := xsize - wsize
						if dsize /= 0 then
							if dsize > 0 then
								mul_1 (target.item, wp, op1.item, xp, min_size, op2, carry)
								cy2 := carry.item
							else
								dsize := -dsize
								cy2 := 0
							end
							add_1 (target.item, wp, target.item, wp, dsize, cy, carry)
							cy := cy2 + carry.item
						end
						target.item [wp + dsize] := cy
						if cy /= 0 then
							new_wsize := new_wsize + 1
						end
					else
						submul_1 (target.item, wp, op1.item, xp, min_size, op2, carry)
						cy := carry.item
						if wsize >= xsize then
							if wsize /= xsize then
								sub_1 (target.item, wp + xsize, op1.item, wp + xsize, wsize - xsize, cy, carry)
								cy := carry.item
								if cy /= 0 then
									target.item [wp + new_wsize] := (-cy.to_integer_32).bit_not.to_natural_32
									d := wp
									s := wp
									n := new_wsize
									from
										target.item [d] := target.item [s].bit_not
										d := d + 1
										s := s + 1
										n := n - 1
									until
										n = 0
									loop
										target.item [d] := target.item [s].bit_not
										d := d + 1
										s := s + 1
										n := n - 1
									end
									new_wsize := new_wsize + 1
									p := wp
									x := target.item [p] + 1
									target.item [p] := x
									if x < 1 then
										from
											p := p + 1
											target.item [p] := target.item [p] + 1
										until
											target.item [p] /= 0
										loop
											p := p + 1
											target.item [p] := target.item [p] + 1
										end
									end
									wsize_signed := -wsize_signed
								end
							else
								d := wp
								s := wp
								n := wsize
								from
									target.item [d] := target.item [s].bit_not
									s := s + 1
									d := d + 1
									n := n - 1
								until
									n = 0
								loop
									target.item [d] := target.item [s].bit_not
									s := s + 1
									d := d + 1
									n := n - 1
								end
								add_1 (target.item, wp, target.item, wp, wsize, 1, carry)
								cy := carry.item
								cy := cy - 1
								if cy = (0).to_natural_32.bit_not then
									cy2 := cy2 + 1
								end
								cy := cy + cy2
								mul_1 (target.item, wp + wsize, target.item, xp + wsize, xsize - wsize, op2, carry)
								cy__ := carry.item
								add_1 (target.item, wp + wsize, target.item, wp + wsize, xsize - wsize, cy, carry)
								cy := cy__ + carry.item
								target.item [wp + new_wsize] := cy
								if cy /= 0 then
									new_wsize := new_wsize + 1
								end
								if cy2 /= 0 then
									p := wp + wsize
									x := target.item [p]
									target.item [p] := x - 1
									if x < 1 then
										from
											p := p + 1
											target.item [p] := target.item [p] - 1
										until
											target.item [p] = 0
										loop
											p := p + 1
											target.item [p] := target.item [p] - 1
										end
									end
								end
								wsize_signed := -wsize_signed
							end
						end
						from
						until
							new_wsize <= 0 or target.item [(wp + new_wsize) * 4] /= 0
						loop
							new_wsize := new_wsize - 1
						end
					end
					if wsize_signed >= 0 then
						target.count := new_wsize
					else
						target.count := -new_wsize
					end
				end
			end
		end

	sub (target: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X)
			-- Set `rop' to `op1' - `op2'.
		local
			usize: INTEGER_32
			vsize: INTEGER_32
			wsize: INTEGER_32
			abs_usize: INTEGER_32
			abs_vsize: INTEGER_32
			pointer_temp: READABLE_INTEGER_X
			integer_temp: INTEGER_32
			junk2: NATURAL_32
			cy_limb: NATURAL_32
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			usize := op1.count
			vsize := -op2.count
			abs_usize := usize.abs
			abs_vsize := vsize.abs
			if abs_usize < abs_vsize then
				pointer_temp := op1
				op1 := op2
				op2 := pointer_temp
				integer_temp := usize
				usize := vsize
				vsize := integer_temp
				integer_temp := abs_usize
				abs_usize := abs_vsize
				abs_vsize := integer_temp
			end
			wsize := abs_usize + 1
			target.resize (wsize)
			if usize.bit_xor (vsize) < 0 then
				if abs_usize /= abs_vsize then
					sub_special (target.item, 0, op1.item, 0, abs_usize, op2.item, 0, abs_vsize, carry)
					junk2 := carry.item
					wsize := abs_usize
					from
					until
						wsize <= 0 or target.item [wsize - 1] /= 0
					loop
						wsize := wsize - 1
					end
					if usize < 0 then
						wsize := -wsize
					end
				elseif cmp (op1.item, 0, op2.item, 0, abs_usize) < 0 then
					sub_n (target.item, 0, op2.item, 0, op1.item, 0, abs_usize, carry)
					junk2 := carry.item
					wsize := abs_usize
					from
					until
						wsize <= 0 or target.item [wsize - 1] /= 0
					loop
						wsize := wsize - 1
					end
					if usize >= 0 then
						wsize := -wsize
					end
				else
					sub_n (target.item, 0, op1.item, 0, op2.item, 0, abs_usize, carry)
					junk2 := carry.item
					wsize := abs_usize
					from
					until
						wsize <= 0 or target.item [wsize - 1] /= 0
					loop
						wsize := wsize - 1
					end
					if usize < 0 then
						wsize := -wsize
					end
				end
			else
				add_special (target.item, 0, op1.item, 0, abs_usize, op2.item, 0, abs_vsize, carry)
				cy_limb := carry.item
				target.item [abs_usize] := cy_limb
				wsize := abs_usize + cy_limb.to_integer_32
				if usize < 0 then
					wsize := -wsize
				end
			end
			target.count := wsize
		end

	sub_ui (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL)
			-- Set `rop' to `op1' - `op2'.
		local
			usize: INTEGER_32
			wsize: INTEGER_32
			abs_usize: INTEGER_32
			vval: NATURAL_32
			cy: NATURAL_32
			junk2: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			usize := op1.count
			abs_usize := usize.abs
			wsize := abs_usize + 1
			target.resize (wsize)
			if abs_usize = 0 then
				target.item [0] := vval
				if op2 /= 0 then
					target.count := -1
				else
					target.count := 0
				end
			else
				if usize < 0 then
					add_1 (target.item, 0, op1.item, 0, abs_usize, op2, carry)
					cy := carry.item
					target.item [abs_usize] := cy
					wsize := - (abs_usize + cy.to_integer_32)
				else
					if abs_usize = 1 and op1.item [0] < op2 then
						target.item [0] := op2 - op1.item [0]
						wsize := -1
					else
						sub_1 (target.item, 0, op1.item, 0, abs_usize, op2, carry)
						junk2 := carry.item
						if target.item [abs_usize - 1] = 0 then
							wsize := abs_usize - 1
						else
							wsize := abs_usize
						end
					end
				end
				target.count := wsize
			end
		end

	ui_sub (target: READABLE_INTEGER_X; op1: NATURAL_32; op2: READABLE_INTEGER_X)
			-- Set `rop' to `op1' - `op2'.
		local
			vn: INTEGER_32
			wn: INTEGER_32
			cy: NATURAL_32
			junk2: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			vn := op2.count
			if vn > 1 then
				if vn > target.capacity then
					target.resize (vn)
				end
				sub_1 (target.item, 0, op2.item, 0, vn, op1, carry)
				junk2 := carry.item
				if target.item [vn - 1] = 0 then
					wn := - (vn - 1)
				else
					wn := - vn
				end
			elseif vn = 1 then
				if op1 >= op2.item [0] then
					target.item [0] := op1 - op2.item [0]
					if target.item [0] /= 0 then
						wn := 1
					else
						wn := 0
					end
				else
					target.item [0] := op2.item [0] - op1
					wn := -1
				end
			elseif vn = 0 then
				target.item [0] := op1
				if op1 /= 0 then
					wn := 1
				else
					wn := 0
				end
			else
				vn := -vn
				target.resize (vn + 1)
				add_1 (target.item, 0, op2.item, 0, vn, op1, carry)
				cy := carry.item
				target.item [vn] := cy
				if cy /= 0 then
					wn := vn + 1
				else
					wn := vn
				end
			end
			target.count := wn
		end

	addmul (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: READABLE_INTEGER_X)
			-- Set `rop' to `rop' + `op1' times `op2'.
		do
			aorsmul (target, op1, op2, 0)
		end

	addmul_ui (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL)
			-- Set `rop' to `rop' + `op1' times `op2'.
		do
			aorsmul_1 (target, op1, op2, 0)
		end

	submul (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: READABLE_INTEGER_X)
			-- Set `rop' to `rop' - `op1' times `op2'.
		do
			aorsmul (target, op1, op2, -1)
		end

	submul_ui (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL)
			-- Set `rop' to `rop' - `op1' times `op2'.
		do
			aorsmul_1 (target, op1, op2, -1)
		end

	mul (target: READABLE_INTEGER_X; op1_a: READABLE_INTEGER_X; op2_a: READABLE_INTEGER_X)
			-- Set `rop' to `op1' times `op2'.
		local
			usize: INTEGER
			vsize: INTEGER
			wsize: INTEGER
			sign_product: INTEGER
			vp: SPECIAL [NATURAL_32]
			vp_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER
			cy_limb: NATURAL_32
			op_temp: READABLE_INTEGER_X
			size_temp: INTEGER_32
			op1: READABLE_INTEGER_X
			op2: READABLE_INTEGER_X
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			op1 := op1_a
			op2 := op2_a
			usize := op1.count
			vsize := op2.count
			sign_product := usize.bit_xor (vsize)
			usize := usize.abs
			vsize := vsize.abs
			if usize = 0 or vsize = 0 then
				target.count := 0
			else
				if vsize = 1 then
					if usize + 1 > target.capacity then
						target.resize (usize + 1)
					end
					wp := target.item
					mul_1 (target.item, 0, op1.item, 0, usize, op2.item [0], carry)
					cy_limb := carry.item
					target.item [usize] := cy_limb
					if cy_limb /= 0 then
						usize := usize + 1
					end
					if sign_product >= 0 then
						target.count := usize
					else
						target.count := -usize
					end
				else
					wsize := usize + vsize
					if wsize <= 32 and target /= op1 and target /= op2 then
						target.resize (wsize)
						wp := target.item
						if usize > vsize then
							mul_basecase (wp, 0, op1.item, 0, usize, op2.item, 0, vsize)
						else
							mul_basecase (wp, 0, op2.item, 0, vsize, op1.item, 0, usize)
						end
						wsize := wsize - (wp [wp_offset + wsize - 1] = 0).to_integer
						if sign_product >= 0 then
							target.count := wsize
						else
							target.count := -wsize
						end
					else
						if usize < vsize then
							op_temp := op1
							op1 := op2
							op2 := op_temp
							size_temp := usize
							usize := vsize
							vsize := size_temp
						end
						up := op1.item
						up_offset := 0
						vp := op2.item
						vp_offset := 0
						wp := target.item
						wp_offset := 0
						if target.capacity < wsize then
							create wp.make_filled (0, wsize)
							target.item := wp
						else
							if wp = up then
								create up.make_filled (0, usize)
								if wp = vp then
									vp := up
								end
								up.copy_data (wp, 0, 0, usize)
							elseif wp = vp then
								create vp.make_filled (0, vsize)
								vp.copy_data (wp, 0, 0, vsize)
							end
						end
						mul_special (wp, 0, up, 0, usize, vp, 0, vsize, carry)
						cy_limb := carry.item
						wsize := usize + vsize
						wsize := wsize - (cy_limb = 0).to_integer
						if sign_product < 0 then
							target.count := -wsize
						else
							target.count := wsize
						end
					end
				end
			end
		end

	mul_2exp (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; count_a: INTEGER)
		local
			usize: INTEGER
			abs_usize: INTEGER
			wsize: INTEGER
			limb_count: INTEGER
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER
			wlimb: NATURAL_32
			count: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			count := count_a
			usize := op1.count
			abs_usize := usize.abs
			if usize = 0 then
				target.count := 0
			else
				limb_count := count // limb_bits
				wsize := abs_usize + limb_count + 1
				target.resize (wsize)
				wp := target.item
				wsize := abs_usize + limb_count
				count := count \\ limb_bits
				if count /= 0 then
					lshift (wp, wp_offset + limb_count, op1.item, 0, abs_usize, count, carry)
					wlimb := carry.item
					if wlimb /= 0 then
						wp [wp_offset + wsize] := wlimb
						wsize := wsize + 1
					end
				else
					wp.copy_data (op1.item, 0, wp_offset + limb_count, abs_usize)
				end
				wp.fill_with (0, wp_offset, wp_offset + limb_count - 1)
				if usize >= 0 then
					target.count := wsize
				else
					target.count := -wsize
				end
			end
		end

	mul_si (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: INTEGER)
		local
			size: INTEGER
			sign_product: INTEGER
			sml: NATURAL_32
			cy: NATURAL_32
			pp: SPECIAL [NATURAL_32]
			pp_offset: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			size := op1.count
			sign_product := size
			if size = 0 or op2 = 0 then
				target.count := 0
			else
				size := size.abs
				sml := op2.abs.to_natural_32
				target.resize (size + 1)
				pp := target.item
				mul_1 (pp, pp_offset, op1.item, 0, size, sml, carry)
				cy := carry.item
				pp [pp_offset + size] := cy
				size := size + (cy /= 0).to_integer
			end
			if sign_product < 0 xor op2 < 0 then
				target.count := -size
			else
				target.count := size
			end
		end

	mul_ui (target: READABLE_INTEGER_X; op1: READABLE_INTEGER_X; op2: NATURAL_32)
		local
			size: INTEGER
			sign_product: INTEGER
			sml: NATURAL_32
			cy: NATURAL_32
			pp: SPECIAL [NATURAL_32]
			pp_offset: INTEGER
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			size := op1.count
			sign_product := size
			if size = 0 or op2 = 0 then
				target.count := 0
			else
				size := size.abs
				sml := op2
				target.resize (size + 1)
				pp := target.item
				mul_1 (pp, pp_offset, op1.item, 0, size, sml, carry)
				cy := carry.item
				pp [pp_offset + size] := cy
				size := size + (cy /= 0).to_integer
			end
			if sign_product < 0 xor op2 < 0 then
				target.count := -size
			else
				target.count := size
			end
		end

	neg (target: READABLE_INTEGER_X; op: READABLE_INTEGER_X)
			-- Set `rop' to -`op'.
		local
			usize: INTEGER_32
			size: INTEGER_32
		do
			usize := op.count
			if target /= op then
				size := usize.abs
				target.resize (size)
				target.item.copy_data (op.item, 0, 0, size)
			end
			target.count := -usize
		end

	abs (target: READABLE_INTEGER_X; op: READABLE_INTEGER_X)
			-- Set `rop' to the absolute value of `op'.
		local
			size: INTEGER_32
		do
			size := op.count.abs
			if op /= target then
				target.resize (size)
				target.item.copy_data (op.item, 0, 0, size)
			end
			target.count := size
		end
end
