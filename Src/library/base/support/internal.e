indexing

	description:
		"Access to internal object properties. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class"

class
	INTERNAL

feature -- Access

	Reference_type: INTEGER is 1;
	Character_type: INTEGER is 2;
	Boolean_type:	INTEGER is 3;
	Integer_type:	INTEGER is 4;
	Real_type:	INTEGER is 5;
	Double_type: 	INTEGER is 6;
	Expanded_type:	INTEGER is 7;
	Bit_type:	INTEGER is 8;
	Pointer_type:	INTEGER is 0;


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
			"C"
		alias
			"ei_dtype"
		end;

	c_field (i: INTEGER; object: POINTER): ANY is
			-- Object referenced by the `i'-th field of `object'
		external
			"C"
		alias
			"ei_field"
		end;

	c_field_name (i: INTEGER; object: POINTER): STRING is
			-- Name of `i'-th field of `object'
		external
			"C"
		alias
			"ei_field_name"
		end;

	c_field_type (i: INTEGER; object: POINTER): INTEGER is
			-- Type of `i'-th field of `object'
		external
			"C"
		alias
			"ei_field_type"
		end;

	c_expanded_type (i: INTEGER; object: POINTER): STRING is
			-- Class name of the `i'-th expanded field of `object'
		external
			"C"
		alias
			"ei_exp_type"
		end;

	c_character_field (i: INTEGER; object: POINTER): CHARACTER is
			-- Character value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_char_field"
		end;

	c_boolean_field (i: INTEGER; object: POINTER): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_bool_field"
		end;

	c_integer_field (i: INTEGER; object: POINTER): INTEGER is
			-- Integer value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_int_field"
		end;

	c_real_field (i: INTEGER; object: POINTER): REAL is
			-- Real value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_float_field"
		end;

	c_pointer_field (i: INTEGER; object: POINTER): POINTER is
			-- Pointer value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_ptr_field"
		end;

	c_double_field (i: INTEGER; object: POINTER): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		external
			"C"
		alias
			"ei_double_field"
		end;

	c_is_special (object: POINTER): BOOLEAN is
			-- Is `object' a special object?
		external
			"C"
		alias
			"ei_special"
		end;

	c_field_offset (i: INTEGER; object: POINTER): INTEGER is
			-- Offset of `i'-th field of `object'
		external
			"C"
		alias
			"ei_offset"
		end;

	c_field_count (object: POINTER): INTEGER is
			-- Number of logical fields in `object'
		external
			"C"
		alias
			"ei_count_field"
		end;


	c_bit_size (i: INTEGER; object: POINTER): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		external
			"C"
		alias
			"ei_bit_size"
		end;


	c_size (object: POINTER): INTEGER is
			-- Physical size of `object'
		external
			"C"
		alias
			"ei_size"
		end;


end -- class INTERNAL


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
