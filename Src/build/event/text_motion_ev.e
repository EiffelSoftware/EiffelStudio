
class TEXT_MOTION_EV 

inherit

	EV_IDENTIFIERS
		export
			{NONE} all
		end;

	EVENT
		redefine
			is_valid_for_context
		
		end;

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
			Result := - text_motion_ev_id
		end;

	make is
		do
			set_symbol (Scr_t_motion_pixmap);
			set_label (Scr_t_motion_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_motion_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			text: TEXT_C
		do	
			text ?= a_context;
			Result := not (text = Void);
		end;

end
