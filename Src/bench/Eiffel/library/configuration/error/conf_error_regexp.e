indexing
	description: "Error for invalid regexps."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_REGEXP

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_regexp: STRING) is
			-- Create.
		require
			a_regexp_not_void: a_regexp /= Void
		do
			text := "Invalid regexp: "+a_regexp
		end

feature -- Access

	text: STRING

end
