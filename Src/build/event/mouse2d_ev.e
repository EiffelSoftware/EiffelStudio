
class MOUSE2D_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2d_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse2d_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse2d_label
		end;

	eiffel_text: STRING is "add_button_press_action (2, ";

end
