indexing
	description: "Context that represents a toolbar separator (EV_TOOL_BAR_SEPARATOR)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_SEPARATOR_C

inherit
	SEPARATOR_ITEM_C
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
			Result := context_catalog.toolbar_page.toolbar_separator_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.toolbar_item_type
		end

feature -- Context creation

	create_context (a_parent: TOOL_BAR_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {SEPARATOR_ITEM_C} Precursor (a_parent)
			a_parent.append (Result)
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_TOOL_BAR) is
		do
			create gui_object.make (a_parent)
		end

feature -- Status report

	shown: BOOLEAN is
		do
			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			a_list: LIST_C
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
			create Result.make ("Tool_bar_separator")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_TOOL_BAR_SEPARATOR"

	full_type_name: STRING is "Toolbar separator"

feature -- Implementation

	gui_object: EV_TOOL_BAR_SEPARATOR

end -- class TOOL_BAR_SEPARATOR_C

