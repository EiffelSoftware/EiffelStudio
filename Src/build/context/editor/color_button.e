class COLOR_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := Pixmaps.color_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.color_label
		end;

end
