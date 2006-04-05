indexing
	description: "Process a structured text and put result in a string for descriptions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DESCRIPTION_STRING_FORMATTER

inherit
	STRING_FORMATTER
		redefine
			make,
			put_comment,
			put_indent,
			put_keyword
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			Precursor {STRING_FORMATTER}
			first_comment := True
		end

feature -- Output

	put_comment (str: STRING) is
			-- Put `str' as representation of a comment.
		local
			l_str: STRING
		do
			if not comments_ended then
				if not str.is_equal (comment) then
					l_str := str.twin
					l_str.prune_all_leading (' ')
					put_string (l_str)
				elseif first_comment then
					put_string ("%N%T%T%T")
					first_comment := False	
				end
			else
				Precursor {STRING_FORMATTER} (str)
			end
		end
		
	put_indent (nbr_of_tabs: INTEGER) is
			-- Put indent of `nbr_of_tabs'.
		do
		end

	put_keyword (str: STRING) is
			-- Put `str' as representation of quoted text.
		do
			if str.is_equal (require_keyword) or str.is_equal (ensure_keyword) then
					-- Add extra description line break
				put_new_line
				comments_ended := True
			end
			put_string (str)
		end

feature {NONE} -- Implementation			
			
	first_comment: BOOLEAN
			-- Is comment the first?
			
	comments_ended: BOOLEAN
			-- Is formatter in comment?
			
	require_keyword: STRING is "require"
			-- require keyword

	ensure_keyword: STRING is "ensure"
			-- require keyword
			
	comment: STRING is "--";
			-- comment marker

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
end -- class DESCRIPTION_STRING_FORMATTER
