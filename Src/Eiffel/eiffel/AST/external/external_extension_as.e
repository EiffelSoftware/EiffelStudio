note
	description: "Encapsulation of an external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXTENSION_AS

inherit
	COMPILER_EXPORTER

	SHARED_AST_CONTEXT

	SHARED_ERROR_HANDLER

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Types of the arguments (extracted from the C signature)

	return_type: INTEGER
			-- Return type (extracted from the C signature)

	header_files: ARRAY [INTEGER]
			-- Header files to include

	is_blocking_call: BOOLEAN
			-- May current external call block execution? If so, in multithreaded
			-- mode we need to ensure that GC will not be blocked waiting for the
			-- blocking call to resume.

	has_parsing_error: BOOLEAN
			-- Did last call to `parse' succeed?

feature -- Conveniences

	has_signature: BOOLEAN
			-- Does the extension define a c_signature?
		do
			Result := return_type > 0 or else argument_types /= Void
		end

feature {EXTERNAL_LANG_AS} -- Implementation

	parse
			-- Parse the external extension.
		do
			has_parsing_error := False
			parse_signature
			parse_include_files
			parse_special_part

				-- Clean memory from non-used attributes
			c_signature := Void
			include_files := Void
			special_part := Void
		end

feature -- Feature information

	extension_i: EXTERNAL_EXT_I
			-- EXTERNAL_EXT_I corresponding to current extension
		deferred
		end

	init_extension_i (ext_i: EXTERNAL_EXT_I)
			-- Initialize `ext_i'
		require
			ext_i_not_void: ext_i /= Void
		do
			ext_i.set_argument_types (argument_types)
			ext_i.set_header_files (header_files)
			ext_i.set_return_type (return_type)
			ext_i.set_is_blocking_call (is_blocking_call)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS)
			-- Perform type check on Current associated with `ext_as_b'.
		do
			type_check_signature
		end

	type_check_signature
			-- Perform type check on the signature.
		local
			ext_same_sign: EXT_SAME_SIGN
			error: BOOLEAN
		do
			if has_signature then
				if argument_types /= Void then
					if argument_types.count /= context.current_feature.argument_count then
						error := True
					end
				end
				if (return_type = 0) = context.current_feature.is_function then
					error := True
				end

				if error then
					create ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
				end
			end
		end

feature -- Setting

	set_include_files (s: STRING)
			-- Assign `s' to `include_files'.
		do
			include_files := s
		end

	set_signature (s: STRING)
			-- Assign `s' to `c_signature'.
		do
			c_signature := s
		end

	set_special_part (s: STRING)
			-- Assign `s' to `special_part'.
		do
			special_part := s
		end

	set_is_blocking_call (v: like is_blocking_call)
			-- Assign `v' to `is_blocking_call'.
		do
			is_blocking_call := v
		ensure
			is_blocking_call_set: is_blocking_call = v
		end

feature {NONE} -- Implementation

	parse_special_part
			-- Parse the special part clause.
		do
		end

	parse_signature
			-- Parse the signature clause.
		local
			end_arg_list: INTEGER
			pos, comma_pos, end_pos: INTEGER
			arg_count: INTEGER
			a_type: STRING
		do
			if c_signature /= Void then
				if c_signature [1] = '(' then
					end_arg_list := c_signature.index_of (')', 1)
					create argument_types.make_empty
					from
						pos := 2
					until
						pos >= end_arg_list
					loop
						comma_pos := c_signature.index_of (',', pos)
						if comma_pos = 0 then
								-- Last type
							end_pos := end_arg_list - 1
						else
							end_pos := comma_pos - 1
						end
						a_type := c_signature.substring (pos, end_pos)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.is_empty then
							insert_error ("Empty type declaration in signature")
						else
							arg_count := arg_count + 1
							Names_heap.put (a_type)
							argument_types.force (Names_heap.found_item, arg_count)
						end
						pos := end_pos + 2 -- position after comma or after )
					end
				else
					end_arg_list := 1
				end
				pos := c_signature.index_of (':', end_arg_list)
				if pos /= 0 then
					if pos = c_signature.count - 1 then
						insert_error ("Missing return type in signature")
					else
						a_type := c_signature.substring (pos + 1, c_signature.count)
						a_type.right_adjust
						a_type.left_adjust
						if a_type.is_empty then
							insert_error ("Missing return type in signature")
						else
							Names_heap.put (a_type)
							return_type := Names_heap.found_item
						end
					end
				end
			end
		end

	parse_include_files
			-- Parse the include file clause.
		local
			start_pos, end_pos: INTEGER
			include_count: INTEGER
			unprocessed: STRING
			header_f: STRING
			nb: INTEGER
			l_has_error: BOOLEAN
		do
			if include_files /= Void then
				include_files.left_adjust
				if include_files.is_empty then
					include_files := Void
				end
			end
			if include_files /= Void then
debug
	io.error.put_string ("Processing include files: ")
	io.error.put_string (include_files)
	io.error.put_new_line
end

				create unprocessed.make_from_string (include_files)
					-- Compute maximum number of include files
				nb := unprocessed.occurrences (',') + 1
				create header_files.make (1, nb)

				from
					start_pos := 1
				until
					unprocessed.is_empty or l_has_error
				loop
					end_pos := parse_file_name (unprocessed, start_pos)
					if end_pos = 0 then
						l_has_error := True
						insert_error ("Invalid include file")
					else
						include_count := include_count + 1
						header_f := unprocessed.substring (start_pos, end_pos)
						Names_heap.put (header_f)
						header_files.put (Names_heap.found_item, include_count)
						unprocessed.remove_head (end_pos)
						unprocessed.left_adjust
						if not unprocessed.is_empty then
								-- Must have a comma separator
							if unprocessed @ 1 = ',' then
									-- Remove comman and white space
								unprocessed.remove_head (1)
								unprocessed.left_adjust
							else
								l_has_error := True
								insert_error ("Invalid character after include file")
							end
						end
					end
				end
			end
		end

	parse_file_name (s: STRING; start: INTEGER): INTEGER
			-- Return position of the end of the file name in `s'
			-- or 0 for invalid construct (parsing starts at `start')
		require
			string_non_void: s /= Void and then s.count > 0
		do
debug
	io.error.put_string ("Parsing file name from ")
	io.error.put_string (s.substring (start, s.count))
	io.error.put_new_line
end
			inspect
				s @ start
			when '<' then
				Result := s.index_of ('>', start)
			when '%"' then
				if s.count >= start + 1 then
					Result := s.index_of ('%"', start + 1)
				end
			else
				Result := 0
			end
debug
	io.error.put_integer (start)
	io.error.put_new_line
	io.error.put_integer (s.count)
	io.error.put_new_line
	io.error.put_integer (Result)
	io.error.put_new_line
end
		end

	insert_error (msg: STRING)
			-- Raise syntax error (`msg' is the explanation).
		do
			has_parsing_error := True
		end

feature {NONE} -- Implementation

	c_signature: STRING
			-- Signature

	include_files: STRING
			-- Include files

	special_part: STRING;
			-- Special part

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

end -- class EXTERNAL_EXTENSION_AS
