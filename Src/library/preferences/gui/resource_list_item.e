indexing
	description: "List item associated to a resource."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_LIST_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

create
	make_resource

feature {NONE} -- Initialization

	make_resource (res: RESOURCE) is
			-- Creation
		require
			resource_exists: res /= Void
		local
			s: STRING
			description: STRING
			l_array_res: ARRAY_RESOURCE
		do
			resource := res
			description := res.description
			if description /= Void and then not description.is_empty then
				s := description.twin
			else
				s := res.name.twin
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')	
			default_create
				-- Here we add the string values to the list columns.
			extend (s)
			l_array_res ?= resource
			if l_array_res /= Void and then l_array_res.selected_value /= Void then
				extend (l_array_res.selected_value.twin)
			else
				extend (resource.value)
			end
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
