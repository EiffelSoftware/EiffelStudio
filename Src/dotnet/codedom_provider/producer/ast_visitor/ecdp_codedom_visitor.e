indexing
	description: "CodeDOM Visitor."
	
class
	ECDP_CODEDOM_VISITOR

inherit
	ECDP_AST_SKELETON_VISITOR
	ECDP_AST_ATOMIC_VISITOR
	ECDP_AST_CALL_VISITOR
	ECDP_AST_CONTENT_VISITOR
	ECDP_AST_EIFFEL_TYPE_VISITOR
	ECDP_AST_EXPRESSION_VISITOR
	ECDP_AST_BINARY_EXPRESSION_VISITOR
	ECDP_AST_UNARY_EXPRESSION_VISITOR
	ECDP_AST_FEATURE_NAME_VISITOR
	ECDP_AST_FEATURE_NAME_VISITOR
	ECDP_AST_FEATURE_SET_VISITOR
	ECDP_AST_INSTRUCTION_VISITOR
	ECDP_AST_ROUT_BODY_VISITOR

create
	make

feature {NONE} -- Initialization

	make is
		do
			clear_cast_expressions
			clear_variables
		end

feature {AST_YACC} -- Initialization

	process_access_address_as (l_as: ACCESS_ADDRESS_AS) is
		do
		end

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

end -- ECDP_CODEDOM_VISITOR
