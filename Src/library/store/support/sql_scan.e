indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: "EiffelStore"

class SQL_SCAN

inherit

	STRING_HDL
		undefine
			is_equal, copy, out, consistent, setup
		end

	EXT_INTERNAL
		undefine
			is_equal, copy, out, consistent, setup
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
		end

	DB_FORMAT
		rename
			make as format_make
		undefine
			is_equal, copy, out, consistent, setup
		end

creation -- Creation procedure

	make

feature -- Initialization

	make (i: INTEGER) is
			-- Create format and allocate string.
		do
			string_make (i)
			format_make
		end

feature -- Basic operations

	parse (s: STRING): STRING is
			-- Parse string `s' by replacing each pattern ":<name>" 
			-- with the Eiffel object description whose name
			-- also matches "<name>".
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

	get_value (obj: ANY; str: STRING) is
			-- Retrieve string value of `obj' and put in `str'.
		require
			str_exists: str /= Void
		local
			r_int: INTEGER_REF
			r_real: REAL_REF
			r_character: CHARACTER_REF
			r_string: STRING
			r_date: DATE_TIME
			r_bool: BOOLEAN_REF
			r_double: DOUBLE_REF
		do
			if is_void (obj) then
				str.append (Null_string)
			else
				if is_integer (obj) then
					r_int ?= obj
					if r_int.item = db_default_null_value.value.truncated_to_integer then
						str.append (Null_string)
					else
						str.append (r_int.out)
					end
				elseif is_double (obj) then
					r_double ?= obj
					if r_double.item = db_default_null_value.value then
						str.append (Null_string)
					else
						str.append (r_double.out)
					end
				elseif is_real (obj) then
					r_real ?= obj
					if r_real.item = db_default_null_value.value.truncated_to_real then
						str.append (Null_string)
					else
						str.append (r_real.out)
					end
				elseif is_character (obj) then
					r_character ?= obj
					str.extend ('%'')
					str.extend (r_character.item)
					str.extend ('%'')
				elseif is_string (obj) then
					r_string ?= obj
					if not r_string.empty then
						buffer.copy (r_string)
						buffer.replace_substring_all ("'", "''")
						str.append (string_format (buffer))
					else
						str.append (Null_string)
					end
				elseif is_boolean (obj) then
					r_bool ?= obj
					str.append (boolean_format (r_bool.item))
				elseif is_date (obj) then
					r_date ?= obj
					if r_date = db_default_null_value.datetime_value then
						str.append (Null_string)
					else
						str.append (date_format (r_date))
					end
				else
					get_complex_value (obj, str)
				end
			end
		end

	get_complex_value (obj: ANY; str: STRING) is
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
			i_obj_field: ANY
			ind: INTEGER
		do
			from
				start (obj)
				ind := 1
			until
				ind > max_index
			loop
				i := next_index (ind)
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
			end
		end

	replace is
			-- Replace all occurences of :key by `ht.item (":key")'
		local
			new_string: like Current
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
						if new_string = Void then
							!! new_string.make (2 * count)
						end
						if old_index < index then
							new_string.append_substring (Current, 
								old_index, index - 1)
						end
						old_index := index
						index := index + 1
						go_after_identifier
						replacement_string (substring (old_index + 1, 
							index - 1), new_string)
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
			if new_string /= Void then
				if old_index <= count then
					new_string.append_substring (Current, old_index, count)
				end
				area := new_string.area
				count := new_string.count
			end
		end

	append_substring (s: STRING; n1, n2: INTEGER) is
			-- Append substring `s.substring (n1, n2)' to `Current'.
			-- Faster than append s.substring (n1, n2).
		require
			string_exists: s /= Void
			meaningful_origin: 1 <= n1
			meaningful_interval: n1 <= n2
			meaningful_end: n2 <= s.count
		local
			a: like area
		do
			grow (count + n2 - n1 + 1)
			a := s.area
			c_append_substring ($area, $a, count, n1, n2)
			count := count + n2 - n1 + 1
		end

feature {NONE} -- Status report

	max_index: INTEGER
			-- Upper bound set to current number of fields

	index: INTEGER
			-- Internal counter
	
	Null_string: STRING is "NULL"
			-- SQL null value constant

	buffer: STRING is
			-- Constant temporary string
		once
			!! Result.make (200)
		ensure
			Result /= Void
		end

	next_index (k: INTEGER): INTEGER is
			-- Get next index position in formalized way through index `k'.
			-- (May be redefined in descendant class).
		do
			Result := k
		end

feature {NONE} -- Status setting

	start (obj: ANY) is
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

	search_special is
			-- Move cursor to next occurence of ':', '%'', or '"'
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
		
	go_after_identifier is
			-- Move cursor to next character not allowed in identifier
		local
			c: CHARACTER
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
		
	replacement_string (key, destination: STRING) is
			-- Replace object associated with `key' in `destination'.
		require
			key_exists: key /= Void
			destination_exists: destination /= Void
		local
			object: ANY
		do
			object := ht.item (key)
			if object /= Void then
				get_value (object, destination)
			else
				destination.append (Null_string)
			end
		end

feature {NONE} -- External features

	c_append_substring (a1, a2: POINTER; c, n1, n2: INTEGER) is
		external 
			"C"
		end

end -- class SQL_SCAN


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

