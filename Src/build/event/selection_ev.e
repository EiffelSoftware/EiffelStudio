
class SELECTION_EV 

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
			Result := - selection_ev_id
		end;

	make is
		do
			set_symbol (Selection_pixmap);
			set_label (Selection_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_selection_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_list: SCROLL_LIST_C;
		do
			a_list ?= a_context;
			Result := not (a_context = Void);
		end;

end
