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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_result_as (Current)
		end

feature -- Attributes

	access_name: STRING is "Result"

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.prepare_for_result
--			ctxt.put_text_item (ti_Result)
--		end

end -- class RESULT_AS
