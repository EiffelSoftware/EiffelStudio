note
	description: "Deferred request handler related to /blogs/... Has an own blog api."
	contributor: "Dario Bösch <daboesch@student.ethz.ch>"
	date: "$Date$"
	revision: "$9661667$"

deferred class
	CMS_BLOG_HANDLER

inherit
	CMS_MODULE_HANDLER [CMS_BLOG_API]
		rename
			module_api as blog_api
		redefine
			make
		end

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_module_api: CMS_BLOG_API)
		do
			Precursor (a_api, a_module_api)
			entries_per_page := a_module_api.default_entries_count_per_page
		end
feature -- Access

	entries_per_page: NATURAL_32

end
