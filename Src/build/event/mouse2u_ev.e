
class MOUSE2U_EV 

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
			Result := - mouse2u_ev_id
		end;

	make is
		do
			set_symbol (Mouse2u_pixmap);
			set_label (Mouse2u_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_release_action (2, ";

end
