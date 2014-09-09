note
	description: "Object parsing a JSON configuration file."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CONFIG

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (p: PATH)
			-- Create object from a file `p'
		do
			parse (p)
		end

feature -- Access

	item (a_query: READABLE_STRING_GENERAL): detachable JSON_VALUE
			-- Item associated with query `a_query' if any.
			-- `a_query' can be a single name such as "foo",
			-- or a qualified name such as "foo.bar" (assuming that "foo" is associated with a JSON object).
		do
			if attached json_value as obj then
				Result := object_json_value (obj, a_query.to_string_32)
			end
		end

	text_item (a_query: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with query `a_query'.
		do
			if attached {JSON_STRING} item (a_query) as l_string then
				Result := l_string.unescaped_string_32
			end
		end

	integer_item (a_query: READABLE_STRING_GENERAL): INTEGER
			-- Integer item associated with query `a_query'.
		do
			if attached {JSON_NUMBER} item (a_query) as l_number then
				Result := l_number.item.to_integer
			end
		end

feature {NONE} -- Implementation

	object_json_value (a_object: JSON_OBJECT; a_query: READABLE_STRING_32): detachable JSON_VALUE
			-- Item associated with query `a_query' from object `a_object' if any.
		local
			i: INTEGER
			h: READABLE_STRING_32
		do
			i := a_query.index_of ('.', 1)
			if i > 1 then
				h := a_query.head (i - 1)
				if attached {JSON_OBJECT} a_object.item (h) as l_obj then
					Result := object_json_value (l_obj, a_query.substring (i + 1, a_query.count))
				else
						-- This is not an object...
					Result := Void
				end
			else
				Result := a_object.item (a_query)
			end
		end

feature -- Implementation

	parse (a_path: PATH)
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				if attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed then
					json_value := jv
				end
			end
		end

feature {NONE} -- JSON

	json_value: detachable JSON_OBJECT
			-- Possible json object representation.

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

end
