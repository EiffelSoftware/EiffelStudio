
class MOUSE_MOT1_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_mot1_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_motion1_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_motion1_label
		end;

	eiffel_text: STRING is "add_button_motion_action (1, ";	

end
