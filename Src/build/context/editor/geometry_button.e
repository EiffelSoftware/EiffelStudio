class GEOMETRY_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := Pixmaps.geometry_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	focus_string: STRING is "";

end
