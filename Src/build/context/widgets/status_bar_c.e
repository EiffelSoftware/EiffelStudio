indexing
	description: "Context that represents a status bar (EV_STATUS_BAR)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	STATUS_BAR_C

inherit
	CONTEXT
		redefine
			gui_object,
			create_context
		end

	HOLDER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.menu_page.status_bar_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.window_child_type
		end

feature -- Context creation

	create_context (par: MENU_ITEM_HOLDER_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {CONTEXT} Precursor (par)
			par.append (Result)
		end

feature -- GUI object creation

	create_gui_object (par: EV_WINDOW) is
		do
			create gui_object.make (par)
		end

feature {NONE} 

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'.
		do
		end

feature -- Status report

	shown: BOOLEAN is
		do
			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			win: WINDOW_C
		do
			win ?= parent
			gui_object.set_parent (win.gui_object)
		end

	hide is
		do
			gui_object.set_parent (Void)
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.status_bar_item_type, rcmd, Void)
			tree_element.add_pnd_command (Pnd_types.status_bar_item_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			gui_object.remove_pnd_commands (Pnd_types.status_bar_item_type)
			tree_element.remove_pnd_commands (Pnd_types.status_bar_item_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature {NONE} -- Callbacks

	add_gui_callbacks is
			-- Define the general behavior of the GUI object.
		do
			add_pnd_callbacks
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
			remove_pnd_callbacks
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Status_bar")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_STATUS_BAR"
		end

	full_type_name: STRING is
		do
			Result := "Status bar"
		end

feature -- Implementation

	gui_object: EV_STATUS_BAR

end -- class STATUS_BAR_C

