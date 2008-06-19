indexing
	description: "[
		Shared access to a global service provider.
		
		Note: `service_provider' provides uniformed access to a global service heap. There should only be one
		heap per application to avoid confusion. Any class requiring access to a service should inherit or
		use {SHARED_SERVICE_PROVIDER} as a client.
		
		On first initialization a service heap {SERVICE_HEAP} will be created to store and maintain a list of services.
		After initialization two services will be registered. 
			* {SERVICE_CONTAINER_S} provides access to the global service container by-passing any chained container.
			* {SERVICE_PROVIDER_S} provides access to the global service provider by-passing any chained provider.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SHARED_SERVICE_PROVIDER

feature -- Access

	frozen service_provider: !SERVICE_PROVIDER_I
			-- Shared access to the global service provider.
		local
			l_provider: !SERVICE_HEAP
		once
			create l_provider.make
			Result := l_provider

			l_provider.register_with_activator ({SERVICE_CONTAINER_S},
				agent (ia_container: !SERVICE_CONTAINER_I): ?SERVICE_CONTAINER_S
					do
						create Result.make (ia_container)
					end (l_provider))

			l_provider.register_with_activator ({SERVICE_PROVIDER_S},
				agent (ia_provider: !SERVICE_PROVIDER_I): ?SERVICE_PROVIDER_S
					do
						create Result.make (ia_provider)
					end (l_provider))
		end

indexing
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

end -- class {SHARED_SERVICE_PROVIDER}
