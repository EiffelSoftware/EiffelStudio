
class POINTER_MOTION_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.pointer_motion_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.pointer_motion_pixmap);
			set_label (Event_const.pointer_motion_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_pointer_motion_action (";	

end
