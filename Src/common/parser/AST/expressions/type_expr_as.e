indexing
	description: "Type expression"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_EXPR_AS
	
inherit
	EXPR_AS
		
create
	initialize
	
feature {NONE} -- Initialize

	initialize (t: like type) is
			-- New instance of TYPE_EXPR_AS initialized with `t'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_AS
			-- Type representing type expression

feature -- Visitor

	process (v: AST_VISITOR) is
			-- 
		do
			v.process_type_expr_as (Current)
		end
		
feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := type.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := type.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'?
		do
			Result := type.is_equivalent (other.type)
		end

invariant
	type_not_void: type /= Void

end
