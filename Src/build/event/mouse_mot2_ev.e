
class MOUSE_MOT2_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_mot2_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_motion2_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_motion2_label
		end;

	eiffel_text: STRING is "add_button_motion_action (2, ";	

end
