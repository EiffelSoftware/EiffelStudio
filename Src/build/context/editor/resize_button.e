class RESIZE_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := Pixmaps.resize_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.bulletin_resize_form_nbr
		end;

	focus_string: STRING is	
		do
			Result := Focus_labels.resize_policy_label
		end; 

end
