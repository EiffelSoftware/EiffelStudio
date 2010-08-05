note
	description: "Summary description for {REPOSITORY_LOG_AUTHOR_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_AUTHOR_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make

feature {NONE} -- Initialization

	make (v: like author)
		do
			author := v
		end

feature -- Access

	author: STRING

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		do
			Result := author.is_case_insensitive_equal (a_log.author)
		end

	to_string: STRING
		do
			Result := "author=" + author
		end

end
