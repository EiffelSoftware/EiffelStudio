class GRID_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := Pixmaps.grid_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.grid_form_nbr
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.grid_label
		end;

end
