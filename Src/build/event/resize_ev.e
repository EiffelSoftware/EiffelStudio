
class RESIZE_EV 

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
			Result := - resize_ev_id
		end;

	make is
		do
			set_symbol (Resize_pixmap);
			set_label (Resize_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_resize_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			dr_area: DR_AREA_C;
		do
			dr_area ?= a_context;
			Result := not (dr_area = Void)
		end;

end
