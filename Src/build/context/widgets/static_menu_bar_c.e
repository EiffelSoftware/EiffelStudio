indexing
	description: "Context that represents a static menu bar (EV_STATIC_MENU_BAR)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATIC_MENU_BAR_C

inherit
	MENU_HOLDER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.static_bar_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_WINDOW) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} 

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'.
		do
		end

feature {NONE} -- Callbacks

	add_gui_callbacks is
			-- Define the general behavior of the GUI object.
		do
		end

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current context may be dragged and
			-- dropped.
		do
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
		end

feature -- Status report

	shown: BOOLEAN is
		do
		end

feature -- Status setting

	show is
		do
		end

	hide is
		do
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Static_menu_bar")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_STATIC_MENU_BAR"
		end

	full_type_name: STRING is
		do
			Result := "Static menu bar"
		end

feature -- Implementation

	gui_object: EV_STATIC_MENU_BAR

end -- class STATIC_MENU_BAR_C

