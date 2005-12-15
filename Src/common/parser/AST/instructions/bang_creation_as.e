indexing
	description: "Object that represents a creation structure (using bang form)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANG_CREATION_AS

inherit
	CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (tp: like type; tg: like target; c: like call; l_as, r_as: like lbang_symbol) is
			-- Create new CREATE_CREATION AST node.
		do
			initialize (tp, tg, c)
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
			v.process_bang_creation_as (Current)
		end

end
