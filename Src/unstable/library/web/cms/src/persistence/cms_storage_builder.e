note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_BUILDER

feature -- Factory

	storage (a_setup: CMS_SETUP): detachable CMS_STORAGE
			-- CMS Storage object based on CMS setup `a_setup'.
		deferred
		end

end
