indexing
	description: "Context that represents a combo box (EV_COMBO_BOX)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_BOX_C

inherit
	TEXT_FIELD_C
		undefine
			add_pnd_callbacks,
			remove_pnd_callbacks
		redefine
			gui_object,
			symbol, type,
			namer, eiffel_type, full_type_name,
			reset_modified_flags
		end

	LIST_C
		undefine
			create_gui_object,
			initialize_transport
		redefine
			gui_object,
			symbol, type,
			namer, eiffel_type, full_type_name,
			reset_modified_flags
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.text_page.combo_box_type
		end

feature -- Status setting

	reset_modified_flags is
		do
			{TEXT_FIELD_C} Precursor
			{LIST_C} Precursor
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Combo_box")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_COMBO_BOX"

	full_type_name: STRING is "Combo box"


feature -- Implementation

	gui_object: EV_COMBO_BOX

end -- class COMBO_BOX_C

