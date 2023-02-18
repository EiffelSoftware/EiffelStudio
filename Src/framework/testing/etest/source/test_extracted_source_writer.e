note
	description: "[
		Objects that print source code for extracted test sets.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXTRACTED_SOURCE_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			ancestor_names,
			put_indexing
		end

	TEST_CAPTURE_OBSERVER
		rename
			prepare as prepare_observer
		redefine
			is_ready,
			is_capturing_objects,
			is_capturing_invocations,
			on_prepare,
			on_prepare_for_objects,
			on_clean,
			on_invocation_capture,
			on_object_capture
		end

	CHARACTER_ROUTINES
--	UT_STRING_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create {STRING_32} class_name.make_empty
			create used_routine_names.make (10)
		end

feature -- Access

	class_name: READABLE_STRING_32
			-- <Precursor>

	ancestor_names: ARRAY [STRING]
			-- <Precursor>
		do
			Result := << extracted_ancestor_name >>
		end

	root_feature_name: STRING = ""
			-- <Precursor>

	used_routine_names: TAG_HASH_TABLE [NATURAL]
			-- Routine names which have been used in the current class
			--
			-- keys: routine names
			-- values: number of times routine name was used

feature {NONE} -- Access

	object_counter: NATURAL
			-- Number of objects that have been captured

feature {TEST_CAPTURER} -- Status report

	is_ready: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and is_writing
		end

	is_capturing_invocations: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and is_writing
		end

	is_capturing_objects: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and is_writing
		end

feature -- Status setting

	prepare (a_file: KI_TEXT_OUTPUT_STREAM; a_class_name: READABLE_STRING_32)
			-- Prepare printing a new axtracted application state to `a_file'.
		require
			not_writing: not is_writing
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			class_name := a_class_name
		ensure
			writing: is_writing
		end

feature {NONE} -- Query

	test_routine_name (a_feature: E_FEATURE): STRING_32
			-- Valid test routine name for feature in `a_stack_element'.
		do
			create Result.make_from_string (a_feature.name_32)
		ensure
			result_not_empty: not Result.is_empty
		end

feature {TEST_CAPTURER} -- Events

	on_invocation_capture (a_stack_element: TEST_CAPTURED_STACK_ELEMENT)
			-- <Precursor>
		local
			l_feat: E_FEATURE
			l_name: READABLE_STRING_32
			l_count: NATURAL
			l_list: LIST [STRING_32]
			i: INTEGER
		do
			l_feat := a_stack_element.called_feature
			l_name := test_routine_name (l_feat)
			used_routine_names.search (l_name)
			l_count := 1
			if used_routine_names.has (l_name) then
				l_count := used_routine_names.found_item + 1
			end
			used_routine_names.force (l_count, l_name)

			stream.indent
			stream.put_string ("test_")
			stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_name))
			if l_count > 1 then
				stream.put_character ('_')
				stream.put_line (l_count.out)
			else
				stream.put_line ("")
			end
			stream.indent

			put_indexing_keyword
			stream.indent
			stream.put_line ("testing: %"type/extracted%"")
			stream.put_string ("testing: %"covers/{")
			stream.put_string (a_stack_element.called_feature.associated_class.name)
			stream.put_string ("}.")
			stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_name))
			stream.put_line ("%"")
			stream.dedent

			stream.put_line ("do")
			stream.indent
			stream.put_string ("run_extracted_test (agent ")
			if a_stack_element.is_creation_procedure then
				if l_feat.argument_count > 0 then
					stream.put_string ("(")
					from
						l_list := a_stack_element.types
						l_list.start
						i := 1
					until
						l_list.after
					loop
						stream.put_string ("an_arg")
						stream.put_integer (i)
						stream.put_string (": ")
						stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_list.item_for_iteration))
						l_list.forth
						i := i + 1
						if not l_list.after then
							stream.put_string ("; ")
						end
					end
					stream.put_line (")")
				else
					stream.put_line ("")
				end
				stream.indent
				if a_stack_element.is_creation_procedure then
					stream.put_line ("local")
					stream.indent
					stream.put_line ("l_result: ANY")
					stream.dedent
				end
				stream.put_line ("do")
				stream.indent
				stream.put_string ("l_result := ")
				stream.put_string ("create {")
				stream.put_string (a_stack_element.type)
				stream.put_string ("}.")
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_feat.name_32))
				if a_stack_element.operands.count > 0 then
					stream.put_character ('(')
					from
						i := 1
					until
						i > l_feat.argument_count
					loop
						stream.put_string ("an_arg" + i.out)
						if i < l_feat.argument_count then
							stream.put_string (", ")
						end
						i := i + 1
					end
					stream.put_character (')')
				end
				stream.put_line ("")
				stream.dedent
				stream.put_string ("end")
				stream.dedent
			else
				stream.put_character ('{')
				stream.put_string (a_stack_element.type)
				stream.put_character ('}')
				stream.put_character ('.')
					-- |FIXME: Unicode encoding
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_feat.name_32))
			end
			stream.put_string (", [")
			from
				l_list := a_stack_element.operands
				l_list.start
			until
				l_list.after
			loop
				put_value (l_list.item_for_iteration)
				l_list.forth
				if not l_list.after then
					stream.put_string (", ")
				end
			end
			stream.put_line ("])")
			stream.dedent
			stream.put_line ("end%N")
			stream.dedent
			stream.dedent
		end

	on_object_capture (a_object: TEST_CAPTURED_OBJECT)
			-- <Precursor>
		local
			l_long_string: BOOLEAN
		do
			object_counter := object_counter + 1
			check
				valid_id: a_object.id = object_counter
			end
			if object_counter > 1 then
				stream.put_line (",")
			end
			stream.put_string ("[{")
			stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_object.type))

			l_long_string := a_object.is_string and then a_object.string.count > max_string_length
			if l_long_string then
				stream.put_line ("}, [%"%%")
			else
				stream.put_line ("}, [")
			end
			stream.indent
			stream.indent

			if l_long_string then
				put_manifest_string (a_object.string)
			elseif a_object.is_string then
				stream.put_character ('"')
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (eiffel_string_32 (a_object.string)))
				stream.put_character ('"')
				stream.put_line ("")
			elseif a_object.has_attributes then
				put_attributes (a_object.attributes)
			else
				put_items (a_object.items)
			end

			stream.dedent
			if l_long_string then
				stream.put_string ("%%%"], ")
			else
				stream.put_string ("], ")
			end
			stream.put_string (a_object.is_invariant_applicable.out)
			stream.put_character (']')
			stream.dedent
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
				put_indexing
				put_class_header
		end

	on_prepare_for_objects
			-- <Precursor>
		do
			stream.put_line ("feature {NONE} -- Access%N")
			stream.indent
			stream.put_line ("context: ARRAY [TUPLE [type: TYPE [ANY]; attributes: TUPLE; inv: BOOLEAN]]")
			stream.indent
			stream.indent
			stream.put_line ("-- <Precursor>")
			stream.dedent
			stream.put_line ("do")
			stream.indent
			stream.put_line ("Result := <<")
			stream.indent
			object_counter := 0
		end

	on_clean
			-- <Precursor>
		do
			stream.put_new_line
			stream.dedent
			stream.put_line (">>")
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_new_line
			stream.put_line ("end")
			used_routine_names.wipe_out
		end

feature {NONE} -- Output

	put_indexing
			-- Append indexing clause.
		do
			put_indexing_keyword
			stream.indent
			stream.put_line ("description: %"Regression tests reproducing application state of a previous execution.%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.dedent
			stream.put_line ("")
		end

	put_manifest_string (a_string: STRING_32)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_string.count
			loop
				stream.put_character ('%%')
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8
					(eiffel_string_32 (a_string.substring (i, (i + max_string_length - 1).min (a_string.count)))))
				stream.put_line ("%%")
				i := i + max_string_length
			end
		end

	put_attributes (a_table: HASH_TABLE [STRING, STRING_32])
		do
			from
				a_table.start
			until
				a_table.after
			loop
				stream.put_character ('"')
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_table.key_for_iteration))
				stream.put_string ("%",  ")
				put_value (a_table.item_for_iteration)
				a_table.forth
				if a_table.after then
					stream.put_line ("")
				else
					stream.put_line (",")
				end
			end
		end

	put_items (a_list: LIST [STRING])
		local
			l_count: INTEGER
		do
			from
				a_list.start
			until
				a_list.after
			loop
				put_value (a_list.item_for_iteration)
				l_count := l_count + a_list.item_for_iteration.count
				a_list.forth
				if a_list.after then
					stream.put_line ("")
				else
					if l_count + a_list.item_for_iteration.count > max_string_length then
						stream.put_line (",")
						l_count := 0
					else
						stream.put_string (", ")
					end
				end
			end
		end

	put_value (a_value: STRING_32)
		do
			if a_value.is_natural then
				stream.put_character ('"')
				stream.put_character ('#')
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_value))
				stream.put_character ('"')
			else
				stream.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_value))
			end
		end

feature {NONE} -- Constants

	max_string_length: INTEGER = 80

	extracted_ancestor_name: STRING = "EQA_EXTRACTED_TEST_SET"

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
