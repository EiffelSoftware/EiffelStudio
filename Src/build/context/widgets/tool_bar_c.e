indexing
	description: "Context that represents a toolbar (EV_TOOL_BAR)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_C

inherit
	PRIMITIVE_C
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks
		end

	HOLDER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
--			Result := Pixmaps.toolbar_pixmap
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.toolbar_page.toolbar_type
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.toolbar_item_type, rcmd, Void)
			tree_element.add_pnd_command (Pnd_types.toolbar_item_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			gui_object.remove_pnd_commands (Pnd_types.toolbar_item_type)
			tree_element.remove_pnd_commands (Pnd_types.toolbar_item_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature -- GUI object creation

	create_gui_object (par: EV_CONTAINER) is
		do
			create gui_object.make (par)
		end

feature -- Default event

-- 	default_event: MOUSE_ENTER_EV is
-- 		do
-- 			Result := mouse_enter_ev
-- 		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Tool_bar")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_TOOL_BAR"

	full_type_name: STRING is "Toolbar"

feature --  Implementation

	gui_object: EV_TOOL_BAR

-- feature -- Storage features
-- 
-- 	stored_node: S_TOOLBAR is
-- 		do
-- 			create Result.make (Current)
-- 		end

end -- class TOOL_BAR_C

