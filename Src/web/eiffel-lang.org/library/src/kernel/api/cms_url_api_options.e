note
	description: "Summary description for {CMS_URL_API_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_URL_API_OPTIONS

inherit
	CMS_API_OPTIONS

create
	make,
	make_absolute

feature {NONE} -- Initialization

	make_absolute
		do
			make (1)
			force (True, "absolute")
		end

end
