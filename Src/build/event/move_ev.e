
class MOVE_EV 

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
			Result := - Event_const.move_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.move_pixmap);
			set_label (Event_const.move_label);
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
