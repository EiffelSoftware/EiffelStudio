indexing
	description: "Objects that provide access to the component viewer."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_COMPONENT_VIEWER

feature -- Access

	component_viewer: GB_COMPONENT_VIEWER is
			-- `Result' is component viewer of system.
		once
			create Result
		end

end -- class GB_SHARED_COMPONENT_VIEWER
