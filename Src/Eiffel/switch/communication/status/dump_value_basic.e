
indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DUMP_VALUE_BASIC

inherit
	DUMP_VALUE
		redefine
			value_boolean,
            value_character_8, value_character_32,
            value_integer_8, value_integer_16, value_integer_32, value_integer_64,
            value_natural_8, value_natural_16, value_natural_32, value_natural_64,
            value_real_32, value_real_64,
			value_bits, type_of_bits,
			value_pointer,
			is_basic,
			is_type_boolean, is_type_integer_32
		end

create
	make_empty

feature {DUMP_VALUE_FACTORY} -- Restricted Initialization

	set_boolean_value  (value: BOOLEAN; dtype: CLASS_C) is
			-- make a boolean item initialized to `value'
		do
			value_boolean := value
			type := Type_boolean
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_character_8_value (value: CHARACTER; dtype: CLASS_C) is
			-- make a character item initialized to `value'
		do
			value_character_8 := value
			type := type_character_8
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_character_32_value (value: WIDE_CHARACTER; dtype: CLASS_C) is
			-- make a wide_character item initialized to `value'
		do
			value_character_32 := value
			type := Type_character_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_integer_8_value  (value: INTEGER_8; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
--			value_integer_8 := value
			value_integer_32 := value
			type := Type_integer_8
			dynamic_class := dtype
		ensure
			value_integer_8 = value
			type /= Type_unknown
		end

	set_integer_16_value  (value: INTEGER_16; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
--			value_integer_16 := value
			value_integer_32 := value
			type := Type_integer_16
			dynamic_class := dtype
		ensure
			value_integer_16 = value
			type /= Type_unknown
		end

	set_integer_32_value  (value: INTEGER_32; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			value_integer_32 := value
			type := Type_integer_32
			dynamic_class := dtype
		ensure
			value_integer_32 = value
			type /= Type_unknown
		end

	set_integer_64_value  (value: INTEGER_64; dtype: CLASS_C) is
			-- make a integer_64 item initialized to `value'
		do
			value_integer_64 := value
			type := Type_integer_64
			dynamic_class := dtype
		ensure
			value_integer_64 = value
			type /= Type_unknown
		end

	set_natural_8_value  (value: NATURAL_8; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
--			value_natural_8 := value
			value_natural_32 := value
			type := Type_natural_8
			dynamic_class := dtype
		ensure
			value_natural_8 = value
			type /= Type_unknown
		end

	set_natural_16_value  (value: NATURAL_16; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
--			value_natural_16 := value
			value_natural_32 := value
			type := Type_natural_16
			dynamic_class := dtype
		ensure
			value_natural_16 = value
			type /= Type_unknown
		end

	set_natural_32_value  (value: NATURAL_32; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			value_natural_32 := value
			type := Type_natural_32
			dynamic_class := dtype
		ensure
			value_natural_32 = value
			type /= Type_unknown
		end

	set_natural_64_value  (value: NATURAL_64; dtype: CLASS_C) is
			-- make a integer_64 item initialized to `value'
		do
			value_natural_64 := value
			type := Type_natural_64
			dynamic_class := dtype
		ensure
			value_natural_64 = value
			type /= Type_unknown
		end

	set_real_32_value (value: REAL; dtype: CLASS_C) is
			-- make a real item initialized to `value'
		do
			value_real_32 := value
			type := type_real_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_real_64_value (value: DOUBLE; dtype: CLASS_C) is
			-- make a double item initialized to `value'
		do
			value_real_64 := value
			type := type_real_64
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_pointer_value (value: POINTER; dtype: CLASS_C) is
			-- make a pointer item initialized to `value'
		do
			value_pointer := value
			type := Type_pointer
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_bits_value  (a_value, a_type: STRING; dtype: CLASS_C) is
			-- Make bit item of type `a_type' and class `dtype'
			-- initialized with `value'.
		require
			a_value_not_void: a_value /= Void
			a_type_not_void: a_type /= Void
			dtype_not_void: dtype /= Void
		do
			value_bits := a_value
			type_of_bits := a_type
			type := Type_bits
			dynamic_class := dtype
		ensure
			type_set: type /= Type_unknown
			dynamic_class_set: dynamic_class = dtype
			value_bits_set: value_bits = a_value
			type_of_bits_set: type_of_bits = a_type
		end

feature {DUMP_VALUE, ES_OBJECTS_GRID_LINE, DBG_EXPRESSION_EVALUATOR, DBG_EVALUATOR_IMP} -- Internal data

	value_boolean	: BOOLEAN
	value_character_8 : CHARACTER
	value_character_32: CHARACTER_32
	value_integer_8: INTEGER_8 is
		do
			Result := value_integer_32.as_integer_8
		end
	value_integer_16: INTEGER_16 is
		do
			Result := value_integer_32.as_integer_16
		end
	value_integer_32: INTEGER_32
	value_integer_64: INTEGER_64
	value_natural_8: NATURAL_8 is
		do
			Result := value_natural_32.as_natural_8
		end
	value_natural_16: NATURAL_16 is
		do
			Result := value_natural_32.as_natural_16
		end
	value_natural_32: NATURAL_32
	value_natural_64: NATURAL_64

	value_real_32	: REAL_32
	value_real_64	: REAL_64
	value_bits		: STRING
	type_of_bits	: STRING
	value_pointer	: POINTER

feature -- Access

	is_basic: BOOLEAN is
			-- Is `Current' of a basic type?
		do
			Result := True
		end

	is_type_boolean: BOOLEAN is
		do
			Result := type = Type_boolean
		end

	is_type_integer_32: BOOLEAN is
		do
			Result := type = Type_integer_32
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
