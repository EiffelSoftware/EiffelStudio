note
	description: "To generate pieces of predefined byte code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_CODE_FACTORY

inherit
	COMPILER_EXPORTER

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Convertibility

	convert_byte_node (a_expr: EXPR_B; a_conversion_info: FEATURE_CONVERSION_INFO): EXPR_B
			-- Convert byte node `a_expr' to an expression that conforms to `a_conversion.target_type'.
			-- Register used types and features for dead code removal and incrementality.
		require
			a_expr_not_void: a_expr /= Void
			a_conversion_info_not_void: a_conversion_info /= Void
		local
			l_source_type, l_target_type: TYPE_A
		do
			l_source_type := a_conversion_info.source_type
			l_target_type := a_conversion_info.target_type

			if a_conversion_info.is_from_conversion then
				if is_basic_conversion (a_expr, l_source_type, l_target_type, True) then
					Result := basic_conversion_byte_node (a_expr, l_source_type, l_target_type, True)
				else
					Result := creation_byte_code (a_conversion_info.conversion_feature,
						l_source_type, l_target_type, a_expr)
				end
			else
				if is_basic_conversion (a_expr, l_source_type, l_target_type, False) then
					Result := basic_conversion_byte_node (a_expr, l_source_type, l_target_type, False)
				else
					Result := to_type_byte_code (a_conversion_info.conversion_feature,
						l_target_type, a_expr)
				end
			end
		ensure
			convert_byte_node_not_void: Result /= Void
		end

feature {NONE} -- Implementation: status report

	is_basic_conversion (a_expr: EXPR_B; a_source_type, a_target_type: TYPE_A; is_from_conversion: BOOLEAN): BOOLEAN
			-- Is conversion of `a_source_type' to `a_target_type' basic?
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			if
				System.il_generation and
				(a_source_type.same_as (String_type) and a_target_type.same_as (System_string_type))
			then
					-- Case of .NET string to Eiffel string conversion.
				Result := attached {STRING_B} a_expr
			elseif
				System.il_generation and then
				(a_source_type.base_class = System.type_class.compiled_class and a_target_type.same_as (System_type_type))
			then
				Result := attached {TYPE_EXPR_B} a_expr
			elseif a_source_type.is_typed_pointer and a_target_type.is_pointer then
				Result := True
			elseif is_from_conversion then
				Result := not a_source_type.is_expanded and a_target_type.is_basic
			elseif not is_from_conversion then
				Result := a_source_type.is_basic and not a_target_type.is_expanded
			end
		end

feature {NONE} -- Implementation: Byte node

	basic_conversion_byte_node (a_expr: EXPR_B; a_source_type, a_target_type: TYPE_A; is_from_conversion: BOOLEAN): EXPR_B
			-- Convert `a_expr' from `a_source_type' to `a_target_type'.
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			is_basic_conversion: is_basic_conversion (a_expr, a_source_type, a_target_type, is_from_conversion)
		local
			l_feat: FEATURE_I
			l_basic_i: BASIC_A
			l_ref: CL_TYPE_A
		do
			if
				System.il_generation and then
				(a_source_type.same_as (String_type) and a_target_type.same_as (System_string_type))
			then
				if attached {STRING_B} a_expr as l_string_b then
					l_string_b.set_is_dotnet_string (True)
					Result := l_string_b
				else
					check
						is_string: False
					end
				end
			elseif
				System.il_generation and then
				(a_source_type.base_class = System.type_class.compiled_class and a_target_type.same_as (System_type_type))
			then
				if attached {TYPE_EXPR_B} a_expr as l_type_expr_b then
					l_type_expr_b.set_is_dotnet_type (True)
					Result := l_type_expr_b
				else
					check
						is_type_expression: False
					end
				end
			elseif a_source_type.is_typed_pointer and a_target_type.is_pointer then
				Result := a_expr
			elseif is_from_conversion then
				if not a_source_type.is_expanded and a_target_type.is_basic then
						-- Simply call `item' from the reference type instead of
						-- trying to create an instance of the basic type and then
						-- calling its creation procedure.
					l_feat := a_source_type.base_class.
						feature_table.item_id ({PREDEFINED_NAMES}.item_name_id)
					check
						l_feat_not_void: l_feat /= Void
					end
					Result := to_type_byte_code (l_feat, a_target_type, a_expr)
				end
			elseif not is_from_conversion then
				if a_source_type.is_basic and not a_target_type.is_expanded then
						-- Create a new instance of the associated reference of `a_source_type'
						-- and then assign new value. We use a hack here to call `set_item' as
						-- creation procedure to avoid having to generate two calls: one
						-- for creating the object, the other to assign it.
					l_basic_i ?= a_source_type
					l_ref := l_basic_i.reference_type
					l_feat := l_ref.base_class.
						feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id)
					check
						l_feat_not_void: l_feat /= Void
						l_basic_i_not_void: l_basic_i /= Void
					end
					if a_source_type.is_typed_pointer then
							-- Special case here to ensure that the attachment type is POINTER and
							-- not TYPED_POINTER otherwise the C generated code will generate an
							-- incorrect signature of `set_item'. It fixed C compilation
							-- warnings/errors (depending on the platform used to run the test)
							-- in eweasel tests ccomp050.
						Result := creation_byte_code (l_feat, pointer_type, l_ref, a_expr)
					else
						Result := creation_byte_code (l_feat, l_basic_i, l_ref, a_expr)
					end
				end
			end
		end

	to_type_byte_code (a_feat: FEATURE_I; a_target_type: TYPE_A; a_expr: EXPR_B): NESTED_B
			-- New instance nested call `a_expr.a_feat'
		require
			a_feat_not_void: a_feat /= Void
			a_target_type_not_void: a_target_type /= Void
			a_expr_not_void: a_expr /= Void
		local
			l_access_expr: ACCESS_EXPR_B
			l_access: ACCESS_B
		do
				-- Initialize nested call `a_expr.a_feat'
			create Result

				-- Create target.
			create l_access_expr.make (a_expr)
			l_access_expr.set_parent (Result)
			Result.set_target (l_access_expr)

				-- Create message.
			l_access := a_feat.access (a_target_type, True, a_target_type.is_separate)
			l_access.set_parent (Result)
			Result.set_message (l_access)
		end

	creation_byte_code (a_feat: FEATURE_I; a_source_type, a_target_type: TYPE_A; a_expr: EXPR_B): CREATION_EXPR_B
			-- New instance of `create {a_target_type}.a_feat (a_expr)'
		require
			a_feat_not_void: a_feat /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_expr_not_void: a_expr /= Void
		local
			l_access: ROUTINE_B
			l_params: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
			l_target_type: TYPE_A
		do
				-- Initialize creation expression `(create {a_target_type}.a_feat (a_expr))'.
			create Result
				-- CREATE_TYPE cannot handle anchors.
			if a_target_type.is_like_current then
					-- Use conformance type instead.
				l_target_type := a_target_type.conformance_type
			else
					-- Use actual type to remove the anchor.
				l_target_type := a_target_type.actual_type
			end
				-- Type used for creating an object should not contain any attachment marks.
				-- See the implementation {CL_TYPE_A}.create_info.
			Result.set_info (create {CREATE_TYPE}.make (l_target_type.as_attachment_mark_free))
			Result.set_type (a_target_type)

				-- Create call.
			l_access ?= a_feat.access (Void_type, True, a_target_type.is_separate)
			create l_param
			l_param.set_expression (a_expr)
			l_param.set_attachment_type (a_source_type)
			create l_params.make (1)
			l_params.extend (l_param)
			l_access.set_parameters (l_params)
			Result.set_call (l_access)
		end

feature {NONE} -- Implementation: Access

	string_type: CL_TYPE_A
			-- Type of STRING class.
		once
			Result := System.string_8_class.compiled_class.actual_type
		ensure
			string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_A
			-- Type of STRING class.
		require
			is_il_generation: System.il_generation
		once
			Result := System.system_string_class.compiled_class.actual_type
		ensure
			system_string_type_not_void: Result /= Void
		end

	system_type_type: CL_TYPE_A
			-- Type of STRING class.
		require
			is_il_generation: System.il_generation
		once
			Result := System.system_type_class.compiled_class.actual_type
		ensure
			system_type_type_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class BYTE_CODE_FACTORY
