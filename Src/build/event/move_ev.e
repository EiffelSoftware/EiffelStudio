
class MOVE_EV 

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
			Result := - move_ev_id
		end;

	make is
		do
			set_symbol (Move_pixmap);
			set_label (Move_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_move_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			scale: SCALE_C
		do
			scale ?= a_context;
			Result := not (scale = Void)
		end;

end
