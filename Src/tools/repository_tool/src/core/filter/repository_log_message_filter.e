note
	description: "Summary description for {REPOSITORY_LOG_AUTHOR_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_MESSAGE_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make

feature {NONE} -- Initialization

	make (v: like message)
		do
			message := v
		end

feature -- Access

	message: STRING

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		do
			Result := a_log.message.has_substring (message)
		end

	to_string: STRING
		do
			Result := "message=" + message
		end

end
