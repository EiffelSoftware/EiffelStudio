
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

	make is
		do
			set_symbol (Pixmaps.mouse_motion3_pixmap);
			set_label (Event_const.mouse_motion3_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_motion_action (3, ";	

end
