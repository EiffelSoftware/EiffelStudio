class ATTRIBUTE_BUTTON

inherit
	FORMAT_BUTTON

creation

	make

feature 

	symb_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("attrib.symb")
		end

	make (owner: ROW_COLUMN editor: CONTEXT_EDITOR) is
		do
			owner_form := owner
			owner_editor := editor
			this_form := perm_wind_form_number
			make_visible (owner)
		end
end
