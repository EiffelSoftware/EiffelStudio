
class KEY_PRESS_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.key_press_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.key_press_pixmap);
			set_label (Event_const.key_press_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_key_press_action (";	

end
