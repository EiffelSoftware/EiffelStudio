note
	description: "PRINT_JSON_VISITOR Generates the JSON-String for a JSON_VALUE"
	author: "jvelilla"
	date: "2008/08/24"
	revision: "0.1"

class
	PRINT_JSON_VISITOR

inherit
	JSON_VISITOR

create make

feature -- Initialization

	make
			-- Create a new instance
		do
			create to_json.make_empty
		end

feature -- Access

	to_json: STRING
		-- JSON representation

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		local
			value: JSON_VALUE
			l_json_array: ARRAYED_LIST [JSON_VALUE]
		do
			l_json_array:=a_json_array.array_representation
			to_json.append ("[")
			from
				l_json_array.start
			until
				l_json_array.off
			loop
				value := l_json_array.item
				value.accept (Current)
				l_json_array.forth
				if not l_json_array.after then
					to_json.append(",")
				end
			end
			to_json.append ("]")
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
			to_json.append (a_json_boolean.item.out)
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		do
			to_json.append ("null")
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		do
			to_json.append (a_json_number.item)
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		local
			l_pairs: HASH_TABLE[JSON_VALUE,JSON_STRING]
		do
			l_pairs := a_json_object.map_representation
			to_json.append ("{")
			from
				l_pairs.start
			until
				l_pairs.off
			loop
				l_pairs.key_for_iteration.accept (Current)
				to_json.append (":")
				l_pairs.item_for_iteration.accept (Current)
				l_pairs.forth
				if not l_pairs.after then
					to_json.append (",")
				end
			end
			to_json.append ("}")
		end

    visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		do
			to_json.append ("%"")
			to_json.append (a_json_string.item)
			to_json.append ("%"")
		end

end
