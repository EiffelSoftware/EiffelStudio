note
	description: "Summary description for {EV_RIBBON_RESOURCES}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_RESOURCES

feature -- Query

	ribbon_list: ARRAYED_LIST [EV_RIBBON]
			-- Global list of ribbons
		once
			create Result.make (5)
		end
		
end
