indexing
	description: 
		"AST representation of retry instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	RETRY_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (l: like location) is
			-- Create a new RETRY AST node.
		require
			l_not_void: l /= Void
		do
			location := clone (l)
		ensure
			location_set: location.is_equal (l)			
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_retry_as (Current)
		end

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
--			ctxt.put_breakable
--			ctxt.put_text_item (ti_Retry_keyword)
--		end

end -- class RETRY_AS
