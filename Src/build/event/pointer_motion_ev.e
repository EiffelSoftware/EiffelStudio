
class POINTER_MOTION_EV 

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
			Result := - pointer_motion_ev_id
		end;

	make is
		do
			set_symbol (Pointer_motion_pixmap);
			set_label (Pointer_motion_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_pointer_motion_action (";	

end
