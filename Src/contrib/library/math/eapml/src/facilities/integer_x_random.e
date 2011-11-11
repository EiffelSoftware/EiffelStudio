note
	description: "Summary description for {INTEGER_X_RANDOM}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Letting lawyers make laws is like letting doctors make diseases. - Anonymous"

deferred class
	INTEGER_X_RANDOM

inherit
	INTEGER_X_FACILITIES
	LIMB_MANIPULATION
	SPECIAL_COMPARISON
	SPECIAL_ARITHMETIC
	SPECIAL_UTILITY

feature

	urandomb (target: READABLE_INTEGER_X; state: RANDOM_NUMBER_GENERATOR; nbits: INTEGER)
			-- Generate a uniformly distributed random integer in the range 0 to 2^`n'-1, inclusive.
			-- `state' must be initialized by calling one of the randinit functions before invoking this function.
		local
			size: INTEGER_32
		do
			size := bits_to_limbs (nbits)
			target.resize (size)
			state.randget (target.item, 0, nbits)
			size := normalize (target.item, 0, size)
			target.count := size
		ensure
			target.bits <= nbits
		end

	urandomm (target: READABLE_INTEGER_X; state: RANDOM_NUMBER_GENERATOR; n: READABLE_INTEGER_X)
			-- Generate a uniform random integer in the range 0 to n-1, inclusive.
			-- `state' must be initialized by calling one of the randinit functions before invoking this function.
		local
			rp: SPECIAL [NATURAL_32]
			rp_offset: INTEGER
			np: SPECIAL [NATURAL_32]
			np_offset: INTEGER
			nlast: INTEGER
			nbits: INTEGER
			size: INTEGER
			count: INTEGER
			pow2: BOOLEAN
			cmp_l: INTEGER
			overlap: BOOLEAN
			junk: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			size := n.count.abs
			if size = 0 then
				(create {DIVIDE_BY_ZERO}).raise
			end
			np := n.item
			nlast := size - 1
			pow2 := pow2_p (n.item [nlast])
			if pow2 then
				from
					np := n.item
				until
					not pow2 or np_offset >= nlast
				loop
					if np [np_offset] /= 0 then
						pow2 := False
					end
					np_offset := np_offset + 1
				end
			end
			count := leading_zeros (np [nlast])
			nbits := size * limb_bits - (count) - pow2.to_integer
			if nbits = 0 then
				target.count := 0
			else
				np := n.item
				np_offset := 0
				rp := target.item
				rp_offset := 0
				if np = rp then
					overlap := True
					create np.make_filled (0, size)
					np.copy_data (n.item, 0, 0, size)
				end
				target.resize (size)
				rp := target.item
				rp [rp_offset + size - 1] := 0
				count := 80
				from
					cmp_l := 0
				until
					cmp_l < 0 or count = 0
				loop
					state.randget (rp, rp_offset, nbits)
					cmp_l := cmp (rp, rp_offset, np, np_offset, size)
					count := count - 1
				end
				if count = 0 then
					sub_n (rp, rp_offset, rp, rp_offset, np, np_offset, size, carry)
					junk := carry.item
				end
				size := normalize (rp, rp_offset, size)
				target.count := size
			end
		end
end
