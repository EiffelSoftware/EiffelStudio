indexing
	description: "Eiffel comment"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_COMMENT

inherit
	ECDP_NAMED_ENTITY
		rename
			name as text
		end

create
	default_create
		
feature -- Access
			
	code: STRING is
			-- | Result := "-- [|] `text'"
			-- Eiffel code of comment
		do
			create Result.make (120)
			Result.append (Indent_string)
			Result.append (dictionary.Dashes)
			Result.append (dictionary.Space)
			if is_implementation_comment then
				Result.append (dictionary.Vertical_bar)
				Result.append (dictionary.Space)
			end
			Result.append (text)
			Result.append (Dictionary.New_line)
		end

feature -- Status Report

	is_implementation_comment: BOOLEAN
			-- Is it an implementation comment? (i.e. not visible in class documentation)

feature -- Status Setting

	set_implementation_comment (a_value: like is_implementation_comment) is
			-- Set `is_implementation_comment' with `a_value'.
		do
			is_implementation_comment := a_value
		ensure
			is_implementation_comment_set: is_implementation_comment = a_value
		end
	
end -- class ECDP_COMMENT

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