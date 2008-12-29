note
	status: "See notice at end of class."
	Access: "internal"
	Product: "EiffelStore"
	Database: "All_Bases"
	Date: "$Date$"
	Revision: "$Revision$"

class EXT_INTERNAL

inherit
	INTERNAL

	BASIC_ROUTINES

	NUMERIC_NULL_VALUE

feature -- Basic operations

	field_copy (i: INTEGER; object, value: ANY): BOOLEAN
			-- Copy `value' in `i'-th field of `object'.
		require
			object_not_void: object /= Void
			value_not_void: value /= Void
		local
			ftype, local_int: INTEGER
			fname: STRING
			int_ref: INTEGER_REF
			local_real: REAL
			real_ref: REAL_REF
			double_ref: DOUBLE_REF
			local_double: DOUBLE
			local_boolean: BOOLEAN
			boolean_ref: BOOLEAN_REF
			local_string1: STRING
			local_char: CHARACTER
			char_ref: CHARACTER_REF
		do
			ftype := field_type (i, object)
			fname := field_name (i, object)
			Result := True

			if ftype = Integer_type then
				double_ref ?= value
				if double_ref /= Void then
					local_int := double_ref.item.truncated_to_integer
				else
					int_ref ?= value
					if int_ref /= Void then
						local_int := int_ref.item
					else
						Result := False
					end
				end
				set_integer_field (i, object, local_int)
			elseif ftype = Real_type then
				real_ref ?= value
				double_ref ?= value
				int_ref ?= value
				if real_ref /= Void then
					local_real := real_ref.item
					set_real_field (i, object, local_real)
				elseif double_ref /= Void then
					local_real := double_ref.item
					set_real_field (i, object, local_real)
				elseif int_ref /= Void then
					int_ref ?= value
					local_real := int_ref.item
					set_real_field (i, object, local_real)
				else
					Result := False
				end
			elseif ftype = Double_type then
				real_ref ?= value
				double_ref ?= value
				int_ref ?= value
				if real_ref /= Void then
					local_double := real_ref.item
					set_double_field (i, object, local_double)
				elseif double_ref /= Void then
					local_double := double_ref.item
					set_double_field (i, object, local_double)
				elseif int_ref /= Void then
					int_ref ?= value
					local_double := int_ref.item
					set_double_field (i, object, local_double)
				else
					Result := False
				end
			elseif is_character (value) and then ftype = Character_type then
				char_ref ?= value
				local_char := char_ref.item
				set_character_field (i, object, local_char)
			elseif is_boolean (value) and then ftype = Boolean_type then
				boolean_ref ?= value
				local_boolean := boolean_ref.item
				set_boolean_field (i, object, local_boolean)
			elseif is_string (value) then
				if ftype = Character_type then
					local_string1 ?= value
					if local_string1.count = 1 then
						local_char := local_string1.item (1)
						set_character_field (i, object, local_char)
					else
						Result := False
					end
				elseif ftype = Boolean_type then
					local_string1 ?= value
					if local_string1.count = 1 then
						local_char := local_string1.item (1)
						local_boolean := 'T' = local_char
						set_boolean_field (i, object, local_boolean)
					else
						Result := False
					end
				elseif ftype = Reference_type then
					set_reference_field (i, object, value)
				else
					Result := False
				end
			elseif ftype = Reference_type then
				set_reference_field (i, object, value)
			else
				Result := False
			end

		end

	field_clean (i: INTEGER; object: ANY): BOOLEAN
			-- Clean `i'-th field of `object'.
		require
			object_not_void: object /= Void
		local
			ftype: INTEGER
			fname: STRING
		do
			ftype := field_type (i, object)
			fname := field_name (i, object)
			Result := True

			if ftype = Integer_type then
				set_integer_field (i, object, numeric_null_value.truncated_to_integer)
			elseif ftype = Real_type then
				set_real_field (i, object, numeric_null_value.truncated_to_real)
			elseif ftype = Double_type then
				set_double_field (i, object, numeric_null_value)
			elseif ftype = Character_type then
				set_character_field (i, object, ' ')
			elseif ftype = Boolean_type then
				set_boolean_field (i, object, False)
			elseif ftype = Reference_type then
				set_reference_field (i, object, Void)
			else
				Result := False
			end
		end

	switch_mark (obj: ANY)
			-- Unmark `obj' if marked or mark it if unmarked.
		require
			object_not_void: obj /= Void
		do
			if is_marked (obj) then
				unmark (obj)
			else
				mark (obj)
			end
		end

	unmark_structure (obj: ANY)
			-- Unmark structure of objects.
		require
			object_not_void: obj /= Void
		local
			i: INTEGER
			nbfield: INTEGER
			type_value: INTEGER
			field_i: ANY
		do
			unmark(obj)
			from
				nbfield := field_count (obj)
				i := 1
			until
				i > nbfield
			loop
				type_value := field_type (i, obj)
				if type_value = Reference_type then
					field_i := field (i, obj)
					unmark_structure (field_i)
				end
				i := i + 1
			end
		end

	traversal (object: ANY)
			-- Traverse the entire object structure starting with root `obj'.
			-- An object in the Eiffel run-time system includes the following:
			--    a) Reference objects instance of a class type
			--    b) Special reference objects allocated to refer to a
			--              variable size object like STRING and ARRAY
			--    c) Reference objects created for a generic type instantiated
			--                      as an expanded type or BITS n
			-- LIMITATION: Current version excludes objects in the Eiffel
			-- run-time system where expanded objects are encapsulated within
			-- other objects
		require
			object_not_void: object /= Void
		local
			type_value, nb_fields, i: INTEGER
		do
			object_init_action (object)
			from
				nb_fields := field_count(object)
				i := 1
			until
				i > nb_fields
			loop
				type_value := field_type (i, object)
				if type_value = Reference_type then
					reference_object_action (i, object)
				else
					simple_object_action (type_value, i, object)
				end
				i := i + 1
			end
			object_finish_action (object)
		end

	deep_traversal (object: ANY)
			-- Perform a deep recursive traversal on 
			-- the transitive closure of the object network 
			-- reachable from root `object'.
		require
			root_object_non_void: object /= Void
		local
			type_value, nb_field, i: INTEGER
			one_field: ANY
			one_array: ARRAY [ANY]
		do
			mark (object)
			one_array ?= object
				-- Test if currently traversed object
				-- is an array.
			if one_array /= Void then
				array_traversal (one_array)
			else
					-- Perform action to store currently 
					-- traversed object
					-- (implementation provided by a descendant class).
				store_action (object)
				from
					nb_field := field_count (object)
					i := 1
				until
					i > nb_field
				loop
					type_value := field_type (i, object)
					if type_value = Reference_type then
						one_field := field (i, object)
						if one_field /= Void and then
								not is_marked (one_field) then
								-- Propagate the traversal to 
								-- referenced objects not traversed yet
							deep_traversal (one_field)	
						end
					end
					i := i + 1
				end
			end
		end

	object_init_action (object: ANY)
			-- Do nothing.
			-- (To be redefined in heir.)
		do
		end

	reference_object_action (i: INTEGER; object: ANY)
			-- Do nothing.
			-- (To be redefined in heir.)
		do
		end

	simple_object_action (type, i: INTEGER; object: ANY)
			-- Do nothing.
			-- (To be redefined in heir.)
		do
		end

	object_finish_action (object: ANY)
			-- Do nothing.
			-- (To be redefined in heir.)
		do
		end

	store_action (object: ANY)
			-- Do nothing.
			-- (To be redefined in heir.)
		do
		end

	nb_classes: INTEGER
			-- Number of dynamic types in current system
		obsolete
			"Should not be used. No other equivalent feature is supported."
		do
		end

feature {NONE} -- Status report

	is_void (obj: ANY): BOOLEAN
		do
			Result := (obj = Void)
		end

	is_integer (obj: ANY): BOOLEAN
			-- Is `obj' an integer value?
		local
			r_int: INTEGER_REF
		do
			r_int ?= obj
			Result := r_int /= Void
		end

	is_real (obj: ANY): BOOLEAN
			-- Is `obj' a real value?
		local
			r_real: REAL_REF
		do
			r_real ?= obj
			Result := r_real /= Void
		end

	is_double (obj: ANY): BOOLEAN
			-- Is `obj' a double value?
		local
			r_double: DOUBLE_REF
		do
			r_double ?= obj
			Result := r_double /= Void
		end

	is_boolean (obj: ANY): BOOLEAN
			-- Is `obj' a boolean value?
		local
			r_boolean: BOOLEAN_REF
		do
			r_boolean ?= obj
			Result := r_boolean /= Void
		end

	is_character (obj: ANY): BOOLEAN
			-- Is `obj' a character value?
		local
			r_character: CHARACTER_REF
		do
			r_character ?= obj
			Result := r_character /= Void
		end

	is_string (obj: ANY): BOOLEAN
			-- Is `obj' a string value?
		local
			r_string: STRING
		do
			r_string ?= obj
			Result := r_string /= Void
		end

	is_date (obj: ANY): BOOLEAN
			-- Is `obj' a date object?
		local
			r_date: DATE_TIME
		do
			r_date ?= obj
			Result := r_date /= Void
		end

feature {NONE} -- Basic operations

	array_traversal (one_array: ARRAY [ANY])
			-- Scan though all item elements of `one_array'
			-- and propagate the deep traversal to those
			-- that are references to objects.
		require
			array_non_void: one_array /= Void
		local
			i: INTEGER
			one_field: ANY
		do
			one_field := one_array.area
			if is_special_any_type (dynamic_type (one_field)) then
					-- `one_array' is an array of elements
					-- that are of reference type.
				from
					i := one_array.lower
				until
					i > one_array.upper 
				loop
					one_field := one_array.item (i)
					if one_field /= Void and then not is_marked (one_field) then
							-- Propagate the traversal to
							-- the next reference object
						deep_traversal (one_field)
					end
					i := i + 1
				end
			else
					-- `one_array' is an array of elements
					-- that are NOT of reference type.
				store_action (one_array)
			end
		end 

	deep_unmark (object: ANY)
			-- Unmark all objects reachable from
			-- the transitive closure of the object network
			-- reachable from the `object' root.
		require
			object_non_void: object /= Void	
		local
			type_value, nb_field, i: INTEGER
			one_array: ARRAY [ANY]
			one_field: ANY
		do
			unmark (object)
			one_array ?= object
			if one_array /= Void then
				array_unmark (one_array)
			else
				from
					i := 1
					nb_field := field_count (object)
				until
					i > nb_field
				loop
					type_value := field_type (i, object)
					if type_value = Reference_type then
						one_field := field (i, object)
						if one_field /= Void and then is_marked (one_field) then
							deep_unmark (one_field)
						end
					end
					i := i + 1
				end
			end
		end

	array_unmark (one_array: ARRAY [ANY])
			-- Scan though all item elements of `one_array'
			-- and propagate the unmarking traversal to those
			-- that are references to objects.
		require
			array_non_void: one_array /= Void
		local
			i: INTEGER
			one_field: ANY
		do
			one_field := one_array.area
			if is_special_any_type (dynamic_type (one_field)) then
				from
					i := one_array.lower
				until
					i > one_array.upper 
				loop
					one_field := one_array.item (i)
					if one_field /= Void and then is_marked (one_field) then
						deep_unmark (one_field)
					end
					i := i + 1
				end
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




end -- class EXT_INTERNAL



