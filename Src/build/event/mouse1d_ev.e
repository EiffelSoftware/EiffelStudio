
class MOUSE1D_EV 

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
			Result := - mouse1d_ev_id
		end;

	make is
		do
			set_symbol (Mouse1d_pixmap);
			set_label (Mouse1d_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_press_action (1, ";	

end
