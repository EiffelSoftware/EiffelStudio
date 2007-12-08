indexing
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

	help_context_id: !STRING_GENERAL
			-- A contextual identifer to link an associated help through.
		require
			is_interface_usable: is_interface_usable
			is_help_available: is_help_available
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	help_context_section: STRING_GENERAL
			-- An optional sub-section in the help document, located using `help_context_id' to navigate to.
		require
			is_interface_usable: is_interface_usable
			is_help_available: is_help_available
		deferred
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	help_provider: !UUID
			-- Help provider kind best used for the help context.
			-- See {HELP_PROVIDER_KINDS} for a list of built-in help providers.
		once
			Result := (create {HELP_PROVIDER_KINDS}).default_help
		end

feature -- Status report

	is_help_available: BOOLEAN
			-- Indicates if any help context is available
		do
			Result := is_interface_usable
		ensure
			is_interface_usable: Result implies is_interface_usable
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
