indexing

	description:
		"Access to internal object properties. %
		%This class may be used as ancestor by classes needing its %
		%facilities."
	status: "See notice at end of class"
	date: "$Date$" 
	revision: "$Revision$"

class
	INTERNAL

feature -- Access

	Reference_type: INTEGER is 1;

	Character_type: INTEGER is 2;

	Boolean_type: INTEGER is 3;

	Integer_type: INTEGER is 4;

	Real_type: INTEGER is 5;

	Double_type: INTEGER is 6;

	Expanded_type: INTEGER is 7;

	Bit_type: INTEGER is 8;

	Pointer_type: INTEGER is 0;

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end;

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := c_dynamic_type ($object)
		end;

	field (i: INTEGER; object: ANY): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			not_special: not is_special (object)
		do
			Result := c_field (i - 1, $object)
		end;

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			not_special: not is_special (object)
		do
			Result := c_field_name (i - 1, $object)
		ensure
			Result_exists: Result /= Void
		end;

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			not_special: not is_special (object)
		do
			Result := c_field_offset (i - 1, $object)
		end;

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Type of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object)
		do
			Result := c_field_type (i - 1, $object)
		end;

	expanded_field_type (i: INTEGER; object: ANY): STRING is
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			is_expanded: field_type (i, object) = Expanded_type
		do
			Result := c_expanded_type (i - 1, $object)
		ensure
			Result_exists: Result /= Void
		end;

	character_field (i: INTEGER; object: ANY): CHARACTER is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			character_field: field_type (i, object) = Character_type;
		do
			Result := c_character_field (i - 1, $object)
		end;

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			boolean_field: field_type (i, object) = Boolean_type;
		do
			Result := c_boolean_field (i - 1, $object)
		end;

	integer_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			integer_field: field_type (i, object) = Integer_type;
		do
			Result := c_integer_field (i - 1, $object)
		end;

	real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			real_field: field_type (i, object) = Real_type;
		do
			Result := c_real_field (i - 1, $object)
		end;

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			pointer_field: field_type (i, object) = Pointer_type;
		do
			Result := c_pointer_field (i - 1, $object)
		end;

	double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			double_field: field_type (i, object) = Double_type;
		do
			Result := c_double_field (i - 1, $object)
		end;

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
		require
			object_not_void: object /= Void
		do
			Result := c_is_special ($object)
		end;

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			reference_field: field_type (i, object) = Reference_type;
		do
			c_set_reference_field (i - 1, $object, $value)
		end;

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			double_field: field_type (i, object) = Double_type;
		do
			c_set_double_field (i - 1, $object, value)
		end;

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			character_field: field_type (i, object) = Character_type;
		do
			c_set_character_field (i - 1, $object, value)
		end;

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			boolean_field: field_type (i, object) = Boolean_type;
		do
			c_set_boolean_field (i - 1, $object, value)
		end;

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			integer_field: field_type (i, object) = Integer_type;
		do
			c_set_integer_field (i - 1, $object, value)
		end;

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			real_field: field_type (i, object) = Real_type;
		do
			c_set_real_field (i - 1, $object, value)
		end;

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			pointer_field: field_type (i, object) = Pointer_type;
		do
			c_set_pointer_field (i - 1, $object, value)
		end;

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := c_field_count ($object)
		end;

	bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void;
			index_large_enough: i >= 1;
			index_small_enough: i <= field_count (object);
			is_bit: field_type (i, object) = Bit_type
		do
			Result := c_bit_size (i - 1, $object)
		ensure
			positive_result: Result > 0
		end;

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := c_size ($object)
		end;

feature {NONE} -- Implementation

	c_dynamic_type (object: POINTER): INTEGER is
			-- Dynamic type of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_dtype"
		end;

	c_field (i: INTEGER; object: POINTER): ANY is
			-- Object referenced by the `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_field"
		end;

	c_field_name (i: INTEGER; object: POINTER): STRING is
			-- Name of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_field_name"
		end;

	c_field_type (i: INTEGER; object: POINTER): INTEGER is
			-- Type of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_field_type"
		end;

	c_expanded_type (i: INTEGER; object: POINTER): STRING is
			-- Class name of the `i'-th expanded field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_exp_type"
		end;

	c_character_field (i: INTEGER; object: POINTER): CHARACTER is
			-- Character value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_char_field"
		end;

	c_boolean_field (i: INTEGER; object: POINTER): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_bool_field"
		end;

	c_integer_field (i: INTEGER; object: POINTER): INTEGER is
			-- Integer value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_int_field"
		end;

	c_real_field (i: INTEGER; object: POINTER): REAL is
			-- Real value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_float_field"
		end;

	c_pointer_field (i: INTEGER; object: POINTER): POINTER is
			-- Pointer value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_ptr_field"
		end;

	c_double_field (i: INTEGER; object: POINTER): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_double_field"
		end;

	c_is_special (object: POINTER): BOOLEAN is
			-- Is `object' a special object?
		external
			"C | %"eif_internal.h%""
		alias
			"ei_special"
		end;

	c_field_offset (i: INTEGER; object: POINTER): INTEGER is
			-- Offset of `i'-th field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_offset"
		end;

	c_field_count (object: POINTER): INTEGER is
			-- Number of logical fields in `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_count_field"
		end;

	c_bit_size (i: INTEGER; object: POINTER): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_bit_size"
		end;

	c_size (object: POINTER): INTEGER is
			-- Physical size of `object'
		external
			"C | %"eif_internal.h%""
		alias
			"ei_size"
		end;

	c_set_reference_field (i: INTEGER; object: POINTER; value: POINTER) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_reference_field"
		end;

	c_set_double_field (i: INTEGER; object: POINTER; value: DOUBLE) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_double_field"
		end;

	c_set_character_field (i: INTEGER; object: POINTER; value: CHARACTER) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_char_field"
		end;

	c_set_boolean_field (i: INTEGER; object: POINTER; value: BOOLEAN) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_boolean_field"
		end;

	c_set_integer_field (i: INTEGER; object: POINTER; value: INTEGER) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_integer_field"
		end;

	c_set_real_field (i: INTEGER; object: POINTER; value: REAL) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_float_field"
		end;

	c_set_pointer_field (i: INTEGER; object: POINTER; value: POINTER) is
		external
			"C | %"eif_internal.h%""
		alias
			"ei_set_pointer_field"
		end;

end -- class INTERNAL


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

