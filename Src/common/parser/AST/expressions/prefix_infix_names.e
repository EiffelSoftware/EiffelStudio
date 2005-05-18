indexing
	description: "Internal names for infix and prefix functions, Bench version"
	date: "$Date$"
	revision: "$Revision$"

class PREFIX_INFIX_NAMES

inherit
	SYNTAX_STRINGS
		export
			{NONE} frozen_str, infix_str, prefix_str, quote_str
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
		require
			op_not_void: op /= Void
		do
			Result := op.substring (Infix_str.count + 1, op.count - Quote_str.count)
		ensure
			result_not_void: Result /= Void
		end

	extract_symbol_from_prefix (op: STRING): STRING is
			-- Get the symbol part from prefix qualified operator `op'.
		require
			op_not_void: op /= Void
		do
			Result := op.substring (Prefix_str.count + 1, op.count - Quote_str.count)
		ensure
			result_not_void: Result /= Void
		end

	extract_alias_name (op: STRING): STRING is
			-- Extract symbol part from alias name encoded as any of the following:
			--   prefix "..."
			--   infix "..."
			--   []
		require
			op_not_void: op /= Void
			op_not_empty: not op.is_empty
			valid_op:
				op.is_equal ("[]") or else
				op.item (op.count) = '%"' and then (op.substring_index ("prefix %"", 1) = 1 or else op.substring_index ("infix %"", 1) = 1)
		local
			c: CHARACTER
		do
			c := op.item (1)
			if c = '[' then
					-- Bracket
				Result := op
			elseif c = 'p' then
					-- Unary (prefix) operator
				Result := extract_symbol_from_prefix (op)
			else
					-- Binary (infix) operator
				Result := extract_symbol_from_infix (op)
			end
		ensure
			result_not_void: Result /= Void
		end

end -- Class PREFIX_INFIX_NAMES
