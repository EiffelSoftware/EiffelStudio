note
	description: "Summary description for {INTEGER_X_GCD}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "'Need' now means wanting someone else's money. 'Greed' means wanting to keep your own. 'Compassion' is when a politician arranges the transfer. -  Joseph Sobran, columnist."

deferred class
	INTEGER_X_GCD

inherit
	INTEGER_X_FACILITIES
	SPECIAL_GCD
		rename
			gcd as gcd_special
		export
			{NONE}
				all
		end

feature

	gcd (g: READABLE_INTEGER_X; u: READABLE_INTEGER_X; v: READABLE_INTEGER_X)
		local
			g_zero_bits: INTEGER
			u_zero_bits: INTEGER
			v_zero_bits: INTEGER
			g_zero_limbs: INTEGER
			u_zero_limbs: INTEGER
			v_zero_limbs: INTEGER
			tp: SPECIAL [NATURAL_32]
			tp_offset: INTEGER
			up: SPECIAL [NATURAL_32]
			up_offset: INTEGER
			usize: INTEGER
			vp: SPECIAL [NATURAL_32]
			vp_offset: INTEGER
			vsize: INTEGER
			gsize: INTEGER
			junk: NATURAL_32
			cy_limb: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			up := u.item
			usize := u.count.abs
			vp := v.item
			vsize := v.count.abs
			if usize = 0 then
				g.count := vsize
				if g = v then
				else
					g.resize (vsize)
					g.item.copy_data (vp, 0, 0, vsize)
				end
			elseif vsize = 0 then
				g.count := usize
				if g = u then
				else
					g.resize (usize)
					g.item.copy_data (up, up_offset, 0, usize)
				end
			elseif usize = 1 then
				g.count := 1
				g.item [0] := gcd_1 (vp, vp_offset, vsize, up [up_offset])
			elseif vsize = 1 then
				g.count := 1
				g.item [0] := gcd_1 (up, up_offset, usize, vp [vp_offset])
			else
				from
				until
					up [up_offset] /= 0
				loop
					up_offset := up_offset + 1
				end
				u_zero_limbs := up_offset - 0
				usize := usize - u_zero_limbs
				u_zero_bits := trailing_zeros (up [up_offset])
				tp := up
				tp_offset := up_offset
				create up.make_filled (0, usize)
				if u_zero_bits /= 0 then
					rshift (up, up_offset, tp, tp_offset, usize, u_zero_bits, carry)
					junk := carry.item
					usize := usize - (up [up_offset + usize - 1] = 0).to_integer
				else
					up.copy_data (tp, tp_offset, up_offset, usize)
				end
				from
				until
					vp [vp_offset] /= 0
				loop
					vp_offset := vp_offset + 1
				end
				v_zero_limbs := vp_offset - 0
				vsize := vsize - v_zero_limbs
				v_zero_bits := trailing_zeros (vp [vp_offset])
				tp := vp
				tp_offset := vp_offset
				create vp.make_filled (0, vsize)
				if v_zero_bits /= 0 then
					rshift (vp, vp_offset, tp, tp_offset, vsize, v_zero_bits, carry)
					junk := carry.item
					vsize := vsize - (vp [vp_offset + vsize - 1] = 0).to_integer
				else
					vp.copy_data (tp, tp_offset, vp_offset, vsize)
				end
				if u_zero_limbs > v_zero_limbs then
					g_zero_limbs := v_zero_limbs
					g_zero_bits := v_zero_bits
				elseif u_zero_limbs < v_zero_limbs then
					g_zero_limbs := u_zero_limbs
					g_zero_bits := u_zero_bits
				else
					g_zero_limbs := u_zero_limbs
					g_zero_bits := u_zero_bits.min (v_zero_bits)
				end
				if usize < vsize or (usize = vsize and up [up_offset + usize - 1] < vp [vp_offset + vsize - 1]) then
					vsize := gcd_special (vp, vp_offset, vp, vp_offset, vsize, up, up_offset, usize)
				else
					vsize := gcd_special (vp, vp_offset, up, up_offset, usize, vp, vp_offset, vsize)
				end
				gsize := vsize + g_zero_limbs
				if g_zero_bits /= 0 then
					gsize := gsize + ((vp [vp_offset + vsize - 1] |>> (32 - g_zero_bits)) /= 0).to_integer
					g.resize (gsize)
					g.item.fill_with (0, 0, g_zero_limbs)
					tp := g.item
					tp_offset := g_zero_limbs
					lshift (tp, tp_offset, vp, vp_offset, vsize, g_zero_bits, carry)
					cy_limb := carry.item
					if cy_limb /= 0 then
						tp [tp_offset + vsize] := cy_limb
					end
				else
					g.resize (gsize)
					g.item.fill_with (0, 0, g_zero_limbs)
					g.item.copy_data (vp, vp_offset, g_zero_limbs, vsize)
				end
				g.count := gsize
			end
		ensure
			g.count /= 0
		end
end
