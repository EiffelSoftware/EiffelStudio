note
	description: "Summary description for {NS_IMAGE_CONSTANTS}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_CONSTANTS

feature -- Access

	image_name_info: NS_STRING
		once
			create Result.make_shared ({NS_IMAGE}.image_name_info)
		end

end
