indexing
	description: "Context that represents a multi column row (EV_MULTI_COLUMN_LIST_ROW)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_ROW_C

inherit
	CONTEXT
		redefine
			gui_object,
			create_context
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_page.multi_col_row_type
		end

feature -- Context creation

	create_context (a_parent: MULTI_COLUMN_LIST_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {CONTEXT} Precursor (a_parent)
			a_parent.append (Result)
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_MULTI_COLUMN_LIST) is
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
--			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		do
--			gui_object.set_parent (parent.gui_object)
		end

	hide is
		do
--			gui_object.set_parent (Void)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Multi_column_row")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_MULTI_COLUMN_LIST_ROW"
		end

	full_type_name: STRING is
		do
			Result := "Multi column list row"
		end

feature -- Implementation

	gui_object: EV_MULTI_COLUMN_LIST_ROW

end -- class MULTI_COLUMN_ROW_C

