note
	description: "Summary description for {EIFFEL_LANG_CMS_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_CMS_SETUP

inherit
	CMS_CUSTOM_SETUP
		redefine
			initialize_modules
		end

create
	make

feature {NONE} -- Initialization		

	initialize_modules
		local
			m: CMS_MODULE
		do
			create modules.make (3)
		end

end
