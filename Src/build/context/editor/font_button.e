class FONT_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

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

	focus_string: STRING is 
		do
			Result := Focus_labels.font_label
		end;

end
