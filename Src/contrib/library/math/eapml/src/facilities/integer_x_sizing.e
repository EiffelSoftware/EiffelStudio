note
	description: "Summary description for {INTEGER_X_SIZING}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "My freedom is more important than your great idea. - Anonymous"

deferred class
	INTEGER_X_SIZING

inherit
	INTEGER_X_FACILITIES
	LIMB_BIT_SCANNING
	LIMB_MANIPULATION
	MP_BASES

feature

	sizeinbase (op: READABLE_INTEGER_X; base: INTEGER): INTEGER_32
			-- Return the size of `op' measured in number of digits in the given base.
			-- `base' can vary from 2 to 62.
			-- The sign of `op' is ignored, just the absolute value is used.
			-- The result will be either exact or 1 too big.
			-- If `base' is a power of 2, the result is always exact.
			-- If `op' is zero the return value is always 1.
			-- This function can be used to determine the space required when converting `op' to a string.
			-- The right amount of allocation is normally two more than the value returned, one extra for
			-- a minus sign and one for the null-terminator.
			-- It will be noted that `sizeinbase(op,2)' can be used to locate the most significant 1
			-- bit in `op', counting from 1. (Unlike the bitwise functions which start from 0.
		local
			lb_base: NATURAL_32
			cnt: INTEGER_32
			totbits: INTEGER_32
		do
			if op.count.abs = 0 then
				Result := 1
			else
				cnt := leading_zeros (op.item [op.count.abs - 1])
				totbits := op.count.abs * limb_bits - cnt
				if pow2_p (base.to_natural_32) then
					lb_base := big_base (base)
					Result := (totbits + lb_base.to_integer_32 - 1) // lb_base.to_integer_32
				else
					Result := ((totbits.to_double * chars_per_bit_exactly (base)) + 1).truncated_to_integer
				end
			end
		end
end
