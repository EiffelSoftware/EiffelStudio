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

feature {NONE} -- Initialization

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
		
feature -- Access

	resource: RESOURCE
			-- Resource
			
	row_number: INTEGER
			-- Row number in the list.

feature -- Element change

	set_row_number (a_number: INTEGER) is
			-- Set `row_number' to `a_number'
		do
			row_number := a_number
		end
		

feature -- Basic operations

	update is
			-- Refresh Current's display according to its new value.
		local
			s: STRING
			description: STRING
		do
			description := resource.description
			if description /= Void and then not description.is_empty then
				s := clone (description)
			else
				s := clone (resource.name)
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')
			wipe_out
			extend (s)
			extend (resource.value)
		end

invariant
	RESOURCE_LIST_ITEM_resource_exists: resource /= Void

end -- class RESOURCE_LIST_ITEM
