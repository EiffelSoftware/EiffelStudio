
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

	make is
		do
			set_symbol (Pixmaps.mouse_motion1_pixmap);
			set_label (Event_const.mouse_motion1_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_motion_action (1, ";	

end
