note
	description: "Summary description for {CMS_NODE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_HANDLER

inherit
	CMS_MODULE_HANDLER [CMS_NODE_API]
		rename
			module_api as node_api
		end

end
