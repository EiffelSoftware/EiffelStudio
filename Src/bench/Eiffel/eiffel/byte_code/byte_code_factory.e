indexing
	description: "To generate pieces of predefined byte code."
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

	convert_byte_node (a_expr: EXPR_B; a_conversion_info: FEATURE_CONVERSION_INFO): EXPR_B is
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
						l_source_type.type_i, l_target_type.type_i, a_expr)
				end
			else
				if is_basic_conversion (a_expr, l_source_type, l_target_type, False) then
					Result := basic_conversion_byte_node (a_expr, l_source_type, l_target_type, False)
				else
					Result := to_type_byte_code (a_conversion_info.conversion_feature,
						l_target_type.type_i, a_expr)
				end
			end
		ensure
			convert_byte_node_not_void: Result /= Void
		end

feature {NONE} -- Implementation: status report

	is_basic_conversion (a_expr: EXPR_B; a_source_type, a_target_type: TYPE_A; is_from_conversion: BOOLEAN): BOOLEAN is
			-- Is conversion of `a_source_type' to `a_target_type' basic?
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
		local
			l_string_b: STRING_B
			l_type_expr_b: TYPE_EXPR_B
		do
			if
				System.il_generation and
				(a_source_type.same_as (String_type) and a_target_type.same_as (System_string_type))
			then
					-- Case of .NET string to Eiffel string conversion.
				l_string_b ?= a_expr
				Result := l_string_b /= Void
			elseif
				System.il_generation and then
				(a_source_type.associated_class = System.type_class.compiled_class and a_target_type.same_as (System_type_type))
			then
				l_type_expr_b ?= a_expr
				Result := l_type_expr_b /= Void
			elseif a_source_type.is_typed_pointer and a_target_type.is_pointer then
				Result := True
			elseif is_from_conversion then
				Result := not a_source_type.is_expanded and a_target_type.is_basic and not a_target_type.is_bits 
			elseif not is_from_conversion then
				Result := a_source_type.is_basic and not a_source_type.is_bits and not a_target_type.is_expanded
			end
		end
		
feature {NONE} -- Implementation: Byte node

	basic_conversion_byte_node (a_expr: EXPR_B; a_source_type, a_target_type: TYPE_A; is_from_conversion: BOOLEAN): EXPR_B is
			-- Convert `a_expr' from `a_source_type' to `a_target_type'.
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			is_basic_conversion: is_basic_conversion (a_expr, a_source_type, a_target_type, is_from_conversion)
		local
			l_string_b: STRING_B
			l_type_expr_b: TYPE_EXPR_B
			l_hector_b: HECTOR_B
			l_feat: FEATURE_I
			l_basic_i: BASIC_I
			l_ref: CL_TYPE_I
		do
			if
				System.il_generation and then
				(a_source_type.same_as (String_type) and a_target_type.same_as (System_string_type))
			then
				l_string_b ?= a_expr
				check
					l_string_b_not_void: l_string_b /= Void
				end
				l_string_b.set_is_dotnet_string (True)
				Result := l_string_b
			elseif
				System.il_generation and then
				(a_source_type.associated_class = System.type_class.compiled_class and a_target_type.same_as (System_type_type))
			then
				l_type_expr_b ?= a_expr
				check
					l_type_expr_b_not_void: l_type_expr_b /= Void
				end
				l_type_expr_b.set_is_dotnet_type (True)
				Result := l_type_expr_b
			elseif a_source_type.is_typed_pointer and a_target_type.is_pointer then
				l_hector_b ?= a_expr
				if l_hector_b /= Void then
					l_hector_b.set_is_pointer
					Result := l_hector_b
				else
					Result := a_expr
				end
			elseif is_from_conversion then
				if not a_source_type.is_expanded and a_target_type.is_basic and not a_target_type.is_bits then
						-- Simply call `item' from the reference type instead of
						-- trying to create an instance of the basic type and then
						-- calling its creation procedure.
					l_feat := a_source_type.associated_class.
						feature_table.item_id (feature {PREDEFINED_NAMES}.item_name_id)
					check
						l_feat_not_void: l_feat /= Void
					end
					Result := to_type_byte_code (l_feat, a_target_type.type_i, a_expr)
				end
			elseif not is_from_conversion then
				if a_source_type.is_basic and not a_source_type.is_bits and not a_target_type.is_expanded then
						-- Create a new instance of the associated reference of `a_source_type'
						-- and then assign new value. We use a hack here to call `set_item' as
						-- creation procedure to avoid having to generate two calls: one
						-- for creating the object, the other to assign it.
					l_basic_i ?= a_source_type.type_i
					l_ref := l_basic_i.reference_type
					l_feat := l_ref.base_class.
						feature_table.item_id (feature {PREDEFINED_NAMES}.set_item_name_id)
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
						Result := creation_byte_code (l_feat, pointer_type.type_i, l_ref, a_expr)
					else
						Result := creation_byte_code (l_feat, l_basic_i, l_ref, a_expr)
					end
				end
			end			
		end

	to_type_byte_code (a_feat: FEATURE_I; a_target_type: TYPE_I; a_expr: EXPR_B): NESTED_B is
			-- New instance nested call `a_expr.a_feat'
		require
			a_feat_not_void: a_feat /= Void
			a_target_type_not_void: a_target_type /= Void
			a_expr_not_void: a_expr /= Void
		local
			l_access_expr: ACCESS_EXPR_B
			l_access: CALL_ACCESS_B
		do
				-- Initialize nested call `a_expr.a_feat'
			create Result

				-- Create target.
			create l_access_expr
			l_access_expr.set_expr (a_expr)
			l_access_expr.set_parent (Result)
			Result.set_target (l_access_expr)

				-- Create message.
			l_access ?= a_feat.access (a_target_type)
			l_access.set_parent (Result)
			Result.set_message (l_access)
		end

	creation_byte_code (a_feat: FEATURE_I; a_source_type, a_target_type: TYPE_I; a_expr: EXPR_B): CREATION_EXPR_B is
			-- New instance of `create {a_target_type}.a_feat (a_expr)'
		require
			a_feat_not_void: a_feat /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_expr_not_void: a_expr /= Void
		local
			l_create_type: CREATE_TYPE
			l_access: CALL_ACCESS_B
			l_params: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
		do
				-- Initialize creation expression `(create {a_target_type}.a_feat (a_expr))'.
			create Result
			create l_create_type.make (a_target_type)
			Result.set_info (l_create_type)
			Result.set_type (a_target_type)

				-- Create call.
			l_access ?= a_feat.access (Void_type.type_i)
			create l_param
			l_param.set_expression (a_expr)
			l_param.set_attachment_type (a_source_type)
			create l_params.make (1)
			l_params.extend (l_param)
			l_access.set_parameters (l_params)
			Result.set_call (l_access)
		end

feature {NONE} -- Implementation: Access

	string_type: CL_TYPE_A is
			-- Type of STRING class.
		once
			Result := System.string_class.compiled_class.actual_type
		ensure
			string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_A is
			-- Type of STRING class.
		require
			is_il_generation: System.il_generation
		once
			Result := System.system_string_class.compiled_class.actual_type
		ensure
			system_string_type_not_void: Result /= Void
		end

	system_type_type: CL_TYPE_A is
			-- Type of STRING class.
		require
			is_il_generation: System.il_generation
		once
			Result := System.system_type_class.compiled_class.actual_type
		ensure
			system_type_type_not_void: Result /= Void
		end

end -- class BYTE_CODE_FACTORY
