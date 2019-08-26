note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: "EiffelStore"

class SQL_SCAN [G -> DATABASE create default_create end]

inherit

	STRING_HDL
		undefine
			is_equal, copy, out
		end

	EXT_INTERNAL
		undefine
			is_equal, copy, out
		end

	STRING_32
		rename
			make as string_make,
			is_real as string_is_real,
			is_integer as string_is_integer,
			is_double as string_is_double,
			is_boolean as string_is_boolean
		undefine
			clear_all
		redefine
			string_make
		end

	DB_FORMAT
		rename
			make as format_make
		undefine
			is_equal, copy, out
		end

	HANDLE_SPEC [G]
		undefine
			is_equal, copy, out
		end

	GLOBAL_SETTINGS
		undefine
			is_equal, copy, out
		end

create -- Creation procedure
	make

create {SQL_SCAN}
	string_make

feature -- Initialization

	make (i: INTEGER)
			-- Create format and allocate string.
		do
			string_make (i)
		end

	string_make (i: INTEGER)
			-- <Precursor>
		do
			create ht.make (10)
			create ht_order.make (10)
			ht_order.compare_objects
			Precursor {STRING_32} (i)
			format_make
		end

feature -- Basic operations

	parse (s: STRING): STRING
			-- Parse string `s' by replacing each pattern ":<name>"
			-- with the Eiffel object description whose name
			-- also matches "<name>".
		obsolete
			"Use `parse_32' instead [2017-11-30]."
		require
			s_not_void: s /= Void
		do
			Result := parse_32 (s).as_string_8
		end

	parse_32 (s: READABLE_STRING_GENERAL): STRING_32
			-- Parse string `s' by replacing each pattern ":<name>"
			-- with the Eiffel object description whose name
			-- also matches "<name>".
		require
			s_not_void: s /= Void
		do
			wipe_out
			append_string_general (s)
			replace
			if
				handle.execution_type.is_tracing and then
				attached handle.execution_type.trace_output as l_trace_output
			then
				l_trace_output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (Current))
				l_trace_output.new_line
			end
			Result := Current
		end

	parse_dynamic (s: READABLE_STRING_GENERAL): STRING_32
			-- Parse string `s' by replacing each pattern ":<name>" with "?".
		require
			s_not_void: s /= Void
		do
			wipe_out
			append_string_general (s)
			replace_dynamic
			if
				handle.execution_type.is_tracing and then
				attached handle.execution_type.trace_output as l_trace_output
			then
				l_trace_output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (Current))
				l_trace_output.new_line
			end
			Result := Current
		end

	get_value (obj: detachable ANY; str: STRING_32)
			-- Retrieve string value of `obj' and put in `str'.
		require
			str_exists: str /= Void
		do
			if obj = Void then
				str.append (null_string)
			else
				if attached {INTEGER_8_REF} obj as r_int8 then
					append_integer_32_value_into (r_int8.item, str)

				elseif attached {INTEGER_REF} obj as r_int32 then
					append_integer_32_value_into (r_int32.item, str)

				elseif attached {INTEGER_16_REF} obj as r_int16 then
					append_integer_32_value_into (r_int16.item, str)

				elseif attached {INTEGER_64_REF} obj as r_int64 then
					append_integer_64_value_into (r_int64.item, str)

				elseif attached {NATURAL_8_REF} obj as na_8 then
					append_natural_32_value_into (na_8.item, str)

				elseif attached {NATURAL_16_REF} obj as na_16 then
					append_natural_32_value_into (na_16.item, str)

				elseif attached {NATURAL_32_REF} obj as na_32 then
					append_natural_32_value_into (na_32.item, str)

				elseif attached {NATURAL_64_REF} obj as na_64 then
					append_natural_64_value_into (na_64.item, str)

				elseif attached {REAL_64_REF} obj as r_real_64 then
					append_real_64_value_into (r_real_64.item, str)

				elseif attached {REAL_32_REF} obj as r_real_32 then
					append_real_64_value_into (r_real_32.item, str)

				elseif attached {CHARACTER_REF} obj as r_char_8 then
					append_character_32_value_into (r_char_8.item, str)

				elseif attached {CHARACTER_32_REF} obj as r_char_32 then
					append_character_32_value_into (r_char_32.item, str)

				elseif attached {READABLE_STRING_GENERAL} obj as r_string then
					buffer.copy (r_string.as_string_32)
					str.append (string_format_32 (buffer))
				elseif attached {BOOLEAN_REF} obj as r_bool then
					str.append_string_general (boolean_format (r_bool.item))
				elseif attached {DATE_TIME} obj as r_date then
					str.append_string_general (date_format (r_date))
				elseif is_decimal_used and then attached obj as l_o and then is_decimal (l_o) then
					str.append_string_general (decimal_output_function.item ([l_o]))
				else
						-- We do not recursively read values from an object.
						-- Because we do not have a way to define database schema for such an object tree.
					if not is_reading_complex_value then
						get_complex_value (obj, str)
					end
				end
			end
		end

	get_complex_value (obj: ANY; str: STRING_32)
			-- Retrieve string value of reference object `obj' and put in `str'.
		require
			object_exists: obj /= Void
			str_exists: str /= Void
		local
			i: INTEGER
			ind, l_identity_index: INTEGER
		do
			is_reading_complex_value := True
			if attached {DB_TABLE} obj as table and then not db_spec.insert_auto_identity_column then
					-- There was an explicit requirement from the database to exclude
					-- the identity column from the statement.
				l_identity_index := table.table_description.identity_column
			else
					-- No such requirement, we simply assign `-1' so that we add
					-- all the columns.
				l_identity_index := -1
			end
			from
				start (obj)
				ind := 1
			until
				ind > max_index
			loop
				i := next_index (ind)
				if i > 0 and then l_identity_index /= i then
					inspect field_type (i, obj)
					when integer_8_type then
						append_integer_32_value_into (integer_8_field (i, obj), str)
					when integer_16_type then
						append_integer_32_value_into (integer_16_field (i, obj), str)
					when integer_32_type then
						append_integer_32_value_into (integer_32_field (i, obj), str)
					when integer_64_type then
						append_integer_64_value_into (integer_64_field (i, obj), str)
					when natural_8_type then
						append_natural_32_value_into (natural_8_field (i, obj), str)
					when natural_16_type then
						append_natural_32_value_into (natural_16_field (i, obj), str)
					when natural_32_type then
						append_natural_32_value_into (natural_32_field (i, obj), str)
					when natural_64_type then
						append_natural_64_value_into (natural_64_field (i, obj), str)
					when Real_type then
						append_real_64_value_into (real_32_field (i, obj), str)
					when Character_8_type then
						append_character_32_value_into (character_8_field (i, obj), str)
					when Character_32_type then
						append_character_32_value_into (character_32_field (i, obj), str)
					when Boolean_type then
						str.append_string_general (boolean_format (boolean_field (i, obj)))
					when Double_type then
						append_real_64_value_into (real_64_field (i, obj), str)
					else
						get_value (field (i, obj), str)
					end
					ind := ind + 1
					if ind <= max_index then
						str.extend ({CHARACTER_32}',')
					end
				else
					ind := ind + 1
				end
			end
			is_reading_complex_value := False
		end

	replace
			-- Replace all occurrences of :key by `ht.item (":key")'
		do
			replace_statement (False)
		end

feature {NONE} -- Implementation

	append_integer_32_value_into (a_val: INTEGER_32; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			if map_zero_null_value and then a_val = numeric_null_value.truncated_to_integer.as_integer_32 then
				a_str.append (null_string)
			else
				a_str.append_integer (a_val)
			end
		end

	append_integer_64_value_into (a_val: INTEGER_64; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			if map_zero_null_value and then a_val = numeric_null_value.truncated_to_integer_64 then
				a_str.append (null_string)
			else
				a_str.append_integer_64 (a_val)
			end
		end

	append_natural_32_value_into (a_val: NATURAL_32; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			if map_zero_null_value and then a_val = numeric_null_value.truncated_to_integer.as_natural_32 then
				a_str.append (null_string)
			else
				a_str.append_natural_32 (a_val)
			end
		end

	append_natural_64_value_into (a_val: NATURAL_64; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			if map_zero_null_value and then a_val = numeric_null_value.truncated_to_integer_64.as_natural_64 then
				a_str.append (null_string)
			else
				a_str.append_natural_64 (a_val)
			end
		end

	append_real_64_value_into (a_val: REAL_64; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			if map_zero_null_value and then a_val = numeric_null_value then
				a_str.append (null_string)
			else
				a_str.append_double (a_val)
			end
		end

	append_character_32_value_into (a_val: CHARACTER_32; a_str: STRING_32)
			-- Append `a_val' in `a_str' if `a_val' is not equal to `numeric_null_value', otheriwse the NULL SQL string.
		do
			a_str.extend ({CHARACTER_32}'%'')
			a_str.extend (a_val)
			a_str.extend ({CHARACTER_32}'%'')
		end

	replace_dynamic
			-- Replace all occurrences of :key by ?.
		do
			replace_statement (True)
		end

	replace_statement (a_dynamic: BOOLEAN)
			-- Replace all occurrences of :key by `ht.item (":key")'.
			-- If `a_dynamic', replace :key by ?.
		local
			l_new_string: detachable like Current
			c: CHARACTER_32
			old_index: INTEGER
		do
			from
				old_index := 1
				index := 1
			invariant
				index >= old_index
			until
			 	index > count
			loop
				search_special
				if index <= count then
					c := item (index)
					if c = {CHARACTER_32}':' then
						if l_new_string = Void then
							create l_new_string.make (2 * count)
						end
						if old_index < index then
							l_new_string.append (substring (old_index, index - 1))
						end
						old_index := index
						index := index + 1
						go_after_identifier
						if not a_dynamic then
							replacement_string (substring (old_index + 1, index - 1), l_new_string)
						else
							l_new_string.append_character ('?')
						end
						old_index := index
					elseif index < count then
						index := index_of (c, index + 1)
						if index = 0 then index := count end
						index := index + 1
					else
						index := index + 1
					end
				end
			variant
				count + 1 - index
			end
			if l_new_string /= Void then
				if old_index <= count then
					l_new_string.append (substring (old_index, count))
				end
				wipe_out
				append (l_new_string)
			end
		end

feature {NONE} -- Status report

	max_index: INTEGER
			-- Upper bound set to current number of fields

	index: INTEGER
			-- Internal counter

	Null_string: STRING_32 = "NULL"
			-- SQL null value constant

	buffer: STRING_32
			-- Constant temporary string
		once
			create Result.make (200)
		ensure
			Result /= Void
		end

	next_index (k: INTEGER): INTEGER
			-- Get next index position in formalized way through index `k'.
			-- (May be redefined in descendant class).
		do
			Result := k
		end

feature {NONE} -- Status setting

	start (obj: ANY)
			-- Set `max_index' with number of field of Current.
			-- (May be redefined in descendant class).
		do
			max_index := field_count (obj)
-- FIXME: Jacques, comments removed according to matisse library			
		ensure
-- Davids: You don't need to force the user to map exactly the same number of Attributes in the
--			Table and in the corresponding class
--			max_index = field_count (obj)
--			
		end

	search_special
			-- Move cursor to next occurrence of ':', '%'', or '"'
		local
			c: CHARACTER_32
			i: INTEGER
			l_count: INTEGER
		do
			from
				i := index
				c := item (i)
				l_count := count
			until
				i > count
				or else c = {CHARACTER_32}':'
				or else c = {CHARACTER_32}'%''
				or else c = {CHARACTER_32}'"'
			loop
				i := i + 1
				if i <= l_count then
					c := item (i)
				end
			end
			index := i
		ensure
			index > count or
			else item (index) = {CHARACTER_32}':' or
			else item (index) = {CHARACTER_32}'%'' or
			else item (index) = {CHARACTER_32}'"'
		end

	go_after_identifier
			-- Move cursor to next character not allowed in identifier
		local
			found: BOOLEAN
			i, l_count: INTEGER
		do
			from
				i := index
				l_count := count
				inspect item (i)
				when 'A'..'Z', 'a'..'z', '0'..'9', '_' then
				else
					found := True
				end
			until
				i > l_count or found
			loop
				i := i + 1
				if i > l_count then
					found := True
				else
					inspect item (i)
						when 'A'..'Z', 'a'..'z', '0'..'9', '_' then
						else
							found := True
						end
				end
			end
			index := i
		end

	replacement_string (key, destination: STRING_32)
			-- Replace object associated with `key' in `destination'.
		require
			ht_not_void: ht /= Void
			key_exists: key /= Void
			destination_exists: destination /= Void
		local
			object: detachable ANY
		do
			object := ht.item (key)
			if object /= Void then
				get_value (object, destination)
			else
				destination.append (Null_string)
			end
		end

	is_reading_complex_value: BOOLEAN;
			-- Reading complex value?

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SQL_SCAN
