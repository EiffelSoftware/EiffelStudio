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
            set_focus_string (Focus_labels.font_label)
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

-- samik	focus_string: STRING is 
-- samik		do
-- samik			Result := Focus_labels.font_label
-- samik		end;

end
