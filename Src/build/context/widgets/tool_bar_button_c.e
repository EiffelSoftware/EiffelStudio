indexing
	description: "Context that represents a toolbar button (EV_TOOL_BAR_BUTTON)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_BUTTON_C

inherit
	SIMPLE_ITEM_C
		redefine
			gui_object,
			create_context
--			stored_node
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
--			Result := Pixmaps.toolbar_button_pixmap
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.toolbar_page.toolbar_button_type
		end

feature -- Context creation

	create_context (par: TOOL_BAR_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {SIMPLE_ITEM_C} Precursor (par)
			par.append (Result)
		end

feature -- GUI object creation

	create_gui_object (par: EV_TOOL_BAR) is
		do
			create gui_object.make (par)
		end

feature -- Default event

-- 	default_event: MOUSE_ENTER_EV is
-- 		do
-- 			Result := mouse_enter_ev
-- 		end

feature -- Status report

	shown: BOOLEAN is
		do
			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			a_list: TOOL_BAR_C
		do
			a_list ?= parent
			gui_object.set_parent (a_list.gui_object)
		end

	hide is
		do
			gui_object.set_parent (Void)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Tool_bar_button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TOOL_BAR_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Toolbar button"
		end

feature --  Implementation

	gui_object: EV_TOOL_BAR_BUTTON

-- feature -- Storage features
-- 
-- 	stored_node: S_TOOL_BAR_BUTTON is
-- 		do
-- 			create Result.make (Current)
-- 		end

end -- class TOOL_BAR_BUTTON_C

