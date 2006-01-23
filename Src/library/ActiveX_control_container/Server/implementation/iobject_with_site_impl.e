indexing
	description: "Implemented `IObjectWithSite' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- IOBJECT_WITH_SITE_IMPL

