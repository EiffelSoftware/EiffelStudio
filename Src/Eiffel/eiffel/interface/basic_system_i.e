note
	description: "Basic classes in a system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class BASIC_SYSTEM_I

feature -- Generation type

	il_generation: BOOLEAN
		deferred
		end

feature -- Classes from the configutation point of view

	any_class: CLASS_I

	system_object_class: EXTERNAL_CLASS_I
			-- Class ANY and System.Object

	system_threading_monitor_class: EXTERNAL_CLASS_I
			-- Class ANY and System.Threading.Monitor.		

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

	string_8_class, system_string_class: CLASS_I
			-- Class STRING ...

	string_32_class: CLASS_I
			-- Class STRING_32

	immutable_string_8_class: CLASS_I
			-- Class IMMUTABLE_STRING_8

	immutable_string_32_class: CLASS_I
			-- Class IMMUTABLE_STRING_32

	array_class: CLASS_I
			-- Class ARRAY

	special_class, native_array_class: CLASS_I
			-- Class SPECIAL and NATIVE_ARRAY

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

feature -- Classes from the type system of view

	ancestor_class_to_all_classes_id: INTEGER
		do
			if il_generation then
				Result := system_object_id
			else
				Result := any_id
			end
		ensure
			valid_result: Result > 0
		end

	any_id: INTEGER
			-- Id of class ANY
		require
			any_class_exists: any_class /= Void
			compiled: any_class.is_compiled
		do
			Result := any_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	any_type: CL_TYPE_A
			-- Type representing ANY
		require
			any_class_exists: any_class /= Void
			compiled: any_class.is_compiled
		do
			create Result.make (any_id)
		ensure
			any_type_not_void: Result /= Void
		end

	detachable_separate_any_type: CL_TYPE_A
			-- Type representing "detachable separate ANY".
		require
			any_class_attached: attached any_class
			compiled: any_class.is_compiled
		do
			create Result.make (any_id)
			Result.set_detachable_mark
			Result.set_separate_mark
		ensure
			detachable_separate_any_type_attached: Result /= Void
			detachable_separate_any_type_detachable: not Result.is_attached
			detachable_separate_any_type_separate: Result.is_separate
		end

	system_object_id: INTEGER
			-- Id of class SYSTEM_OBJECT
		require
			system_object_class_exists: system_object_class /= Void
			compiled: system_object_class.is_compiled
		do
			Result := system_object_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	array_id: INTEGER
			-- Id of class ARRAY
		require
			array_class_exists: array_class /= Void
			compiled: array_class.is_compiled
		do
			Result := array_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	native_array_id: INTEGER
			-- Id of class STRING
		require
			native_array_class_exists: native_array_class /= Void
			compiled: native_array_class.is_compiled
		do
			Result := native_array_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_string_id: INTEGER
			-- Id of class STRING
		require
			system_string_class_exists: system_string_class /= Void
			compiled: system_string_class.is_compiled
		do
			Result := system_string_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	string_8_id: INTEGER
			-- Id of class STRING
		require
			string_8_class_exists: string_8_class /= Void
			compiled: string_8_class.is_compiled
		do
			Result := string_8_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	string_32_id: INTEGER
			-- Id of class STRING_32
		require
			string_32_class_exists: string_32_class /= Void
			compiled: string_32_class.is_compiled
		do
			Result := string_32_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	immutable_string_8_id: INTEGER
			-- Id of class IMMUTABLE_STRING_8
		require
			immutable_string_8_class_exists: immutable_string_8_class /= Void
			compiled: immutable_string_8_class.is_compiled
		do
			Result := immutable_string_8_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	immutable_string_32_id: INTEGER
			-- Id of class IMMUTABLE_STRING_32
		require
			immutable_string_32_class_exists: immutable_string_32_class /= Void
			compiled: immutable_string_32_class.is_compiled
		do
			Result := immutable_string_32_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	special_id: INTEGER
			-- Id of class SPECIAL
		require
			special_class_exists: special_class /= Void
			compiled: special_class.is_compiled
		do
			Result := special_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	tuple_id: INTEGER
			-- Id of class TUPLE
		require
			tuple_class_exists: tuple_class /= Void
			compiled: tuple_class.is_compiled
		do
			Result := tuple_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	routine_class_id: INTEGER
			-- Id of class ROUTINE
		require
			is_routine_class_compiled: attached routine_class as c and then c.is_compiled
		do
			Result := routine_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	procedure_class_id: INTEGER
			-- Id of class PROCEDURE
		require
			is_procedure_class_compiled: attached procedure_class as c and then c.is_compiled
		do
			Result := procedure_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	function_class_id: INTEGER
			-- Id of class FUNCTION
		require
			is_function_class_compiled: attached function_class as c and then c.is_compiled
		do
			Result := function_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	predicate_class_id: INTEGER
			-- Id of class PREDICATE
		require
			is_predicate_class_compiled: attached predicate_class as c and then c.is_compiled
		do
			Result := predicate_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_type_id: INTEGER
			-- Id of class SYSTEM_STRING
		require
			system_type_class_exists: system_type_class /= Void
			compiled: system_type_class.is_compiled
		do
			Result := system_type_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	eiffel_type_id: INTEGER
			-- Id of class TYPE
		require
			type_class_exists: type_class /= Void
			compiled: type_class.is_compiled
		do
			Result := type_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	ise_exception_manager_class_id: INTEGER
			-- Id of class ISE_EXCEPTION_MANAGER
		require
			type_class_exists: ise_exception_manager_class /= Void
			compiled: ise_exception_manager_class.is_compiled
		do
			Result := ise_exception_manager_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	exception_class_id: INTEGER
			-- Id of type EXCEPTION
		require
			exception_class_exists: exception_class /= Void
			compiled: exception_class.is_compiled
		do
			Result := exception_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	rt_extension_type_id: INTEGER
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

	exception_manager_type_id: INTEGER
			-- Dynamic type_id of class ISE_EXCEPTION_MANAGER
		require
			exception_manager_class_exist: ise_exception_manager_class /= Void
			compiled: ise_exception_manager_class.is_compiled
		do
			Result := ise_exception_manager_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	exception_type_id: INTEGER
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

	reset_all
			-- Reset all information about the system.
		do
			any_class := Void
			arguments_class := Void
			array_class := Void
			boolean_class := Void
			character_32_class := Void
			character_8_class := Void
			disposable_class := Void
			exception_class := Void
			function_class := Void
			integer_16_class := Void
			integer_32_class := Void
			integer_64_class := Void
			integer_8_class := Void
			ise_exception_manager_class := Void
			native_array_class := Void
			natural_16_class := Void
			natural_32_class := Void
			natural_64_class := Void
			natural_8_class := Void
			pointer_class := Void
			predicate_class := Void
			procedure_class := Void
			real_32_class := Void
			real_64_class := Void
			routine_class := Void
			rt_extension_class := Void
			special_class := Void
			string_32_class := Void
			immutable_string_32_class := Void
			string_8_class := Void
			immutable_string_8_class := Void
			system_exception_type_class := Void
			system_object_class := Void
			system_string_class := Void
			system_type_class := Void
			system_value_type_class := Void
			tuple_class := Void
			type_class := Void
			typed_pointer_class := Void
			system_threading_monitor_class := Void
		ensure
			not attached any_class
		end

	set_any_class (c: CLASS_I)
			-- Assign `c' to `any_class'.
		require
			c_not_void: c /= Void
		do
			any_class := c
			c.set_as_basic_class
		ensure
			any_class_set: any_class = c
		end

	set_system_object_class (c: CLASS_I)
			-- Assign `c' to `system_object_class
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			if attached {EXTERNAL_CLASS_I} c as e then
				system_object_class := e
			end
		ensure
			system_object_class_set: c.is_external_class implies system_object_class = c
		end

	set_system_threading_monitor_class (c: CLASS_I)
		-- Assign `c' to `system_threading_monitor_class`
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			if attached {EXTERNAL_CLASS_I} c as e then
				system_threading_monitor_class := e
			end
		ensure
			system_threading_monitor_set: c.is_external_class implies system_threading_monitor_class = c
		end


	set_system_value_type_class (c: CLASS_I)
			-- Assign `c' to `system_value_type_class
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			if attached {EXTERNAL_CLASS_I} c as e then
				system_value_type_class := e
			end
		ensure
			system_object_class_set: c.is_external_class implies system_value_type_class = c
		end

	set_system_exception_type_class (c: CLASS_I)
			-- Assign `c' to `set_system_exception_type_class'
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			if attached {EXTERNAL_CLASS_I} c as e then
				system_exception_type_class := e
			end
		ensure
			system_exception_class_set: c.is_external_class implies system_exception_type_class = c
		end

	set_boolean_class (c: CLASS_I)
			-- Assign `c' to `boolean_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			boolean_class := c
		ensure
			boolean_class_set: boolean_class = c
		end

	set_character_class (c: CLASS_I; n: INTEGER)
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

	set_integer_class (c: CLASS_I; n: INTEGER)
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

	set_natural_class (c: CLASS_I; n: INTEGER)
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

	set_real_class (c: CLASS_I; n: INTEGER)
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

	set_pointer_class (c: CLASS_I)
			-- Assign `c' to `pointer_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			pointer_class := c
		ensure
			pointer_class_set: pointer_class = c
		end

	set_string_class (c: CLASS_I; n: INTEGER)
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

	set_immutable_string_class (c: CLASS_I; n: INTEGER)
			-- Assign `c' to `immutable_string_n_class'.
		require
			c_not_void: c /= Void
			n_valid: n = 8 or n = 32
		do
			c.set_as_basic_class
			if n = 32 then
				immutable_string_32_class := c
			else
				immutable_string_8_class := c
			end
		ensure
			immutable_string_32_class_set: n = 32 implies immutable_string_32_class = c
			immutable_string_8_class_set: n = 8 implies immutable_string_8_class = c
		end

	set_system_string_class (c: CLASS_I)
			-- Assign `c' to `system_string_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			system_string_class := c
		ensure
			system_string_class_set: system_string_class = c
		end

	set_array_class (c: CLASS_I)
			-- Assign `c' to `array_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			array_class := c
		ensure
			array_class_set: array_class = c
		end

	set_special_class (c: CLASS_I)
			-- Assign `c' to `special_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			special_class := c
		ensure
			special_class_set: special_class = c
		end

	set_native_array_class (c: CLASS_I)
			-- Assign `c' to `native_array_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			native_array_class := c
		ensure
			native_array_class_set: native_array_class = c
		end

	set_typed_pointer_class (c: CLASS_I)
			-- Assign `c' to `typed_pointer_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			typed_pointer_class := c
		ensure
			typed_pointer_class_set: typed_pointer_class = c
		end

	set_disposable_class (c: CLASS_I)
			-- Assign `c' to `disposable_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			disposable_class := c
		ensure
			disposable_class_set: disposable_class = c
		end

	set_tuple_class (c: CLASS_I)
			-- Assign `c' to `tuple_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			tuple_class := c
		ensure
			tuple_class_set: tuple_class = c
		end

	set_routine_class (c: CLASS_I)
			-- Assign `c' to `routine_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			routine_class := c
		ensure
			routine_class_set: routine_class = c
		end

	set_procedure_class (c: CLASS_I)
			-- Assign `c' to `procedure_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			procedure_class := c
		ensure
			procedure_class_set: procedure_class = c
		end

	set_function_class (c: CLASS_I)
			-- Assign `c' to `function_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			function_class := c
		ensure
			function_class_set: function_class = c
		end

	set_predicate_class (c: CLASS_I)
			-- Assign `c' to `predicate_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			predicate_class := c
		ensure
			predicate_class_set: predicate_class = c
		end

	set_arguments_class (c: CLASS_I)
			-- Assign `c' to `arguments_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			arguments_class := c
		ensure
			arguments_class: arguments_class = c
		end

	set_type_class (c: CLASS_I)
			-- Assign `c' to `type_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			type_class := c
		ensure
			type_class_set: type_class = c
		end

	set_system_type_class (c: CLASS_I)
			-- Assign `c' to `system_type_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			system_type_class := c
		ensure
			system_type_class_set: system_type_class = c
		end

	set_exception_class (c: CLASS_I)
			-- Assign `c' to `exception_class'.
		require
			c_not_void: c /= Void
		do
			exception_class := c
		ensure
			exception_class_set: exception_class = c
		end

	set_rt_extension_class (c: CLASS_I)
			-- Assign `c' to `rt_extension_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			rt_extension_class := c
		ensure
			rt_extension_class_set: rt_extension_class = c
		end

feature -- Settings: Exception

	set_exception_manager_class (c: CLASS_I)
			-- Assign `c' to `ise_exception_manager_class'.
		require
			c_not_void: c /= Void
		do
			c.set_as_basic_class
			ise_exception_manager_class := c
		ensure
			ise_exception_manager_class_set: ise_exception_manager_class = c
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
