
class KEY_RELEASE_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.key_release_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.key_release_pixmap);
			set_label (Event_const.key_release_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_key_release_action (";	

end
