-- Basic classes in a system

class BASIC_SYSTEM_I 

inherit

	SHARED_CODE_FILES
	
feature 

	plug_file: INDENT_FILE;

	general_class: CLASS_I;
			-- Class GENERAL

	any_class: CLASS_I;
			-- Class ANY

	boolean_class: CLASS_I;
			-- Class BOOLEAN

	character_class: CLASS_I;
			-- Class CHARACTER

	integer_class: CLASS_I;
			-- Class INTEGER

	real_class: CLASS_I;
			-- Class REAL

	double_class: CLASS_I;
			-- Class DOUBLE

	pointer_class: CLASS_I;
			-- Class POINTER

	string_class: CLASS_I;
			-- Class STRING

	array_class: CLASS_I;
			-- Class ARRAY

	special_class: CLASS_I;
			-- Class SPECIAL

	to_special_class: CLASS_I;
			-- Class TO_SPECIAL

	bit_class: CLASS_I;
			-- Class BIT_REF

	character_ref_class: CLASS_I;
			-- Class CHARACTER_REF

	boolean_ref_class: CLASS_I;
			-- Class BOOLEAN_REF

	integer_ref_class: CLASS_I;
			-- Class INTEGER_REF

	real_ref_class: CLASS_I;
			-- Class REAL_REF

	double_ref_class: CLASS_I;
			-- Class DOUBLE_REF

	pointer_ref_class: CLASS_I;
			-- Class POINTER_REF

	set_general_class (c: CLASS_I) is
			-- Assign `c' to `general_class'.
		do
			general_class := c;
		end;
	
	set_any_class (c: CLASS_I) is
			-- Assign `c' to `any_class'.
		do
			any_class := c;
		end;

	set_boolean_class (c: CLASS_I) is
			-- Assign `c' to `boolean_class'.
		do
			boolean_class := c;
		end;

	set_character_class (c: CLASS_I) is
			-- Assign `c' to `character_class'.
		do
			character_class := c;
		end;

	set_integer_class (c: CLASS_I) is
			-- Assign `c' to `integer_class'.
		do
			integer_class := c;
		end;

	set_real_class (c: CLASS_I) is
			-- Assign `c' to `real_class'.
		do
			real_class := c;
		end;

	set_double_class (c: CLASS_I) is
			-- Assign `c' to `double_class'.
		do
			double_class := c;
		end;

	set_pointer_class (c: CLASS_I) is
			-- Assign `c' to `pointer_class'.
		do
			pointer_class := c;
		end;

	set_string_class (c: CLASS_I) is
			-- Assign `c' to `string_class'.
		do
			string_class := c;
		end;

	set_array_class (c: CLASS_I) is
			-- Assign `c' to `array_class'.
		do
			array_class := c;
		end;

	set_special_class (c: CLASS_I) is
			-- Assign `c'to `special_class'.
		do
			special_class := c;
		end;

	set_to_special_class (c: CLASS_I) is
			-- Assign `c' to `to_special_class'.
		do
			to_special_class := c;
		end;

	set_bit_class (c: CLASS_I) is
			-- Assign `c' to `bit_class'.
		do
			bit_class := c;
		end;

	set_character_ref_class (c: CLASS_I) is
			-- Assign `c' to `character_ref_class'.
		do
			character_ref_class := c;
		end;

	set_boolean_ref_class (c: CLASS_I) is
			-- Assign `c' to `boolean_ref_class'.
		do
			boolean_ref_class := c;
		end;

	set_integer_ref_class (c: CLASS_I) is
			-- Assign `c' to `integer_ref_class'.
		do
			integer_ref_class := c;
		end;

	set_real_ref_class (c: CLASS_I) is
			-- Assign `c' to `real_ref_class'.
		do
			real_ref_class := c;
		end;

	set_double_ref_class (c: CLASS_I) is
			-- Assign `c' to `double_ref_class'.
		do
			double_ref_class := c;
		end;

	set_pointer_ref_class (c: CLASS_I) is
			-- Assign `c' to `pointer_ref_class'.
		do
			pointer_ref_class := c;
		end;

	general_id: INTEGER is
			-- Id of class GENERAL
		require
			general_class_exists: general_class /= Void;
			compiled: general_class.compiled;
		do
			Result := general_class.compiled_class.id;
		end;

	any_id: INTEGER is
			-- Id of class ANY
		require
			any_class_exists: any_class /= Void;
			compiled: any_class.compiled;
		do
			Result := any_class.compiled_class.id;
		end;

	boolean_id: INTEGER is
			-- Id of class BOOLEAN
		require
			boolean_class_exists: boolean_class /= Void;
			compiled: boolean_class.compiled;
		do
			Result := boolean_class.compiled_class.id;
		end;

	character_id: INTEGER is
			-- Id of class CHARACTER
		require
			character_class_exists: character_class /= Void;
			compiled: character_class.compiled;
		do
			Result := character_class.compiled_class.id;
		end;

	integer_id: INTEGER is
			-- Id of class INTEGER
		require
			integer_class_exists: integer_class /= Void;
			compiled: integer_class.compiled;
		do
			Result := integer_class.compiled_class.id;
		end;

	real_id: INTEGER is
			-- Id of class REAL
		require
			real_class_exists: real_class /= Void;
			compiled: real_class.compiled;
		do
			Result := real_class.compiled_class.id;
		end;

	double_id: INTEGER is
			-- Id of class DOUBLE
		require
			double_class_exists: double_class /= Void;
			compiled: double_class.compiled;
		do
			Result := double_class.compiled_class.id;
		end;

	pointer_id: INTEGER is
			-- Id of class POINTER
		require
			pointer_class_exists: pointer_class /= Void;
			compiled: pointer_class.compiled;
		do
			Result := pointer_class.compiled_class.id;
		end;

	array_id: INTEGER is
			-- Id of class ARRAY
		require
			array_class_exists: array_class /= Void;
			compiled: array_class.compiled;
		do
			Result := array_class.compiled_class.id;
		end;

	string_id: INTEGER is
			-- Id of class STRING
		require
			string_class_exists: string_class /= Void;
			compiled: string_class.compiled;
		do
			Result := string_class.compiled_class.id;
		end; -- string_id

	special_id: INTEGER is
			-- Id of class SPECIAL
		require
			special_class_exists: special_class /= Void;
			compiled: special_class.compiled;
		do
			Result := special_class.compiled_class.id;
		end; -- special_id

	to_special_id: INTEGER is
			-- Id of class TO_SPECIAL
		require
			to_special_class_exists: to_special_class /= Void;
			compiled: to_special_class.compiled;
		do
			Result := to_special_class.compiled_class.id;
		end; -- to_special_id

	bit_id: INTEGER is
			-- Id of class BIT_REF
		require
			bit_class_exists: bit_class /= Void;
			compiled: bit_class.compiled;
		do
			Result := bit_class.compiled_class.id;
		end; -- bit_id

	character_ref_id: INTEGER is
			-- Id of class CHARACTER_REF
		require
			character_ref_class_exists: character_ref_class /= Void;
			compiled: character_ref_class.compiled;
		do
			Result := character_ref_class.compiled_class.id;
		end; -- character_ref_id

	boolean_ref_id: INTEGER is
			-- Id of class BOOLEAN_REF
		require
			boolean_ref_class_exists: boolean_ref_class /= Void;
			compiled: boolean_ref_class.compiled;
		do
			Result := boolean_ref_class.compiled_class.id;
		end; -- boolean_ref_id

	integer_ref_id: INTEGER is
			-- Id of class INTEGER_REF
		require
			integer_ref_class_exists: integer_ref_class /= Void;
			compiled: integer_ref_class.compiled;
		do
			Result := integer_ref_class.compiled_class.id;
		end; -- integer_ref_id

	real_ref_id: INTEGER is
			-- Id of class REAL_REF
		require
			real_ref_class_exists: real_ref_class /= Void;
			compiled: real_ref_class.compiled;
		do
			Result := real_ref_class.compiled_class.id;
		end; -- real_ref_id

	double_ref_id: INTEGER is
			-- Id of class DOUBLE_REF
		require
			double_ref_class_exists: double_ref_class /= Void;
			compiled: double_ref_class.compiled;
		do
			Result := double_ref_class.compiled_class.id;
		end; -- double_ref_id

	pointer_ref_id: INTEGER is
			-- Id of class POINTER_REF
		require
			pointer_ref_class_exists: pointer_ref_class /= Void;
			compiled: pointer_ref_class.compiled;
		do
			Result := pointer_ref_class.compiled_class.id;
		end; -- pointer_ref_id

	pointer_ref_dtype: INTEGER is
			-- Id of class POINTER_REF
		require
			pointer_ref_class_exists: pointer_ref_class /= Void;
			compiled: pointer_ref_class.compiled;
		do
			Result := pointer_ref_class.compiled_class.types.first.type_id;
		end; 

	double_ref_dtype: INTEGER is
			-- Dynamic type_id of class DOUBLE_REF
		require
			double_ref_class_exists: double_ref_class /= Void;
			compiled: double_ref_class.compiled;
		do
			Result := double_ref_class.compiled_class.types.first.type_id;
		end; 

	real_ref_dtype: INTEGER is
			-- Dynamic type_id of class REAL_REF
		require
			real_ref_class_exists: real_ref_class /= Void;
			compiled: real_ref_class.compiled;
		do
			Result := real_ref_class.compiled_class.types.first.type_id;
		end; 

	integer_ref_dtype: INTEGER is
			-- Dynamic type_id of class INTEGER_REF
		require
			int_ref_class_exists: integer_ref_class /= Void;
			compiled: integer_ref_class.compiled;
		do
			Result := integer_ref_class.compiled_class.types.first.type_id;
		end; 

	boolean_ref_dtype: INTEGER is
			-- Dynamic type_id of class BOOLEAN_REF
		require
			bool_ref_class_exists: boolean_ref_class /= Void;
			compiled: boolean_ref_class.compiled;
		do
			Result := boolean_ref_class.compiled_class.types.first.type_id;
		end; 

	character_ref_dtype: INTEGER is
			-- Dynamic type_id of class CHARACTER_REF
		require
			char_ref_class_exists: character_ref_class /= Void;
			compiled: character_ref_class.compiled;
		do
			Result := character_ref_class.compiled_class.types.first.type_id;
		end; 

	generate_dynamic_ref_type is
			-- Generate dynaminc reference types of basic classes.
		do
			Plug_file.putstring ("int int_ref_dtype = ");
			Plug_file.putint (integer_ref_dtype - 1);
			Plug_file.putstring (";%N");	
			Plug_file.putstring ("int bool_ref_dtype = ");
			Plug_file.putint (boolean_ref_dtype - 1);
			Plug_file.putstring (";%N");	
			Plug_file.putstring ("int real_ref_dtype = ");
			Plug_file.putint (real_ref_dtype - 1);
			Plug_file.putstring (";%N");	
			Plug_file.putstring ("int char_ref_dtype = ");
			Plug_file.putint (character_ref_dtype - 1);
			Plug_file.putstring (";%N");	
			Plug_file.putstring ("int doub_ref_dtype = ");
			Plug_file.putint (double_ref_dtype - 1);
			Plug_file.putstring (";%N");	
			Plug_file.putstring ("int point_ref_dtype = ");
			Plug_file.putint (pointer_ref_dtype - 1);
			Plug_file.putstring (";%N");	
		end;

end -- class BASIC_SYSTEM_I
