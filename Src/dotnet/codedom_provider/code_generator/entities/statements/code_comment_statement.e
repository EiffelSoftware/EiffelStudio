indexing
	description: "Eiffel representation of a CodeDom comment statement"
	date: "$$"
	revision: "$$"	
	
class
	CODE_COMMENT_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `comment'.
		do
		end
		
feature -- Access

	comment: CODE_COMMENT
			-- Comment

	code: STRING is
			-- | Result := "`comment'"
			-- Eiffel code of comment statement
		do
			create Result.make (120)
			Result.append (comment.code)
		end
		
feature -- Status Report
		
	ready: BOOLEAN is
			-- Is comment statement ready to be generated?
		do
			Result := comment.ready
		end

feature -- Status Setting

	set_comment (a_comment: like comment) is
			-- Set `comment' with `a_comment'.
		require
			non_void_comment: a_comment /= Void
		do
			comment := a_comment
		ensure
			comment_set: comment = a_comment
		end		
	
end -- class CODE_COMMENT_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------