
class TEXT_MOTION_EV 

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
			Result := - Event_const.text_motion_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.scr_t_motion_pixmap);
			set_label (Event_const.scr_t_motion_label);
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
