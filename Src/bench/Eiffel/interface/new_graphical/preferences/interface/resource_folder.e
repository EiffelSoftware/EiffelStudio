indexing
	description: "Class which encapsulates the information relative to a resource category."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RESOURCE_FOLDER
 
feature -- Initialization

	load_attributes is
		deferred
		end

feature -- Implementation

--	path: STRING
		-- Id of Current, it is unique.

	name: STRING
		-- Id of Current, it is unique.

	description: STRING
		-- Description of Current.

	resource_list: LINKED_LIST [RESOURCE]
		-- List of resources.

	child_list: LINKED_LIST [like Current]
		-- List of Categories.

	structure: RESOURCE_STRUCTURE

feature -- Status Report

	non_automatic_loading: BOOLEAN
		-- Are contents of Current not computed at creation?

	loading_not_done: BOOLEAN
		-- Are contents of Current not been computed yet?

end -- class RESOURCE_FOLDER
