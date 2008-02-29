indexing
	description: "[
		Base interface for all classes exposing a means to query for a local service.
		
		Note: Provides access to services registered in by using a {SERVICE_CONTAINER}. Services
		are added and queried for using a service type, which is a TYPE [G]. 
		
		Queries are always made on a locally available service provider. Any services registered on the local
		service provider are given priority. If no local service is available a parent service provider is
		checked for the service all the way up to the root service provider, implemented on {SERVICE_HEAP}.
		
		Clients are free to query directly for the global service provider using {SERVICE_PROVIDER} or {SERVICE_CONTAINER}.
		However, it's not guarenteed that querying for {SERVICE_PROVIDER} or {SERVICE_CONTAINER} will return
		the global versions of those services. These may also be localized services.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SERVICE_PROVIDER

feature -- Query

	query_service (a_type: TYPE [ANY]): SERVICE_I
			-- Queries for service `a_type' and returns result if service was found on Current
		require
			a_type_attached: a_type /= Void
		deferred
		ensure
			result_sited: Result /= Void implies Result.site = Current
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class {SERVICE_PROVIDER}
