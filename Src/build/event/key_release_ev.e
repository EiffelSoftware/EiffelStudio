
class KEY_RELEASE_EV 

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
			Result := - key_release_ev_id
		end;

	make is
		do
			set_symbol (Key_release_pixmap);
			set_label (Key_release_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_key_release_action (";	

end
