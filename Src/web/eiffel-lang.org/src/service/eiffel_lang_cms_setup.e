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
			build_modules
		end

create
	default_create,
	make,
	make_from_file

feature {NONE} -- Initialization		

	build_modules
		local
			m: CMS_MODULE
		do
			create modules.make (3)
		end

end
