note
	description: "Summary description for {NUMBER_SIZING}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Whatever you do will be insignificant, but it is very important that you do it. -  Mahatma Gandhi"

deferred class
	SPECIAL_SIZING

inherit
	LIMB_MANIPULATION
	MP_BASES

feature

	sizeinbase (source: SPECIAL [NATURAL_32]; source_offset: INTEGER; size: INTEGER; base: INTEGER): INTEGER
		require
			size >= 0
			base >= 2
		local
			lb_base: INTEGER
			count: INTEGER
			total_bits: INTEGER
		do
			if size = 0 then
				Result := 1
			else
				count := leading_zeros (source [source_offset + size - 1])
				total_bits := size * limb_bits - count
				if pow2_p (base.to_natural_32) then
					lb_base := big_base (base).to_integer_32
					Result := (total_bits + lb_base - 1) // lb_base
				else
					Result := ((total_bits * chars_per_bit_exactly (base)) + 1).truncated_to_integer
				end
			end
		end

	sizeinbase_2exp (ptr: SPECIAL [NATURAL_32]; ptr_offset: INTEGER; ptr_count: INTEGER; base2exp: INTEGER): INTEGER
		require
			ptr_count > 0
			ptr [ptr_offset + ptr_count - 1] /= 0
		local
			count: INTEGER
			totbits: INTEGER
		do
			count := leading_zeros (ptr [ptr_offset + ptr_count - 1])
			totbits := ptr_count * limb_bits - count
			Result := (totbits + base2exp - 1) // base2exp
		end
end
