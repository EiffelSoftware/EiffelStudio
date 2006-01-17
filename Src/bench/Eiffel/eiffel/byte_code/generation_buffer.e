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
			create buffers.make (10)
			chunk_size := n
		ensure
			chunk_size_set: chunk_size = n
		end

feature -- Status report

	tabs: INTEGER
			-- Number of inserted tabs.

	as_string: STRING is
			-- Representation of Current as a STRING.
		do
			create Result.make (count)
			from
				buffers.start
			until
				buffers.after
			loop
				Result.append (buffers.item)
				buffers.forth
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
			old_tabs := 0
			emitted := False
				-- We reuse the first buffer allocated with `chunk_size' characters.
				-- If `buffers' is not empty, then the first buffer is at the first
				-- entry of `buffers', otherwise we simply reset `count' of 
				-- current_buffer.
			if not buffers.is_empty then
				current_buffer := buffers.first
			end
			current_buffer.set_count (0)
			buffers.wipe_out
		end

	open_write_c, start_c_specific_code is
			-- Write at beginning of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("%N#ifdef __cplusplus%Nextern %"C%" {%N#endif%N%N")
		end

	close_c, end_c_specific_code is
			-- Write at end of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("%N#ifdef __cplusplus%N}%N#endif%N%N")
		end

	flush_buffer (file: INDENT_FILE) is
			-- Flush buffer if `buffer.count' is about `chunk_size'.
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
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened_write: file.is_open_write
		do
			from
				buffers.start
			until
				buffers.after
			loop
				file.put_string (buffers.item)
				buffers.forth
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
			put_integer (class_id)
		end

	put_real_body_id (real_body_id: INTEGER) is
			-- Generate textual representation of real body id
			-- in generated C code
		do
			put_integer (real_body_id - 1)
		end

	put_real_body_index (real_body_index: INTEGER) is
			-- Generate textual representation of real body index
			-- in generated C code
		do
			put_integer (real_body_index - 1)
		end

	put_type_id (type_id: INTEGER) is
			-- Generate textual representation of static type id
			-- in generated C code
		do
			put_integer (type_id - 1)
		end

	put_static_type_id (static_type_id: INTEGER) is
			-- Generate textual representation of type id
			-- in generated C code
		do
			put_integer (static_type_id - 1)
		end

feature -- Basic element change

	put_character (c: CHARACTER) is
			-- Write char `c'.
		do
			emit_tabs
			current_buffer.append_character (c)
		end
	
	put_integer (i: INTEGER) is
			-- Write int `i'.
		do
			emit_tabs
			current_buffer.append_integer (i)
		end
	
	put_string (s: STRING) is
			-- Write string `s'.
		require
			s_not_void: s /= Void
		do
			emit_tabs
			append (s)
		end

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

	left_margin is
			-- Temporary reset to left margin
		do
			old_tabs := tabs
			tabs := 0
		end
	
	restore_margin is
			-- Restore margin value as of the one which was in
			-- use when a `left_margin' call was issued.
		do
			tabs := old_tabs
		end

	put_new_line is
			-- Write a '\n'.
		do
			current_buffer.append_character ('%N')
			emitted := False
		end

	put_local_registration (i: INTEGER; loc_name: STRING) is
			-- Write "RTLR(`i',`loc_name');".
		require
			i_positive: i >= 0
			loc_name_not_void: loc_name /= Void
			loc_name_not_empty: not loc_name.is_empty
		do
			emit_tabs
			append ("RTLR(")
			current_buffer.append_integer (i)
			current_buffer.append_character (',')
			append (loc_name)
			current_buffer.append_character (')')
			current_buffer.append_character (';')
		end

	put_current_registration (i: INTEGER) is
			-- Write "RTLR(`i',Current);".
		require
			i_positive: i >= 0
		do
			emit_tabs
			append ("RTLR(")
			current_buffer.append_integer (i)
			append (",Current);")
		end

	put_result_registration (i: INTEGER) is
			-- Write "RTLR(`i',Result);".
		require
			i_positive: i >= 0
		do
			emit_tabs
			append ("RTLR(")
			current_buffer.append_integer (i)
			append (",Result);")
		end

	put_string_literal (s: STRING) is
			-- Append string literal `s' breaking it into several chunks if required.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
			j: INTEGER
			n: INTEGER
		do
			i := s.count
			if i > maximum_string_literal_count then
					-- Put string in several chunks
				indent
				from
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
					emit_tabs
					put_character ('"')
					string_converter.escape_substring (current_buffer, s, j, j + n - 1)
					put_character ('"')
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
		do
			put_character ('"')
			string_converter.escape_string (current_buffer, s)
			put_character ('"')
		end	

	escape_char (c: CHARACTER) is
			-- Append `c' with C escape sequences.
		do
			string_converter.escape_char (current_buffer, c)
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
			-- including the starting '{'
		require
			non_void_args: type /= Void and f_name /= Void and
				arg_names /= Void and arg_types /= Void
			same_count: arg_names.count = arg_types.count
			valid_lower: arg_names.lower = 1 and arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			extern_header.generate_function_declaration (type, f_name, extern, arg_types)
			if not extern then
				append ("static ")
			end
			if is_il_generation then
				append ("RT_IL ")
			end
			append (type)
			if is_il_generation then
				append (" __stdcall ")
			else
				current_buffer.append_character (' ')
			end
			append (f_name)
			append (" (")

			nb := arg_names.count
			if nb = 0 then
				append ("void")
			else
				from
					i := 1
				until
					i > nb
				loop
					append (arg_types @ i)
					current_buffer.append_character (' ')
					append (arg_names @ i)
					if i /= nb then
						append (", ")
					end
					i := i + 1
				end
			end

			current_buffer.append_character (')')
			put_new_line
			current_buffer.append_character ('{')
			put_new_line
			if not is_il_generation then
				indent
				put_string ("GTCX")
				exdent
				put_new_line
			end
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
		do
			if extern then
				if is_il_generation then
					append ("RT_IL ")
				else
					append ("extern ")
				end
			else
				append ("static ")
			end

			append (type)
			if is_il_generation then
				append (" __stdcall ")
			else
				current_buffer.append_character (' ')
			end
			append (f_name)
			current_buffer.append_character ('(')
			nb := arg_types.count
			
			if nb = 0 then
				append ("void")
			else
				from
					i := 1
				until
					i > nb
				loop
					if i /= 1 then
						append (", ")
					end
					append (arg_types @ i)
					i := i + 1
				end
			end
			append (");%N")
		end

feature {NONE} -- Implementation: Status report

	is_il_generation: BOOLEAN
			-- Are we in IL code generation?

	emitted: BOOLEAN
			-- Have leading tabs already been emitted?

	old_tabs: INTEGER
			-- Saved indentation value

	chunk_size: INTEGER
			-- Size of buffers we will create.
			
	max_chunk_size: INTEGER is 262144
			-- Maximum size of chunks allocated (256KB)

	count: INTEGER is
			-- Number of characters in current.
		do
			from
				buffers.start
			until
				buffers.after
			loop
				Result := Result + buffers.item.count
				buffers.forth
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

	buffers: ARRAYED_LIST [STRING]
			-- Store buffers when they become too large.

	string_converter: STRING_CONVERTER is
			-- Instance of STRING_CONVERTER for `escape_string' and `escape_char'.
		once
			create Result
		end

feature {NONE} -- Implementation: Element change

	append (s: STRING) is
			-- Append a copy of `s' at end of `buffer'.
		require
			s_not_void: s /= Void
		local
			l_count: INTEGER
		do
			if (current_buffer.count + s.count) > current_buffer.capacity then
				l_count := count
				buffers.extend (current_buffer)
				create current_buffer.make (max_chunk_size.min (l_count * 2))
			end
			current_buffer.append (s)
		ensure
			new_count: count = old count + s.count
		end

	emit_tabs is
			-- Emit the `tabs' leading tabs
		local
			i: INTEGER
		do
			if not emitted then
				from
					i := 1
				until
					i > tabs
				loop
					current_buffer.append_character ('%T')
					i := i + 1
				end
				emitted := True
			end
		end

invariant
	current_buffer_not_void: current_buffer /= Void
	buffers_not_void: buffers /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class GENERATION_BUFFER
