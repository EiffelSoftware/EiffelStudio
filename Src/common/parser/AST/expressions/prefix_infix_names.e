indexing
	description: "Internal names for infix and prefix functions, Bench version"
	date: "$Date$"
	revision: "$Revision$"

class PREFIX_INFIX_NAMES

inherit
	SYNTAX_STRINGS
		export
			{NONE} all
		end

feature -- Basic operations

	prefix_feature_name_with_symbol (symbol: STRING): STRING is
			-- Internal name corresponding to prefix `symbol'.
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
			Result := Prefix_str + symbol + Quote_str
		ensure
			Result_not_void: Result /= Void
		end

	infix_feature_name_with_symbol (symbol: STRING): STRING is
			-- Internal name corresponding to prefix `symbol'
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
			Result := Infix_str + symbol + Quote_str
		ensure
			Result_not_void: Result /= Void
		end

	extract_symbol_from_infix (op: STRING): STRING is
			-- Get the symbol part from infix qualified operator `op'.
		do
			Result := op.substring (Infix_str.count + 1, op.count - Quote_str.count)
		end

	extract_symbol_from_prefix (op: STRING): STRING is
			-- Get the symbol part from prefix qualified operator `op'.
		do
			Result := op.substring (Prefix_str.count + 1, op.count - Quote_str.count)
		end

end -- Class PREFIX_INFIX_NAMES
