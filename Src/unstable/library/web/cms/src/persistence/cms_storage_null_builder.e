note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_NULL_BUILDER

inherit
	CMS_STORAGE_BUILDER

feature -- Factory

	storage (a_setup: CMS_SETUP): detachable CMS_STORAGE_NULL
		do
			create Result
		end

end
