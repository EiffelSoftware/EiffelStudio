note
	description: "JSON_PRETTY_STRING_VISITOR Generates the JSON-String for a JSON_VALUE"
	revision: "0.1"

class
	JSON_PRETTY_STRING_VISITOR

inherit

	JSON_VISITOR

create
	make,
	make_custom

feature -- Initialization

	make (a_output: like output)
			-- Create a new instance
		do
			make_custom (a_output, 1, 1)
		end

	make_custom (a_output: like output; a_object_count_inlining, a_array_count_inlining: INTEGER)
			-- Create a new instance
		do
			output := a_output
			create indentation.make_empty
			indentation_step := "%T"
			object_count_inlining := a_object_count_inlining
			array_count_inlining := a_array_count_inlining
		end

feature -- Access

	output: STRING_GENERAL
			-- JSON representation

feature -- Settings

	indentation_step: STRING
			-- Text used for indentation.
			--| by default a tabulation "%T"

	object_count_inlining: INTEGER
			-- Inline where object item count is under `object_count_inlining'.
			--| ex 3:
			--| { "a", "b", "c" }
			--| ex 2:
			--| {
			--|		"a",
			--|		"b",
			--|		"c"
			--|	}

	array_count_inlining: INTEGER
			-- Inline where array item count is under `object_count_inlining'.

feature -- Element change

	set_indentation_step (a_step: STRING)
			-- Set `indentation_step' to `a_step'.
		do
			indentation_step := a_step
		end

	set_object_count_inlining (a_nb: INTEGER)
			-- Set `object_count_inlining' to `a_nb'.
		do
			object_count_inlining := a_nb
		end

	set_array_count_inlining (a_nb: INTEGER)
			-- Set `array_count_inlining' to `a_nb'.
		do
			array_count_inlining := a_nb
		end

feature {NONE} -- Implementation			

	indentation: STRING

	indent
		do
			indentation.append (indentation_step)
		end

	exdent
		do
			indentation.remove_tail (indentation_step.count)
		end

	new_line
		do
			output.append ("%N")
			output.append (indentation)
			line_number := line_number + 1
		end

	line_number: INTEGER

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		local
			value: JSON_VALUE
			l_json_array: ARRAYED_LIST [JSON_VALUE]
			l_line: like line_number
			l_multiple_lines: BOOLEAN
			l_output: like output
		do
			l_output := output
			l_json_array := a_json_array.array_representation
			l_multiple_lines := l_json_array.count >= array_count_inlining
									or across l_json_array as p some attached {JSON_OBJECT} p.item or attached {JSON_ARRAY} p.item end
			l_output.append_code (91) -- '[' : 91

			l_line := line_number
			indent
			from
				l_json_array.start
			until
				l_json_array.off
			loop
				if line_number > l_line or l_multiple_lines then
					new_line
				end
				value := l_json_array.item
				value.accept (Current)
				l_json_array.forth
				if not l_json_array.after then
					l_output.append (", ")
				end
			end
			exdent
			if line_number > l_line or l_json_array.count >= array_count_inlining then
				new_line
			end
			l_output.append_code (93) -- ']' : 93
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
			output.append (a_json_boolean.item.out)
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		do
			output.append ("null")
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		do
			output.append (a_json_number.item)
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		local
			l_pairs: HASH_TABLE [JSON_VALUE, JSON_STRING]
			l_line: like line_number
			l_multiple_lines: BOOLEAN
			l_output: like output
		do
			l_output := output
			l_pairs := a_json_object.map_representation
			l_multiple_lines := l_pairs.count >= object_count_inlining or across l_pairs as p some attached {JSON_OBJECT} p.item or attached {JSON_ARRAY} p.item end
			l_output.append_code (123) -- '{' : 123
			l_line := line_number
			indent
			from
				l_pairs.start
			until
				l_pairs.off
			loop
				if line_number > l_line or l_multiple_lines then
					new_line
				end
				l_pairs.key_for_iteration.accept (Current)
				l_output.append (": ")
				l_pairs.item_for_iteration.accept (Current)
				l_pairs.forth
				if not l_pairs.after then
					l_output.append (", ")
				end
			end
			exdent
			if line_number > l_line or l_pairs.count >= object_count_inlining then
				new_line
			end
			l_output.append_code (125) -- '}' : 125
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		local
			l_output: like output
		do
			l_output := output
			l_output.append_code (34) -- '%"' : 34
			l_output.append (a_json_string.item)
			l_output.append_code (34) -- '%"' : 34
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
