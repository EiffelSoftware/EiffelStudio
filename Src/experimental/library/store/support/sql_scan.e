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

	STRING
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
			Precursor {STRING} (i)
			format_make
		end

feature -- Basic operations

	parse (s: STRING): STRING
			-- Parse string `s' by replacing each pattern ":<name>"
			-- with the Eiffel object description whose name
			-- also matches "<name>".
		require
			s_not_void: s /= Void
		do
			wipe_out
			append (s)
			replace
			if handle.execution_type.is_tracing then
				handle.execution_type.trace_output.putstring (Current)
				handle.execution_type.trace_output.new_line
			end
			Result := Current
		end

	get_value (obj: detachable ANY; str: STRING)
			-- Retrieve string value of `obj' and put in `str'.
		require
			str_exists: str /= Void
		local
			l_obj: detachable ANY
		do
			if is_void (obj) then
				str.append (null_string)
			else
				if is_integer (obj) then
					if attached {INTEGER_REF} obj as r_int then
						if r_int.item = numeric_null_value.truncated_to_integer then
							str.append (null_string)
						else
							str.append (r_int.out)
						end
					else
						check False end -- implied by `is_integer'
					end
				elseif is_double (obj) then
					if attached {DOUBLE_REF} obj as r_double then
						if r_double.item = numeric_null_value then
							str.append (null_string)
						else
							str.append (r_double.out)
						end
					else
						check False end -- implied by `is_double'
					end
				elseif is_real (obj) then
					if attached {REAL_REF} obj as r_real then
						if r_real.item = numeric_null_value.truncated_to_real then
							str.append (null_string)
						else
							str.append (r_real.out)
						end
					else
						check False end -- implied by `is_real'
					end
				elseif is_character (obj) then
					if attached {CHARACTER_REF} obj as r_character then
						str.extend ('%'')
						str.extend (r_character.item)
						str.extend ('%'')
					else
						check False end -- implied by `is_character'
					end
				elseif is_string (obj) then
					if attached {STRING} obj as r_string then
						buffer.copy (r_string)
						str.append (string_format (buffer))
					else
						check False end -- implied by `is_string'
					end
				elseif is_boolean (obj) then
					if attached {BOOLEAN_REF} obj as r_bool then
						str.append (boolean_format (r_bool.item))
					else
						check False end -- implied by `is_boolean'
					end
				elseif is_date (obj) then
					if attached {DATE_TIME} obj as r_date then
						str.append (date_format (r_date))
					else
						check False end -- implied by `is_date'
					end
				else
					l_obj := obj
					check l_obj /= Void end -- implied by previous `if is_void (obj)'
					get_complex_value (l_obj, str)
				end
			end
		end

	get_complex_value (obj: ANY; str: STRING)
			-- Retrieve string value of reference object `obj' and put in `str'.
		require
			object_exists: obj /= Void
			str_exists: str /= Void
		local
			i, i_obj_type: INTEGER
			r_int: INTEGER
			r_real: REAL
			r_bool: BOOLEAN
			r_double: DOUBLE
			r_character: CHARACTER
			i_obj_field: detachable ANY
			ind, l_identity_index: INTEGER
		do
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
					i_obj_type := field_type (i, obj)
					if i_obj_type = Integer_type then
						r_int := integer_field (i, obj)
						get_value (r_int, str)
					elseif i_obj_type = Real_type then
						r_real := real_field (i, obj)
						get_value (r_real, str)
					elseif i_obj_type = Character_type then
						r_character := character_field (i, obj)
						get_value (r_character, str)
					elseif i_obj_type = Boolean_type then
						r_bool := boolean_field (i, obj)
						get_value (r_bool, str)
					elseif i_obj_type = Double_type then
						r_double := double_field (i, obj)
						get_value (r_double, str)
					else
						i_obj_field := field (i, obj)
						get_value (i_obj_field, str)
					end
					ind := ind + 1
					if ind <= max_index then
						str.extend (',')
					end
				else
					ind := ind + 1
				end
			end
		end

	replace
			-- Replace all occurrences of :key by `ht.item (":key")'
		local
			l_new_string: detachable like Current
			c: CHARACTER
			old_index: INTEGER
		do
			from
				old_index := 1
				index := 1
			invariant
				index >= old_index
			variant
				count + 1 - index
			until
			 	index > count
			loop
				search_special
				if index <= count then
					c := item (index)
					if c = ':' then
						if l_new_string = Void then
							create l_new_string.make (2 * count)
						end
						if old_index < index then
							l_new_string.append (substring (old_index, index - 1))
						end
						old_index := index
						index := index + 1
						go_after_identifier
						replacement_string (substring (old_index + 1, index - 1), l_new_string)
						old_index := index
					elseif index < count then
						index := index_of (c, index + 1)
						if index = 0 then index := count end
						index := index + 1
					else
						index := index + 1
					end
				end
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

	Null_string: STRING = "NULL"
			-- SQL null value constant

	buffer: STRING
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
			c: CHARACTER
			i: INTEGER
			l_count: INTEGER
		do
			from
				i := index
				c := item (i)
				l_count := count
			until
				i > count
				or else c = ':'
				or else c = '%''
				or else c = '"'
			loop
				i := i + 1
				if i <= l_count then
					c := item (i)
				end
			end
			index := i
		ensure
			index > count or
			else item (index) = ':' or
			else item (index) = '%'' or
			else item (index) = '"'
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

	replacement_string (key, destination: STRING)
			-- Replace object associated with `key' in `destination'.
		require
			key_exists: key /= Void
			destination_exists: destination /= Void
		local
			object: detachable ANY
			l_ht: like ht
		do
			l_ht := ht
			check l_ht /= Void end -- FIXME: implied by ... bug?
			object := l_ht.item (key)
			if object /= Void then
				get_value (object, destination)
			else
				destination.append (Null_string)
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SQL_SCAN



