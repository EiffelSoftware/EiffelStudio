note
	description: "Summary description for {REPOSITORY_LOG_READ_STATUS_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_READ_STATUS_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make_read

feature {NONE} -- Initialization

	make_read (v: like status)
		do
			status := v
		end

feature -- Access

	status: BOOLEAN

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		do
			Result := not a_log.unread = status
		end

	to_string: STRING
		do
			if status then
				Result := "read"
			else
				Result := "unread"
			end
		end

end
