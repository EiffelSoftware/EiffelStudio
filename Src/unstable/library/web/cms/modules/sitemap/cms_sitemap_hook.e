note
	description: "Hook provided by module {CMS_RECENT_CHANGES_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SITEMAP_HOOK

inherit
	CMS_HOOK

feature -- Invocation

	populate_sitemap (a_sitemap: CMS_SITEMAP)
			-- Populate `a_sitemap`.
		deferred
		end

end
