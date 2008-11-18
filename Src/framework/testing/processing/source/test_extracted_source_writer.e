indexing
	description: "[
		Objects that print source code for extracted test sets.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXTRACTED_SOURCE_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			root_feature_name,
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

	UT_STRING_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create class_name.make_empty
			create used_routine_names.make_default
			used_routine_names.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [!STRING]})
		end

feature -- Access

	class_name: !STRING
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "EQA_EXTRACTED_TEST_SET" >>
		end

	root_feature_name: !STRING = ""
			-- <Precursor>

feature {NONE} -- Access

	used_routine_names: !DS_HASH_TABLE [NATURAL, !STRING]
			-- Routine names which have been used in the current class
			--
			-- keys: routine names
			-- values: number of times routine name was used

	object_counter: NATURAL
			-- Number of objects that have been captured

feature {EIFFEL_TEST_CAPTURER} -- Status report

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

	prepare (a_file: !KI_TEXT_OUTPUT_STREAM; a_class_name: !STRING)
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

	test_routine_name (a_feature: !E_FEATURE): !STRING
			-- Valid test routine name for feature in `a_stack_element'.
		local
			i: INTEGER_32
			l_custom_symbol: STRING_8
		do
			if a_feature.is_prefix then
				Result := "prefix_"
				if a_feature.prefix_symbol.is_equal ("+") then
					Result.append ("plus")
				elseif a_feature.prefix_symbol.is_equal ("-") then
					Result.append ("minus")
				else
						-- Replace all non-alpha-numeric characters with valid representations.
					from
						create l_custom_symbol.make_empty
						i := 1
					until
						i > a_feature.prefix_symbol.count
					loop
						if a_feature.prefix_symbol.item (i).is_alpha_numeric then
							l_custom_symbol.append_character (a_feature.prefix_symbol.item (i))
						else
							inspect a_feature.prefix_symbol.item (i)
							when '#' then
								l_custom_symbol.append_string ("_symb_number_")
							when '|' then
								l_custom_symbol.append_string ("_symb_vertbar_")
							when '@' then
								l_custom_symbol.append_string ("_symb_at_")
							when '&' then
								l_custom_symbol.append_string ("_symb_amp_")
							else
								l_custom_symbol.append_string ("_symb_" + a_feature.prefix_symbol.item (i).code.out + "_")
							end
						end
						i := i + 1
					end
					Result.append (l_custom_symbol)
				end
			elseif a_feature.is_infix then
    			Result := "infix_"
				if a_feature.infix_symbol.is_equal ("+") then
					Result.append ("plus")
				elseif a_feature.infix_symbol.is_equal ("-") then
					Result.append ("minus")
				elseif a_feature.infix_symbol.is_equal ("*") then
					Result.append ("multiply")
				elseif a_feature.infix_symbol.is_equal ("/") then
					Result.append ("division")
				elseif a_feature.infix_symbol.is_equal ("<") then
					Result.append ("less")
				elseif a_feature.infix_symbol.is_equal (">") then
					Result.append ("greater")
				elseif a_feature.infix_symbol.is_equal ("<=") then
					Result.append ("less_or_equal")
				elseif a_feature.infix_symbol.is_equal (">=") then
					Result.append ("greater_or_equal")
				elseif a_feature.infix_symbol.is_equal ("//") then
					Result.append ("integer_division")
				elseif a_feature.infix_symbol.is_equal ("\\") then
					Result.append ("modulo")
				elseif a_feature.infix_symbol.is_equal ("^") then
					Result.append ("power")
				else
						-- Replace all non-alpha-numeric characters with valid representations.
					from
						create l_custom_symbol.make_empty
						i := 1
					until
						i > a_feature.infix_symbol.count
					loop
						if a_feature.infix_symbol.item (i).is_alpha_numeric then
							l_custom_symbol.append_character (a_feature.infix_symbol.item (i))
						else
							inspect a_feature.infix_symbol.item (i)
							when '#' then
								l_custom_symbol.append_string ("_symb_number_")
							when '|' then
								l_custom_symbol.append_string ("_symb_vertbar_")
							when '@' then
								l_custom_symbol.append_string ("_symb_at_")
							when '&' then
								l_custom_symbol.append_string ("_symb_amp_")
							else
								l_custom_symbol.append_character ('_')
							end
						end
						i := i + 1
					end
					Result.append (l_custom_symbol)
				end
			else
				create Result.make_from_string (a_feature.name)
			end
		ensure
			result_not_empty: not Result.is_empty
		end

feature {EIFFEL_TEST_CAPTURER} -- Events

	on_invocation_capture (a_stack_element: !TEST_CAPTURED_STACK_ELEMENT)
			-- <Precursor>
		local
			l_feat: E_FEATURE
			l_name: STRING
			l_count: NATURAL
			l_cursor: DS_LINEAR_CURSOR [!STRING]
			l_types: !DS_ARRAYED_LIST [!STRING]
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
			stream.put_string (l_name)
			if l_count > 1 then
				stream.put_character ('_')
				stream.put_line (l_count.out)
			else
				stream.put_line ("")
			end
			stream.indent

			stream.put_line ("indexing")
			stream.indent
			stream.put_string ("testing: %"covers/{")
			stream.put_string (a_stack_element.called_feature.associated_class.name)
			stream.put_string ("}.")
			stream.put_string (l_name)
			stream.put_line ("%"")
			stream.dedent

			stream.put_line ("do")
			stream.indent
			stream.put_string ("run_extracted_test (agent ")
			if a_stack_element.is_creation_procedure or a_stack_element.is_xfix then
				if l_feat.argument_count > 0 or a_stack_element.is_xfix then
					stream.put_string ("(")
					from
						l_cursor := a_stack_element.types.new_cursor
						l_cursor.start
						i := 1
					until
						l_cursor.after
					loop
						stream.put_string ("an_arg")
						stream.put_integer (i)
						stream.put_string (": ")
						stream.put_string (l_cursor.item)
						l_cursor.forth
						i := i + 1
						if not l_cursor.after then
							stream.put_string ("; ")
						end
					end
					stream.put_line (")")
				else
					stream.put_line ("")
				end
				stream.indent
				if a_stack_element.is_creation_procedure or a_stack_element.is_xfix then
					stream.put_line ("local")
					stream.indent
					stream.put_line ("l_result: ANY")
					stream.dedent
				end
				stream.put_line ("do")
				stream.indent
				stream.put_string ("l_result := ")
				if l_feat.is_prefix then
					stream.put_string (l_feat.prefix_symbol)
					stream.put_line (" an_arg1")
				elseif l_feat.is_infix then
					stream.put_string ("an_arg1 ")
					stream.put_string (l_feat.infix_symbol)
					stream.put_line (" an_arg2")
				else
					stream.put_string ("create {")
					stream.put_string (a_stack_element.type)
					stream.put_string ("}.")
					stream.put_string (l_feat.name)
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
				end
				stream.dedent
				stream.put_string ("end")
				stream.dedent
			else
				stream.put_character ('{')
				stream.put_string (a_stack_element.type)
				stream.put_character ('}')
				stream.put_character ('.')
				stream.put_string (l_feat.name)
			end
			stream.put_string (", [")
			from
				l_cursor := a_stack_element.operands.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				put_value (l_cursor.item)
				l_cursor.forth
				if not l_cursor.after then
					stream.put_string (", ")
				end
			end
			stream.put_line ("])")
			stream.dedent
			stream.put_line ("end%N")
			stream.dedent
			stream.dedent
		end

	on_object_capture (a_object: !TEST_CAPTURED_OBJECT)
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
			stream.put_string (a_object.type)

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
				put_eiffel_string (stream.output_stream, a_object.string)
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
			stream.put_line ("context: !ARRAY [!TUPLE [type: !TYPE [ANY]; attributes: !TUPLE; inv: BOOLEAN]]")
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

	put_indexing is
			-- Append indexing clause.
		do
			stream.put_line ("indexing%N")
			stream.indent
			stream.put_line ("description: %"Regression tests reproducing application state of a previous execution.%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.put_line ("testing: %"type/extracted%"")
			stream.dedent
			stream.put_line ("")
		end

	put_manifest_string (a_string: !STRING)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_string.count
			loop
				stream.put_character ('%%')
				put_eiffel_string (stream.output_stream, a_string.substring (i, (i + max_string_length - 1).min (a_string.count)))
				stream.put_line ("%%")
				i := i + max_string_length
			end
		end

	put_attributes (a_table: !DS_HASH_TABLE [!STRING, !STRING])
		do
			from
				a_table.start
			until
				a_table.after
			loop
				stream.put_character ('"')
				stream.put_string (a_table.key_for_iteration)
				stream.put_string ("%",  ")
				put_value (a_table.item_for_iteration)
				if a_table.is_last then
					stream.put_line ("")
				else
					stream.put_line (",")
				end
				a_table.forth
			end
		end

	put_items (a_list: !DS_LINEAR [!STRING])
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

	put_value (a_value: !STRING)
		do
			if a_value.is_natural then
				stream.put_character ('"')
				stream.put_character ('#')
				stream.put_string (a_value)
				stream.put_character ('"')
			else
				stream.put_string (a_value)
			end
		end

feature {NONE} -- Constants

	max_string_length: INTEGER = 80

end
