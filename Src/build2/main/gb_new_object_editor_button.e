indexing
	description: "Objects that represent the new object tool button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NEW_OBJECT_EDITOR_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, is_equal, copy
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
			a_pixmap.set_with_named_file ("D:\EIffel50\bench\bitmaps\png\icon_object_symbol.png")
			set_pixmap (a_pixmap)
			select_actions.extend (agent new_object_editor_empty)
			drop_actions.extend (agent new_object_editor (?))
			drop_actions.set_veto_pebble_function (agent do_not_allow_object_type (?))
		end

feature {NONE} -- Implementation
	
	do_not_allow_object_type (transported_object: GB_OBJECT): BOOLEAN is
			do
					-- If the object is not void, it means that
					-- we are not currently picking a type.
				if transported_object.object /= Void then
					Result := True
				end
			end

end -- class GB_NEW_OBJECT_EDITOR_BUTTON