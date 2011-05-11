note
	description: "Collection of stubs that are used to perform separate feature calls in finalized mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEPARATE_PATTERNS

inherit
	SHARED_BYTE_CONTEXT
	SHARED_CODE_FILES

create
	make

feature {NONE} -- Creation

	make
			-- Initialize table.
		do
			create patterns.make (0)
		end

feature -- Modification

	wipe_out
			-- Remove all items from the table.
		do
			patterns.wipe_out
		end

	put (f: CALL_ACCESS_B)
			-- Register a stub to call `f', add its declaration to a header file and generate its name to the current generation buffer.
		require
			f_attached: attached f
		local
			a: detachable ARRAY [TYPE_C]
			i: C_PATTERN_INFO
			buffer: GENERATION_BUFFER
			is_attribute: BOOLEAN
		do
			if attached f.parameters as p then
				create a.make_empty
				from
					p.start
				until
					p.after
				loop
					a.force (p.item.c_type, a.upper + 1)
					p.forth
				end
			end
			create i.make (create {C_PATTERN}.make (f.c_type, a))
			i.set_c_pattern_id (patterns.count + 1)
			patterns.put (i)
			check attached patterns.item (i) as p then
				is_attribute := f.is_attribute
				buffer := context.header_buffer
				buffer.put_new_line
				buffer.put_string ("extern ")
				generate_pattern_signature (p, is_attribute, buffer)
				buffer.put_character (';')
				generate_pattern_name (p, is_attribute, context.buffer)
			end
		end

feature -- Generation

	generate
			-- Generate stubs.
		local
			t: like patterns
			i: C_PATTERN_INFO
			p: C_PATTERN
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
			value: TYPE_C
			is_reference: BOOLEAN
			is_attribute: BOOLEAN
		do
				-- Clear buffer for current generation
			buffer := context.buffer
			buffer.clear_all

				-- Generate header.
			buffer.put_string ("#include %"eif_macros.h%"%N")
			buffer.start_c_specific_code

				-- Generate stubs.
			t := patterns
			from
				t.start
			until
				t.after
			loop
				i := t.item_for_iteration
				p := i.pattern
				buffer.put_new_line
				buffer.put_new_line
				generate_pattern_signature (i, False, buffer)
				buffer.generate_block_open
				buffer.put_new_line
					-- Reset indicator of an attribute call stub.
				is_attribute := False
				if not p.result_type.is_void then
					buffer.put_character ('*')
					p.result_type.generate_access_cast (buffer)
					buffer.put_string ("(a -> result) = ")
						-- This pattern may fit attribute call stub.
					is_attribute := True
				end
				buffer.put_character ('(')
				p.result_type.generate_function_cast (buffer, p.argument_type_array, False)
				buffer.put_string ("(a -> feature.address)) (eif_access (a -> target)")
				if attached p.argument_types as a then
						-- This pattern cannot be used for attribute call stub.
					is_attribute := False
					across
						a as x
					loop
						buffer.put_two_character (',', ' ')
						value := x.item
						is_reference := value.is_reference
						if is_reference then
							buffer.put_string ("eif_access (")
						end
						buffer.put_string ("a -> argument [")
						buffer.put_integer (x.target_index - 1)
						buffer.put_two_character (']', '.')
						value.generate_typed_field (buffer)
						if is_reference then
							buffer.put_character (')')
						end
					end
				end
				buffer.put_two_character (')', ';')
				buffer.generate_block_close
				if is_attribute then
						-- Generate pattern for attribute.
					buffer.put_new_line
					buffer.put_new_line
					generate_pattern_signature (i, True, buffer)
					buffer.generate_block_open
					buffer.put_new_line
					buffer.put_character ('*')
					p.result_type.generate_access_cast (buffer)
					buffer.put_string ("(a -> result) = *")
					p.result_type.generate_access_cast (buffer)
					buffer.put_string (" (eif_access (a -> target) + a -> feature.offset);")
					buffer.generate_block_close
				end
				t.forth
			end

				-- Generate footer.
			buffer.end_c_specific_code

				-- Write file.
			create file.make_c_code_file (final_file_name (Epattern, Dot_c, 1));
			buffer.put_in_file (file)
			file.close
		end

feature {NONE} -- Access

	patterns: SEARCH_TABLE [C_PATTERN_INFO]
			-- Registered stubs to perform separate feature calls.

feature {NONE} -- Generation

	generate_pattern_name (info: C_PATTERN_INFO; is_attribute: BOOLEAN; buffer: GENERATION_BUFFER)
			-- Generate a name of a pattern identified by `info' to buffer `buffer'.
			-- `is_attribute' indicates whether the pattern is for attribute or not.
		require
			info_attached: attached info
			buffer_attached: attached buffer
		do
			buffer.put_string ("eif_sc")
			if is_attribute then
				buffer.put_character ('a')
			else
				buffer.put_character ('r')
			end
			buffer.put_integer (info.c_pattern_id)
		end

	generate_pattern_signature (info: C_PATTERN_INFO; is_attribute: BOOLEAN; buffer: GENERATION_BUFFER)
			-- Generate a signature of a pattern identified by `info' to buffer `buffer'.
			-- `is_attribute' indicates whether the pattern is for attribute or not.
		require
			i_attached: attached info
			b_attached: attached buffer
		do
			buffer.put_string ("void ")
			generate_pattern_name (info, is_attribute, buffer)
			buffer.put_string (" (call_data * a)")
		end

invariant
	patterns_attached: attached patterns

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
