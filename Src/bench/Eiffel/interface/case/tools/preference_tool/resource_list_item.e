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

	make_resource(par: EV_MULTI_COLUMN_LIST; res: XML_RESOURCE) is
		-- Creation
		require
			parent_exists: par /= Void
			resource_exists: res /= Void
		local
			s: STRING
		do
			s := clone(res.value.name)
			s.replace_substring_all("_"," ")
			make_with_text(par, <<s, res.value.value>>)	
			resource := res
		ensure
			resource_consistent: resource = res
		end

feature -- Implenentation

	resource: XML_RESOURCE
		-- Resource

invariant
	RESOURCE_LIST_ITEM_resource_exists: resource /= Void
end -- class RESOURCE_LIST_ITEM
