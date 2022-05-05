note
	description: "Objects that read json content."
	author: "jvelilla"
	date: "$Date$"
	revision: "0.1"

class
	JSON_READER

create
	make

feature {NONE} -- Initialization

	make (a_json: READABLE_STRING_8)
			-- Initialize Reader
		do
			set_representation (a_json)
		end

feature -- Commands

	reset
			-- Reset reader
		do
			index := 1
		end

	set_representation (a_json: READABLE_STRING_8)
			-- Set `representation'.
		do
			representation := a_json.to_string_8
			representation.left_adjust
			representation.right_adjust
			reset
		end

	read: CHARACTER
			-- Read character
		do
			if not representation.is_empty then
				Result := representation.item (index)
			end
		end

	next
			-- Move to next index
		require
			has_more_elements: has_next
		do
			index := index + 1
		ensure
			incremented: old index + 1 = index
		end

	previous
			-- Move to previous index
		require
			not_is_first: has_previous
		do
			index := index - 1
		ensure
			incremented: old index - 1 = index
		end

	skip_white_spaces
			-- Remove white spaces
		local
			c: like actual
		do
			from
				c := actual
			until
				(c /= ' ' and c /= '%N' and c /= '%R' and c /= '%U' and c /= '%T') or not has_next
			loop
				next
				c := actual
			end
		end

	json_substring (start_index, end_index: INTEGER_32): STRING
			-- JSON representation between `start_index' and `end_index'
		do
			Result := representation.substring (start_index, end_index)
		end

	has_json_substring (a_string: READABLE_STRING_GENERAL; start_index, end_index: INTEGER_32): BOOLEAN
			-- Has JSON representation between `start_index' and `end_index' the substring `a_string'
		do
			Result := representation.same_caseless_characters_general (a_string, start_index, end_index, index)
		end

feature -- Status report

	has_next: BOOLEAN
			-- Has a next character?
		do
			Result := index <= representation.count
		end

	has_previous: BOOLEAN
			-- Has a previous character?
		do
			Result := index >= 1
		end

feature -- Access

	representation: STRING
			-- Serialized representation of the original JSON string

feature {NONE} -- Implementation

	actual: CHARACTER
			-- Current character or '%U' if none
		do
			if index > representation.count then
				Result := '%U'
			else
				Result := representation.item (index)
			end
		end

	index: INTEGER
			-- Actual index

invariant
	representation_not_void: representation /= Void

note
	copyright: "2010-2019, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
