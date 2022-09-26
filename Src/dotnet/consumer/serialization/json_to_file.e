note
	description: "Summary description for {JSON_TO_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_FILE

inherit
	JSON_VISITOR

create
	make

feature -- Initialization

	make (a_output: like output)
			-- Create a new instance
		do
			output := a_output
		end

feature -- Access

	output: FILE
			-- JSON representation

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		local
			value: JSON_VALUE
			l_json_array: ARRAYED_LIST [JSON_VALUE]
			l_output: like output
		do
			l_output := output
			l_json_array := a_json_array.array_representation
			l_output.put_character ('[')
			from
				l_json_array.start
			until
				l_json_array.off
			loop
				value := l_json_array.item
				value.accept (Current)
				l_json_array.forth
				if not l_json_array.after then
					l_output.put_string (", ")
				end
			end
			l_output.put_character (']')
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
			if a_json_boolean.item then
				output.put_string ("true")
			else
				output.put_string ("false")
			end
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		do
			output.put_string ("null")
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		do
			output.put_string (a_json_number.item)
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		local
			l_pairs: HASH_TABLE [JSON_VALUE, JSON_STRING]
			l_output: like output
		do
			l_output := output
			l_pairs := a_json_object.map_representation
			l_output.put_character ('{')
			from
				l_pairs.start
			until
				l_pairs.off
			loop
				l_pairs.key_for_iteration.accept (Current)
				l_output.put_string (": ")
				l_pairs.item_for_iteration.accept (Current)
				l_pairs.forth
				if not l_pairs.after then
					l_output.put_string (", ")
				end
			end
			l_output.put_character ('}')
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		local
			l_output: like output
		do
			l_output := output
			l_output.put_character ('%"')
			l_output.put_string (a_json_string.item)
			l_output.put_character ('%"')
		end

end

