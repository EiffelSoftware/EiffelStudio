indexing
	description: "Class type for NATIVE_ARRAY class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NATIVE_ARRAY_CLASS_TYPE

inherit
	CLASS_TYPE
		rename
			il_type_name as eiffel_il_type_name
		redefine
			type
		end

	SHARED_C_LEVEL

	SHARED_IL_CODE_GENERATOR

	IL_CONST

	PREDEFINED_NAMES

create
	make

feature -- Access

	type: NATIVE_ARRAY_TYPE_A
			-- Type of generic derivation.

	first_generic: TYPE_A is
			-- First generic parameter type
		require
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
		do
			Result := type.generics.item (1)
		end

	il_type_name: STRING is
			-- Associated name to current generic derivation.
			-- E.g. NATIVE_ARRAY [INTEGER] gives `INTEGER []'.
		require
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
			in_il_generation: System.il_generation
		do
			Result := il_element_type_name
			Result.append ("[]")
		end

	il_element_type_name: STRING is
			-- Associated name of element types.
			-- E.g. NATIVE_ARRAY [INTEGER] gives `INTEGER'.
		require
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
			in_il_generation: System.il_generation
		local
			cl_type: CL_TYPE_A
			l_name: STRING
		do
			cl_type ?=  type.generics.item (1)
			if cl_type = Void then
				cl_type := object_type
			end
			l_name := cl_type.il_type_name (Void, Void)
			create Result.make (l_name.count + 2)
			Result.append (l_name)
		end

	deep_il_element_type: CL_TYPE_A is
			-- Find actual type of element array.
			-- I.e. if you have NATIVE_ARRAY [NATIVE_ARRAY [INTEGER]], it
			-- will return INTEGER.
		do
			Result := type.deep_il_element_type
		ensure
			deep_il_element_type_not_void: Result /= Void
		end

feature -- IL code generation

	generate_il_put_preparation (array_type, a_context_type: CL_TYPE_A) is
			-- Generate preparation to `put' calls in case of expanded elements.
		require
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
			array_type_not_void: array_type /= Void
			array_type_is_valid: array_type.generics /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			l_actual_generic_parameter: TYPE_A
			generic_type_id: INTEGER
		do
			if first_generic.is_true_expanded then
				l_actual_generic_parameter := array_type.generics.item (1)
				if l_actual_generic_parameter.actual_type.is_formal then
						-- Type that was provided to us didn't have much type information, we have
						-- to rely on what we have from `Current'. 
					l_actual_generic_parameter := first_generic
				end
				if l_actual_generic_parameter.has_associated_class_type (a_context_type) then
					generic_type_id := l_actual_generic_parameter.associated_class_type (a_context_type).static_type_id
				else
						-- It is most likely a formal.
					generic_type_id := system.system_object_class.compiled_class.types.first.static_type_id
				end
				Il_generator.generate_array_write_preparation (generic_type_id)
			end
		end

	generate_il (name_id: INTEGER; array_type, a_context_type: CL_TYPE_A) is
			-- Generate call to `name_id' from NATIVE_ARRAY.
		require
			valid_name_id: name_id > 0
			has_generics: type.generics /= Void
			good_generic_count: type.generics.count = 1
			array_type_not_void: array_type /= Void
			array_type_is_valid: array_type.generics /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			l_actual_generic_parameter: TYPE_A
			l_actual_array_type: CL_TYPE_A
			l_formal: FORMAL_A
			l_param_is_expanded: BOOLEAN
			type_c: TYPE_C
			type_kind: INTEGER
			generic_type: CLASS_TYPE
			generic_type_id: INTEGER
		do
			l_actual_generic_parameter := first_generic
			l_param_is_expanded := l_actual_generic_parameter.is_true_expanded

			l_actual_array_type ?= array_type.instantiated_in (a_context_type)
			check
				l_actual_array_type_not_void: l_actual_array_type /= Void
			end
			l_actual_generic_parameter := l_actual_array_type.generics.item (1)
			if l_actual_generic_parameter.actual_type.is_formal and not first_generic.is_formal then
					-- Type that was provided to us didn't have much type information, we have
					-- to rely on what we have from `Current'. 
				l_actual_generic_parameter := first_generic
			end
			if l_actual_generic_parameter.has_associated_class_type (a_context_type) then
				generic_type := l_actual_generic_parameter.associated_class_type (a_context_type)
			else
					-- It is a formal. We simply assume System.Object
				generic_type := system.system_object_class.compiled_class.types.first
				l_formal ?= l_actual_generic_parameter
			end

			generic_type_id := generic_type.static_type_id

			if not l_param_is_expanded then
				type_c := l_actual_generic_parameter.c_type
				inspect
					type_c.level
				when c_boolean then
					type_kind := il_i1
				when C_char then
					type_kind := il_i2
				when C_wide_char then
					type_kind := il_u4
				when C_int32 then
					type_kind := il_i4
				when C_int8 then
					type_kind := il_i1
				when C_int16 then
					type_kind := il_i2
				when C_int64 then
					type_kind := il_i8
				when c_uint8 then
					type_kind := il_u1
				when c_uint16 then
					type_kind := il_u2
				when c_uint32 then
					type_kind := il_u4
				when c_uint64 then
					type_kind := il_u8
				when C_real32 then
					type_kind := il_r4
				when C_real64 then
					type_kind := il_r8
				when C_pointer then
					type_kind := il_i
				else
					type_kind := il_ref
				end
			else
				type_kind := il_expanded
			end

			inspect
				name_id

			when item_name_id, infix_at_name_id then
				il_generator.generate_array_access (type_kind, generic_type_id)

			when put_name_id then
				il_generator.generate_array_write (type_kind, generic_type_id)

			when make_name_id then
				if l_formal /= Void then
						-- Create the correct array type based on how the formal
						-- will be instantiated.
					il_generator.generate_generic_array_creation (l_formal)
					il_generator.generate_check_cast (Void, l_actual_array_type)
				else
					if l_actual_generic_parameter.is_basic then
						generic_type_id := l_actual_generic_parameter.external_id (Void)
					end
					il_generator.generate_array_creation (generic_type_id)
					il_generator.generate_array_initialization (l_actual_array_type, generic_type)
				end

			when count_name_id then
				il_generator.generate_array_count

			when lower_name_id then
				il_generator.generate_array_lower

			when upper_name_id then
				il_generator.generate_array_upper

			when all_default_name_id then

			when clear_all_name_id then

			when index_of_name_id then

			when resized_area_name_id then

			when same_items_name_id then

			else
--					check
--						False
--					end
			end
		end

	Object_type: CL_TYPE_A is
			-- Type of SYSTEM_OBJECT.
		require
			in_il_generation: system.il_generation
			system_not_void: system /= Void
			object_class_not_void: system.system_object_class /= Void
			object_class_compiled: system.system_object_class.is_compiled
		once
			Result := system.system_object_class.compiled_class.actual_type
		ensure
			object_type_not_void: Result /= Void
		end

invariant
	il_generation: System.il_generation

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

end -- end of NATIVE_ARRAY_CLASS_TYPE
