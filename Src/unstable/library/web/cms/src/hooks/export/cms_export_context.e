note
	description: "[
			Parameters used by CMS_HOOK_EXPORT subscribers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EXPORT_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_location: PATH)
		do
			location := a_location
			create logs.make (10)
		end

feature -- Access

	location: PATH
			-- Location of export folder.		

feature -- Logs

	logs: ARRAYED_LIST [READABLE_STRING_8]
			-- Associated exportation logs.

	log (m: READABLE_STRING_8)
			-- Add message `m' into `logs'.
		do
			logs.force (m)
		end

invariant

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
