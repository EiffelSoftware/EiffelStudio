class SUBMENU_BUTTON

inherit

	FORMAT_BUTTON
		redefine
			set_form_number,
			valid_form_nbr
		end

creation

	make

feature 

	form_number: INTEGER;

	symbol: PIXMAP is
		once
			Result := Pixmaps.submenu_pixmap
		end

	focus_string: STRING is "";

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
