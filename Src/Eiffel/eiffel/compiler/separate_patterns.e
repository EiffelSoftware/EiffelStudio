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
	SHARED_TYPE_I

create
	make

feature {NONE} -- Creation

	make
			-- Initialize table.
		do
			create patterns.make (0)
			create optimized_patterns.make (0)
			create tuple_patterns.make (0)
		end

feature -- Modification

	wipe_out
			-- Remove all items from the table.
		do
			patterns.wipe_out
			optimized_patterns.wipe_out
			tuple_patterns.wipe_out
		end

	put (f: CALL_ACCESS_B)
			-- Register a stub to call `f', add its declaration to a header file and generate its name to the current generation buffer.
		require
			f_attached: attached f
		local
			a: detachable SPECIAL [TYPE_C]
			i: C_PATTERN_INFO
			buffer: GENERATION_BUFFER
			k: like pattern_kind_attribute
		do
			if attached f.parameters as p then
				create a.make_empty (p.count)
				from
					p.start
				until
					p.after
				loop
					a.extend (p.item.c_type)
					p.forth
				end
			end
			create i.make (create {C_PATTERN}.make (f.return_c_type, a))
			i.set_c_pattern_id (patterns.count + 1)
			patterns.put (i)
			check attached patterns.item (i) as p then
				if f.is_attribute then
					k := pattern_kind_attribute
				else
					k := pattern_kind_routine
				end
				buffer := context.header_buffer
				buffer.put_new_line
				buffer.put_string ("extern ")
				generate_pattern_signature (p, k, buffer)
				buffer.put_character (';')
				generate_pattern_name (p, k, context.buffer)
			end
		end

	put_optimized (f: CALL_ACCESS_B)
			-- Register a stub to call `f' with an optimized result, add its declaration to a header file and generate its name to the current generation buffer.
		require
			f_attached: attached f
		local
			a: detachable SPECIAL [TYPE_C]
			i: C_PATTERN_INFO
			buffer: GENERATION_BUFFER
		do
			if attached f.parameters as p then
				create a.make_empty (p.count)
				from
					p.start
				until
					p.after
				loop
					a.extend (p.item.c_type)
					p.forth
				end
			end
			create i.make (create {C_PATTERN}.make (f.return_c_type, a))
			i.set_c_pattern_id (optimized_patterns.count + 1)
			optimized_patterns.put (i)
			check attached optimized_patterns.item (i) as p then
				buffer := context.header_buffer
				buffer.put_new_line
				buffer.put_string ("extern ")
				generate_pattern_signature (p, pattern_kind_optimized, buffer)
				buffer.put_character (';')
				generate_pattern_name (p, pattern_kind_optimized, context.buffer)
			end
		end

	put_tuple_access (f: TUPLE_ACCESS_B)
			-- Register a stub to call `f', add its declaration to a header file and generate its name to the current generation buffer.
		require
			f_attached: attached f
		local
			a: detachable SPECIAL [TYPE_C]
			i: C_PATTERN_INFO
			buffer: GENERATION_BUFFER
			result_type: TYPE_C
		do
			if attached f.source then
					-- Assignment to a tuple field.
					-- Set value type.
				create a.make_filled (context.real_type (f.tuple_element_type).c_type, 1)
				result_type := void_c_type
			else
					-- Retrieval of a tuple field value.
				result_type := context.real_type (f.tuple_element_type).c_type
			end
			create i.make (create {C_PATTERN}.make (result_type, a))
			i.set_c_pattern_id (tuple_patterns.count + 1)
			tuple_patterns.put (i)
			check attached tuple_patterns.item (i) as p then
				buffer := context.header_buffer
				buffer.put_new_line
				buffer.put_string ("extern ")
				generate_pattern_signature (p, pattern_kind_tuple, buffer)
				buffer.put_character (';')
				generate_pattern_name (p, pattern_kind_tuple, context.buffer)
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
				generate_pattern_signature (i, pattern_kind_routine, buffer)
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
				buffer.put_string ("(a -> address)) (a -> target")
				if attached p.argument_types as a then
						-- This pattern cannot be used for attribute call stub.
					is_attribute := False
					across
						a as x
					loop
						buffer.put_two_character (',', ' ')
						value := x.item
						is_reference := value.is_reference
						buffer.put_string ("a -> argument [")
							-- `x' is a SPECIAL so it is already zero-indexed.
						buffer.put_integer (x.target_index)
						buffer.put_two_character (']', '.')
						value.generate_typed_field (buffer)
					end
				end
				buffer.put_two_character (')', ';')
				buffer.generate_block_close
				if is_attribute then
						-- Generate pattern for attribute.
					buffer.put_new_line
					buffer.put_new_line
					generate_pattern_signature (i, pattern_kind_attribute, buffer)
					buffer.generate_block_open
					buffer.put_new_line
					buffer.put_character ('*')
					p.result_type.generate_access_cast (buffer)
					buffer.put_string ("(a -> result) = *")
					p.result_type.generate_access_cast (buffer)
					buffer.put_string (" (a->target + a->offset);")
					buffer.generate_block_close
				end
				t.forth
			end

				-- Generate stubs for optimized result values.
			t := optimized_patterns
			from
				t.start
			until
				t.after
			loop
				i := t.item_for_iteration
				p := i.pattern
				buffer.put_new_line
				buffer.put_new_line
				generate_pattern_signature (i, pattern_kind_optimized, buffer)
				buffer.generate_block_open
				buffer.put_gtcx
				buffer.put_new_line
				buffer.put_string ({C_CONST}.eif_optimize_return)
				buffer.put_five_character (' ', '=', ' ', '1', ';')
				buffer.put_new_line
				if not p.result_type.is_void then
					buffer.put_character ('*')
					p.result_type.generate_access_cast (buffer)
					buffer.put_string ("(a -> result) = ")
				end
				buffer.put_character ('*')
				p.result_type.generate_access_cast (buffer)
				buffer.put_character ('(')
				reference_c_type.generate_function_cast (buffer, p.argument_type_array, False)
				buffer.put_string ("(a -> address)) (a->target")
				if attached p.argument_types as a then
					across
						a as x
					loop
						buffer.put_two_character (',', ' ')
						value := x.item
						is_reference := value.is_reference
						buffer.put_string ("a -> argument [")
							-- `x' is a SPECIAL so it is already zero-indexed.
						buffer.put_integer (x.target_index)
						buffer.put_two_character (']', '.')
						value.generate_typed_field (buffer)
					end
				end
				buffer.put_two_character (')', ';')
				buffer.generate_block_close
				t.forth
			end

				-- Generate stubs for tuple access.
			t := tuple_patterns
			from
				t.start
			until
				t.after
			loop
				i := t.item_for_iteration
				p := i.pattern
				buffer.put_new_line
				buffer.put_new_line
				generate_pattern_signature (i, pattern_kind_tuple, buffer)
				buffer.generate_block_open
				buffer.put_new_line
					-- Reset indicator of an attribute call stub.
				if p.result_type.is_void then
						-- Write operation.
					value := p.argument_types [0]
					value.generate_tuple_put (buffer)
					buffer.put_string (" (a->target, a->offset, ")
					is_reference := value.is_reference
					buffer.put_string ("a -> argument [0].")
					value.generate_typed_field (buffer)
					buffer.put_two_character (')', ';')
				else
						-- Read operation.
					buffer.put_character ('*')
					p.result_type.generate_access_cast (buffer)
					buffer.put_string ("(a -> result) = ")
					p.result_type.generate_tuple_item (buffer)
					buffer.put_string (" (a -> target, a -> offset);")
				end
				buffer.generate_block_close
				buffer.put_new_line
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

	optimized_patterns: SEARCH_TABLE [C_PATTERN_INFO]
			-- Registered stubs to perform separate feature calls with optimized return value.

	tuple_patterns: SEARCH_TABLE [C_PATTERN_INFO]
			-- Registered stuns to perform separate access to tuples.

feature {NONE} -- Generation

	pattern_kind_attribute: NATURAL_8 = 1
			-- Pattern for an attribute.

	pattern_kind_routine: NATURAL_8 = 2
			-- Pattern for a routine.

	pattern_kind_optimized: NATURAL_8 = 3
			-- Pattern for an optimized function call.

	pattern_kind_tuple: NATURAL_8 = 4
			-- Pattern for a tuple.

	generate_pattern_name (info: C_PATTERN_INFO; pattern_kind: NATURAL_8; buffer: GENERATION_BUFFER)
			-- Generate a name of a pattern identified by `info' to buffer `buffer'.
			-- `pattern_kind' indicates whether the pattern is for attribute, routine, tuple.
		require
			info_attached: attached info
			buffer_attached: attached buffer
			valid_pattern_kind:
				pattern_kind = pattern_kind_attribute or
				pattern_kind = pattern_kind_routine or
				pattern_kind = pattern_kind_tuple or
				pattern_kind = pattern_kind_optimized
		do
			buffer.put_string ("eif_sc")
			inspect pattern_kind
			when pattern_kind_attribute then
				buffer.put_character ('a')
			when pattern_kind_routine then
				buffer.put_character ('r')
			when pattern_kind_optimized then
				buffer.put_character ('o')
			else
				buffer.put_character ('t')
			end
			buffer.put_integer (info.c_pattern_id)
		end

	generate_pattern_signature (info: C_PATTERN_INFO;  pattern_kind: NATURAL_8; buffer: GENERATION_BUFFER)
			-- Generate a signature of a pattern identified by `info' to buffer `buffer'.
			-- `pattern_kind' indicates whether the pattern is for attribute, routine, tuple.
		require
			i_attached: attached info
			b_attached: attached buffer
			valid_pattern_kind:
				pattern_kind = pattern_kind_attribute or
				pattern_kind = pattern_kind_routine or
				pattern_kind = pattern_kind_tuple or
				pattern_kind = pattern_kind_optimized
		do
			buffer.put_string ("void ")
			generate_pattern_name (info, pattern_kind, buffer)
			buffer.put_string (" (call_data * a)")
		end

invariant
	patterns_attached: attached patterns

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
