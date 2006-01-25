indexing
	description: "AST unary expression Visitor."
	
deferred class
	CODE_AST_UNARY_EXPRESSION_VISITOR

inherit
	AST_VISITOR
	
feature {AST_YACC} -- Implementation

	process_un_free_as (l_as: UN_FREE_AS) is
			-- Process `l_as'.
		do
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
			-- Process `l_as'.
		do
		end

	process_un_not_as (l_as: UN_NOT_AS) is
			-- Process `l_as'.
		do
		end

	process_un_old_as (l_as: UN_OLD_AS) is
			-- Process `l_as'.
		do
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
			-- Process `l_as'.
		do
		end

end -- CODE_AST_UNARY_EXPRESSION_VISITOR
