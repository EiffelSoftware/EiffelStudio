indexing
	description: "Temporization buffer used during the C generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_BUFFER

inherit
	STRING_HANDLER

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create new generation buffer.
		require
			n_positive: n >= 0
		do
			create current_buffer.make (n)
			current_buffer_size := n
			create buffers.make (10)
		end

feature -- Status report

	tabs: INTEGER
			-- Number of inserted tabs.

	as_string: STRING is
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

feature -- Open, close buffer operations

	clear_all is
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
			current_buffer.set_count (0)
			buffers.wipe_out
		end

	start_c_specific_code is
			-- Write at beginning of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			put_string (starting_c_code_string)
		end

	end_c_specific_code is
			-- Write at end of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			put_string (ending_c_code_string)
		end

	flush_buffer (file: INDENT_FILE) is
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

	put_in_file (file: FILE) is
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

feature -- Settings

	set_is_il_generation (v: BOOLEAN) is
			-- Set `is_il_generation' with `v'.
		do
			is_il_generation := v
		ensure
			is_il_generation_set: is_il_generation = v
		end

feature -- Ids generation

	put_class_id (class_id: INTEGER) is
			-- Generate textual representation of class id
			-- in generated C code
		do
			current_buffer.append_integer (class_id)
		end

	put_real_body_id (real_body_id: INTEGER) is
			-- Generate textual representation of real body id
			-- in generated C code
		do
			current_buffer.append_integer (real_body_id - 1)
		end

	put_real_body_index (real_body_index: INTEGER) is
			-- Generate textual representation of real body index
			-- in generated C code
		do
			current_buffer.append_integer (real_body_index - 1)
		end

	put_type_id (type_id: INTEGER) is
			-- Generate textual representation of static type id
			-- in generated C code
		do
			current_buffer.append_integer (type_id - 1)
		end

	put_static_type_id (static_type_id: INTEGER) is
			-- Generate textual representation of type id
			-- in generated C code
		do
			current_buffer.append_integer (static_type_id - 1)
		end

feature -- Automatically indented output

	put_character (c: CHARACTER) is
			-- Write char `c'.
		do
			current_buffer.append_character (c)
		end

	put_two_character (a, b: CHARACTER) is
			-- Write char `a' and `b' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
		end

	put_three_character (a, b, c: CHARACTER) is
			-- Write char `a', `b' and `c' assuming no calls to `put_new_line' were done prior to this call.
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character (a)
			l_buffer.append_character (b)
			l_buffer.append_character (c)
		end

	put_four_character (a, b, c, d: CHARACTER) is
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

	put_integer (i: INTEGER) is
			-- Write int `i'.
		do
			current_buffer.append_integer (i)
		end

	put_integer_64 (i: INTEGER_64) is
			-- Write `i'.
		do
			current_buffer.append_integer_64 (i)
		end

	put_natural_8 (i: NATURAL_8) is
			-- Write natural `i'.
		do
			current_buffer.append_natural_8 (i)
		end

	put_natural_16 (i: NATURAL_16) is
			-- Write natural `i'.
		do
			current_buffer.append_natural_16 (i)
		end

	put_natural_32 (i: NATURAL_32) is
			-- Write natural `i'.
		do
			current_buffer.append_natural_32 (i)
		end

	put_natural_64 (i: NATURAL_64) is
			-- Write natural `i'.
		do
			current_buffer.append_natural_64 (i)
		end

	put_hex_natural_16 (v: NATURAL_16) is
			-- Write int `i' as an hexadecimal value.
		local
			i, nb, val: INTEGER
			a_digit: INTEGER
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			l_buffer.append_character ('0')
			l_buffer.append_character ('x')
				-- Complicated part: we estimate the required size depending
				-- on the size of the integer we are given. If it is too big
				-- to fit the `current_buffer', we resize it. We write the hex
				-- numbers by pair.
			if v <= 0xFF then
				nb := 2
			else
				nb := 4
			end
			i := nb + l_buffer.count
			if i > current_buffer_size then
				buffers.extend (l_buffer)
				create l_buffer.make (max_chunk_size)
				current_buffer := l_buffer
				i := nb
			end
			l_buffer.set_count (i)
			from
				val := v
			until
				nb = 0
			loop
				a_digit := (val & 0xF)
				l_buffer.put (a_digit.to_hex_character, i)
				val := val |>> 4
				i := i - 1
				nb := nb - 1
			end
		end

	put_string (s: STRING) is
			-- Write string `s'.
		require
			s_not_void: s /= Void
			s_not_void: s /= Void
		local
			l_buffer: like current_buffer
		do
			l_buffer := current_buffer
			if (l_buffer.count + s.count) > current_buffer_size then
				buffers.extend (l_buffer)
				create l_buffer.make (max_chunk_size.max (s.count))
				current_buffer := l_buffer
			end
			l_buffer.append (s)
		ensure
			new_count: count = old count + s.count
		end

	put_string_array (a: ARRAY [STRING]) is
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

	put_safe_array (a: ARRAY [ANY]) is
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
				put_string ((a @ i).out)
				i := i + 1
			end
		end

	put_local_registration (i: INTEGER; loc_name: STRING) is
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

	put_current_registration (i: INTEGER) is
			-- Write "RTLR(`i',Current);".
		require
			i_positive: i >= 0
		do
			put_local_registration (i, current_string)
		end

	put_result_registration (i: INTEGER) is
			-- Write "RTLR(`i',Result);".
		require
			i_positive: i >= 0
		do
			put_local_registration (i, result_string)
		end

	put_character_literal (c: CHARACTER) is
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

	put_string_literal (s: STRING) is
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
				variant
					i + 1
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
				end
				exdent
			else
					-- Put string in one chunk
				put_indivisible_string_literal (s)
			end
		end

	put_indivisible_string_literal (s: STRING) is
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

	put_gtcx is
			-- Add GTCX macro.
		do
			put_new_line
			put_string (gtcx_string)
		end

	generate_block_open is
			-- Open a new C block and indent code
		do
			put_new_line
			put_character ('{')
			indent
		ensure
			tabs_set: tabs = old tabs + 1
		end

	generate_block_close is
			-- Close C block.
		do
			exdent
			put_new_line
			put_character ('}')
		ensure
			tabs_set: tabs = old tabs - 1
		end

feature -- Formatting

	indent is
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1
		end

	exdent is
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0
		do
			tabs := tabs - 1
		end

	put_new_line_only is
			-- Write a '\n'.
		do
			current_buffer.append_character ('%N')
		end

	put_new_line is
			-- Write a '\n' and add the necessary `\t' after.
		do
			current_buffer.append_character ('%N')
			put_indentation
		end

	put_indentation is
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

	generate_extern_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, True, arg_types)
		end

	generate_static_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, False, arg_types)
		end

	generate_function_signature (type: STRING; f_name: STRING;
					extern: BOOLEAN; extern_header: like Current
					arg_names: ARRAY [STRING]; arg_types: ARRAY [STRING]) is
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
					put_string (arg_types @ i)
					current_buffer.append_character (' ')
					put_string (arg_names @ i)
					if i /= nb then
						put_string (l_sep)
					end
					i := i + 1
				end
			end

			current_buffer.append_character (')')
		end

feature {GENERATION_BUFFER} -- prototype code generation

	generate_function_declaration (type: STRING; f_name: STRING;
			extern: BOOLEAN; arg_types: ARRAY [STRING]) is
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
					put_string (arg_types @ i)
					i := i + 1
				end
			end
			put_two_character (')', ';')
		end

feature {NONE} -- Implementation: Status report

	is_il_generation: BOOLEAN
			-- Are we in IL code generation?

	current_buffer_size: INTEGER
			-- Size of buffers we will create.

	max_chunk_size: INTEGER is 262144
			-- Maximum size of chunks allocated (256KB)

	count: INTEGER is
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

	maximum_string_literal_count: INTEGER is 512
			-- Maximum length of C string literal
			-- (CL limit is 2048 - see CL error C2026)

feature {NONE} -- Implementation: Access

	current_buffer: STRING
			-- Currently used buffer.

	buffers: ARRAYED_LIST [like current_buffer]
			-- Store buffers when they become too large.


feature {NONE} -- Implementation

	escape_string (buffer: like current_buffer; s: STRING) is
			-- Append `buffer' with the escaped version of `s'
		require
			valid_arguments: s /= Void and then buffer /= Void
		do
			escape_substring (buffer, s, 1, s.count)
		end

	escape_substring (buffer: like current_buffer; s: STRING; start_index, end_index: INTEGER) is
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
			variant
				end_index - i + 2
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
			end
		end

	put_octal (buffer: like current_buffer; i: INTEGER) is
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

	starting_c_code_string: STRING is "%N%N#ifdef __cplusplus%Nextern %"C%" {%N#endif%N"
	ending_c_code_string: STRING is "%N%N#ifdef __cplusplus%N}%N#endif%N"
	coma_sep_string: STRING is ", "
	rtlr_string: STRING is "RTLR("
	current_string: STRING is "Current"
	result_string: STRING is "Result"
	static_string: STRING is "static "
	void_string: STRING is "void"
	gtcx_string: STRING is "GTCX"
	stdcall_string: STRING is " __stdcall "
	rtil_string: STRING is "RT_IL "
	extern_string: STRING is "extern "
			-- String constants for code generation to avoid useless creation of string objects.

invariant
	current_buffer_not_void: current_buffer /= Void
	buffers_not_void: buffers /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
