
class VALUE_CHANGED_EV 

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
			Result := - value_changed_ev_id
		end;

	make is
		do
			set_symbol (Value_changed_pixmap);
			set_label (Value_changed_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_value_changed_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			toggle: TOGGLE_B_C;
			scale: SCALE_C;
		do
			toggle ?= a_context;
			scale ?= a_context;
			Result := (not (scale = Void)) or (not (toggle = Void))
		end;

end
