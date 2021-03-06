note
	description: "[
		A full, customizable help context for use in client needed situations. Use {ES_HELP_CONTEXT} for
		inheritance based help contexts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ES_HELP_CUSTOM_CONTEXT

inherit
	ES_HELP_CONTEXT
		rename
			help_context_section as internal_help_context_section
		redefine
			internal_help_context_section
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_GENERAL; a_section: detachable like help_context_section)
			-- Initialize a new custom help context.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			not_a_section_is_empty: a_section /= Void implies not a_section.is_empty
		do
			create help_context_id.make_from_string_general (a_id)
			help_context_section := a_section
		ensure
			help_context_id_set: a_id.same_string (help_context_id)
			help_context_section_set: help_context_section /= Void implies help_context_section.same_string (a_section)
		end

feature -- Access

	help_context_id: STRING_32
			-- <Precursor>

	help_context_section: detachable STRING_32
			-- -- An optional sub-section in the help document, located using `help_context_id' to navigate to.

feature {NONE} -- Access

	internal_help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- <Precursor>
		do
			if attached help_context_section as l_section then
				create {HELP_CONTEXT_SECTION} Result.make (l_section)
			end
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Determines if the interface is usable
		do
			Result := True
		end

invariant
	not_help_context_section_is_empty: help_context_section /= Void implies not help_context_section.is_empty

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
