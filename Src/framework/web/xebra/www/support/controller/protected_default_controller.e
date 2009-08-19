note
	description: "Summary description for {LOGIN_CONTROLLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PROTECTED_DEFAULT_CONTROLLER

inherit
	XWA_CONTROLLER

create
	default_create

feature -- Access

	legend_repeater: LIST [STRING]
			-- TODO
		do
			create {ARRAYED_LIST [STRING]} Result.make (2)
		end

end
