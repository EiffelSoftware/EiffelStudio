note
	description: "Summary description for {CMS_MODULE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE_HANDLER [G -> CMS_MODULE_API]

inherit
	CMS_HANDLER
		rename
			make as cms_make
		end

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_module_api: G)
		do
			cms_make (a_api)
			module_api := a_module_api
		end

	module_api: G
			-- Node api	

end
