note
	description: "Object parsing a JSON configuration file."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CONFIG

inherit
	CONFIG_READER

create
	make_from_file,
	make_from_string,
	make_from_json_object

feature {NONE} -- Initialization

	make_from_file (p: PATH)
			-- Create object from a file `p'
		do
			parse (p)
		end

	make_from_string (a_json: READABLE_STRING_8)
			-- Create current config from string `a_json'.
		local
			l_parser: JSON_PARSER
		do
			create l_parser.make_with_string (a_json)
			l_parser.parse_content
			if
				l_parser.is_valid and then
				attached l_parser.parsed_json_object as j_o
			then
				make_from_json_object (j_o)
			else
				has_error := True
			end
		end

	make_from_json_object (a_object: JSON_OBJECT)
			-- Create current config from JSON `a_object'.
		do
			associated_path := Void
			json_value := a_object
		end

feature -- Status report

	has_item  (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item associated with key `k'?
		do
			Result := item (k) /= Void
		end

	has_error: BOOLEAN
			-- Has error?
			--| Syntax error, source not found, ...

feature -- Access: Config Reader

	text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with query `k'.
		do
			Result := value_to_string_32 (item (k))
		end

	text_list_item (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- List of String item associated with key `k'.
		do
			if attached {JSON_ARRAY} item (k) as l_array then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (l_array.count)
				Result.compare_objects
				across
					l_array as ic
				until
					Result = Void
				loop
					if attached value_to_string_32 (ic.item) as s32 then
						Result.force (s32)
					else
						Result := Void
					end
				end
			end
		end

	text_table_item (k: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
			-- Table of String item associated with key `k'.
		do
			if attached {JSON_OBJECT} item (k) as obj then
				create {STRING_TABLE [READABLE_STRING_32]} Result.make (obj.count)
				Result.compare_objects
				across
					obj as ic
				until
					Result = Void
				loop
					if attached value_to_string_32 (ic.item) as s32 then
						Result.force (s32, ic.key.item)
					else
						Result := Void
					end
				end
			end
		end
	
	table_keys (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- <Precursor>
		do
			if attached {JSON_OBJECT} item (k) as obj then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (obj.count)
				Result.compare_objects
				across
					obj as ic
				loop
					Result.force (ic.key.item)
				end
			end
		end

	integer_item (k: READABLE_STRING_GENERAL): INTEGER
			-- Integer item associated with key `k'.
		do
			if attached {JSON_NUMBER} item (k) as l_number then
				Result := l_number.item.to_integer
			end
		end

	associated_path: detachable PATH
			-- If current was built from a filename, return this path.

feature -- Duplication

	sub_config (k: READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration representing a subset of Current for key `k'.
		do
			if attached {JSON_OBJECT} item (k) as j_o then
				create {JSON_CONFIG} Result.make_from_json_object (j_o)
			end
		end

feature -- Access

	item (k: READABLE_STRING_GENERAL): detachable JSON_VALUE
			-- Item associated with query `k' if any.
			-- `k' can be a single name such as "foo",
			-- or a qualified name such as "foo.bar" (assuming that "foo" is associated with a JSON object).
		do
			if attached json_value as obj then
				Result := object_json_value (obj, k.to_string_32)
			end
		end

feature {NONE} -- Implementation

	value_to_string_32 (v: detachable ANY): detachable STRING_32
		do
			if attached {JSON_STRING} v as l_string then
				Result := l_string.unescaped_string_32
			elseif attached {JSON_NUMBER} v as l_number then
				Result := l_number.item
			end
		end

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

	parse (a_path: PATH)
		local
			l_parser: JSON_PARSER
		do
			associated_path := a_path
			has_error := False
			if attached json_file_from (a_path) as json_file then
				l_parser := new_json_parser (json_file)
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jv
				then
					json_value := jv
				else
					has_error := True
				end
			else
				has_error := True
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
			create Result.make_with_string (a_string)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
