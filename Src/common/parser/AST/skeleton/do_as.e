indexing
	description: 
		"AST representation of a non-deferred routine."
	date: "$Date$"
	revision: "$Revision $"

class
	DO_AS

inherit

	INTERNAL_AS

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_do_as (Current)
		end

--feature {NONE}
--
--	begin_keyword: BASIC_TEXT is
--			-- "do" keyword
--		once
--			Result := ti_Do_keyword
--		end

end -- class DO_AS
