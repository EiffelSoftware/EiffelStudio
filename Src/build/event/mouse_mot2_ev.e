
class MOUSE_MOT2_EV 

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
			Result := - mouse_mot2_ev_id
		end;

	make is
		do
			set_symbol (Mouse_motion2_pixmap);
			set_label (Mouse_motion2_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_motion_action (2, ";	

end
