indexing
	description: "Objects that provide access to an attribute editor for EV_BOX objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_BOX
	
inherit
	GB_EV_BOX_EDITOR_CONSTRUCTOR
	
	GB_COMMON_EDITOR
	
feature {NONE} -- Implementation

	update_object_expansion (is_expanded: BOOLEAN; index: INTEGER) is
			-- Modify expanded state of `index' child of `object', based on
			-- `is_expanded'.
		do
			-- Nothing to perform here, as this is unly used in EiffelBuild.
		end

end -- class GB_EV_BOX

