note
	description: "Summary description for {LIMB_BIT_SCANNING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIMB_BIT_SCANNING

inherit
	LIMB_DEFINITION

feature

	leading_zeros (limb_a: NATURAL_32): INTEGER
		do
			if limb_a = 0 then
				Result := limb_bits
			else
				Result := count_leading_zeros (limb_a)
			end
		end

	most_significant_one (limb_a: NATURAL_32): INTEGER
			-- 31 high, 0 low
		require
			limb_a /= 0
		do
			Result := limb_high_bit - leading_zeros (limb_a)
		end

	trailing_zeros (limb_a: NATURAL_32): INTEGER
			-- 31 high, 0 low
		require
			limb_a /= 0
		do
			Result := count_trailing_zeros (limb_a)
		end

feature {NONE} -- Implementation

	count_trailing_zeros (limb_a: NATURAL_32): INTEGER
		external
			"C inline"
		alias
			"[
				return __builtin_ctz ($limb_a);
			]"
		end

	count_leading_zeros (limb_a: NATURAL_32): INTEGER
		external
			"C inline"
		alias
			"[
				return __builtin_clz ($limb_a);
			]"
		end
end
