indexing
	description: "Description of a custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class CUSTOM_ATTRIBUTE_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent, type_check
		end

create
	initialize
	
feature {AST_FACTORY} -- Initialization

	initialize (c: like creation_expr) is
			-- Create a new UNIQUE AST node.
		require
			c_not_void: c /= Void
		do
			creation_expr := c
		ensure
			creation_expr_set: creation_expr = c
		end

feature -- Access

	creation_expr: CREATION_EXPR_AS
			-- Creation of Custom attribute.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := creation_expr.is_equivalent (other.creation_expr)
		end

feature -- Type checking

	type_check is
			-- Type check a unique type
		do
			creation_expr.type_check
		end

feature -- Output

	string_value: STRING is ""

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			creation_expr.simple_format (ctxt)
		end

end -- class CUSTOM_ATTRIBUTE_AS
