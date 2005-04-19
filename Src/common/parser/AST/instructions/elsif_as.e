indexing
	description:
			"Abstract description of a elsif clause of a condition %
			%instruction. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ELSIF_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots,
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; c: like compound) is
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
		ensure
			expr_set: expr = e
			compound_set: compound = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_elseif_as (Current)
		end

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if compound /= Void then
				Result := compound.end_location
			else
				Result := expr.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr) and
				equivalent (compound, other.compound)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	set_compound (c: like compound) is
		do
			compound := c
		end

invariant
	expr_not_void: expr /= Void

end -- class ELSIF_AS
