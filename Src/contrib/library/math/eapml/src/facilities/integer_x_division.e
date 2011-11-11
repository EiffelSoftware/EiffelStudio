note
	description: "Summary description for {INTEGER_X_DIVISION}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Collecting more taxes than is absolutely necessary is legalized robbery. -  President Calvin Coolidge"

deferred class
	INTEGER_X_DIVISION

inherit
	INTEGER_X_FACILITIES
	SPECIAL_UTILITY
		export
			{NONE}
				all
		end
	SPECIAL_DIVISION
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			tdiv_qr as tdiv_qr_special
		export
			{NONE}
				all
		end
	INTEGER_X_ARITHMETIC
	INTEGER_X_ASSIGNMENT
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special
		export
			{NONE}
				all
		end

feature

	fdiv_r_2exp (target: READABLE_INTEGER_X; u: READABLE_INTEGER_X; count: INTEGER)
		do
			cfdiv_r_2exp (target, u, count, -1)
		end

	cdiv_r_2exp (target: READABLE_INTEGER_X; u: READABLE_INTEGER_X; count: INTEGER)
		do
			cfdiv_r_2exp (target, u, count, 1)
		end

	cfdiv_r_2exp (target: READABLE_INTEGER_X; u: READABLE_INTEGER_X; count_a: INTEGER; direction: INTEGER)
		local
			usize: INTEGER
			abs_usize: INTEGER
			limb_count: INTEGER
			i: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER
			high: NATURAL_32
			count: INTEGER
			returned: BOOLEAN
			negate: BOOLEAN
		do
			create wp.make_empty (0)
			count := count_a
			usize := u.count
			if usize = 0 then
				target.count := 0
			else
				limb_count := count // 32
				count := count \\ 32
				abs_usize := usize.abs
				up := u.item
				if usize.bit_xor (direction) < 0 and Current = u and abs_usize <= limb_count then
					returned := True
				else
					if usize.bit_xor (direction) < 0 then
						if Current = u then
							wp := target.item
						else
							i := abs_usize.min (limb_count + 1)
							target.resize (i)
							wp := target.item
							wp.copy_data (up, up_offset, wp_offset, i)
							if abs_usize <= limb_count then
								target.count := usize
								returned := True
							end
						end
					else
						if abs_usize <= limb_count then
							negate := True
						else
							from
								i := 0
							until
								i < limb_count or negate
							loop
								negate := up [up_offset + i] /= 0
								i := i + 1
							end
							if not negate then
								if up [up_offset + limb_count].bit_and (((1).to_natural_32 |<< count) - 1) /= 0 then
									negate := True
								else
									target.count := 0
									returned := True
								end
							end
						end
						if not returned and negate then
							target.resize (limb_count + 1)
							up := u.item
							up_offset := 0
							wp := target.item
							wp_offset := 0
							i := abs_usize.min (limb_count + 1)
							com_n (wp, wp_offset, up, up_offset, i)
							from
							until
								i > limb_count
							loop
								wp [wp_offset + i] := high.max_value
								i := i + 1
							end
							incr_u (wp, wp_offset, 1)
							usize := -usize
						end
					end
				end
				if not returned then
					high := wp [wp_offset + limb_count]
					high := high.bit_and (((1).to_natural_32 |<< count) - 1)
					wp [wp_offset + limb_count] := high
					from
						limb_count := limb_count - 1
					until
						high /= 0 or limb_count < 0
					loop
						high := wp [wp_offset + limb_count]
					end
					if limb_count < 0 then
						target.count := 0
					else
						limb_count := limb_count + 1
						if usize >= 0 then
							target.count := limb_count
						else
							target.count := -limb_count
						end
					end
				end
			end
		end

	mod (target: READABLE_INTEGER_X; dividend: READABLE_INTEGER_X; divisor_a: READABLE_INTEGER_X)
		local
			divisor_size: INTEGER
			temp_divisor: INTEGER_X
			divisor: READABLE_INTEGER_X
		do
			divisor := divisor_a
			divisor_size := divisor.count
			if target = divisor then
				create temp_divisor.make_limbs (divisor_size.abs)
				temp_divisor.set_from_other (divisor)
				divisor := temp_divisor
			end
			tdiv_r (target, dividend, divisor)
			if target.count /= 0 then
				if dividend.count < 0 then
					if divisor.count < 0 then
						sub (target, target, divisor)
					else
						add (target, target, divisor)
					end
				end
			end
		end

	tdiv_q (target: READABLE_INTEGER_X; numerator: READABLE_INTEGER_X; denominator: READABLE_INTEGER_X)
		local
			ql: INTEGER
			ns: INTEGER
			ds: INTEGER
			nl: INTEGER
			dl: INTEGER
			np: SPECIAL [NATURAL_32]
			np_offset: INTEGER
			dp: SPECIAL [NATURAL_32]
			dp_offset: INTEGER
			qp: SPECIAL [NATURAL_32]
			qp_offset: INTEGER
			rp: SPECIAL [NATURAL_32]
			rp_offset: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
		do
			ns := numerator.count
			ds := denominator.count
			nl := ns.abs
			dl := ds.abs
			ql := nl - dl + 1

			if dl = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			if ql <= 0 then
				target.count := 0
			else
				target.resize (ql)
				qp := target.item
				create rp.make_filled (0, dl)
				np := numerator.item
				dp := denominator.item
				if dp = qp then
					create tp.make_filled (0, dl)
					tp.copy_data (dp, dp_offset, tp_offset, dl)
					dp := tp
				end
				if np = qp then
					create tp.make_filled (0, nl)
					tp.copy_data (np, np_offset, tp_offset, nl)
					np := tp
				end
				tdiv_qr_special (qp, qp_offset, rp, rp_offset, np, np_offset, nl, dp, dp_offset, dl)
				ql := ql - (qp [qp_offset + ql - 1] = 0).to_integer
				if ns.bit_xor (ds) >= 0 then
					target.count := ql
				else
					target.count := -ql
				end
			end
		end

	tdiv_q_2exp (target: READABLE_INTEGER_X; op: READABLE_INTEGER_X; count_a: INTEGER_32)
		local
			usize: INTEGER
			wsize: INTEGER
			limb_count: INTEGER
			wp: SPECIAL [NATURAL_32]
			wp_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			junk: NATURAL_32
			count: INTEGER_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			count := count_a
			usize := op.count
			limb_count := count // 32
			wsize := usize.abs - limb_count
			if wsize <= 0 then
				target.count := 0
			else
				target.resize (wsize)
				wp := target.item
				up := op.item
				count := count \\ 32
				if count /= 0 then
					rshift (wp, wp_offset, up, up_offset + limb_count, wsize, count, carry)
					junk := carry.item
					wsize := wsize - (wp [wp_offset + wsize - 1] = 0).to_integer
				else
					wp.copy_data (up, up_offset + limb_count, wp_offset, wsize)
				end
				if usize >= 0 then
					target.count := wsize
				else
					target.count := -wsize
				end
			end
		end

	tdiv_qr (target: READABLE_INTEGER_X; remainder: READABLE_INTEGER_X; numerator: READABLE_INTEGER_X; denominator: READABLE_INTEGER_X)
		local
			ql: INTEGER_32
			ns: INTEGER_32
			ds: INTEGER_32
			nl: INTEGER_32
			dl: INTEGER_32
			temp_dp: SPECIAL [NATURAL_32]
			temp_np: SPECIAL [NATURAL_32]
		do
			ns := numerator.count
			ds := denominator.count
			nl := ns.abs
			dl := ds.abs
			ql := nl - dl + 1
			if dl = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			remainder.resize (dl)
			if ql <= 0 then
				if numerator /= remainder then
					remainder.item.copy_data (numerator.item, 0, 0, nl)
					remainder.count := numerator.count
				end
				target.count := 0
			else
				target.resize (ql)
				if denominator = remainder or denominator = Current then
					create temp_dp.make_empty (dl)
					temp_dp.copy_data (denominator.item, 0, 0, dl)
				else
					temp_dp := denominator.item
				end
				if numerator = remainder or numerator = Current then
					create temp_np.make_empty (nl)
					temp_np.copy_data (numerator.item, 0, 0, nl)
				else
					temp_np := numerator.item
				end
				tdiv_qr_special (target.item, 0, remainder.item, 0, temp_np, 0, nl, temp_dp, 0, dl)
				if target.item [ql - 1] = 0 then
					ql := ql - 1
				end
				remainder.count :=  normalize (remainder.item, 0, remainder.count)
				dl := remainder.count
				if ns.bit_xor (ds) >= 0 then
					target.count := ql
				else
					target.count := -ql
				end
				if ns >= 0 then
					remainder.count := dl
				else
					remainder.count := -dl
				end
			end
		end

	tdiv_r (remainder: READABLE_INTEGER_X; numerator: READABLE_INTEGER_X; denominator: READABLE_INTEGER_X)
		local
			ql: INTEGER
			ns: INTEGER
			ds: INTEGER
			nl: INTEGER
			dl: INTEGER
			np: SPECIAL [NATURAL_32]
			np_offset: INTEGER
			dp: SPECIAL [NATURAL_32]
			dp_offset: INTEGER
			qp: SPECIAL [NATURAL_32]
			qp_offset: INTEGER
			rp: SPECIAL [NATURAL_32]
			rp_offset: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
		do
			ns := numerator.count
			ds := denominator.count
			nl := ns.abs
			dl := ds.abs
			ql := nl - dl + 1
			if dl = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			remainder.resize (dl)
			if ql <= 0 then
				if numerator /= remainder then
					np := numerator.item
					rp := remainder.item
					rp.copy_data (np, 0, 0, nl)
					remainder.count := numerator.count
				end
			else
				create qp.make_filled (0, ql)
				rp := remainder.item
				np := numerator.item
				dp := denominator.item
				if dp = rp then
					create tp.make_filled (0, nl)
					tp.copy_data (np, np_offset, tp_offset, nl)
					np := tp
					np_offset := tp_offset
				end
				tdiv_qr_special (qp, qp_offset, rp, rp_offset, np, np_offset, nl, dp, dp_offset, dl)
				dl := normalize (rp, rp_offset, dl)
				if ns >= 0 then
					remainder.count := dl
				else
					remainder.count := -dl
				end
			end
		end

	tdiv_r_2exp (target: READABLE_INTEGER_X; op: READABLE_INTEGER_X; count: INTEGER)
		local
			in_size: INTEGER
			res_size: INTEGER
			limb_count: INTEGER
			in_ptr: SPECIAL [NATURAL_32]
			in_ptr_offset: INTEGER
			x: NATURAL_32
		do
			in_size := op.count.abs
			limb_count := count // 32
			in_ptr := op.item
			if in_size > limb_count then
				x := in_ptr [in_ptr_offset + limb_count].bit_and (((1).to_natural_32 |<< (count \\ 32)- 1))
				if x /= 0 then
					res_size := limb_count + 1
					target.resize (res_size)
					target.item [limb_count] := x
				else
					res_size := limb_count
					res_size := normalize (in_ptr, in_ptr_offset, res_size)
					target.resize (res_size)
					limb_count := res_size
				end
			else
				res_size := in_size
				target.resize (res_size)
				limb_count := res_size
			end
			if target /= op then
				target.item.copy_data (op.item, 0, 0, limb_count)
			end
			if op.count >= 0 then
				target.count := res_size
			else
				target.count := -res_size
			end
		end
end
