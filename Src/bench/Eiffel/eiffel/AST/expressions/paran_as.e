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
		redefine
			type_check, byte_node
		end
create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr) is
			-- Create a new PARAN AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_paran_as (Current)
		end

feature -- Attributes

	expr: EXPR_AS
			-- Parenthesized expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
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
			-- Type check an parenthesized expression
		do
			expr.type_check
		end

	byte_node: PARAN_B is
			-- Associated byte code
		do
			create Result
			Result.set_expr (expr.byte_node)
		end

invariant
	expr_not_void: expr /= Void

end -- class PARAN_AS
