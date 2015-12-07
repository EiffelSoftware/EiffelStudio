note
	description: "Hook provided by module {CMS_TAXONOMY_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_TAXONOMY_HOOK

inherit
	CMS_HOOK

feature -- Hook

	populate_content_associated_with_term (t: CMS_TERM; a_contents: CMS_TAXONOMY_ENTITY_CONTAINER)
			-- Populate `a_contents' with taxonomy entity associated with term `t'.
		deferred
		end

end
