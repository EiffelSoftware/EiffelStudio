indexing
	description: "AST Eiffel type Visitor."
	
deferred class
	ECDP_AST_EIFFEL_TYPE_VISITOR

inherit
	AST_VISITOR
	ECDP_SUPPORT
	ECDP_USER_DATA_KEYS

feature {AST_YACC} -- Implementation

	process_class_type_as (l_as: CLASS_TYPE_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_exp_type_as (l_as: EXP_TYPE_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_separate_type_as (l_as: SEPARATE_TYPE_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_formal_as (l_as: FORMAL_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_bits_as (l_as: BITS_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
		end

end -- ECDP_AST_EIFFEL_TYPE_VISITOR

