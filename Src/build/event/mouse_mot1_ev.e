
class MOUSE_MOT1_EV 

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
			Result := - mouse_mot1_ev_id
		end;

	make is
		do
			set_symbol (Mouse_motion1_pixmap);
			set_label (Mouse_motion1_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_motion_action (1, ";	

end
