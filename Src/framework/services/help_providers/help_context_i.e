note
	description: "[
		Abstract interface for implement help context in a help context aware section of EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	HELP_CONTEXT_I

inherit
	USABLE_I

feature -- Access

	help_context_id: STRING
			-- A contextual identifer to link an associated help through.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: help_context_id /= Void
			not_result_is_empty: not Result.is_empty
		end

	help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- An optional sub-section in the help document, located using `help_context_id' to navigate to.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	help_context_description: detachable STRING_32
			-- An optional description of the context.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	help_provider: UUID
			-- Help provider kind best used for the help context.
			-- See {HELP_PROVIDER_KINDS} for a list of built-in help providers.
			--
			--|The return value should never change, implement as a once.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ help_provider
		end

feature -- Status report

	is_help_available: BOOLEAN
			-- Indicates if any help context is available
		do
			Result := is_interface_usable and then not help_context_id.is_empty
		ensure
			is_interface_usable: Result implies is_interface_usable
			not_help_context_id_is_empty: not help_context_id.is_empty
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
