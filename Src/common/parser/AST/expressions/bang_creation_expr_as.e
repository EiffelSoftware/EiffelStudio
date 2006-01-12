indexing
	description: "Abstract description of an Eiffel creation expression call (using bang form) "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANG_CREATION_EXPR_AS

inherit
	CREATION_EXPR_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization
	make (t: like type; c: like call; l_as, r_as: like lbang_symbol)is
			-- new CREATE_CREATION_EXPR AST node.
		do
			initialize (t, c)
			lbang_symbol := l_as
			rbang_symbol := r_as
		ensure
			lbang_symbol_set: lbang_symbol = l_as
			rbang_symbol_set: rbang_symbol = r_as
		end

feature -- Roundtrip

	lbang_symbol, rbang_symbol: SYMBOL_AS
			-- Symbol "!" associated with this structure

	set_lbang_symbol (a_symbol: SYMBOL_AS) is
			--- Set `lbang_symbol' with `a_symbol'.
		do
			lbang_symbol := a_symbol
		ensure
			lbang_symbol_set: lbang_symbol = a_symbol
		end

	set_rbang_symbol (a_symbol: SYMBOL_AS) is
			--- Set `rbang_symbol' with `a_symbol'.
		do
			rbang_symbol := a_symbol
		ensure
			rbang_symbol_set: rbang_symbol = a_symbol
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bang_creation_expr_as (Current)
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := type.complete_start_location (a_list)
			else
				Result := lbang_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if call /= Void then
				Result := call.complete_end_location (a_list)
			else
				if a_list = Void then
					Result := type.complete_end_location (a_list)
				else
					Result := rbang_symbol.complete_end_location (a_list)
				end

			end
		end

end
