indexing
	description: "Implemented `IObjectWithSite' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOBJECT_WITH_SITE_IMPL

inherit
	IOBJECT_WITH_SITE_INTERFACE

	OUTER_SITE_PROXY
	
feature -- Basic Operations

	set_site (p_unk_site: ECOM_INTERFACE) is
			-- No description available.
			-- `p_unk_site' [in].  
		do
			unknown_site := p_unk_site
		end

	get_site (riid: ECOM_GUID; ppv_site: CELL [POINTER]) is
			-- No description available.
			-- `riid' [in].  
			-- `ppv_site' [out].  
		do
			if unknown_site /= Void then
				ppv_site.put (unknown_site.item)
			end
		end

	
end -- IOBJECT_WITH_SITE_IMPL

