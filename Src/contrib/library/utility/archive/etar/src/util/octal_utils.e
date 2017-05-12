note
	description: "[
			Utilities to print numbers in octal representation 
			and parse octal formatted strings
			
			Inherit from this class to use its facilities
			
			Parsing allows natural numbers only
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	OCTAL_UTILS

feature -- Format check

	is_octal_formatted (a_string: READABLE_STRING_8): BOOLEAN
			-- Is `a_string' composed of characters allowed by octal formatting?
			-- i.e: composed by number from 0 to 7, without any sign or whitespace.
		local
			i,n: INTEGER
		do
			Result := True
			from
				i := 1
				n := a_string.count
			until
				i > n or not Result
			loop
				inspect
					a_string [i]
				when '0'..'7' then
					Result := True
				else
					Result := False
				end
				i := i + 1
			end
		ensure
			result_coherent: Result implies (
						(a_string.is_number_sequence and
							not a_string.has ('8') and not a_string.has ('9') and
							not a_string.has ('+') and not a_string.has ('-') and
							not a_string.has (' ')
						) or (
							a_string.is_empty
						)
					)
		end

	is_octal_natural_16_string (a_string: READABLE_STRING_8): BOOLEAN
			-- Does `a_string' represent an octal encoded NATURAL_16?
		do
			Result := is_octal_formatted (a_string) and (
								-- Length check
							(a_string.count - leading_zeros_count (a_string) < octal_16_max_digits)
							or (
								(a_string.count - leading_zeros_count (a_string) = octal_16_max_digits) and
								(a_string [leading_zeros_count (a_string) + 1].code <= ('1').code)
							)
						)
		end

	is_octal_natural_32_string (a_string: READABLE_STRING_8): BOOLEAN
			-- Does `a_string' represent an octal encoded NATURAL_32?
		do
			Result := is_octal_formatted (a_string) and (
								-- Length check
							(a_string.count - leading_zeros_count (a_string) < octal_32_max_digits)
							or (
								(a_string.count - leading_zeros_count (a_string) = octal_32_max_digits) and
								(a_string [leading_zeros_count (a_string) + 1].code <= ('3').code)
							)
						)
		end

	is_octal_natural_64_string (a_string: READABLE_STRING_8): BOOLEAN
			-- Does `a_string' represent an octal encoded NATURAL_64?
		do
			Result := is_octal_formatted (a_string) and (
								-- Length check
							(a_string.count - leading_zeros_count (a_string) < octal_64_max_digits)
							or (
								(a_string.count - leading_zeros_count (a_string) = octal_64_max_digits) and
								(a_string [leading_zeros_count (a_string) + 1].code <= ('1').code)
							)
						)
		end

feature -- Parsing

	octal_string_to_natural_16 (a_string: READABLE_STRING_8): NATURAL_16
			-- Converts `a_string' (interpreted as octal) to a NATURAL_16.
		require
			valid_input: is_octal_natural_16_string (a_string)
		do
			Result := octal_string_to_natural_64 (a_string).to_natural_16
		end

	octal_string_to_natural_32 (a_string: READABLE_STRING_8): NATURAL_32
			-- Converts `a_string' (interpreted as octal) to a NATURAL_32.
		require
			valid_input: is_octal_natural_32_string (a_string)
		do
			Result := octal_string_to_natural_64 (a_string).to_natural_32
		end

	octal_string_to_natural_64 (a_string: READABLE_STRING_8): NATURAL_64
			-- Converts `a_string' (interpreted as octal) to a NATURAL_64.
		require
			valid_input: is_octal_natural_64_string (a_string)
		local
			digit_weight: NATURAL_64
			i: INTEGER
			leading_zeros: INTEGER
		do
			digit_weight := 1
				-- Result is set by default to 0
			from
				i := a_string.count
				leading_zeros := leading_zeros_count (a_string)
			until
				i < leading_zeros + 1 -- last non-zero digit
			loop
				Result := Result + digit_weight * (a_string [i].code - ('0').code).to_natural_64
				digit_weight := digit_weight * 8
				i := i - 1
			end
		end

feature -- Output

	natural_16_to_octal_string (n: NATURAL_16): STRING_8
			-- Converts `n' to an octal string.
		do
			Result := natural_64_to_octal_string (n.to_natural_64)
		end

	natural_32_to_octal_string (n: NATURAL_32): STRING_8
			-- Converts `n' to an octal string.
		do
			Result := natural_64_to_octal_string (n.to_natural_64)
		end

	natural_64_to_octal_string (n: NATURAL_64): STRING_8
			-- Converts `n' to an octal string.
		local
			tmp: NATURAL_64
		do
			from
				tmp := n
				create Result.make (octal_64_max_digits)
			until
				tmp = 0
			loop
				Result.append_character (natural_8_to_octal_character ((tmp & 0c7).to_natural_8))
				tmp := tmp |>> 3
			end
			Result.mirror

			if Result.is_empty then
				Result := "0"
			end
		end

feature -- Utilities

	natural_8_to_octal_character (n: NATURAL_8): CHARACTER_8
			-- Convert `n' to its corresponding character representation.
		require
			in_range: 0 <= n and n <= 7
		do
			Result := (('0').code + n.to_integer_32).to_character_8
		ensure
			valid_character: ("01234567").has (Result)
		end

	leading_zeros_count (a_string: STRING_8): INTEGER
			-- The number of leading zeros of `a_string'.
		do
			from
				Result := 1
			until
				Result > a_string.count or else a_string [Result] /= '0'
			loop
				Result := Result + 1
			end
				-- Loop stops at first non-zero digit, hence subtract one
			Result := Result - 1
				-- "0" has no leading zeros
			Result := if not a_string.is_empty and Result = a_string.count then Result - 1 else Result end
		ensure
			leading_zeros: a_string.head (Result).to_natural = 0
			not_more_zeros: a_string.is_empty or else a_string [Result + 1] /= '0' or else Result + 1 = a_string.count
		end

	pad (a_string: STRING_8; n: INTEGER)
			-- Pad `a_string' with `n' zeros.
		require
			positive: n >= 0
		do
			a_string.prepend_string (create {STRING_8}.make_filled ('0', n))
		ensure
			prepended: a_string.count - n = old a_string.count
			zeros_prepended: a_string.head (n).to_natural_64 = 0
		end

feature -- Constants

	octal_16_max_digits: INTEGER = 6
			-- Maximal digits of a 16 bit natural octal string representation.

	octal_32_max_digits: INTEGER = 11
			-- Maximal digits of a 32 bit natural octal string representation.

	octal_64_max_digits: INTEGER = 22
			-- Maximal digits of a 64 bit natural octal string representation.

note
	copyright: "2015-2017, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
