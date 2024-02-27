note
	description: "[
			CMS HOOK providing a way to execute cleanup (clean and archive) operations.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_CLEANUP

inherit
	CMS_HOOK

feature -- Hook	

	cleanup (ctx: CMS_HOOK_CLEANUP_CONTEXT; a_response: CMS_RESPONSE)
			-- Cleanup
		deferred
		end

note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
