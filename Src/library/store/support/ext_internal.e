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
			local_real: REAL
			local_double: DOUBLE
			local_boolean: BOOLEAN
			local_char: CHARACTER
		do
			ftype := field_type (i, object)
			fname := field_name (i, object)
			Result := True

			if ftype = Integer_type then
				if attached {DOUBLE_REF} value as double_ref then
					local_int := double_ref.item.truncated_to_integer
				else
					if attached {INTEGER_REF} value as int_ref then
						local_int := int_ref.item
					else
						Result := False
					end
				end
				set_integer_field (i, object, local_int)
			elseif ftype = Real_type then
				if attached {REAL_REF} value as real_ref then
					local_real := real_ref.item
					set_real_field (i, object, local_real)
				elseif attached {DOUBLE_REF} value as double_ref then
					local_real := double_ref.item.truncated_to_real
					set_real_field (i, object, local_real)
				elseif attached {INTEGER_REF} value as int_ref then
					local_real := int_ref.item
					set_real_field (i, object, local_real)
				else
					Result := False
				end
			elseif ftype = Double_type then
				if attached {REAL_REF} value as real_ref then
					local_double := real_ref.item
					set_double_field (i, object, local_double)
				elseif attached {DOUBLE_REF} value as double_ref then
					local_double := double_ref.item
					set_double_field (i, object, local_double)
				elseif attached {INTEGER_REF} value as int_ref then
					local_double := int_ref.item
					set_double_field (i, object, local_double)
				else
					Result := False
				end
			elseif is_character (value) and then ftype = Character_type then
				if attached {CHARACTER_REF} value as char_ref then
					local_char := char_ref.item
					set_character_field (i, object, local_char)
				else
					check False end -- implied by ftype = Character_type
				end
			elseif is_boolean (value) and then ftype = Boolean_type then
				if attached {BOOLEAN_REF} value as boolean_ref then
					local_boolean := boolean_ref.item
					set_boolean_field (i, object, local_boolean)
				else
					check False end -- implied by ftype = Boolean_type
				end
			elseif is_string (value) then
				if ftype = Character_type then
					if attached {STRING} value as local_string1 and then local_string1.count = 1 then
						local_char := local_string1.item (1)
						set_character_field (i, object, local_char)
					else
						Result := False
					end
				elseif ftype = Boolean_type then
					if attached {STRING} value as local_string1 and then local_string1.count = 1 then
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

feature {NONE} -- Status report

	is_void (obj: detachable ANY): BOOLEAN
		do
			Result := (obj = Void)
		end

	is_integer (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {INTEGER_REF} obj
		end

	is_real (obj: detachable ANY): BOOLEAN
			-- Is `obj' a real value?
		do
			Result := attached {REAL_REF} obj
		end

	is_double (obj: detachable ANY): BOOLEAN
			-- Is `obj' a double value?
		do
			Result := attached {DOUBLE_REF} obj
		end

	is_boolean (obj: detachable ANY): BOOLEAN
			-- Is `obj' a boolean value?
		do
			Result := attached {BOOLEAN_REF} obj
		end

	is_character (obj: detachable ANY): BOOLEAN
			-- Is `obj' a character value?
		do
			Result := attached {CHARACTER_REF} obj
		end

	is_string (obj: detachable ANY): BOOLEAN
			-- Is `obj' a string value?
		do
			Result := attached {STRING} obj
		end

	is_date (obj: detachable ANY): BOOLEAN
			-- Is `obj' a date object?
		do
			Result := attached {DATE_TIME} obj
		end

feature {NONE} -- Obsolete (Use class INTERNAL instead)

	switch_mark (obj: ANY)
		obsolete
			"Removed. Use {INTERNAL}.mark and {INTERNAL}.unmark instead."
		do
		end

	unmark_structure (obj: ANY)
		obsolete
			"Removed. Previous implementation was not safe. Use {INTERNAL} and a structure to remember%
			%what needs to be unmarked."
		do
		end	

	traversal (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object."
		do
		end

	deep_traversal (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object."
		do
		end

	object_init_action (object: ANY)
		obsolete
			"Not used anymore."
		do
		end

	reference_object_action (i: INTEGER; object: ANY)
		obsolete
			"Not used anymore."
		do
		end

	simple_object_action (type, i: INTEGER; object: ANY)
		obsolete
			"Not used anymore."
		do
		end

	object_finish_action (object: ANY)
		obsolete
			"Not used anymore."
		do
		end

	store_action (object: ANY)
		obsolete
			"Not used anymore."
		do
		end

	nb_classes: INTEGER
			-- Number of dynamic types in current system
		obsolete
			"Should not be used. No other equivalent feature is supported."
		do
		end

	array_traversal (one_array: ARRAY [ANY])
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object."
		do
		end

	array_unmark (one_array: ARRAY [ANY])
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object."
		do
		end

	deep_unmark (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object."
		do
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



