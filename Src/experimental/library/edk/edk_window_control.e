note
	description: "Summary description for {EDK_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_WINDOW_CONTROL

inherit
	EDK_WINDOW


feature -- Event Handling

	parent_add: IMMUTABLE_STRING_8 once Result := "parent_add" end
		-- Passes sessions id of the new parent for `Current'
	parent_remove: IMMUTABLE_STRING_8 once Result := "parent_remove" end
		-- Passes session id of the parent `Current's is being removed from.

	parent_query: IMMUTABLE_STRING_8 once Result := "parent_remove" end
		-- Retrieve session id of parent

end
