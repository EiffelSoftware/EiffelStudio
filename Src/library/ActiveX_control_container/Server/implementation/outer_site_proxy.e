indexing
	description: "Proxy of outer site."
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

end -- class OUTER_SITE_PROXY
