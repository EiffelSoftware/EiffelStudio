indexing
	description: "AST representation to access to `Current'."
	date: "$Date$"
	revision: "$Revision$"

class
	CURRENT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new CURRENT AST node.
		do
			-- Do nothing.
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	access_name: STRING is "Current"

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_current;
			ctxt.put_text_item (ti_Current)
		end;

end -- class CURRENT_AS
