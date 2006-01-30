indexing
	description: "Object that represents a list which is surrounded by '(' and ')'"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARAN_LIST_AS

inherit
	AST_EIFFEL

feature -- Roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with current AST node

	set_rparan_symbol (a_symbol: SYMBOL_AS) is
			-- Set `rparan_symbol' with `a_symbol'.
		do
			rparan_symbol := a_symbol
		ensure
			rparan_symbol_set: rparan_symbol = a_symbol
		end

	set_lparan_symbol (a_symbol: SYMBOL_AS) is
			-- Set `lparan_symbol' with `a_symbol'.
		do
			lparan_symbol := a_symbol
		ensure
			lparan_symbol_set: lparan_symbol = a_symbol
		end

	set_paran_symbols (l, r: SYMBOL_AS) is
			-- Set `lparan_symbol' with `l' and `rparan_symbol' with 'r'.
		do
			set_lparan_symbol (l)
			set_rparan_symbol (r)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if lparan_symbol /= Void then
				Result := lparan_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if rparan_symbol /= Void then
				Result := rparan_symbol.last_token (a_list)
			end
		end

end
