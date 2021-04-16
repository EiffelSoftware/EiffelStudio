note
	description: "Temporization buffer used during the C generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_BUFFER

inherit
	STRING_HANDLER

	SHARED_ENCODING_CONVERTER

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create new generation buffer.
		require
			n_positive: n >= 0
		do
			create current_buffer.make (n)
			create buffers.make (10)
			initial_size := n
		end

feature -- Status report

	initial_size: INTEGER
			-- Initial size of generation buffer.

	tabs: INTEGER
			-- Number of inserted tabs.

	as_string: STRING
			-- Representation of Current as a STRING.
		local
			l_buffers: like buffers
		do
			create Result.make (count)
			from
				l_buffers := buffers
				l_buffers.start
			until
				l_buffers.after
			loop
				Result.append (l_buffers.item)
				l_buffers.forth
			end
			Result.append (current_buffer)
		ensure
			as_string_not_void: Result /= Void
		end

	is_empty: BOOLEAN
			-- Is current empty?
		do
			Result := count = 0
		end

feature -- Open, close buffer operations

	clear_all
			-- Reset the cache for a new generation
		do
			tabs := 0
				-- We reuse the first buffer allocated with the creation procedure.
				-- If `buffers' is not empty, then the first buffer is at the first
				-- entry of `buffers', otherwise we simply reset `count' of
				-- current_buffer.
			if not buffers.is_empty then
				current_buffer := buffers.first
			end
			if current_buffer.capacity > initial_size then
					-- Reset to initial size should 'area' be larger than `initial_size'
				current_buffer.make (initial_size)
			else
					-- No need for size reset.
				current_buffer.set_count (0)
			end
			buffers.wipe_out
		end

	start_c_specific_code
			-- Write at beginning of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			put_string (starting_c_code_string)
		end

	end_c_specific_code
			-- Write at end of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			put_string (ending_c_code_string)
		end

	flush_buffer (file: INDENT_FILE)
			-- Flush buffer to `file' if more than one buffer has been allocated.
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened_write: file.is_open_write
		do
			if not buffers.is_empty then
					-- When `buffers' is not empty then it means we have filled
					-- our first buffer chunk and it is now time to flush it
					-- to `file'.
				put_in_file (file)
			end
		end

	put_in_file (file: INDENT_FILE)
			-- Write Current into `file'
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened_write: file.is_open_write
		local
			l_buffers: like buffers
		do
			from
				l_buffers := buffers
				l_buffers.start
			until
				l_buffers.after
			loop
				file.put_string (l_buffers.item)
				l_buffers.forth
			end
			file.put_string (current_buffer)
			clear_all
		end

	put_buffer (a_buffer: like Current)
			-- Append `a_buffer' to Current.
		require
			a_buffer_not_void: a_buffer /= Void
		local
			l_buffers: like buffers
		do
			from
				l_buffers := a_buffer.buffers
				l_buffers.start
			until
				l_buffers.after
			loop
				put_string (l_buffers.item)
				l_buffers.forth
			end
			put_string (a_buffer.current_buffer)
		end

feature -- Settings

	set_is_il_generation (v: BOOLEAN)
			-- Set `is_il_generation' with `v'.
		do
			is_il_generation := v
		ensure
			is_il_generation_set: is_il_generation = v
		end

feature -- Ids generation

	put_class_id (class_id: INTEGER)
			-- Generate textual representation of class id
			-- in generated C code
		do
			current_buffer.append_integer (class_id)
		end

	put_real_body_id (real_body_id: INTEGER)
			-- Generate textual representation of real body id
			-- in generated C code
		do
			current_buffer.append_integer (real_body_id - 1)
		end

	put_real_body_index (real_body_index: INTEGER)
			-- Generate textual representation of real body index
			-- in generated C code
		do
			if real_body_index > 0 then
				current_buffer.append_integer (real_body_index - 1)
			else
					-- If the value is negative we can only output a hex format since
					-- a body index is an unsigned integer.
				put_hex_integer_32 (real_body_index)
			end
		end

	put_type_id (type_id: INTEGER)
			-- Generate textual representation of static type id
			-- in generated C code
		do
			current_buffer.append_integer (type_id - 1)
		end

	put_static_type_id (static_type_id: INTEGER)
			-- Generate textual representation of type id
			-- in generated C code
		do
			current_buffer.append_integer (static_type_id - 1)
		end

feature -- Automatically indented output

	put_character (c: CHARACTER)
			-- Write char `c'.
		do
			current_buffer.append_character (c)
		end

	put_two_character (a, b: CHARACTER)
			-- Write char `a' and `b' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
		end

	put_three_character (a, b, c: CHARACTER)
			-- Write char `a', `b' and `c' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
			l_buffer.append_character (c)
		end

	put_four_character (a, b, c, d: CHARACTER)
			-- Write char `a', `b', `c' and `d' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
			l_buffer.append_character (c)
			l_buffer.append_character (d)
		end

	put_five_character (a, b, c, d, e: CHARACTER)
			-- Write char `a', `b', `c', `d' and `e' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
			l_buffer.append_character (c)
			l_buffer.append_character (d)
			l_buffer.append_character (e)
		end

	put_integer (i: INTEGER)
			-- Write int `i'.
		do
			current_buffer.append_integer (i)
		end

	put_integer_64 (i: INTEGER_64)
			-- Write `i'.
		do
			current_buffer.append_integer_64 (i)
		end

	put_natural_8 (i: NATURAL_8)
			-- Write natural `i'.
		do
			current_buffer.append_natural_8 (i)
		end

	put_natural_16 (i: NATURAL_16)
			-- Write natural `i'.
		do
			current_buffer.append_natural_16 (i)
		end

	put_natural_32 (i: NATURAL_32)
			-- Write natural `i'.
		do
			current_buffer.append_natural_32 (i)
		end

	put_natural_64 (i: NATURAL_64)
			-- Write natural `i'.
		do
			current_buffer.append_natural_64 (i)
		end

	put_hex_integer_8 (v: INTEGER_8)
			-- Write integer `v' as a 16-bit hexadecimal value.
		do
			put_hex_natural_64 (v.as_natural_8)
		end

	put_hex_integer_16 (v: INTEGER)
			-- Write integer `v' as a 16-bit hexadecimal value.
		require
			valid_as_integer_16: v <= {INTEGER_16}.max_value
		do
			put_hex_natural_64 (v.as_natural_16)
		end

	put_hex_integer_32 (v: INTEGER_32)
			-- Write integer `v' as a 32-bit hexadecimal value.
		do
			put_hex_natural_64 (v.as_natural_32)
		end

	put_hex_integer_64 (v: INTEGER_64)
			-- Write integer `v' as a 32-bit hexadecimal value.
		do
			put_hex_natural_64 (v.as_natural_64)
		end

	put_hex_natural_8 (v: NATURAL_8)
			-- Write natural `v' as a 16-bit hexadecimal value.
		do
			put_hex_natural_64 (v)
		end

	put_hex_natural_16 (v: NATURAL)
			-- Write natural `v' as a 16-bit hexadecimal value.
		require
			valid_as_natural_16: v <= {NATURAL_16}.max_value
		do
			put_hex_natural_64 (v)
		end

	put_integer_for_type_array (i: INTEGER)
			-- Write `i' a non-negative integer as a sequence of 16-bit value.
			-- For values between 0 and 0x7FFF, write the value itself.
			-- For values between 0x8000 and 0x7FFFFFE, write 1xxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx.
			-- We do not enable 0x7FFFFFFF because this would generate 0x8FFF 0xFFFF and the 0xFFFF
			-- would be considered a terminator which is not what is intended.
		require
			i_non_negative: i >= 0
			i_not_maximum_integer: i < {INTEGER}.max_value
		do
			if i <= 0x7FFF then
				current_buffer.append_integer (i)
			else
				put_hex_natural_64 ((i.to_natural_64 |>> 16) | 0x8000)
				current_buffer.append_character (',')
				put_hex_natural_64 (i.as_natural_16)
			end
		end

	put_hex_natural_32 (v: NATURAL_32)
			-- Write natural `v' as a 32-bit hexadecimal value.
		do
			put_hex_natural_64 (v)
		end

	put_hex_natural_64 (v: NATURAL_64)
			-- Write natural `v' as a 32-bit hexadecimal value.
		local
			i, nb: INTEGER
			val, a_digit: NATURAL_64
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
				-- Complicated part: we estimate the required size depending
				-- on the size of the integer we are given. If it is too big
				-- to fit the `current_buffer', we resize it. We write the hex
				-- numbers by pair.
			if v <= 0xFFFFFFFF then
				if v <= 0xFFFF then
					if v <= 0xFF then
						nb := 4
					else
						nb := 6
					end
				elseif v <= 0xFFFFFF then
					nb := 8
				else
					nb := 10
				end
			elseif v <= 0xFFFFFFFFFFFF then
				if v <= 0xFFFFFFFFFF then
					nb := 12
				else
					nb := 14
				end
			elseif v <= 0xFFFFFFFFFFFFFF then
				nb := 16
			else
				nb := 18
			end
			i := nb + l_buffer.count
			if i > l_buffer.capacity then
				buffers.extend (l_buffer)
				create l_buffer.make (max_chunk_size.max (nb))
				current_buffer := l_buffer
				i := nb
			end
			l_buffer.set_count (i)
				-- Now write the hexa decimal number in reverse order.
			from
				val := v
					-- Remove the extra `0x' from `nb'
				nb := nb - 2
			until
				nb = 0
			loop
				a_digit := (val & 0xF)
				l_buffer.put (a_digit.to_hex_character, i)
				val := val |>> 4
				i := i - 1
				nb := nb - 1
			end
			l_buffer.put ('x', i)
			l_buffer.put ('0', i - 1)
		end

	put_string (s: READABLE_STRING_8)
			-- Write string `s'.
		require
			s_not_void: s /= Void
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			if (l_buffer.count + s.count) > l_buffer.capacity then
				buffers.extend (l_buffer)
				create l_buffer.make (max_chunk_size.max (s.count))
				current_buffer := l_buffer
			end
			l_buffer.append (s)
		ensure
			new_count: count = old count + s.count
		end

	put_string_array (a: ARRAY [STRING])
			-- Write elements of array `a'
		require
			a_not_void: a /= Void
		local
			i, nb: INTEGER
			sep: STRING
		do
			from
				i := 1
				nb := a.count
				sep := coma_sep_string
			until
				i > nb
			loop
				if i /= 1 then
					put_string (sep)
				end
				put_string (a [i])
				i := i + 1
			end
		end

	put_safe_array (a: ARRAY [ANY])
			-- Write elements of array `a'
		require
			a_not_void: a /= Void
		local
			i, nb: INTEGER
			sep: STRING
		do
			from
				i := 1
				nb := a.count
				sep := coma_sep_string
			until
				i > nb
			loop
				if i /= 1 then
					put_string (sep)
				end
				put_string ((a [i]).out)
				i := i + 1
			end
		end

	put_local_registration (i: INTEGER; loc_name: STRING)
			-- Write "RTLR(`i',`loc_name');".
		require
			i_positive: i >= 0
			loc_name_not_void: loc_name /= Void
			loc_name_not_empty: not loc_name.is_empty
		do
			put_new_line
			put_string (rtlr_string)
			current_buffer.append_integer (i)
			current_buffer.append_character (',')
			put_string (loc_name)
			current_buffer.append_character (')')
			current_buffer.append_character (';')
		end

	put_current_registration (i: INTEGER)
			-- Write "RTLR(`i',Current);".
		require
			i_positive: i >= 0
		do
			put_local_registration (i, current_string)
		end

	put_result_registration (i: INTEGER)
			-- Write "RTLR(`i',Result);".
		require
			i_positive: i >= 0
		do
			put_local_registration (i, result_string)
		end

	put_character_literal (c: CHARACTER)
			-- Append `c'.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character ('%'')
			inspect c
			when '"', '\', '%'', '?' then
				l_buffer.append_character ('\')
				l_buffer.append_character (c)
			else
				if c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
					l_buffer.append_character ('\')
					put_octal (l_buffer, c.code)
				else
					l_buffer.append_character (c)
				end
			end
			l_buffer.append_character ('%'')
		end

	put_string_literal (s: STRING)
			-- Append string literal `s' breaking it into several chunks if required.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
			j: INTEGER
			n: INTEGER
			l_current_buffer: like current_buffer
		do
			i := s.count
			if i > maximum_string_literal_count then
					-- Put string in several chunks
				indent
				from
					l_current_buffer := current_buffer
					j := 1
				invariant
					i >= 0
					i + j = s.count + 1
				until
					i = 0
				loop
					if i > maximum_string_literal_count then
						n := maximum_string_literal_count
					else
						n := i
					end
					put_new_line
					l_current_buffer.append_character ('"')
					escape_substring (l_current_buffer, s, j, j + n - 1)
					l_current_buffer.append_character ('"')
					i := i - n
					j := j + n
				variant
					i + 1
				end
				exdent
			else
					-- Put string in one chunk
				put_indivisible_string_literal (s)
			end
		end

	put_indivisible_string_literal (s: STRING)
			-- Append string literal `s' without breaking it into chunks.
		require
			s_not_void: s /= Void
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character ('"')
			escape_string (l_buffer, s)
			l_buffer.append_character ('"')
		end

	put_escaped_string (s: STRING)
			-- Append string `s' and add escape character if necessary.
		require
			s_not_void: s /= Void
		do
			escape_string (current_buffer, s)
		end

	generate_manifest_string_32 (value: STRING_32; is_immutable: BOOLEAN)
			-- Generate code that creates a new string with the content specified by `value`.
			-- The new string is of immutable variant if `is_immutable`.
		do
			put_string (if is_immutable then {C_CONST}.rtmis32_ex_h else {C_CONST}.rtms32_ex_h end)
			put_character ('(')
			put_string_literal (encoding_converter.string_32_to_stream (value))
			put_character(',')
			put_integer(value.count)
			put_character(',')
			put_integer (value.hash_code)
			put_character(')')
		end

	put_gtcx
			-- Add GTCX macro.
		do
			put_new_line
			put_string (gtcx_string)
		end

	generate_block_open
			-- Open a new C block and indent code
		do
			put_new_line
			put_character ('{')
			indent
		ensure
			tabs_set: tabs = old tabs + 1
		end

	generate_construct_block_open
			-- Open a new C block for a C construct such as `if', `while' and indent code.
			-- This will append to the current line, i.e. no new line is generated.
		do
			put_character ('{')
			indent
		ensure
			tabs_set: tabs = old tabs + 1
		end

	generate_block_close
			-- Close C block.
		do
			exdent
			put_new_line
			put_character ('}')
		ensure
			tabs_set: tabs = old tabs - 1
		end

feature -- Formatting

	indent
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1
		end

	exdent
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0
		do
			tabs := tabs - 1
		end

	put_new_line_only
			-- Write a '\n'.
		do
			current_buffer.append_character ('%N')
		end

	put_new_line
			-- Write a '\n' and add the necessary `\t' after.
		do
			current_buffer.append_character ('%N')
			put_indentation
		end

	put_indentation
			-- Write as many `\t' as `tabs'.
		local
			i: INTEGER
			l_buffer: like current_buffer
		do
			from
				i := tabs
				l_buffer := current_buffer
			until
				i = 0
			loop
				l_buffer.append_character ('%T')
				i := i - 1
			end
		end

feature -- prototype code generation

	generate_extern_declaration (type: STRING; f_name: STRING; arg_types: ARRAY [STRING])
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, True, arg_types)
		end

	generate_static_declaration (type: STRING; f_name: STRING; arg_types: ARRAY [STRING])
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, False, arg_types)
		end

	generate_function_signature (type: STRING; f_name: READABLE_STRING_8;
					extern: BOOLEAN; extern_header: like Current
					arg_names: ARRAY [STRING]; arg_types: ARRAY [STRING])
			-- Generate the function signature for ANSI C
			-- without the starting '{'
		require
			non_void_args: type /= Void and f_name /= Void and
				arg_names /= Void and arg_types /= Void
			same_count: arg_names.count = arg_types.count
			valid_lower: arg_names.lower = 1 and arg_types.lower = 1
		local
			i, nb: INTEGER
			l_sep: STRING
		do
			if extern_header /= Void then
				extern_header.generate_function_declaration (type, f_name, extern, arg_types)
			end
			put_new_line
			if not extern then
				put_string (static_string)
			end
			if is_il_generation then
				put_string (rtil_string)
			end
			put_string (type)
			if is_il_generation then
				put_string (stdcall_string)
			else
				current_buffer.append_character (' ')
			end
			put_string (f_name)
			put_two_character (' ', '(')

			nb := arg_names.count
			if nb = 0 then
				put_string (void_string)
			else
				from
					i := 1
					l_sep := coma_sep_string
				until
					i > nb
				loop
					put_string (arg_types [i])
					current_buffer.append_character (' ')
					put_string (arg_names [i])
					if i /= nb then
						put_string (l_sep)
					end
					i := i + 1
				end
			end

			current_buffer.append_character (')')
		end

feature {GENERATION_BUFFER} -- prototype code generation

	generate_function_declaration (type: STRING; f_name: READABLE_STRING_8; extern: BOOLEAN; arg_types: ARRAY [STRING])
				-- Generate funtion declaration using macros
		require
			type_not_void: type /= Void
			f_name_not_void: f_name /= Void
			arg_types_not_void: arg_types /= Void
		local
			i, nb: INTEGER
			l_sep: STRING
		do
			put_new_line
			if extern then
				if is_il_generation then
					put_string (rtil_string)
				else
					put_string (extern_string)
				end
			else
				put_string (static_string)
			end

			put_string (type)
			if is_il_generation then
				put_string (stdcall_string)
			else
				current_buffer.append_character (' ')
			end
			put_string (f_name)
			current_buffer.append_character ('(')
			nb := arg_types.count

			if nb = 0 then
				put_string (void_string)
			else
				from
					i := 1
					l_sep := coma_sep_string
				until
					i > nb
				loop
					if i /= 1 then
						put_string (l_sep)
					end
					put_string (arg_types [i])
					i := i + 1
				end
			end
			put_two_character (')', ';')
		end

feature {NONE} -- Implementation: Status report

	is_il_generation: BOOLEAN
			-- Are we in IL code generation?

	max_chunk_size: INTEGER = 262144
			-- Maximum size of chunks allocated (256KB)

	count: INTEGER
			-- Number of characters in current.
		local
			l_buffers: like buffers
			l_index: INTEGER
		do
			from
				l_buffers := buffers
				l_index := l_buffers.count
			until
				l_index = 0
			loop
				Result := Result + l_buffers.i_th (l_index).count
				l_index := l_index - 1
			end
			Result := Result + current_buffer.count
		ensure
			count_nonnegative: Result >= 0
		end

	maximum_string_literal_count: INTEGER = 512
			-- Maximum length of C string literal
			-- (CL limit is 2048 - see CL error C2026)

feature {GENERATION_BUFFER} -- Implementation: Access

	current_buffer: STRING
			-- Currently used buffer.

	buffers: ARRAYED_LIST [like current_buffer]
			-- Store buffers when they become too large.


feature {NONE} -- Implementation

	escape_string (buffer: like current_buffer; s: STRING)
			-- Append `buffer' with the escaped version of `s'
		require
			valid_arguments: s /= Void and then buffer /= Void
		do
			escape_substring (buffer, s, 1, s.count)
		end

	escape_substring (buffer: like current_buffer; s: STRING; start_index, end_index: INTEGER)
			-- Append escaped version of `s.substring (start_index, end_index)' to `buffer'.
		require
			buffer_not_void: buffer /= Void
			s_not_void: s /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= s.count
			valid_indexes: start_index <= end_index + 1
		local
			i: INTEGER
			c: CHARACTER
			l_area: SPECIAL [CHARACTER]
		do
			from
				i := start_index - 1
				l_area := s.area
			until
				i = end_index
			loop
				c := l_area.item (i)
				inspect c
				when '"', '\', '%'', '?' then
					buffer.append_character ('\')
					buffer.append_character (c)
				else
					if c < ' ' or c > '%/127/' then
							-- Assume ASCII set, sorry--RAM.
						buffer.append_character ('\')
						put_octal (buffer, c.code)
					else
						buffer.append_character (c)
					end
				end
				i := i + 1
			variant
				end_index - i + 2
			end
		end

	put_octal (buffer: like current_buffer; i: INTEGER)
			-- Print octal representation of `i' into `buffer'
			--| always generate 3 digits
		local
			val: INTEGER
			l_min_char: INTEGER
		do
			l_min_char := ('0').code
			if i < 64 then
				buffer.append_character ('0')
				if i < 8 then
					buffer.append_character ('0')
					buffer.append_character ((l_min_char + i).to_character_8)
				else
					buffer.append_character ((l_min_char + i // 8).to_character_8)
					buffer.append_character ((l_min_char + i \\ 8).to_character_8)
				end
			else
					-- First we compute the 3rd digit.
				buffer.append_character ((l_min_char + i // 64).to_character_8)
				val := i \\ 64
					-- Then the last digit as if it was a number less than 64.
				buffer.append_character ((l_min_char + val // 8).to_character_8)
				buffer.append_character ((l_min_char + val \\ 8).to_character_8)
			end
		ensure
			count_updated: buffer.count = old buffer.count + 3
		end

feature -- Constants

	starting_c_code_string: STRING = "%N%N#ifdef __cplusplus%Nextern %"C%" {%N#endif%N"
	ending_c_code_string: STRING = "%N%N#ifdef __cplusplus%N}%N#endif%N"
	coma_sep_string: STRING = ", "
	rtlr_string: STRING = "RTLR("
	current_string: STRING = "Current"
	result_string: STRING = "Result"
	static_string: STRING = "static "
	void_string: STRING = "void"
	gtcx_string: STRING = "GTCX"
	stdcall_string: STRING = " __stdcall "
	rtil_string: STRING = "RT_IL "
	extern_string: STRING = "extern "
			-- String constants for code generation to avoid useless creation of string objects.

invariant
	current_buffer_not_void: current_buffer /= Void
	buffers_not_void: buffers /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
