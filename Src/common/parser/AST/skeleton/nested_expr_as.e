indexing
	description:
			"Abstract description of a nested call `target.message' where %
			%the target is a parenthesized expression. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_EXPR_AS

inherit
	CALL_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; m: like message; d_as, l_as, r_as: like dot_symbol) is
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
			dot_symbol := d_as
			lparan_symbol := l_as
			rparan_symbol := r_as
		ensure
			target_set: target = t
			message_set: message = m
			dot_symbol_set: dot_symbol = d_as
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_nested_expr_as (Current)
		end

feature -- Roundtrip

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

feature -- Attributes

	target: EXPR_AS
			-- Target of the call

	message: CALL_AS
			-- Message send to the target

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := target.complete_start_location (a_list)
			else
				Result := lparan_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := message.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void

end -- class NESTED_EXPR_AS
