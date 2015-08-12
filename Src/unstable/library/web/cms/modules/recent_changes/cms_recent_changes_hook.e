note
	description: "Hook provided by module {CMS_RECENT_CHANGES_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_RECENT_CHANGES_HOOK

inherit
	CMS_HOOK

feature -- Invocation

	populate_recent_changes (a_changes: CMS_RECENT_CHANGE_CONTAINER; a_sources: LIST [READABLE_STRING_8])
			-- Populate recent changes inside `a_changes' according to associated parameters.
			-- Also provide sources of information.
		deferred
		end

end
