indexing
	description: "[
		Representation of an object that contains tags
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAGABLE_I

inherit
	USABLE_I

feature -- Access

	tags: !DS_LINEAR [!STRING]
			-- List of tags
		require
			usable: is_interface_usable
		deferred
		end

end
