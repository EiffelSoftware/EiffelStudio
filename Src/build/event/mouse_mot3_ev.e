
class MOUSE_MOT3_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_mot3_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_motion3_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_motion3_label
		end;

	eiffel_text: STRING is "add_button_motion_action (3, ";	

end
