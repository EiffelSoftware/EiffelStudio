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

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := call.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := call.end_location
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

