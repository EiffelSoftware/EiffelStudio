
class MOUSE_LEAVE_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_leave_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse_leave_pixmap);
			set_label (Event_const.mouse_leave_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_leave_action (";	

end
