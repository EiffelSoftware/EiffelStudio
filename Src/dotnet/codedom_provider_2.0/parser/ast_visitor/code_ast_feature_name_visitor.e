indexing
	description: "AST feature name Visitor."
	
deferred class
	CODE_AST_FEATURE_NAME_VISITOR

inherit
	AST_VISITOR
	
feature {AST_YACC} -- Implementation

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
			-- Process `l_as'.
		do
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
			-- Process `l_as'.
		do
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
			-- Process `l_as'.
		do
		end

end -- CODE_AST_FEATURE_NAME_VISITOR

