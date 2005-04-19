indexing
	description	: "Abstract description of a tagged expression. %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class
	TAGGED_AS

inherit
	EXPR_AS
		redefine
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like tag; e: like expr) is
			-- Create a new TAGGED AST node.
		require
			e_not_void: e /= Void
		do
			tag := t
			expr := e
		ensure
			tag_set: tag = t
			expr_set: expr = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tagged_as (Current)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is 1
			-- Number of stop points for AST

feature -- Attributes

	tag: ID_AS
			-- Expression tag

	expr: EXPR_AS
			-- Expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			if tag /= Void then
				Result := tag.start_location
			else
				Result := expr.start_location
			end
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := expr.end_location
		end
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and then
				equivalent (expr, other.expr)
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' tagged as equivalent to Current?
		do
			Result := equivalent (tag, other.tag) and then equivalent (expr, other.expr)
		end;	

invariant
	expr_not_void: expr /= Void

end -- class TAGGED_AS
