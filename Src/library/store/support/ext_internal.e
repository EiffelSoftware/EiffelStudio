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

	GLOBAL_SETTINGS

feature -- Basic operations

	field_copy (i: INTEGER; object, value: ANY): BOOLEAN
			-- Copy `value' in `i'-th field of `object'.
		require
			object_not_void: object /= Void
			value_not_void: value /= Void
		local
			ftype, local_int: INTEGER
			local_int16: INTEGER_16
			local_int64: INTEGER_64
			local_real: REAL
			local_double: DOUBLE
			local_boolean: BOOLEAN
			local_char: CHARACTER
			l_type: INTEGER
		do
			Result := True
			ftype := field_type (i, object)
			if ftype = Integer_type then
				if attached {DOUBLE_REF} value as double_ref then
					local_int := double_ref.item.truncated_to_integer
				elseif attached {REAL_32_REF}value as real_ref then
					local_int := real_ref.item.truncated_to_integer
				elseif attached {INTEGER_REF} value as int_ref then
					local_int := int_ref.item
				elseif attached {INTEGER_16_REF} value as int16_ref then
					local_int := int16_ref.item.as_integer_32
				elseif attached {INTEGER_64_REF} value as int64_ref then
					local_int := int64_ref.item.as_integer_32
				else
					Result := False
				end
				set_integer_field (i, object, local_int)
			elseif ftype = Integer_16_type then
				if attached {DOUBLE_REF} value as double_ref then
					local_int16 := double_ref.item.truncated_to_integer.as_integer_16
				elseif attached {REAL_32_REF}value as real_ref then
					local_int16 := real_ref.item.truncated_to_integer.as_integer_16
				elseif attached {INTEGER_REF} value as int_ref then
					local_int16 := int_ref.item.as_integer_16
				elseif attached {INTEGER_16_REF} value as int16_ref then
					local_int16 := int16_ref.item
				elseif attached {INTEGER_64_REF} value as int64_ref then
					local_int16 := int64_ref.item.as_integer_16
				else
					Result := False
				end
				set_integer_16_field (i, object, local_int16)
			elseif ftype = Integer_64_type then
				if attached {DOUBLE_REF} value as double_ref then
					local_int64 := double_ref.item.truncated_to_integer_64
				elseif attached {REAL_32_REF}value as real_ref then
					local_int64 := real_ref.item.truncated_to_integer_64
				elseif attached {INTEGER_REF} value as int_ref then
					local_int64 := int_ref.item.as_integer_64
				elseif attached {INTEGER_16_REF} value as int16_ref then
					local_int64 := int16_ref.item.as_integer_64
				elseif attached {INTEGER_64_REF} value as int64_ref then
					local_int64 := int64_ref.item.as_integer_64
				else
					Result := False
				end
				set_integer_64_field (i, object, local_int64)
			elseif ftype = Real_type then
				if attached {REAL_32_REF} value as real_ref then
					local_real := real_ref.item
				elseif attached {DOUBLE_REF} value as double_ref then
					local_real := double_ref.item.truncated_to_real
				elseif attached {INTEGER_REF} value as int_ref then
					local_real := int_ref.item
				elseif attached {INTEGER_16_REF} value as int16_ref then
					local_real := int16_ref.item.to_real
				elseif attached {INTEGER_64_REF} value as int64_ref then
					local_real := int64_ref.item.to_real
				else
					Result := False
				end
				set_real_field (i, object, local_real)
			elseif ftype = Double_type then
				if attached {REAL_REF} value as real_ref then
					local_double := real_ref.item
				elseif attached {DOUBLE_REF} value as double_ref then
					local_double := double_ref.item
				elseif attached {INTEGER_REF} value as int_ref then
					local_double := int_ref.item
				elseif attached {INTEGER_16_REF} value as int16_ref then
					local_double := int16_ref.item.to_double
				elseif attached {INTEGER_64_REF} value as int64_ref then
					local_double := int64_ref.item.to_double
				else
					Result := False
				end
				set_double_field (i, object, local_double)
			elseif (ftype = Character_8_type or ftype = Character_32_type) and then attached {CHARACTER_REF} value as char_ref then
				local_char := char_ref.item
				if ftype = Character_8_type then
					set_character_8_field (i, object, local_char)
				elseif ftype = Character_32_type then
					set_character_32_field (i, object, local_char)
				end
			elseif ftype = Boolean_type and then attached {BOOLEAN_REF} value as boolean_ref then
				local_boolean := boolean_ref.item
				set_boolean_field (i, object, local_boolean)
			elseif attached {STRING_GENERAL} value as string_general then
				if ftype = Character_8_type then
					if string_general.count = 1 then
						set_character_8_field (i, object, string_general.code (1).to_character_8)
					else
						Result := False
					end
				elseif ftype = Character_32_type then
					if string_general.count = 1 then
						set_character_32_field (i, object, string_general.code (1).to_character_32)
					else
						Result := False
					end
				elseif ftype = Boolean_type then
					if string_general.count = 1 then
						local_char := string_general.code (1).to_character_8
						local_boolean := 'T' = local_char
						set_boolean_field (i, object, local_boolean)
					else
						Result := False
					end
				elseif ftype = Reference_type then
					l_type := field_static_type_of_type (i, dynamic_type (object))
					if field_conforms_to (dynamic_type (value), l_type) then
						set_reference_field (i, object, value.twin)
					elseif field_conforms_to (immutable_string_8_dtype, l_type) then
							-- Field is compatible with IMMUTABLE_STRING_8, let's go for it.
						if string_general.is_valid_as_string_8 then
							set_reference_field (i, object, create {IMMUTABLE_STRING_8}.make_from_string (string_general.to_string_8))
						else
							check is_string_8: False end
							set_reference_field (i, object, create {IMMUTABLE_STRING_8}.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (string_general)))
						end
					elseif field_conforms_to (immutable_string_32_dtype, l_type) then
							-- Field is compatible with IMMUTABLE_STRING_32, let's go for it.
						set_reference_field (i, object, create {IMMUTABLE_STRING_32}.make_from_string_general (string_general))
					else
						Result := False
					end
				else
					Result := False
				end
			elseif ftype = Reference_type and then field_conforms_to (dynamic_type (value), field_static_type_of_type (i, dynamic_type (object))) then
				set_reference_field (i, object, value.twin)
			else
				Result := False
			end
		end

	field_clean (i: INTEGER; object: ANY): BOOLEAN
			-- Clean `i'-th field of `object'.
		require
			object_not_void: object /= Void
		local
			dftype: INTEGER
		do
			dftype := dynamic_type (object)
			Result := True
			inspect field_type_of_type (i, dftype)
			when Integer_type then
				set_integer_field (i, object, numeric_null_value.truncated_to_integer)
			when Integer_16_type then
				set_integer_16_field (i, object, numeric_null_value.truncated_to_integer.as_integer_16)
			when Integer_64_type then
				set_integer_64_field (i, object, numeric_null_value.truncated_to_integer_64)
			when Real_type then
				set_real_field (i, object, numeric_null_value.truncated_to_real)
			when Double_type then
				set_double_field (i, object, numeric_null_value)
			when Character_type then
				set_character_field (i, object, ' ')
			when Boolean_type then
				set_boolean_field (i, object, False)
			when Reference_type then
				if not is_attached_type (field_static_type_of_type (i, dftype)) then
						-- We can safely set it to Void
					set_reference_field (i, object, Void)
				elseif attached field (i, object) as l_data then
						-- Object field is attached but got NULL from the database, we reset the field
						-- with its arbitrary default value based on the type of the object currently
						-- associated with the field: empty strings or date 0/1/1 0:0:0.
					if is_string (l_data) then
						set_reference_field (i, object, "")
					elseif is_string32 (l_data) then
						set_reference_field (i, object, {STRING_32} "")
					elseif is_immutable_string (l_data) then
						set_reference_field (i, object, create {IMMUTABLE_STRING_8}.make_empty)
					elseif is_immutable_string_32 (l_data) then
						set_reference_field (i, object, create {IMMUTABLE_STRING_32}.make_empty)
					elseif is_date (l_data) then
						set_reference_field (i, object, create {DATE_TIME}.make (0, 1, 1, 0, 0, 0))
					elseif is_decimal_used and then is_decimal (l_data) then
						set_reference_field (i, object, decimal_creation_function.item (["0", 1, 1, 0]))
					else
						Result := False
					end
				end
			else
				Result := False
			end
		end

feature {NONE} -- Status report

	is_void (obj: detachable ANY): BOOLEAN
		do
			Result := (obj = Void)
		end

	is_ref_integer_8 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {INTEGER_8_REF} obj
		end

	is_integer (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {INTEGER_REF} obj
		end

	is_ref_integer_16 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {INTEGER_16_REF} obj
		end

	is_ref_integer_64 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {INTEGER_64_REF} obj
		end

	is_ref_natural_8 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {NATURAL_8_REF} obj
		end

	is_ref_natural_16 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {NATURAL_16_REF} obj
		end

	is_ref_natural_32 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {NATURAL_32_REF} obj
		end

	is_ref_natural_64 (obj: detachable ANY): BOOLEAN
			-- Is `obj' an integer value?
		do
			Result := attached {NATURAL_64_REF} obj
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

	is_string32 (obj: detachable ANY): BOOLEAN
			-- Is `obj' a string value?
		do
			Result := attached {STRING_32} obj
		end

	is_string_general (obj: detachable ANY): BOOLEAN
			-- Is `obj' string general?
		do
			Result := attached {STRING_GENERAL} obj
		end

	is_immutable_string (obj: detachable ANY): BOOLEAN
			-- Is `obj' a string value?
		do
			Result := attached {IMMUTABLE_STRING_8} obj
		end

	is_immutable_string_32 (obj: detachable ANY): BOOLEAN
			-- Is `obj' a string value?
		do
			Result := attached {IMMUTABLE_STRING_32} obj
		end

	is_immutable_string_general (obj: detachable ANY): BOOLEAN
			-- Is `obj' string general?
		do
			Result := attached {IMMUTABLE_STRING_GENERAL} obj
		end

	is_readable_string_general (obj: detachable ANY): BOOLEAN
			-- Is `obj' readable string general?
		do
			Result := attached {READABLE_STRING_GENERAL} obj
		end

	is_date (obj: detachable ANY): BOOLEAN
			-- Is `obj' a date object?
		do
			Result := attached {DATE_TIME} obj
		end

	is_decimal (obj: detachable ANY): BOOLEAN
			-- Is `obj' a decimal object?
		do
			if attached obj as l_o then
				Result := is_decimal_function.item ([l_o])
			end
		end

feature {NONE} -- Implementation

	immutable_string_8_dtype: INTEGER_32
			-- Dynamic type of IMMUTABLE_STRING_8
		local
			l_s: IMMUTABLE_STRING_8
		once
			create l_s.make_empty
			Result :=  dynamic_type (l_s)
		end

	immutable_string_32_dtype: INTEGER_32
			-- Dynamic type of IMMUTABLE_STRING_32
		local
			l_s: IMMUTABLE_STRING_32
		once
			create l_s.make_empty
			Result :=  dynamic_type (l_s)
		end

feature {NONE} -- Obsolete (Use class INTERNAL instead)

	switch_mark (obj: ANY)
		obsolete
			"Removed. Use {INTERNAL}.mark and {INTERNAL}.unmark instead [2017-11-30]."
		do
		end

	unmark_structure (obj: ANY)
		obsolete
			"Removed. Previous implementation was not safe. Use {INTERNAL} and a structure to remember%
			%what needs to be unmarked [2017-11-30]."
		do
		end

	traversal (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object [2017-11-30]."
		do
		end

	deep_traversal (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object [2017-11-30]."
		do
		end

	object_init_action (object: ANY)
		obsolete
			"Not used anymore [2017-11-30]."
		do
		end

	reference_object_action (i: INTEGER; object: ANY)
		obsolete
			"Not used anymore [2017-11-30]."
		do
		end

	simple_object_action (type, i: INTEGER; object: ANY)
		obsolete
			"Not used anymore [2017-11-30]."
		do
		end

	object_finish_action (object: ANY)
		obsolete
			"Not used anymore [2017-11-30]."
		do
		end

	store_action (object: ANY)
		obsolete
			"Not used anymore [2017-11-30]."
		do
		end

	nb_classes: INTEGER
			-- Number of dynamic types in current system
		obsolete
			"Should not be used. No other equivalent feature is supported [2017-11-30]."
		do
		end

	array_traversal (one_array: ARRAY [ANY])
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object [2017-11-30]."
		do
		end

	array_unmark (one_array: ARRAY [ANY])
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object [2017-11-30]."
		do
		end

	deep_unmark (object: ANY)
		obsolete
			"Use {OBJECT_GRAPH_TRAVERSABLE} descendants to get a complete graph of an object [2017-11-30]."
		do
		end

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

end -- class EXT_INTERNAL
