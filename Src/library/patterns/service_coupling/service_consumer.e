note
	description: "[
		A utility for clients accessing a service (globally or locally via a service provider) and determining a service's existence.
	]"
	doc: "wiki://Service Consumers"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SERVICE_CONSUMER [G -> SERVICE_I]

inherit
	ANY

	SHARED_SERVICE_PROVIDER
		rename
			service_provider as global_service_provider
		export
			{NONE} all
		end

create
	default_create,
	make_with_provider

feature {NONE} -- Initialization

	make_with_provider (a_provider: like service_provider)
			-- Initialize a service consumer using an alternative (local) service provider.
			--
			-- `a_provider': A service provider to use when querying for a service, instead of the global
			--               one.
		require
			a_provider_attached: a_provider /= Void
		do
			internal_service_provider := a_provider
		ensure
			service_provider_set: service_provider = a_provider
		end

feature -- Access

	service: detachable G
			-- Access to the service
		do
			Result := internal_service
			if not attached Result then
				Result := ({G}) / service_provider.service ({G})
				internal_service := Result
			end
		end

feature {NONE} -- Access

	service_provider: SERVICE_PROVIDER_I
			-- Access to the set service provider, or global service provider if no local provider was set.
		local
			l_result: like internal_service_provider
		do
			l_result := internal_service_provider
			if l_result /= Void then
				Result := l_result
			else
				Result := global_service_provider
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_service_available: BOOLEAN
			-- Indicates if the service is available.
		obsolete
			"Use `service' directly to find out if service is available."
		do
			Result := internal_service /= Void or else (service_provider.service ({detachable G}) /= Void)
		ensure
			has_service: Result implies (internal_service /= Void) or else service_provider.service ({detachable G}) /= Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_service: detachable G
			-- Cached version of `service'.
			-- Note: Do not use directly!

	internal_service_provider: detachable like service_provider
			-- Cached version of `service_provider'
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
