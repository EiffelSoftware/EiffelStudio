class FONT_BUTTON

inherit

	FORMAT_BUTTON
        rename
            make as parent_make
		end

creation

	make

feature 

    make (a_parent: COMPOSITE; ed: like editor) is
        do
            parent_make (a_parent, ed)
        end

	selected_symbol: PIXMAP is
		once
			Result := Pixmaps.selected_font_pixmap
		end;

	symbol: PIXMAP is
		once
			Result := Pixmaps.font_pixmap
		end;

	form_number: INTEGER is
		do
			Result := Context_const.font_form_nbr
		end;

	create_focus_label is 
		do
			set_focus_string (Focus_labels.font_label)
		end;

end
