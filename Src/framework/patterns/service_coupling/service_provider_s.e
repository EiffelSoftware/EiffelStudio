indexing
	description: "[
		The service interface for retrieving the global service provider.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	SERVICE_PROVIDER_S

inherit
	SERVICE_I

	SERVICE_PROVIDER_I

create
	make

feature {NONE} -- Initialization

	make (a_provider: !like provider)
			-- Initializes the service provider service with an actual provider.
			--
			-- `a_provider': The actual service provider use to delegate calls to.
		do
			provider := a_provider
		ensure
			provider_set: provider = a_provider
		end

feature {NONE} -- Access

	provider: !SERVICE_PROVIDER_I
			-- Actual service provider to perform operations on.

feature -- Query

	service (a_type: !TYPE [SERVICE_I]): ?SERVICE_I
			-- <Precursor>
		do
			Result := provider.service (a_type)
		end

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

