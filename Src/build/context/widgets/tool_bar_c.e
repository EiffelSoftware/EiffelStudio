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
			initialize_transport --, stored_node
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

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.toolbar_page.toolbar_type
		end

feature {NONE} -- Pick and drop

	initialize_transport is
		local
			routine_cmd: EV_ROUTINE_COMMAND
		do
			{PRIMITIVE_C} Precursor
--			create routine_cmd.make (~process_type)
--			gui_object.add_pnd_command (Pnd_types.type_data_type, routine_cmd, Void)
			create routine_cmd.make (~process_context)
			gui_object.add_pnd_command (Pnd_types.context_type, routine_cmd, Void)
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

