
class MOUSE_ENTER_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_enter_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse_Enter_pixmap);
			set_label (Event_const.mouse_Enter_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_enter_action (";	

end
