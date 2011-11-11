note
	description: "Summary description for {INTEGER_X_ACCESS}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "It is error alone which needs the support of government. Truth can stand by itself. -  Thomas Jefferson (1743-1846), U.S. President, Notes on the State of Virginia, 1782"

deferred class
	INTEGER_X_ACCESS

inherit
	INTEGER_X_FACILITIES
	SPECIAL_SIZING
	SPECIAL_ACCESS
		rename
			get_str as get_str_special
		end

feature

	get_string (op: READABLE_INTEGER_X; base: INTEGER): STRING_8
		require
			base >= 2
			base <= 62
		local
			xp: SPECIAL [NATURAL_32]
			xp_offset: INTEGER
			x_size: INTEGER
			str: STRING_8
			str_offset: INTEGER
			return_str: STRING_8
			return_str_offset: INTEGER
			str_size: INTEGER
			alloc_size: INTEGER
			num_to_text: CHARACTER_STRATEGY
			i: INTEGER
		do
			x_size := op.count
			if base <= 35 then
				create {CASE_INSENSITIVE_STRATEGY}num_to_text
			else
				create {CASE_SENSITIVE_STRATEGY}num_to_text
			end
			alloc_size := sizeinbase (op.item, 0, x_size.abs, base)
			alloc_size := alloc_size + (x_size < 0).to_integer
			create Result.make_filled ('%U', alloc_size)
			return_str := Result
			return_str_offset := 1
			if x_size < 0 then
				return_str [return_str_offset] := '-'
				return_str_offset := return_str_offset + 1
				x_size := -x_size
			end
			xp := op.item
			xp_offset := 0
			if not pow2_p (base.to_natural_32) then
				create xp.make_filled (0, x_size + 1)
				xp.copy_data (op.item, 0, 0, x_size)
			end
			str_size := get_str_special (return_str, return_str_offset, base, xp, xp_offset, x_size)
			str := return_str
			str.remove_tail (alloc_size - str_size - (return_str_offset - 1))
			str_offset := return_str_offset
			if str [str_offset] = (0x0).to_character_8 and str_size /= 1 then
				str_size := str_size - 1
				str_offset := str_offset + 1
			end
			from
				i := 0
			until
				i >= str_size
			loop
				return_str [return_str_offset + i] := num_to_text.number_to_text (str [str_offset + i].code.to_natural_8).to_character_8
				i := i + 1
			end
		end
end
