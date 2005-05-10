indexing
	description: "CodeDOM Visitor."
	
class
	CODE_CODEDOM_VISITOR

inherit
	CODE_AST_SKELETON_VISITOR
	CODE_AST_ATOMIC_VISITOR
	CODE_AST_CALL_VISITOR
	CODE_AST_CONTENT_VISITOR
	CODE_AST_EIFFEL_TYPE_VISITOR
	CODE_AST_EXPRESSION_VISITOR
	CODE_AST_BINARY_EXPRESSION_VISITOR
	CODE_AST_UNARY_EXPRESSION_VISITOR
	CODE_AST_FEATURE_NAME_VISITOR
	CODE_AST_FEATURE_NAME_VISITOR
	CODE_AST_FEATURE_SET_VISITOR
	CODE_AST_INSTRUCTION_VISITOR
	CODE_AST_ROUT_BODY_VISITOR

create
	make

feature {NONE} -- Initialization

	make is
		do
			clear_cast_expressions
			clear_variables
		end

feature {AST_YACC} -- Initialization

	process_internal_as (l_as: INTERNAL_AS) is
		do
		end

	process_delayed_access_feat_as (l_as: DELAYED_ACCESS_FEAT_AS) is
		do
		end

	process_expr_addresse_as (l_as: EXPR_ADDRESS_AS) is
		do
		end

	process_use_list_as (l_as: USE_LIST_AS) is
		do
		end

	process_void_as (l_as: VOID_AS) is
		do
		end

end -- CODE_CODEDOM_VISITOR
