indexing
	description: "[
		Abstract interface for defining and using an help provider retrieved through the help providers service {HELP_PROVIDER_S}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	HELP_PROVIDER_I

inherit
	USABLE_I

feature -- Access

	document_protocol: !STRING_GENERAL
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	document_description: !STRING_GENERAL
			-- Document short description
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	frozen kind: !UUID
			-- Help provider id, assigned to by the help providers service

feature {HELP_PROVIDERS_S} -- Element change

	frozen set_kind (a_kind: !UUID)
			-- Set's help provider's kind ID.
		do
			kind := a_kind
		ensure
			kind_set: kind = a_kind
		end

feature -- Basic operations

	show_help (a_context_id: !STRING_GENERAL; a_section: ?STRING_GENERAL)
			-- Attempts to show help for a specific context using the current help provider
			--
			-- `a_context_id': The primary help provider's linkable context content id, used to locate a help document.
			-- `a_section': An optional section to locate sub context in the to-be-shown help document.
		require
			is_interface_usable: is_interface_usable
			not_a_context_id_is_empty: not a_context_id.is_empty
			a_context_id_is_valid_context_id: is_valid_context_id (a_context_id)
			not_a_section_is_empty: a_section /= Void implies not a_section.is_empty
		deferred
		end

feature -- Query

	is_valid_context_id (a_context_id: !STRING_GENERAL): BOOLEAN
			-- Determines if a help content context id is valid
			--
			-- `a_context_id': A help provider's linkable context content id to validate.
			-- `Result': True to indicate the context id is valid; False otherwise.
		require
			not_a_context_id_is_empty: not a_context_id.is_empty
		do
			Result := True
		end

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
