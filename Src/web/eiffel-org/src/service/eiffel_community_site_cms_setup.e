note
	description: "Summary description for {EIFFEL_COMMUNITY_SITE_CMS_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_SITE_CMS_SETUP

inherit
	CMS_DEFAULT_SETUP
		redefine
			initialize_modules
		end

create
	make

feature {NONE} -- Initialization		

	initialize_modules
		do
			create modules.make (3)
		end

end
