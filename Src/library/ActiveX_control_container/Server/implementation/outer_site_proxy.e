indexing
	description: "Proxy of outer site."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	OUTER_SITE_PROXY
	
feature -- Access

	unknown_site: ECOM_INTERFACE
	
	service_provider: ISERVICE_PROVIDER_IMPL_PROXY is
			-- IServiceProvider interface of site.
		require
			non_void_site_unknown: unknown_site /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_from_other (unknown_site)
			end
		rescue
			retried := True
			retry
		end

	ole_container: IOLE_CONTAINER_IMPL_PROXY is
			-- IOleContainer interface of site.
		require
			non_void_site_unknown: unknown_site /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_from_other (unknown_site)
			end
		rescue
			retried := True
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class OUTER_SITE_PROXY
