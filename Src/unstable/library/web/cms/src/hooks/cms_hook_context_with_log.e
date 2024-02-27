note
	description: "Summary description for {CMS_HOOK_WITH_LOG_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HOOK_CONTEXT_WITH_LOG

create
	make

feature {NONE} -- Initialization

	make
		do
			create logs.make (10)
		end

feature -- Logs

	logs: ARRAYED_LIST [READABLE_STRING_8]
			-- Associated exportation logs.

	log (m: READABLE_STRING_8)
			-- Add message `m' into `logs'.
		do
			logs.force (m)
		end

note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
