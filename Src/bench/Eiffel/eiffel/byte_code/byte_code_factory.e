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

	convert_byte_node (a_expr: EXPR_B; a_source_type, a_target_type: CL_TYPE_A; n: INTEGER): EXPR_B is
			-- Convert byte node `a_expr' to an expression that conforms to `a_target_type'.
			-- Register used types and features for dead code removal and incrementality.
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			n_positive: n > 0 or n = -1
		local
			l_class, l_other: CLASS_C
			l_feat: FEATURE_I
			l_creation_expr: CREATION_EXPR_B
			l_create_type: CREATE_TYPE
			l_access: CALL_ACCESS_B
			l_params: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
			l_nested: NESTED_B
			l_target_type: CL_TYPE_I
			l_access_expr: ACCESS_EXPR_B
		do
			l_target_type := a_target_type.type_i
			l_class := a_source_type.associated_class
			l_other := a_target_type.associated_class

			if (l_other.convert_from /= Void and then l_other.convert_from.has (a_source_type)) then
				if is_basic_conversion (a_expr, a_source_type, a_target_type) then
					Result := basic_conversion_byte_node (a_expr, a_source_type, a_target_type)
				else
					l_feat := l_other.feature_table.item_id (l_other.convert_from.item (a_source_type))
					check
						l_feat_not_void: l_feat /= Void
					end
					
						-- Initialize creation expression `(create {a_target_type}.l_feat (a_expr))'.
					create l_creation_expr
					create l_create_type.make (l_target_type)
					l_creation_expr.set_info (l_create_type)
					l_creation_expr.set_type (l_target_type)
					if n > 0 then
						l_creation_expr.set_line_number (n)
					end
		
						-- Create call.
					l_access ?= l_feat.access (Void_type.type_i)
					create l_param
					l_param.set_expression (a_expr)
					l_param.set_attachment_type (a_source_type.type_i)
					create l_params.make (1)
					l_params.extend (l_param)
					l_access.set_parameters (l_params)
					l_creation_expr.set_call (l_access)
		
					Result := l_creation_expr
				end
			elseif (l_class.convert_to /= Void and then l_class.convert_to.has (a_target_type)) then
				if is_basic_conversion (a_expr, a_source_type, a_target_type) then
					Result := basic_conversion_byte_node (a_expr, a_source_type, a_target_type)
				else
					l_feat := l_class.feature_table.item_id (l_class.convert_to.item (a_target_type))
					check
						l_feat_not_void: l_feat /= Void
					end
						-- Initialize nested call `a_expr.l_feat'
					create l_nested
	
						-- Create target.
					create l_access_expr
					l_access_expr.set_expr (a_expr)
					l_access_expr.set_parent (l_nested)
					l_nested.set_target (l_access_expr)
	
						-- Create message.
					l_access ?= l_feat.access (l_target_type)
					l_access.set_parent (l_nested)
					l_nested.set_message (l_access)
	
					Result := l_nested
				end
			end

			check
				l_feat_not_void: l_feat /= Void
			end
		ensure
			convert_byte_node_not_void: Result /= Void
		end

feature {NONE} -- Implementation: status report

	is_basic_conversion (a_expr: EXPR_B; a_source_type, a_target_type: CL_TYPE_A): BOOLEAN is
			-- Is conversion from `a_source_type' to `a_target_type' basic?
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
		do

		end
		
feature {NONE} -- Implementation: Byte node

	basic_conversion_byte_node (a_expr: EXPR_B; a_source_type, a_target_type: CL_TYPE_A): EXPR_B is
			-- Convert `a_expr' from `a_source_type' to `a_target_type'.
		require
			a_expr_not_void: a_expr /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			is_basic_conversion: is_basic_conversion (a_expr, a_source_type, a_target_type)
		do
			
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
		
end -- class BYTE_CODE_FACTORY
