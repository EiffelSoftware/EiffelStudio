indexing
	description: "Information on an item of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMI_ITEM

feature -- Access

	xmi_id: INTEGER
			-- Number which identifies current item in the XMI description.

feature -- Action
		
	code: STRING is
			-- XMI representation of the item.
		deferred
		end

end -- class XMI_ITEM
