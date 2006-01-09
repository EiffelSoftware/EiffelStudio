indexing
	description:
		"Abstract description of a parenthesized expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAN_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; l_as, r_as: like lparan_symbol) is
			-- Create a new PARAN AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			lparan_symbol := l_as
			rparan_symbol := r_as
		ensure
			expr_set: expr = e
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_paran_as (Current)
		end

feature -- Roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

feature -- Attributes

	expr: EXPR_AS
			-- Parenthesized expression

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expr.complete_start_location (a_list)
			else
				Result := lparan_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expr.complete_end_location (a_list)
			else
				Result := rparan_symbol.complete_end_location (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

invariant
	expr_not_void: expr /= Void

end -- class PARAN_AS
