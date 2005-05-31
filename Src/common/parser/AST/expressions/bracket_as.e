indexing
	description: "Bracket expression node."
	date: "$Date$"
	revision: "$Revision$"

class
	BRACKET_AS

inherit
	EXPR_AS
		redefine
			start_location, end_location
		end

create
	make

feature {NONE} -- Creation

	make (t: like target; o: like operands) is
			-- Create bracket expression with target `t' and operands `o'.
		require
			t_not_void: t /= Void
			o_not_void: o /= Void
			o_not_empty: not o.is_empty
		do
			target := t
			operands :=  o
		ensure
			target_set: target = t
			operands_set: operands = o
		end

feature -- Access

	target: EXPR_AS
			-- Target of bracket expression

	operands: EIFFEL_LIST [EXPR_AS]
			-- Operands of bracket expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := target.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := operands.last.end_location
		end

	left_bracket_location: LOCATION_AS is
			-- Location of a left bracket
		do
			Result := operands.first.start_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (target, other.target) and then
				equivalent (operands, other.operands)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Process current element.
		do
			v.process_bracket_as (Current)
		end

invariant
	target_not_void: target /= Void
	operands_not_void: operands /= Void
	operands_not_empty: not operands.is_empty

end
