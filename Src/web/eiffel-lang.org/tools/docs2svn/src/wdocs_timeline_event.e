note
	description: "Summary description for {WDOCS_TIMELINE_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_TIMELINE_EVENT

inherit
	COMPARABLE

feature -- Access

	event_summary: STRING_32
		deferred
		ensure
			not_new_line: not Result.has ('%N')
		end

	date: DATE_TIME
		deferred
		end

end
