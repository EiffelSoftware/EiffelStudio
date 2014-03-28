note
	description: "PCRE shared character sets"
	library: "Gobo Eiffel Regexp Library"
	copyright: "Copyright (c) 2001-2002, Harald Erdbruegger and others"
	license: "MIT License"

class SHARED_CHARACTER_SETS

feature -- Defaults

	default_character_case_mapping: CASE_MAPPING
			-- Default character lower- and upper-case mapping
		once
			create Result.make ("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz")
		ensure
			default_character_case_mapping_not_void: Result /= Void
		end

	default_word_set: PCRE_CHARACTER_SET
			-- Set of characters making up words
		once
			create Result.make ("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_")
		ensure
			default_word_set_not_void: Result /= Void
			default_word_set_not_empty: not Result.is_empty
		end

feature -- Character sets

	upper_set: PCRE_CHARACTER_SET
			-- Upper character set
		once
			create Result.make ("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
		ensure
			upper_set_not_void: Result /= Void
			upper_set_not_empty: not Result.is_empty
		end

	lower_set: PCRE_CHARACTER_SET
			-- Lower character set
		once
			create Result.make ("abcdefghijklmnopqrstuvwxyz")
		ensure
			lower_set_not_void: Result /= Void
			lower_set_not_empty: not Result.is_empty
		end

	alpha_set: PCRE_CHARACTER_SET
			-- Alphabetical character set
		once
			create Result.make_empty
			Result.add_set (lower_set)
			Result.add_set (upper_set)
		ensure
			alpha_set_not_void: Result /= Void
			alpha_set_not_empty: not Result.is_empty
		end

	digit_set: PCRE_CHARACTER_SET
			-- Digit character set
		once
			create Result.make ("0123456789")
		ensure
			digit_set_not_void: Result /= Void
			digit_set_not_empty: not Result.is_empty
		end

	alnum_set: PCRE_CHARACTER_SET
			-- Alphanumeric character set
		once
			create Result.make_empty
			Result.add_set (alpha_set)
			Result.add_set (digit_set)
		ensure
			alnum_set_not_void: Result /= Void
			alnum_set_not_empty: not Result.is_empty
		end

	xdigit_set: PCRE_CHARACTER_SET
			-- Hexadecimal digit character set
		once
			create Result.make ("0123456789abcdefABCDEF")
		ensure
			xdigit_set_not_void: Result /= Void
			xdigit_set_not_empty: not Result.is_empty
		end

	cntrl_set: PCRE_CHARACTER_SET
			-- Control character set
		local
			i: INTEGER
		once
			create Result.make_empty
			from
				i := 0
			until
				i > 31
			loop
				Result.add_character (i)
				i := i + 1
			end
			Result.add_character (127)
		ensure
			cntrl_set_not_void: Result /= Void
			cntrl_set_not_empty: not Result.is_empty
		end

	graph_set: PCRE_CHARACTER_SET
			-- Graph character set
		once
			create Result.make ("!%"#$%%&%'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
		ensure
			graph_set_not_void: Result /= Void
			graph_set_not_empty: not Result.is_empty
		end

	print_set: PCRE_CHARACTER_SET
			-- Printable character set
		once
			create Result.make (" !%"#$%%&%'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
		ensure
			print_set_not_void: Result /= Void
			print_set_not_empty: not Result.is_empty
		end

	punct_set: PCRE_CHARACTER_SET
			-- Punctuation character set
		once
			create Result.make ("!%"#$%%&%'()*+,-./:;<=>?@[\]^_`{|}~")
		ensure
			punct_set_not_void: Result /= Void
			punct_set_not_empty: not Result.is_empty
		end

	ascii_set: PCRE_CHARACTER_SET
			-- Ascii character set
		local
			i: INTEGER
		once
			create Result.make_empty
			from
				i := 0
			until
				i > 127
			loop
				Result.add_character (i)
				i := i + 1
			end
		ensure
			ascii_set_not_void: Result /= Void
			ascii_set_not_empty: not Result.is_empty
		end

	space_set: PCRE_CHARACTER_SET
			-- Space character set
		once
			create Result.make ("%T%N%F%R%/11/ ")
		ensure
			space_set_not_void: Result /= Void
			space_set_not_empty: not Result.is_empty
		end

	meta_set: PCRE_CHARACTER_SET
			-- Meta character set
		once
			create Result.make ("*+?{^.$|()[")
		ensure
			meta_set_not_void: Result /= Void
			meta_set_not_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	class_names: ARRAY [STRING]
			-- Names of POSIX character classes. The first three must be "alpha",
			-- "upper", "lower", as this is assumed for handling case independence.
		once
			Result := <<"alpha", "lower", "upper",
				"alnum", "ascii", "cntrl", "digit", "graph",
				"print", "punct", "space", "word", "xdigit">>
		end

	class_sets: ARRAY [PCRE_CHARACTER_SET]
			-- Must correspond to the list `class_names' above
		once
			Result := <<alpha_set, lower_set, upper_set, alnum_set, ascii_set, cntrl_set,
				digit_set, graph_set, print_set, punct_set, space_set, default_word_set, xdigit_set>>
		end

end
