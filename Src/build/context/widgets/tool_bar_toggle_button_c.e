indexing
	description: "Context that represents a toolbar toggle button (EV_TOOL_BAR_TOGGLE_BUTTON)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_TOGGLE_BUTTON_C

inherit
	TOOL_BAR_BUTTON_C
		redefine
			symbol, type,
			namer, eiffel_type,
			full_type_name,
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
--			Result := Pixmaps.toolbar_toggle_pixmap
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.toolbar_page.toolbar_toggle_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Tool_bar_toggle_button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TOOL_BAR_TOGGLE_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Toolbar toggle button"
		end

feature --  Implementation

	gui_object: EV_TOOL_BAR_TOGGLE_BUTTON

-- feature -- Storage features
-- 
-- 	stored_node: S_TOOL_BAR_TOGGLE_BUTTON is
-- 		do
-- 			create Result.make (Current)
-- 		end

end -- class TOOL_BAR_TOGGLE_BUTTON_C

