
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

	make is
		do
			set_symbol (Pixmaps.mouse_motion2_pixmap);
			set_label (Event_const.mouse_motion2_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_motion_action (2, ";	

end
