indexing
	description:
		"Abstract description of a call as an expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class EXPR_CALL_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like call) is
			-- Create a new EXPR_CALL AST node.
		require
			c_not_void: c /= Void
		do
			call := c
		ensure
			call_set: call = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_expr_call_as (Current)
		end

feature -- Attributes

	call: CALL_AS
			-- Expression call

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := call.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := call.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call)
		end

feature {EXPR_CALL_AS, OPERAND_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c
		end

invariant
	call_not_void: call /= Void

end

