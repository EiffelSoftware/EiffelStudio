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
		redefine
			type_check, byte_node
		end

	SHARED_TYPES

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr) is
			-- Create a new EXPR_ADDRESS AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			if not is_allowed then
				error_handler.insert_error (create {SYNTAX_ERROR}.init)
				error_handler.raise_error
			end
		ensure
			expr_set: expr = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_expr_addresse_as (Current)
		end

feature -- Properties

	expr: EXPR_AS
			-- Expression to address

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := expr.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access.
		do
			expr.type_check
				-- Replace type of expression by pointer type
			context.replace (pointer_type)
		end

	byte_node: EXPR_ADDRESS_B is
			-- Associated byte code.
		do
			create Result
			Result.set_expr (expr.byte_node)
		end

feature {NONE} -- Implementation

	is_allowed: BOOLEAN is
			-- Is this construct allowed?
		do
			Result := System.address_expression_allowed
		end
		
invariant
	expr_not_void: expr /= Void

end -- class EXPR_ADDRESS_AS
