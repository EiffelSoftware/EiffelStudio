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
			api := a_api
		end

feature {CMS_MODULE, CMS_API} -- Restricted access		

	api: CMS_API

	storage: CMS_STORAGE
		do
			Result := api.storage
		end

end
