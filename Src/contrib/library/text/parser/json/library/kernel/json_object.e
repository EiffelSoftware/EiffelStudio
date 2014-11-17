note
	description: "[
		            An JSON_OBJECT represent an object in JSON.
		            An object is an unordered set of name/value pairs
		
					Examples:
						object
						{}
						{"key": value}
						{"key": "value"}
	]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"

class
	JSON_OBJECT

inherit

	JSON_VALUE

	TABLE_ITERABLE [JSON_VALUE, JSON_STRING]

	DEBUG_OUTPUT

create
	make_empty, make_with_capacity, make

feature {NONE} -- Initialization

	make_with_capacity (nb: INTEGER)
			-- Initialize with a capacity of `nb' items.
		do
			create items.make (nb)
		end

	make_empty
			-- Initialize as empty object.
		do
			make_with_capacity (0)
		end

	make
			-- Initialize with default capacity.
		do
			make_with_capacity (3)
		end

feature -- Change Element

	put (a_value: detachable JSON_VALUE; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			a_key_not_present: not has_key (a_key)
		do
			if a_value = Void then
				items.extend (create {JSON_NULL}, a_key)
			else
				items.extend (a_value, a_key)
			end
		end

	put_string (a_value: READABLE_STRING_GENERAL; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			key_not_present: not has_key (a_key)
		local
			l_value: JSON_STRING
		do
			if attached {READABLE_STRING_8} a_value as s then
				create l_value.make_from_string (s)
			else
				create l_value.make_from_string_32 (a_value.as_string_32)
			end
			put (l_value, a_key)
		end

	put_integer (a_value: INTEGER_64; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			key_not_present: not has_key (a_key)
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_integer (a_value)
			put (l_value, a_key)
		end

	put_natural (a_value: NATURAL_64; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			key_not_present: not has_key (a_key)
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_natural (a_value)
			put (l_value, a_key)
		end

	put_real (a_value: DOUBLE; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			key_not_present: not has_key (a_key)
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_real (a_value)
			put (l_value, a_key)
		end

	put_boolean (a_value: BOOLEAN; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		require
			key_not_present: not has_key (a_key)
		local
			l_value: JSON_BOOLEAN
		do
			create l_value.make (a_value)
			put (l_value, a_key)
		end

	replace (a_value: detachable JSON_VALUE; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		do
			if a_value = Void then
				items.force (create {JSON_NULL}, a_key)
			else
				items.force (a_value, a_key)
			end
		end

	replace_with_string (a_value: READABLE_STRING_GENERAL; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		local
			l_value: JSON_STRING
		do
			if attached {READABLE_STRING_8} a_value as s then
				create l_value.make_from_string (s)
			else
				create l_value.make_from_string_32 (a_value.as_string_32)
			end
			replace (l_value, a_key)
		end

	replace_with_integer (a_value: INTEGER_64; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_integer (a_value)
			replace (l_value, a_key)
		end

	replace_with_with_natural (a_value: NATURAL_64; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_natural (a_value)
			replace (l_value, a_key)
		end

	replace_with_real (a_value: DOUBLE; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		local
			l_value: JSON_NUMBER
		do
			create l_value.make_real (a_value)
			replace (l_value, a_key)
		end

	replace_with_boolean (a_value: BOOLEAN; a_key: JSON_STRING)
			-- Assuming there is no item of key `a_key',
			-- insert `a_value' with `a_key'.
		local
			l_value: JSON_BOOLEAN
		do
			create l_value.make (a_value)
			replace (l_value, a_key)
		end

	remove (a_key: JSON_STRING)
			-- Remove item indexed by `a_key' if any.
		do
			items.remove (a_key)
		end

	wipe_out
			-- Reset all items to default values; reset status.
		do
			items.wipe_out
		end

feature -- Status report

	has_key (a_key: JSON_STRING): BOOLEAN
			-- has the JSON_OBJECT contains a specific key `a_key'.
		do
			Result := items.has (a_key)
		end

	has_item (a_value: JSON_VALUE): BOOLEAN
			-- has the JSON_OBJECT contain a specfic item `a_value'
		do
			Result := items.has_item (a_value)
		end

feature -- Access

	item (a_key: JSON_STRING): detachable JSON_VALUE
			-- the json_value associated with a key `a_key'.
		do
			Result := items.item (a_key)
		end

	current_keys: ARRAY [JSON_STRING]
			-- Array containing actually used keys.
		do
			Result := items.current_keys
		end

	representation: STRING
			-- <Precursor>
		do
			create Result.make (2)
			Result.append_character ('{')
			across
				items as ic
			loop
				if Result.count > 1 then
					Result.append_character (',')
				end
				Result.append (ic.key.representation)
				Result.append_character (':')
				Result.append (ic.item.representation)
			end
			Result.append_character ('}')
		end

feature -- Mesurement

	count: INTEGER
			-- Number of field.
		do
			Result := items.count
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [JSON_VALUE, JSON_STRING]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty object?
		do
			Result := items.is_empty
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_object' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_object (Current)
		end

feature -- Conversion

	map_representation: HASH_TABLE [JSON_VALUE, JSON_STRING]
			-- A representation that maps keys to values
		do
			Result := items
		end

feature -- Report

	hash_code: INTEGER
			-- Hash code value
		do
			from
				items.start
				Result := items.out.hash_code
			until
				items.off
			loop
				Result := ((Result \\ 8388593) |<< 8) + items.item_for_iteration.hash_code
				items.forth
			end
				-- Ensure it is a positive value.
			Result := Result.hash_code
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := count.out + "item(s)"
		end

feature {NONE} -- Implementation

	items: HASH_TABLE [JSON_VALUE, JSON_STRING]
			-- Value container

invariant
	items_not_void: items /= Void

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
