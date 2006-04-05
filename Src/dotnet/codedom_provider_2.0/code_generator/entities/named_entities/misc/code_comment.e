indexing
	description: "Eiffel comment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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