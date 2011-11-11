note
	description: "Summary description for {INTEGER_X_ASSIGNMENT}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The object and practice of liberty lies in the limitation of governmental power. - General Douglas MacArthur"

deferred class
	INTEGER_X_ASSIGNMENT

inherit
	INTEGER_X_FACILITIES
	SPECIAL_ASSIGNMENT
		rename
			set_str as set_str_special
		end
	MP_BASES

feature

	swap (target: READABLE_INTEGER_X; other_a: READABLE_INTEGER_X)
			-- Swap the values `rop1' and `rop2' efficiently.
		local
			other_size: INTEGER_32
			other_pointer: SPECIAL [NATURAL_32]
		do
			other_size := other_a.count
			other_pointer := other_a.item
			other_a.count := target.count
			other_a.item := target.item
			target.count := other_size
			target.item := other_pointer
		end

	set_str (target: READABLE_INTEGER_X; str: READABLE_STRING_8; base_a: INTEGER)
			-- Set the value of `rop' from `str', a null-terminated C string in base `base'.
			-- White space is allowed in the string, and is simply ignored.
			-- The base may vary from 2 to 62, or if base is 0, then the leading characters
			-- are used: 0x and 0X for hexadecimal, 0b and 0B for binary, 0 for octal, or
			-- decimal otherwise.
			-- For bases up to 36, case is ignored; upper-case and lower-case letters have
			-- the same value.
			-- For bases 37 to 62, upper-case letter represent the usual 10..35 while
			-- lower-case letter represent 36..61.
			-- This function returns 0 if the entire string is a valid number in base base.
			-- Otherwise it returns -1.
		require
			base_a <= 62
			base_a >= 2 or base_a = 0
		local
			base: INTEGER
			str_offset: INTEGER
			s: SPECIAL [NATURAL_8]
			s_offset: INTEGER
			begs: INTEGER
			i: INTEGER
			xsize: INTEGER
			c: CHARACTER
			negative: BOOLEAN
			digit_value: CHARACTER_STRATEGY
			str_size: INTEGER
			dig: NATURAL_8
		do
			base := base_a
			if base > 36 then
				create {CASE_SENSITIVE_STRATEGY}digit_value
			else
				create {CASE_INSENSITIVE_STRATEGY}digit_value
			end
			from
				str_offset := 1
				c := ' '
			until
				not c.is_space or not str.valid_index (str_offset)
			loop
				c := str [str_offset]
				str_offset := str_offset + 1
			end
			if c = '-' then
				negative := True
				c := str [str_offset]
				str_offset := str_offset + 1
			end
			if base = 0 then
				if digit_value.text_to_number (c.code.to_natural_8) >= 10 then
					(create {INTEGER_X_STRING_EXCEPTION}).raise
				end
			else
				if digit_value.text_to_number (c.code.to_natural_8) >= base then
					(create {INTEGER_X_STRING_EXCEPTION}).raise
				end
			end
			if base = 0 then
				base := 10
				if c = '0' then
					base := 8
					if str.valid_index (str_offset) then
						c := str [str_offset]
					end
					str_offset := str_offset + 1
					if c = 'x' or c = 'X' then
						base := 16
						c := str [str_offset]
						str_offset := str_offset + 1
					elseif c = 'b' or c = 'B' then
						base := 2
						c := str [str_offset]
						str_offset := str_offset + 1
					end
				end
			end
			from
			until
				c /= '0' and not c.is_space or not str.valid_index (str_offset)
			loop
				c := str [str_offset]
				str_offset := str_offset + 1
			end
			if c.code = 0 then
				target.count := 0
				target.item [0] := 0
			else
				str_size := str.count - str_offset + 2
				create s.make_filled (0, str_size)
				from
					i := 0
				until
					i >= str_size
				loop
					if not c.is_space then
						dig := digit_value.text_to_number (c.code.to_natural_8)
						if dig.to_integer_32 >= base then
							(create {INTEGER_X_STRING_EXCEPTION}).raise
						end
						s [s_offset] := dig
						s_offset := s_offset + 1
					end
					if str.valid_index (str_offset) then
						c := str [str_offset]
					end
					str_offset := str_offset + 1
					i := i + 1
				end
				str_size := s_offset - begs
				xsize := (str_size / chars_per_bit_exactly (base)).truncated_to_integer // 32 + 2
				target.resize (xsize)
				xsize := set_str_special (target.item, 0, s, begs, str_size, base)
				if negative then
					target.count := -xsize
				else
					target.count := xsize
				end
			end
		end
end
