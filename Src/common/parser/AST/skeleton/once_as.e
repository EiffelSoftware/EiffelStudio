indexing

	description: 
		"AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision $"

class ONCE_AS

inherit

	INTERNAL_AS
		redefine
			is_once
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

--feature {NONE}
--
--	begin_keyword: BASIC_TEXT is
--			-- "once" keyword
--		once
--			Result := ti_Once_keyword
--		end

end -- class ONCE_AS
