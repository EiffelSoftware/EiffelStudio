
class BUT_REL_EV 

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
			Result := - but_rel_ev_id
		end;

	make is
		do
			set_symbol (Button_release_pixmap);
			set_label (Button_release_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_release_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_button: BUTTON_C
		do
			a_button ?= a_context;
			Result := not (a_button = Void)
		end;

end
