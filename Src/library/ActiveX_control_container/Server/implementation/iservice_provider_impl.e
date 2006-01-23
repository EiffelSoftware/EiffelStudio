indexing
	description: "Implemented `IServiceProvider' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ISERVICE_PROVIDER_IMPL

inherit
	ISERVICE_PROVIDER_INTERFACE
	
	ECOM_EXCEPTION
	
	OUTER_SITE_PROXY

feature -- Basic Operations

	query_service (guid_service: ECOM_GUID; riid: ECOM_GUID; ppv_object: CELL [ECOM_INTERFACE]) is
			-- Acts as the factory method for any services
			-- exposed through an implementation of IServiceProvider.
			-- `guid_service' [in]. Unique identifier of the service.
			-- `riid' [in]. Unique identifier of the interface the 
			-- caller wishes to receive for the service. 
			-- `ppv_object' [out].  
		do
			if 
				unknown_site /= Void and then
				m_service_provider = Void 
			then
				m_service_provider := service_provider
			end
			if 
				m_service_provider /= Void
			then
				service_provider.query_service (guid_service, riid, ppv_object)
			else
				trigger (E_nointerface)
			end
		end

feature {NONE} -- Implementation

	m_service_provider: ISERVICE_PROVIDER_IMPL_PROXY; 
			-- IServiceProvider interface of site.
			
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




end -- ISERVICE_PROVIDER_IMPL

