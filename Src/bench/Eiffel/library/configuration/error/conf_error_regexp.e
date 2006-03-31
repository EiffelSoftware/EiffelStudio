indexing
	description: "Error for invalid regexps."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_REGEXP

inherit
	CONF_ERROR_PARSE
		redefine
			text
		end

feature -- Access

	text: STRING is
		do
			if file /= Void then
				Result := "Parse error in "+file+": Invalid regexp: "+regexp
			else
				Result := "Parse error: Invalid regexp: "+regexp
			end
		end

feature -- Update

	set_regexp (a_regexp: STRING) is
			-- Set regexp
		do
			regexp := a_regexp
		end

feature {NONE} -- Implementation

	regexp: STRING


end
