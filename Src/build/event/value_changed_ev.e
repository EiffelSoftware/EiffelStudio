
class VALUE_CHANGED_EV 

inherit

	EVENT
		redefine
			is_valid_for_context
		end

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.value_changed_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.value_changed_pixmap);
			set_label (Event_const.value_changed_label);
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
