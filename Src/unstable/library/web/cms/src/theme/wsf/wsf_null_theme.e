note
	description: " Null theme for void-safety purpose."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_NULL_THEME

inherit
	WSF_THEME

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Core

	site_url: STRING = ""

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		do
		end

end
