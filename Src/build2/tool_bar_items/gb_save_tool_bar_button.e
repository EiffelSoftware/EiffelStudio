indexing
	description: "Objects that represent the save button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SAVE_TOOL_BAR_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_XML_HANDLER
		undefine
			copy, default_create, is_equal
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set pixmap and connect agents.
		local
			a_pixmap: EV_PIXMAP
		do
			Precursor {EV_TOOL_BAR_BUTTON}
			create a_pixmap
			a_pixmap.set_with_named_file ("D:\EIffel50\bench\bitmaps\png\icon_save_color.png")
			set_pixmap (a_pixmap)
			select_actions.extend (agent save_object)
		end

feature {NONE} -- Implementation

	save_object is
			-- Save representation of window to XML.
		local
			node: XML_NODE
		do
			--| FIXME need to add a file save dialog box, and get
			--| the location for the save.
			xml_handler.save
		end

end -- class GB_SAVE_TOOL_BAR_BUTTON
