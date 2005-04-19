indexing
	description: "Description of a custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class CUSTOM_ATTRIBUTE_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end

create
	initialize
	
feature {NONE} -- Initialization

	initialize (c: like creation_expr; t: like tuple) is
			-- Create a new UNIQUE AST node.
		require
			c_not_void: c /= Void
		do
			creation_expr := c
			tuple := t
		ensure
			creation_expr_set: creation_expr = c
			tuple_set: tuple = t
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_custom_attribute_as (Current)
		end

feature -- Access

	creation_expr: CREATION_EXPR_AS
			-- Creation of Custom attribute.
			
	tuple: TUPLE_AS
			-- Tuple for addition custom attribute settings.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := creation_expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if tuple /= Void then
				Result := tuple.end_location
			else
				Result := creation_expr.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := creation_expr.is_equivalent (other.creation_expr)
		end

feature -- Output

	string_value: STRING is ""

invariant
	creation_expr_not_void: creation_expr /= Void

end -- class CUSTOM_ATTRIBUTE_AS
