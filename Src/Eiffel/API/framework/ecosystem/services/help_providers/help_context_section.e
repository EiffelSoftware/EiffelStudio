indexing
	description: "[
			A default implementation of {HELP_CONTEXT_SECTION_I} to further page navigation, once a context
			page reference has been located.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_CONTEXT_SECTION

inherit
	HELP_CONTEXT_SECTION_I

create
	make

feature {NONE} -- Initialization

	make (a_section: like section)
			-- Initialize a help context section (page part).
			--
			-- `a_section': The context help page section to set.
		require
			not_a_section_is_empty: not a_section.is_empty
		do
			set_section (a_section)
		end

feature -- Access

	section: !STRING_GENERAL assign set_section
			-- <Precursor>

feature -- Element change

	set_section (a_section: !like section)
			-- Set the help context page section.
			--
			-- `a_section': The context help page section to set.
		require
			not_a_section_is_empty: not a_section.is_empty
		do
			section := a_section
		ensure
			section_set: section.is_equal (a_section)
		end

invariant
	not_section_is_empty: not section.is_empty

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
