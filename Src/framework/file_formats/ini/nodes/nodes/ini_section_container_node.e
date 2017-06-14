note
	description: "Base implementation for all AS nodes that can contain property AS nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_SECTION_CONTAINER_NODE

feature {NONE} -- Initialization

	make
			-- Initialize container
		do
			create mutable_sections.make (1)
		end

feature -- Access

	sections: LIST [INI_SECTION_NODE]
			-- List of sections contained within current container
		do
			Result := mutable_sections
		ensure
			result_attached: Result /= Void
		end

feature -- Extension

	extend_section (a_section: INI_SECTION_NODE)
			-- Extends container with section `a_section'.
		require
			a_section_attached: a_section /= Void
			already_added: not sections.has (a_section)
		do
			mutable_sections.extend (a_section)
		ensure
			a_section_added: sections.has (a_section)
		end

feature {NONE} -- Implementation

	mutable_sections: ARRAYED_LIST [INI_SECTION_NODE]
			-- Mutable version of `sections'

invariant
	mutable_sections_attached: mutable_sections /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
