class SUBMENU_BUTTON

inherit

	FORMAT_BUTTON
        rename
            make as parent_make
		redefine
			set_form_number,
			valid_form_nbr
		end

creation

	make

feature 

    make (a_parent: COMPOSITE; ed: like editor) is
        do
            parent_make (a_parent, ed)
        end

	form_number: INTEGER;

	selected_symbol: PIXMAP is
		once
			Result := Pixmaps.selected_submenu_pixmap
		end

	symbol: PIXMAP is
		once
			Result := Pixmaps.submenu_pixmap
		end

	create_focus_label is 
		do
			set_focus_string (Focus_labels.command_type_label)
		end;

	set_form_number (nbr: INTEGER) is
		do
			form_number := nbr
		end;

	valid_form_nbr (nbr: INTEGER): BOOLEAN is
		do
			Result := 
				nbr = Context_const.pulldown_sm_form_nbr or else
				nbr = Context_const.menu_sm_form_nbr or else
				nbr = Context_const.bar_sm_form_nbr
		end;

end
