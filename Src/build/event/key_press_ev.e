
class KEY_PRESS_EV 

inherit

	EV_IDENTIFIERS
		export
			{NONE} all
		end;

	EVENT
		;

	EV_PIXMAPS
		export
			{NONE} all
		end;

	EVENT_LABELS
		export
			{NONE} all
		end


creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - key_press_ev_id
		end;

	make is
		do
			set_symbol (Key_press_pixmap);
			set_label (Key_press_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_key_press_action (";	

end
