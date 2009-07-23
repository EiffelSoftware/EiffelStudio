note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROTECTED_DEFAULT_CONTROLLER

inherit
	XWA_CONTROLLER

create
	make

feature -- Access

	legend_repeater: LIST [STRING]
			-- TODO
		do
			create {ARRAYED_LIST [STRING]} Result.make (2)
		end

end
