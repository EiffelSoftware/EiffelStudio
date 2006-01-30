indexing
	description: "Object that represents a list of formal generic declaraction"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_GENERIC_LIST_AS

inherit
	EIFFEL_LIST [FORMAL_DEC_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_formal_generic_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := lsqure_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := rsqure_symbol.last_token (a_list)
			end

		end

feature -- Roundtrip

	lsqure_symbol, rsqure_symbol: SYMBOL_AS
			-- Symbol "[" and "]" associated with Current AST node

	set_lsqure_symbol (a_symbol: SYMBOL_AS) is
			-- Set `lsqure_symbol' with `a_symbol'.
		do
			lsqure_symbol := a_symbol
		ensure
			lsqure_symbol_set: lsqure_symbol = a_symbol
		end

	set_rsqure_symbol (a_symbol: SYMBOL_AS) is
			-- Set `rsqure_symbol' with `a_symbol'.
		do
			rsqure_symbol := a_symbol
		ensure
			rsqure_symbol_set: rsqure_symbol = a_symbol
		end

	set_squre_symbols (l_as, r_as: SYMBOL_AS) is
			-- Set `lsqure_symbol' with `l_as' and `rsqure_symbol' with `r_as'.
		do
			set_lsqure_symbol (l_as)
			set_rsqure_symbol (r_as)
		end

end
