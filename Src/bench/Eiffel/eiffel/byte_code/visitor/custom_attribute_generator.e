indexing
	description: "[
		Generator for custom attributes (CA) in CIL code generation.

		It follows the description of the ECMA standard for CLI Partition II-23.3.

		There is a difference between fixed argument, i.e. argument set because the
		CA's constructor needs them, and named argument which corresponds to public
		field or property with a setter.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	eweasel: "dotnet018"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_ATTRIBUTE_GENERATOR

inherit
	BYTE_NODE_NULL_VISITOR
		redefine
			process_array_const_b,
			process_bool_const_b,
			process_char_const_b,
			process_constant_b,
			process_external_b,
			process_integer_constant,
			process_paran_b,
			process_real_const_b,
			process_string_b,
			process_type_expr_b,
			process_void_b
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

feature -- Code generation

	generate (a_ca: CUSTOM_ATTRIBUTE_B; a_owner_token: INTEGER; a_code_generator: CIL_CODE_GENERATOR) is
			-- Generate `a_ca'.
		require
			a_ca_not_void: a_ca /= Void
			a_owner_token_valid: a_owner_token /= 0
			a_code_generator_not_void: a_code_generator /= Void
		local
			cb: CREATION_EXPR_B
			l_creation_external: EXTERNAL_B
			l_extension: IL_EXTENSION_I
			count: INTEGER
			param: BYTE_LIST [EXPR_B]
			param_b: PARAMETER_B
			l_tuple_const: ARRAYED_LIST [TUPLE [STRING_B, EXPR_B]]
			l_ctor_token: INTEGER
			l_creation_class: CLASS_C
			l_type: CL_TYPE_I
		do
			cil_generator := a_code_generator

			cb := a_ca.creation_expr
			l_type ?= cb.type
			l_creation_class := l_type.base_class
			l_tuple_const := a_ca.named_arguments

			l_creation_external ?= cb.call
			if l_creation_external /= Void then
				l_extension ?= l_creation_external.extension
				l_ctor_token := l_extension.token
			end

			param := cb.call.parameters
			if param /= Void then
				count := param.count
			else
				count := 0
			end

				-- Start initialization of custom attribute.
			create ca_blob.make

				-- Generate value of arguments if any.
			if count > 0 then
				from
					param.start
				until
					param.after
				loop
					param_b ?= param.item
					check
						param_b_not_void: param_b /= Void
					end
					l_type ?= param_b.attachment_type
					set_target_type (l_type)
					param_b.expression.process (Current)
					param.forth
				end
			end

				-- Generate name argument
			if l_tuple_const /= Void then
				ca_blob.put_integer_16 (l_tuple_const.count.to_integer_16)

				from
					l_tuple_const.start
				until
					l_tuple_const.after
				loop
					add_named_argument (l_creation_class, l_tuple_const.item)
					l_tuple_const.forth
				end
			else
				ca_blob.put_integer_16 (0)
			end

				-- Assign `ca_blob' to `a_owner_token'.
			cil_generator.define_custom_attribute (a_owner_token, l_ctor_token, ca_blob)

				-- Reset current
			cil_generator := Void
			target_type := Void
			ca_blob := Void
		end

feature {NONE} -- Access

	target_type: TYPE_I
			-- Actual expected type of custom attribute argument or optional argument.

	cil_generator: CIL_CODE_GENERATOR
			-- Back-end of custom attribute code generator.

	ca_blob: MD_CUSTOM_ATTRIBUTE
			-- Blob used for storing custom attribute.

feature {NONE} -- Setting

	set_target_type (a_type: like target_type) is
			-- Set `a_type' to `target_type'.
		do
			target_type := a_type
		ensure
			target_type_set: target_type = a_type
		end

feature {BYTE_NODE} -- Visitors

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		local
			l_expressions: BYTE_LIST [BYTE_NODE]
			l_expr: EXPR_B
			l_old_target_type: like target_type
			l_type: TYPE_I
		do
			check is_constant_expression: a_node.is_constant_expression end
			l_expressions := a_node.expressions
			l_type := a_node.type.true_generics [1]

			if is_target_object then
					-- Mark the fact it is an array when not a fixed argument
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_szarray)

					-- Mark the type of elements.
				insert_field_or_prop_type (l_type)
			end

				-- Put number of elements in array.
			ca_blob.put_natural_32 (l_expressions.count.to_natural_32)

				-- Process elements.
			from
					-- Store context.
				l_old_target_type := target_type
					-- All elements have the same target type.
				set_target_type (l_type)
				l_expressions.start
			until
				l_expressions.after
			loop
				l_expr ?= l_expressions.item
				check l_expr_not_void: l_expr /= Void end
				l_expr.process (Current)
				l_expressions.forth
			end

				-- Restore context
			set_target_type (l_old_target_type)
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end
			if is_target_object then
				ca_blob.put_integer_8 (a_node.type.element_type)
			end
			ca_blob.put_boolean (a_node.value)
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end
			if is_target_object then
				ca_blob.put_integer_8 (a_node.type.element_type)
			end
			ca_blob.put_character (a_node.value)
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		local
			l_value: VALUE_I
			l_type: TYPE_I
			l_int: INTEGER_CONSTANT
			l_bool: BOOL_VALUE_I
			l_char: CHAR_VALUE_I
			l_real: REAL_VALUE_I
			l_string: STRING_VALUE_I
		do
			check is_constant_expression: a_node.is_constant_expression end
			l_type := a_node.type
			if is_target_object and l_type.is_basic then
				ca_blob.put_integer_8 (l_type.element_type)
			end

			l_value := a_node.value

			if l_value.is_integer then
				l_int ?= l_value
				check l_int_not_void: l_int /= Void end
				insert_integer_constant (l_int)
			elseif l_value.is_string then
				l_string ?= l_value
				check l_string_not_void: l_string /= Void end
				ca_blob.put_string (l_string.string_value)
			elseif l_value.is_boolean then
				l_bool ?= l_value
				check l_bool_not_void: l_bool /= Void end
				ca_blob.put_boolean (l_bool.boolean_value)
			elseif l_value.is_character then
				l_char ?= l_value
				check l_char_not_void: l_char /= Void end
				ca_blob.put_character (l_char.character_value)
			elseif l_value.is_real then
				l_real ?= l_value
				check l_real_not_void: l_real /= Void end
				if target_type.is_real_32 then
					if l_value.is_real_32 then
						ca_blob.put_real_32 (l_real.real_32_value)
					else
						ca_blob.put_real_32 (l_real.real_64_value)
					end
				elseif target_type.is_real_64 then
					if l_value.is_real_32 then
						ca_blob.put_real_64 (l_real.real_32_value)
					else
						ca_blob.put_real_64 (l_real.real_64_value)
					end
				else
						-- Case where target is System.object.
					check is_target_object end
					if l_value.is_real_32 then
						ca_blob.put_real_32 (l_real.real_32_value)
					else
						ca_blob.put_real_64 (l_real.real_64_value)
					end
				end
			else
				check not_supported: False end
			end
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		local
			l_il_enum: IL_ENUM_EXTENSION_I
			l_cl_type: CL_TYPE_I
		do
			check is_constant_expression: a_node.is_constant_expression end
			l_il_enum ?= a_node.extension
			if l_il_enum /= Void then
				if is_target_object then
					l_cl_type ?= a_node.type
					check l_cl_type_not_void: l_cl_type /= Void end
					insert_enum_type (l_cl_type)
				end
				ca_blob.put_integer_32 (l_il_enum.value)
			else
				check not_supported: False end
			end
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end

			if is_target_object then
				ca_blob.put_integer_8 (a_node.type.element_type)
			end
			insert_integer_constant (a_node)
		end

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end
			a_node.expr.process (Current)
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end
			if is_target_object then
				ca_blob.put_integer_8 (a_node.type.element_type)
			end

			if target_type.is_real_32 then
				ca_blob.put_real_32 (a_node.value.to_real)
			elseif target_type.is_real_64 then
				ca_blob.put_real_64 (a_node.value.to_double)
			else
				check is_target_object end
				if a_node.type.is_real_32 then
					ca_blob.put_real_32 (a_node.value.to_real)
				else
					ca_blob.put_real_64 (a_node.value.to_double)
				end
			end
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		do
			check is_constant_expression: a_node.is_constant_expression end
			if is_target_object then
					-- Force the type to be a .NET SYSTEM_STRING as `a_node' is
					-- still considered as being an Eiffel string.
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
			end
			ca_blob.put_string (a_node.value)
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		local
			l_gen_type: GEN_TYPE_I
			l_actual_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
			l_type_name: STRING
			l_ext_class: EXTERNAL_CLASS_C
		do
			check is_constant_expression: a_node.is_constant_expression end
			if is_target_object then
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_type)
			end

			if a_node.is_dotnet_type then
				l_class_type := a_node.type.associated_class_type
			else
				l_gen_type ?= a_node.type
				check
					l_gen_type_not_void: l_gen_type /= Void
					l_gen_type_has_one_generic: l_gen_type.true_generics.count > 0
				end
				l_actual_type ?= l_gen_type.true_generics[1]
				if l_actual_type /= Void then
					l_class_type := l_actual_type.associated_class_type
				end
			end
			if l_class_type /= Void then
				create l_type_name.make_from_string (l_class_type.full_il_type_name)
				if l_class_type.is_precompiled then
					l_type_name.append_character (',')
					l_type_name.append_character (' ')
					l_type_name.append (l_class_type.assembly_info.full_name)
				else
					l_ext_class ?= l_class_type.associated_class
					if l_ext_class /= Void  then
						l_type_name.append_character (',')
						l_type_name.append_character (' ')
						l_type_name.append (l_ext_class.assembly.full_name)
					end
				end
				ca_blob.put_string (l_type_name)
			end
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		local
			l_cl_type: CL_TYPE_I
		do
			check is_constant_expression: a_node.is_constant_expression end
			l_cl_type ?= target_type
			if l_cl_type.base_class = system.native_array_class.compiled_class then
					-- We insert the value 0xFFFFFFFF to show that it is a Void array.
				ca_blob.put_integer_32 (0xFFFFFFFF)
			else
				check not_supported: False end
			end
		end


feature {NONE} -- Implemention

	is_target_object: BOOLEAN is
			-- Is `a_type' of type System.Object?
		require
			target_type_not_void: target_type /= Void
		local
			l_cl_type: CL_TYPE_I
		do
			l_cl_type ?= target_type
			if l_cl_type /= Void then
				Result := l_cl_type.class_id = system.system_object_id or
					l_cl_type.class_id = system.any_id
			end
		end

	add_named_argument (a_class: CLASS_C; a_tuple: TUPLE [STRING_B, EXPR_B]) is
			-- Lookup named argument in `a_tuple' and insert it in `ca_blob'.
		require
			blob_not_void: ca_blob /= Void
			tuple_not_void: a_tuple /= Void
			tuple_valid: a_tuple.item (1) /= Void and then a_tuple.item (2) /= Void
		local
			l_expr_b: EXPR_B
			l_feat: FEATURE_I
			l_extension: IL_EXTENSION_I
			l_string_b: STRING_B
			l_feat_name: STRING
			l_type: TYPE_I
		do
			l_string_b ?= a_tuple.item (1)
			l_expr_b ?= a_tuple.item (2)
			check
				has_string: l_string_b /= Void
				has_expression: l_expr_b /= Void
			end
			l_feat_name := l_string_b.value.as_lower

			l_feat := a_class.feature_table.item (l_feat_name)
				-- Not Void because it must have passed the type checking.
			check has_feature: l_feat /= Void end

				-- First mark if it is an attribute or a property.
			if l_feat.is_attribute then
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_field)
			else
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
			end

			l_type := l_feat.type.actual_type.type_i
			insert_field_or_prop_type (l_type)

				-- Put name of attribute or property.
			if l_feat.written_class.is_external then
				l_extension ?= l_feat.extension
				l_feat_name := l_extension.alias_name
				if not l_feat.is_attribute then
					l_feat_name := l_feat_name.twin
					check
						l_feat_valid_count: l_feat_name.count > 4
						has_setter: l_feat_name.substring (1, 4).is_equal ("get_")
					end
					l_feat_name.remove_head (4)
				end
			end
			ca_blob.put_string (l_feat_name)

				-- Finally generate value.
			set_target_type (l_type)
			l_expr_b.process (Current)
		end

	insert_integer_constant (a_int: INTEGER_CONSTANT) is
			-- Simply insert `a_int' into `ca_blob'. Depending on `target_type'
			-- it might requires to actually put any of the NATURAL_XX/INTEGER_XX
			-- compatible value, or a REAL_32/REAL_64 value.
		local
			l_element_type: INTEGER_8
		do
			if is_target_object then
					-- We simply assume that we will put the INTEGER as is.
				l_element_type := a_int.type.element_type
			else
				l_element_type := target_type.element_type
			end

			inspect l_element_type

			when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
				ca_blob.put_integer_8 (a_int.integer_8_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
				ca_blob.put_integer_16 (a_int.integer_16_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
				ca_blob.put_integer_32 (a_int.integer_32_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
				ca_blob.put_integer_64 (a_int.integer_64_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				ca_blob.put_natural_8 (a_int.natural_8_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				ca_blob.put_natural_16 (a_int.natural_16_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
				ca_blob.put_natural_32 (a_int.natural_32_value)
			when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				ca_blob.put_natural_64 (a_int.natural_64_value)


			when {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
				inspect a_int.il_element_type
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_i1,
					{MD_SIGNATURE_CONSTANTS}.element_type_i2,
					{MD_SIGNATURE_CONSTANTS}.element_type_i4,
					{MD_SIGNATURE_CONSTANTS}.element_type_i8
				then
					ca_blob.put_real_32 (a_int.integer_64_value.to_real)

				when
					{MD_SIGNATURE_CONSTANTS}.element_type_u1,
					{MD_SIGNATURE_CONSTANTS}.element_type_u2,
					{MD_SIGNATURE_CONSTANTS}.element_type_u4,
					{MD_SIGNATURE_CONSTANTS}.element_type_u8
				then
					ca_blob.put_real_32 (a_int.natural_64_value.to_real_32)
				end


			when {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
				inspect a_int.il_element_type
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_i1,
					{MD_SIGNATURE_CONSTANTS}.element_type_i2,
					{MD_SIGNATURE_CONSTANTS}.element_type_i4,
					{MD_SIGNATURE_CONSTANTS}.element_type_i8
				then
					ca_blob.put_real_64 (a_int.integer_64_value.to_double)

				when
					{MD_SIGNATURE_CONSTANTS}.element_type_u1,
					{MD_SIGNATURE_CONSTANTS}.element_type_u2,
					{MD_SIGNATURE_CONSTANTS}.element_type_u4,
					{MD_SIGNATURE_CONSTANTS}.element_type_u8
				then
					ca_blob.put_real_64 (a_int.natural_64_value.to_real_64)
				end
			else
				check not_reached: False end
			end
		end

	insert_field_or_prop_type (a_type: TYPE_I) is
			-- Fill `FieldOrPropType' in `ca_blob'.
		require
			a_type_not_void: a_type /= Void
		local
			l_cl_type: CL_TYPE_I
		do
			l_cl_type ?= a_type
			if l_cl_type = Void then
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boxed)
			elseif l_cl_type.is_enum then
				insert_enum_type (l_cl_type)
			elseif l_cl_type.is_basic then
				ca_blob.put_integer_8 (l_cl_type.element_type)
			elseif l_cl_type.class_id = system.system_string_id then
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
			elseif l_cl_type.class_id = system.system_type_id then
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_type)
			elseif l_cl_type.class_id = system.native_array_id then
					-- Mark the fact it is an array
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_szarray)
				check
					has_generics: l_cl_type.true_generics /= Void and then
						l_cl_type.true_generics.count = 1
				end
					-- Mark the type of elements.
				insert_field_or_prop_type (l_cl_type.true_generics.item (1))
			else
				ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boxed)
			end
		end

	insert_enum_type (a_cl_type: CL_TYPE_I) is
			-- Insert enum specification in `ca_blob'.
		require
			a_cl_type_not_void: a_cl_type /= Void
		local
			l_type_name: STRING
			l_ext_class: EXTERNAL_CLASS_C
		do
			ca_blob.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_enum)
			create l_type_name.make_from_string (a_cl_type.il_type_name (Void))
			l_type_name.append_character (',')
			l_type_name.append_character (' ')
			l_ext_class ?= a_cl_type.base_class
			check l_ext_class_not_void: l_ext_class /= Void end
			l_type_name.append (l_ext_class.assembly.full_name)
			ca_blob.put_string (l_type_name)
		end

invariant
	is_dotnet_compilation: system.il_generation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
