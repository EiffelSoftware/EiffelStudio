note
	description: "Common ancestor for all module apis."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE_API

feature {NONE} -- Initialization

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

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
