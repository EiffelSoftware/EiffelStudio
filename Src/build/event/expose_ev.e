
class EXPOSE_EV 

inherit

	EVENT
		redefine
			is_valid_for_context
		end;

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.expose_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.expose_pixmap);
			set_label (Event_const.expose_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_expose_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			dr_area: DR_AREA_C;
		do
			dr_area ?= a_context;
			Result := not (dr_area = Void)
		end;

end
