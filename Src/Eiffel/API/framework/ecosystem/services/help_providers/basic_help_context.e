indexing
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

	make (a_context: like help_context_id; a_section: like help_context_section; a_provider: like help_provider)
			-- Initialize a help context using a set of help context information.
		require
			not_a_context_is_empty: not a_context.is_empty
			not_a_section_is_empty: a_section /= Void implies not a_section.is_empty
		do
			help_context_id := a_context
			help_context_section := a_section
			internal_help_provider := a_provider
		ensure
			help_context_id_set: help_context_id = a_context
			help_context_section_set: help_context_section = a_section
			internal_help_provider: internal_help_provider_set = a_provider
		end

feature -- Access

	help_context_id: !STRING_GENERAL
			-- A contextual identifer to link an associated help through.

	help_context_section: ?STRING_GENERAL
			-- An optional sub-section in the help document, located using `help_context_id' to navigate to.

	help_provider: !UUID
			-- Help provider kind best used for the help context.
			-- See {HELP_PROVIDER_KINDS} for a list of built-in help providers.
		do
			Result := internal_help_provider
		end

feature -- Status report

	is_help_available: BOOLEAN
			-- Indicates if any help context is available
		do
			Result := True
		end

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := True
		end

feature {NONE} -- Internal implementation cache

	internal_help_provider: like help_provider
			-- Mutable version of `help_provider'

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
