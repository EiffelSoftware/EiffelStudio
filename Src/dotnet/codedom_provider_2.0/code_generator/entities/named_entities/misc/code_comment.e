indexing
	description: "Eiffel comment"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_COMMENT

inherit
	CODE_NAMED_ENTITY
		rename
			name as text
		end

create
	make

feature {NONE} -- Initialization
	
	make (a_text: like text; a_is_implementation_comment: like is_implementation_comment) is
			-- Set `text' with `a_text' and `is_implementation_comment' with `a_is_implementation_comment'.
		require
			non_void_text: a_text /= Void
		do
			text := a_text
			is_implementation_comment := a_is_implementation_comment
		ensure
			text_set: text = a_text
			is_implementation_comment_set: is_implementation_comment = a_is_implementation_comment
		end
		
feature -- Access
			
	code: STRING is
			-- | Result := "-- [|] `text'"
			-- Eiffel code of comment
		do
			create Result.make (120)
			Result.append (Indent_string)
			Result.append ("-- ")
			if is_implementation_comment then
				Result.append ("| ")
			end
			Result.append (text)
			Result.append (Line_return)
		end

feature -- Status Report

	is_implementation_comment: BOOLEAN
			-- Is it an implementation comment? (i.e. not visible in class documentation)

invariant
	non_void_text: text /= Void

end -- class CODE_COMMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------