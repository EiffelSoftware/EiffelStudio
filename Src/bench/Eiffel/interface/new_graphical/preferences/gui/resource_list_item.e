indexing
	description: "List item associated to a resource."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_LIST_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

creation
	make_resource

feature -- Initialization

	make_resource (res: RESOURCE) is
			-- Creation
		require
			resource_exists: res /= Void
		local
			s: STRING
			description: STRING
		do
			description := res.description
			if description /= Void and then not description.is_empty then
				s := clone (description)
			else
				s := clone (res.name)
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')	
			default_create
			extend (s)
			extend (res.value)
			resource := res
		ensure
			resource_consistent: resource = res
		end

feature -- Implenentation

	resource: RESOURCE
		-- Resource

invariant
	RESOURCE_LIST_ITEM_resource_exists: resource /= Void

end -- class RESOURCE_LIST_ITEM
