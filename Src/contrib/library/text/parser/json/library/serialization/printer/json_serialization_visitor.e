note
	description: "JSON_SERIALIZATION_VISITOR Generates a compact JSON-String for a JSON_VALUE"
	author: "Jocelyn Fiat & Javier Velilla"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZATION_VISITOR

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

	output: STRING_GENERAL
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
			l_output.append_code (91) -- '[' : 91
			from
				l_json_array.start
			until
				l_json_array.off
			loop
				value := l_json_array.item
				value.accept (Current)
				l_json_array.forth
				if not l_json_array.after then
					l_output.append_code (44) -- ',' : 44
				end
			end
			l_output.append_code (93) -- ']' : 93
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
			if a_json_boolean.item then
				output.append ("true")
			else
				output.append ("false")
			end
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
			l_output: like output
		do
			l_output := output
			l_pairs := a_json_object.map_representation
			l_output.append_code (123) -- '{' : 123
			from
				l_pairs.start
			until
				l_pairs.off
			loop
				visit_json_object_member (l_pairs.key_for_iteration, l_pairs.item_for_iteration)
				l_pairs.forth
				if not l_pairs.after then
					l_output.append_code (44) -- ',' : 44
				end
			end
			l_output.append_code (125) -- '}' : 125
		end

	visit_json_object_member (a_json_name: JSON_STRING; a_json_value: JSON_VALUE)
			-- Visit object member `a_json_name`: `a_json_value`.
		do
			a_json_name.accept (Current)
			output.append_code (58) -- ':' : 58
			a_json_value.accept (Current)
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
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end

