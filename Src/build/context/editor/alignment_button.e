class ALIGNMENT_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := Pixmaps.alignment_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.alignment_form_nbr
		end;

	focus_string: STRING is "";

end
