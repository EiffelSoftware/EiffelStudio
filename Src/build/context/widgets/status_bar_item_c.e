indexing
	description: "Context that represents a status bar item (EV_STATUS_BAR_ITEM)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	STATUS_BAR_ITEM_C

inherit
	SIMPLE_ITEM_C
		redefine
			gui_object,
			create_context
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.menu_page.status_bar_item_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.status_bar_item_type
		end

feature -- Context creation

	create_context (par: STATUS_BAR_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {SIMPLE_ITEM_C} Precursor (par)
			par.append (Result)
		end

feature -- GUI object creation

	create_gui_object (par: EV_STATUS_BAR) is
		do
			create gui_object.make (par)
		end

feature -- Status report

	shown: BOOLEAN is
		do
			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			a_list: STATUS_BAR_C
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
			create Result.make ("Status_bar_item")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_STATUS_BAR_ITEM"

	full_type_name: STRING is "Status bar item"

feature -- Implementation

	gui_object: EV_STATUS_BAR_ITEM

end -- class STATUS_BAR_ITEM_C

