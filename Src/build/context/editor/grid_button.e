class GRID_BUTTON

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
            set_focus_string (Focus_labels.show_window_label)
        end

	symbol: PIXMAP is
		once
			Result := Pixmaps.grid_pixmap
		end

	selected_symbol: PIXMAP is
		once
			Result := Pixmaps.selected_grid_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.grid_form_nbr
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.grid_label
-- samik		end;

end
