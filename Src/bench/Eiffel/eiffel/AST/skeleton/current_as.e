indexing
	description:
		"Abstract description to access to `Current'. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CURRENT_AS

inherit
	ACCESS_AS
		redefine
			type_check, byte_node,
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new CURRENT AST node.
		do
			-- Do nothing.
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	access_name: STRING is "Current"

feature -- Type check and byte code

	type_check is
			-- Type check access to Current
		local
			current_access: CURRENT_B
		do
				-- Creation of a byte code access to Current and insertion
			   -- of it in the access line.
			!!current_access
			context.access_line.insert (current_access)
		end

	byte_node: CURRENT_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE
		do
			access_line := context.access_line
			check
				access_line_is_ok: not access_line.after
			end
			Result ?= access_line.access
			access_line.forth
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_current
			ctxt.put_text_item (ti_Current)
		end

end -- class CURRENT_AS
