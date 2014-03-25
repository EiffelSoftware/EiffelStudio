note
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

	document_protocol: STRING_32
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	document_description: STRING_32
			-- Document short description
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen kind: UUID assign set_kind
			-- Help provider id, assigned to by the help providers service.
		attribute
			create Result
		end

feature {NONE} -- Access

	context_variables: STRING_TABLE [READABLE_STRING_32]
			-- Custom table of context variables
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {HELP_PROVIDERS_S} -- Element change

	frozen set_kind (a_kind: UUID)
			-- Set's help provider's kind ID.
		require
			a_kind_attached: a_kind /= Void
		do
			kind := a_kind
		ensure
			kind_set: kind = a_kind
		end

feature -- Status report

	is_valid_context_id (a_context_id: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a help content context id is valid
			--
			-- `a_context_id': A help provider's linkable context content id to validate.
			-- `Result': True to indicate the context id is valid; False otherwise.
		require
			a_context_id_attached: a_context_id /= Void
			not_a_context_id_is_empty: not a_context_id.is_empty
		do
			Result := True
		end

	is_launched: BOOLEAN
			-- Indicates if the last call to `show_help' was successful.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	help_title (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I): STRING_32
			-- A human readable title for a help document, given a context id and section.
			--
			-- `a_context_id': The primary help provider's linkable context content id, used to locate a help document.
			-- `a_section': An optional section to locate sub context in the to-be-shown help document.
		require
			is_interface_usable: is_interface_usable
			a_context_id_attached: a_context_id /= Void
			not_a_context_id_is_empty: not a_context_id.is_empty
			a_context_id_is_valid_context_id: is_valid_context_id (a_context_id)
		do
			create Result.make (50)
			Result.append (a_context_id.as_string_32)
			if a_section /= Void then
				Result.append ({STRING_32} ", ")
				Result.append_string_general (a_section.section)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- Attempts to show help for a specific context using the current help provider
			--
			-- `a_context_id': The primary help provider's linkable context content id, used to locate a help document.
			-- `a_section': An optional section to locate sub context in the to-be-shown help document.
		require
			is_interface_usable: is_interface_usable
			a_context_id_attached: a_context_id /= Void
			not_a_context_id_is_empty: not a_context_id.is_empty
			a_context_id_is_valid_context_id: is_valid_context_id (a_context_id)
		deferred
		end

--invariant
	--kind_attached: kind /= Void

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
