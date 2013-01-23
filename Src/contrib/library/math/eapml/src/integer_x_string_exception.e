note
	description: "An exception when a {STRING} couldn't be parsed in to a {INTEGER_X}"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Heresy is only another word for freedom of thought. -  Graham Greene (1904-1991)"

class
	INTEGER_X_STRING_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			tag
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_8 ("Error parsing string as INTEGER_X.")
		end

end
