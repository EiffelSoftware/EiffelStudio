indexing
	description: "Graphical representation of an XMI item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMI_PRESENTATION

inherit
	XMI_ITEM

feature -- Access

	item: XMI_ITEM
		-- XMI item of which `Current' is the graphical representation.

feature -- Action

	code: STRING is
			-- XMI representation of the presentation.
		deferred
		end

end -- class XMI_PRESENTATION
