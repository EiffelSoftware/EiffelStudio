indexing
	description: "Basic classes in a system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class BASIC_SYSTEM_I

feature -- Generation type

	il_generation: BOOLEAN is
		deferred
		end

feature -- Access

	any_class: CLASS_I
	system_object_class: EXTERNAL_CLASS_I
			-- Class ANY and System.Object

	system_value_type_class: EXTERNAL_CLASS_I
			-- Class System.ValueType

	system_exception_type_class: EXTERNAL_CLASS_I
			-- Class System.Exception

	boolean_class: CLASS_I
			-- Class BOOLEAN

	character_8_class, character_32_class: CLASS_I
			-- Class CHARACTER 8 and 32.

	integer_8_class, integer_16_class,
	integer_32_class, integer_64_class: CLASS_I
			-- Class INTEGER 8, 16, 32 and 64 btis

	natural_8_class, natural_16_class,
	natural_32_class, natural_64_class: CLASS_I
			-- Class NATURAL 8, 16, 32 and 64 btis

	real_32_class: CLASS_I
			-- Class REAL

	real_64_class: CLASS_I
			-- Class DOUBLE

	pointer_class: CLASS_I
			-- Class POINTER

	string_32_class, string_8_class, system_string_class: CLASS_I
			-- Class STRING ...

	array_class: CLASS_I
			-- Class ARRAY

	special_class, native_array_class: CLASS_I
			-- Class SPECIAL and NATIVE_ARRAY

	bit_class: CLASS_I
			-- Class BIT_REF

	disposable_class: CLASS_I
			-- Class DISPOSABLE

	tuple_class: CLASS_I
			-- Class TUPLE

	routine_class: CLASS_I
			-- Class ROUTINE

	procedure_class: CLASS_I
			-- Class PROCEDURE

	function_class: CLASS_I
			-- Class FUNCTION

	predicate_class: CLASS_I
			-- Class PREDICATE

	typed_pointer_class: CLASS_I
			-- Class TYPED_POINTER

	arguments_class: CLASS_I
			-- Class ARGUMENTS

	type_class, system_type_class: CLASS_I
			-- Class TYPE

	rt_extension_class: CLASS_I

	ise_exception_manager_class: CLASS_I
			-- Class ISE_EXCEPTION_MANAGER

	exception_class: CLASS_I
			-- Class EXCEPTION

feature -- Access: XX_REF classes

	character_8_ref_class, character_32_ref_class: CLASS_I
			-- Class CHARACTER_REF 8 and 32 bits.

	boolean_ref_class: CLASS_I
			-- Class BOOLEAN_REF

	integer_8_ref_class, integer_16_ref_class,
	integer_32_ref_class, integer_64_ref_class: CLASS_I
			-- Class INTEGER_REF 8, 16, 32 and 64 bits

	natural_8_ref_class, natural_16_ref_class,
	natural_32_ref_class, natural_64_ref_class: CLASS_I
			-- Class NATURAL_REF 8, 16, 32 and 64 bits

	real_32_ref_class: CLASS_I
			-- Class REAL_REF

	real_64_ref_class: CLASS_I
			-- Class DOUBLE_REF

	pointer_ref_class: CLASS_I
			-- Class POINTER_REF

feature -- Access

	ancestor_class_to_all_classes_id: INTEGER is
		do
			if il_generation then
				Result := system_object_id
			else
				Result := any_id
			end
		ensure
			valid_result: Result > 0
		end

	any_id: INTEGER is
			-- Id of class ANY
		require
			any_class_exists: any_class /= Void
			compiled: any_class.is_compiled
		do
			Result := any_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_object_id: INTEGER is
			-- Id of class SYSTEM_OBJECT
		require
			system_object_class_exists: system_object_class /= Void
			compiled: system_object_class.is_compiled
		do
			Result := system_object_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	array_id: INTEGER is
			-- Id of class ARRAY
		require
			array_class_exists: array_class /= Void
			compiled: array_class.is_compiled
		do
			Result := array_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	native_array_id: INTEGER is
			-- Id of class STRING
		require
			native_array_class_exists: native_array_class /= Void
			compiled: native_array_class.is_compiled
		do
			Result := native_array_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_string_id: INTEGER is
			-- Id of class STRING
		require
			system_string_class_exists: system_string_class /= Void
			compiled: system_string_class.is_compiled
		do
			Result := system_string_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	string_8_id: INTEGER is
			-- Id of class STRING
		require
			string_8_class_exists: string_8_class /= Void
			compiled: string_8_class.is_compiled
		do
			Result := string_8_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	special_id: INTEGER is
			-- Id of class SPECIAL
		require
			special_class_exists: special_class /= Void
			compiled: special_class.is_compiled
		do
			Result := special_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	bit_id: INTEGER is
			-- Id of class BIT_REF
		require
			bit_class_exists: bit_class /= Void
			compiled: bit_class.is_compiled
		do
			Result := bit_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	tuple_id: INTEGER is
			-- Id of class TUPLE
		require
			tuple_class_exists: tuple_class /= Void
			compiled: tuple_class.is_compiled
		do
			Result := tuple_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	routine_class_id: INTEGER is
			-- Id of class ROUTINE
		require
			routine_class_exists: routine_class /= Void
			compiled: routine_class.is_compiled
		do
			Result := routine_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	procedure_class_id: INTEGER is
			-- Id of class PROCEDURE
		require
			procedure_class_exists: procedure_class /= Void
			compiled: procedure_class.is_compiled
		do
			Result := procedure_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	function_class_id: INTEGER is
			-- Id of class FUNCTION
		require
			function_class_exists: function_class /= Void
			compiled: function_class.is_compiled
		do
			Result := function_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	predicate_class_id: INTEGER is
			-- Id of class PREDICATE
		require
			predicate_class_exists: predicate_class /= Void
			compiled: predicate_class.is_compiled
		do
			Result := predicate_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_type_id: INTEGER is
			-- Id of class SYSTEM_STRING
		require
			system_type_class_exists: system_type_class /= Void
			compiled: system_type_class.is_compiled
		do
			Result := system_type_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	eiffel_type_id: INTEGER is
			-- Id of class TYPE
		require
			type_class_exists: type_class /= Void
			compiled: type_class.is_compiled
		do
			Result := type_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	ise_exception_manager_class_id: INTEGER is
			-- Id of class ISE_EXCEPTION_MANAGER
		require
			type_class_exists: ise_exception_manager_class /= Void
			compiled: ise_exception_manager_class.is_compiled
		do
			Result := ise_exception_manager_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	exception_class_id: INTEGER is
			-- Id of type EXCEPTION
		require
			exception_class_exists: exception_class /= Void
			compiled: exception_class.is_compiled
		do
			Result := exception_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	rt_extension_type_id: INTEGER is
			-- Id of type RT_EXTENSION
		require
			rt_extension_class_exists: rt_extension_class /= Void
			compiled: rt_extension_class.is_compiled
		do
			Result := rt_extension_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

feature -- Status report

	pointer_ref_type_id: INTEGER is
			-- Id of class POINTER_REF
		require
			pointer_ref_class_exists: pointer_ref_class /= Void
			compiled: pointer_ref_class.is_compiled
		do
			Result := pointer_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	real_64_ref_type_id: INTEGER is
			-- Dynamic type_id of class DOUBLE_REF
		require
			real_64_ref_class_exists: real_64_ref_class /= Void
			compiled: real_64_ref_class.is_compiled
		do
			Result := real_64_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	real_32_ref_type_id: INTEGER is
			-- Dynamic type_id of class REAL_REF
		require
			real_32_ref_class_exists: real_32_ref_class /= Void
			compiled: real_32_ref_class.is_compiled
		do
			Result := real_32_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	integer_ref_type_id (n: INTEGER): INTEGER is
			-- Dynamic type_id of class INTEGER_REF with `n' bits.
		require
			int_ref_class_exists: integer_8_ref_class /= Void and then
						integer_16_ref_class /= Void and then
						integer_32_ref_class /= Void and then
						integer_64_ref_class /= Void
			compiled: integer_8_ref_class.is_compiled and then
						integer_16_ref_class.is_compiled and then
						integer_32_ref_class.is_compiled and then
						integer_64_ref_class.is_compiled
		do
			inspect n
			when 8 then Result := integer_8_ref_class.compiled_class.types.first.type_id
			when 16 then Result := integer_16_ref_class.compiled_class.types.first.type_id
			when 32 then Result := integer_32_ref_class.compiled_class.types.first.type_id
			when 64 then Result := integer_64_ref_class.compiled_class.types.first.type_id
			end
		ensure
			valid_result: Result > 0
		end

	natural_ref_type_id (n: INTEGER): INTEGER is
			-- Dynamic type_id of class NATURAL_REF with `n' bits.
		require
			int_ref_class_exists: natural_8_ref_class /= Void and then
						natural_16_ref_class /= Void and then
						natural_32_ref_class /= Void and then
						natural_64_ref_class /= Void
			compiled: natural_8_ref_class.is_compiled and then
						natural_16_ref_class.is_compiled and then
						natural_32_ref_class.is_compiled and then
						natural_64_ref_class.is_compiled
		do
			inspect n
			when 8 then Result := natural_8_ref_class.compiled_class.types.first.type_id
			when 16 then Result := natural_16_ref_class.compiled_class.types.first.type_id
			when 32 then Result := natural_32_ref_class.compiled_class.types.first.type_id
			when 64 then Result := natural_64_ref_class.compiled_class.types.first.type_id
			end
		ensure
			valid_result: Result > 0
		end

	boolean_ref_type_id: INTEGER is
			-- Dynamic type_id of class BOOLEAN_REF
		require
			bool_ref_class_exists: boolean_ref_class /= Void
			compiled: boolean_ref_class.is_compiled
		do
			Result := boolean_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	character_8_ref_type_id: INTEGER is
			-- Dynamic type_id of class CHARACTER_REF
		require
			character_8_ref_class_exists: character_8_ref_class /= Void
			compiled: character_8_ref_class.is_compiled
		do
			Result := character_8_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	character_32_ref_type_id: INTEGER is
			-- Dynamic type_id of class UNICODE_CHARACTER_REF
		require
			character_32_ref_class_exists: character_32_ref_class /= Void
			compiled: character_32_ref_class.is_compiled
		do
			Result := character_32_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

feature -- Status report

	exception_manager_type_id: INTEGER is
			-- Dynamic type_id of class ISE_EXCEPTION_MANAGER
		require
			exception_manager_class_exist: ise_exception_manager_class /= Void
			compiled: ise_exception_manager_class.is_compiled
		do
			Result := ise_exception_manager_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	exception_type_id: INTEGER is
			-- Dynamic type_id of class EXCEPTION
		require
			exception_class_exist: exception_class /= Void
			compiled: exception_class.is_compiled
		do
			Result := exception_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

feature -- Settings

	set_any_class (c: CLASS_I) is
			-- Assign `c' to `any_class'.
		require
			c_not_void: c /= Void
		do
			any_class := c
			c.set_as_basic_class
		ensure
			any_class_set: any_class = c
		end

	set_system_object_class (c: CLASS_I) is
			-- Assign `c' to `system_object_class
		require
			c_not_void: c /= Void
		local
			l_ext: EXTERNAL_CLASS_I
		do
			c.set_as_basic_class
			l_ext ?= c
			if l_ext /= Void then
				system_object_class := l_ext
			end
		ensure
			system_object_class_set: c.is_external_class implies system_object_class = c
		end

	set_system_value_type_class (c: CLASS_I) is
			-- Assign `c' to `system_value_type_class
		require
			c_not_void: c /= Void
		local
			l_ext: EXTERNAL_CLASS_I
		do
			c.set_as_basic_class
			l_ext ?= c
			if l_ext /= Void then
				system_value_type_class := l_ext
			end
		ensure
			system_object_class_set: c.is_external_class implies system_value_type_class = c
		end

	set_system_exception_type_class (c: CLASS_I) is
			-- Assign `c' to `set_system_exception_type_class'
		require
			c_not_void: c /= Void
		local
			l_ext: EXTERNAL_CLASS_I
		do
			c.set_as_basic_class
			l_ext ?= c
			if l_ext /= Void then
				system_exception_type_class := l_ext
			end
		ensure
			system_exception_class_set: c.is_external_class implies system_exception_type_class = c
		end

	set_boolean_class (c: CLASS_I) is
			-- Assign `c' to `boolean_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			boolean_class := c
		ensure
			boolean_class_set: boolean_class = c
		end

	set_character_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `character_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 32
		do
			c.set_as_basic_class
			if n = 32 then
				character_32_class := c
			else
				character_8_class := c
			end
		ensure
			character_32_class_set: n = 32 implies character_32_class = c
			character_8_class_set: n = 8 implies character_8_class = c
		end

	set_integer_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 16 or n = 32 or n = 64
		do
			c.set_as_basic_class
			inspect n
			when 8 then integer_8_class := c
			when 16 then integer_16_class := c
			when 32 then integer_32_class := c
			when 64 then integer_64_class := c
			end
		ensure
			integer_8_class_set: n = 8 implies integer_8_class = c
			integer_16_class_set: n = 16 implies integer_16_class = c
			integer_32_class_set: n = 32 implies integer_32_class = c
			integer_64_class_set: n = 64 implies integer_64_class = c
		end

	set_natural_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `natural_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 16 or n = 32 or n = 64
		do
			c.set_as_basic_class
			inspect n
			when 8 then natural_8_class := c
			when 16 then natural_16_class := c
			when 32 then natural_32_class := c
			when 64 then natural_64_class := c
			end
		ensure
			natural_8_class_set: n = 8 implies natural_8_class = c
			natural_16_class_set: n = 16 implies natural_16_class = c
			natural_32_class_set: n = 32 implies natural_32_class = c
			natural_64_class_set: n = 64 implies natural_64_class = c
		end

	set_real_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `real_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 32 or n = 64
		do
			c.set_as_basic_class
			if n = 32 then
				real_32_class := c
			else
				real_64_class := c
			end
		ensure
			real_32_class_set: n = 32 implies real_32_class = c
			real_64_class_set: n = 64 implies real_64_class = c
		end

	set_pointer_class (c: CLASS_I) is
			-- Assign `c' to `pointer_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			pointer_class := c
		ensure
			pointer_class_set: pointer_class = c
		end

	set_string_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `string_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 32
		do
			c.set_as_basic_class
			if n = 32 then
				string_32_class := c
			else
				string_8_class := c
			end
		ensure
			string_32_class_set: n = 32 implies string_32_class = c
			string_8_class_set: n = 8 implies string_8_class = c
		end

	set_system_string_class (c: CLASS_I) is
			-- Assign `c' to `system_string_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			system_string_class := c
		ensure
			system_string_class_set: system_string_class = c
		end

	set_array_class (c: CLASS_I) is
			-- Assign `c' to `array_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			array_class := c
		ensure
			array_class_set: array_class = c
		end

	set_special_class (c: CLASS_I) is
			-- Assign `c' to `special_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			special_class := c
		ensure
			special_class_set: special_class = c
		end

	set_native_array_class (c: CLASS_I) is
			-- Assign `c' to `native_array_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			native_array_class := c
		ensure
			native_array_class_set: native_array_class = c
		end

	set_typed_pointer_class (c: CLASS_I) is
			-- Assign `c' to `typed_pointer_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			typed_pointer_class := c
		ensure
			typed_pointer_class_set: typed_pointer_class = c
		end

	set_bit_class (c: CLASS_I) is
			-- Assign `c' to `bit_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			bit_class := c
		ensure
			bit_class_set: bit_class = c
		end

	set_disposable_class (c: CLASS_I) is
			-- Assign `c' to `disposable_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			disposable_class := c
		ensure
			disposable_class_set: disposable_class = c
		end

	set_tuple_class (c: CLASS_I) is
			-- Assign `c' to `tuple_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			tuple_class := c
		ensure
			tuple_class_set: tuple_class = c
		end

	set_routine_class (c: CLASS_I) is
			-- Assign `c' to `routine_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			routine_class := c
		ensure
			routine_class_set: routine_class = c
		end

	set_procedure_class (c: CLASS_I) is
			-- Assign `c' to `procedure_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			procedure_class := c
		ensure
			procedure_class_set: procedure_class = c
		end

	set_function_class (c: CLASS_I) is
			-- Assign `c' to `function_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			function_class := c
		ensure
			function_class_set: function_class = c
		end

	set_predicate_class (c: CLASS_I) is
			-- Assign `c' to `predicate_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			predicate_class := c
		ensure
			predicate_class_set: predicate_class = c
		end

	set_arguments_class (c: CLASS_I) is
			-- Assign `c' to `arguments_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			arguments_class := c
		ensure
			arguments_class: arguments_class = c
		end

	set_type_class (c: CLASS_I) is
			-- Assign `c' to `type_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			type_class := c
		ensure
			type_class_set: type_class = c
		end

	set_system_type_class (c: CLASS_I) is
			-- Assign `c' to `system_type_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			system_type_class := c
		ensure
			system_type_class_set: system_type_class = c
		end

	set_exception_class (c: CLASS_I) is
			-- Assign `c' to `exception_class'.
		require
			c_not_void: c /= Void
		do
			exception_class := c
		ensure
			exception_class_set: exception_class = c
		end

	set_rt_extension_class (c: CLASS_I) is
			-- Assign `c' to `rt_extension_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			rt_extension_class := c
		ensure
			rt_extension_class_set: rt_extension_class = c
		end

feature -- Settings: XX_REF classes

	set_character_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `character_n_ref_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 32
		do
			c.set_as_basic_class
			if n = 32 then
				character_32_ref_class := c
			else
				character_8_ref_class := c
			end
		ensure
			character_32_ref_class_set: n = 32 implies character_32_ref_class = c
			character_8_ref_class_set: n = 8 implies character_8_ref_class = c
		end

	set_boolean_ref_class (c: CLASS_I) is
			-- Assign `c' to `boolean_ref_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			boolean_ref_class := c
		ensure
			boolean_ref_class_set: boolean_ref_class = c
		end

	set_integer_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_ref_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			inspect n
			when 8 then integer_8_ref_class := c
			when 16 then integer_16_ref_class := c
			when 32 then integer_32_ref_class := c
			when 64 then integer_64_ref_class := c
			end
		ensure
			integer_8_ref_class_set: n = 8 implies integer_8_ref_class = c
			integer_16_ref_class_set: n = 16 implies integer_16_ref_class = c
			integer_32_ref_class_set: n = 32 implies integer_32_ref_class = c
			integer_64_ref_class_set: n = 64 implies integer_64_ref_class = c
		end

	set_natural_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `natural_n_ref_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			inspect n
			when 8 then natural_8_ref_class := c
			when 16 then natural_16_ref_class := c
			when 32 then natural_32_ref_class := c
			when 64 then natural_64_ref_class := c
			end
		ensure
			natural_8_ref_class_set: n = 8 implies natural_8_ref_class = c
			natural_16_ref_class_set: n = 16 implies natural_16_ref_class = c
			natural_32_ref_class_set: n = 32 implies natural_32_ref_class = c
			natural_64_ref_class_set: n = 64 implies natural_64_ref_class = c
		end

	set_real_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `real_n_ref_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 32 or n = 64
		do
			c.set_as_basic_class
			if n = 32 then
				real_32_ref_class := c
			else
				real_64_ref_class := c
			end
		ensure
			real_32_ref_class_set: n = 32 implies real_32_ref_class = c
			real_64_ref_class_set: n = 64 implies real_64_ref_class = c
		end

	set_pointer_ref_class (c: CLASS_I) is
			-- Assign `c' to `pointer_ref_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			pointer_ref_class := c
		ensure
			pointer_ref_class_set: pointer_ref_class = c
		end

feature -- Settings: Exception

	set_exception_manager_class (c: CLASS_I) is
			-- Assign `c' to `ise_exception_manager_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			ise_exception_manager_class := c
		ensure
			ise_exception_manager_class_set: ise_exception_manager_class = c
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

end -- class BASIC_SYSTEM_I
