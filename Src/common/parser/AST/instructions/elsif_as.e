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

	initialize (e: like expr; c: like compound; l_as, t_as: like elseif_keyword) is
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
			elseif_keyword := l_as
			then_keyword := t_as
		ensure
			expr_set: expr = e
			compound_set: compound = c
			elseif_keyword_set: elseif_keyword = l_as
			then_keyword_set: then_keyword = t_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_elseif_as (Current)
		end

feature -- Roundtrip

	elseif_keyword: KEYWORD_AS
			-- Keyword "elseif" associated with this structure

	then_keyword: KEYWORD_AS
			-- Keyword "then" associated with this structure			

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Roundtrip

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := expr.complete_start_location (a_list)
			else
				Result := elseif_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if compound /= Void then
				Result := compound.complete_end_location (a_list)
			else
				if a_list = Void then
						-- Non-roundtrip mode
					Result := expr.complete_end_location (a_list)
				else
						-- Roundtrip mode
					Result := then_keyword.complete_end_location (a_list)
				end
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
