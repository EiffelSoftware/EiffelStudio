note
	description: "Summary description for {CMS_MODULE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE_API

feature {NONE} -- Implementation

	make (a_api: CMS_API)
		do
			cms_api := a_api
			initialize
		end

	initialize
			-- Initialize Current api.
		do
		end

feature {CMS_API_ACCESS, CMS_MODULE, CMS_API} -- Restricted access		

	cms_api: CMS_API

	storage: CMS_STORAGE
		do
			Result := cms_api.storage
		end

end
