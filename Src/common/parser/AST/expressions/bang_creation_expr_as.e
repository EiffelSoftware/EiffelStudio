indexing
	description: "Abstract description of an Eiffel creation expression call (using bang form) "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANG_CREATION_EXPR_AS

inherit
	CREATION_EXPR_AS
		rename
			process as creation_expr_process
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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bang_creation_expr_as (Current)
		end

end
