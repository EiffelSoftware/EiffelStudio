class BEHAVIOUR_BUTTON

inherit

	FORMAT_BUTTON

creation

	make

feature

	symbol: PIXMAP is
		once
			Result := Pixmaps.behavior_format_pixmap
		end

	form_number: INTEGER is
		do
			Result := Context_const.behavior_form_nbr
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.behaviour_label
		end;


end
