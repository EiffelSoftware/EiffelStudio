indexing
	description:
		"Abstract description of an Eiffel expression pointer. %
		%Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPR_ADDRESS_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; a_as, l_as, r_as: like address_symbol) is
			-- Create a new EXPR_ADDRESS AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			address_symbol := a_as
			lparan_symbol := l_as
			rparan_symbol := r_as
		ensure
			expr_set: expr = e
			address_symbol_set: address_symbol = a_as
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_expr_address_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

feature -- Properties

	expr: EXPR_AS
			-- Expression to address

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expr.complete_start_location (a_list)
			else
				Result := address_symbol.complete_start_location (a_list)
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

end -- class EXPR_ADDRESS_AS
