indexing
	description: "AST representation to access to `Result'."
	date: "$Date$"
	revision: "$Revision$"

class
	RESULT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new RESULT AST node.
		do
			-- Do nothing.
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end

feature -- Properties

	access_name: STRING is "Result"

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_result
			ctxt.put_text_item (ti_Result)
		end

end -- class RESULT_AS
