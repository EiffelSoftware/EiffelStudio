note
	description: "[
		Basic help provider context, providing contextual information through external parameters.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	BASIC_HELP_CONTEXT

inherit
	HELP_CONTEXT_I
		redefine
			help_provider,
			is_help_available
		end

create
	make

feature {NONE} -- Initialization

	make (a_context: like help_context_id; a_section: like help_context_section; a_desc: like help_context_description; a_provider: like help_provider)
			-- Initialize a help context using a set of help context information.
		require
			not_a_context_is_empty: not a_context.is_empty
		do
			help_context_id := a_context
			help_context_section := a_section
			help_context_description := a_desc
			internal_help_provider := a_provider
		ensure
			help_context_id_set: help_context_id ~ a_context
			help_context_section_set: help_context_section ~ a_section
			help_context_description_set: help_context_description ~ a_desc
			internal_help_provider_set: internal_help_provider ~ a_provider
		end

feature -- Access

	help_context_id: STRING
			-- <Precursor>

	help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- <Precursor>

	help_context_description: detachable STRING_32
			-- <Precursor>

	help_provider: UUID
			-- <Precursor>
		do
			Result := internal_help_provider
		end

feature -- Status report

	is_help_available: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Internal implementation cache

	internal_help_provider: like help_provider
			-- Mutable version of `help_provider'.

invariant
	help_context_id_attached: help_context_id /= Void
	not_help_context_id_is_empty: not help_context_id.is_empty
	help_context_description_attached: help_context_description /= Void
	not_help_context_description_is_empty:
		(attached help_context_description as l_description) implies not l_description.is_empty

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
