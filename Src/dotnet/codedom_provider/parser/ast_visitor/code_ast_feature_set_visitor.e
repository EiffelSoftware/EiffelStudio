indexing
	description: "AST feature set Visitor."
	
deferred class
	CODE_AST_FEATURE_SET_VISITOR

inherit
	AST_VISITOR
	
feature {AST_YACC} -- Implementation

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
			-- Process `l_as'.
		do
		end

	process_all_as (l_as: ALL_AS) is
			-- Process `l_as'.
		do
		end

end -- CODE_AST_FEATURE_SET_VISITOR
