
class SELECTION_EV 

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
			Result := - Event_const.selection_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.selection_pixmap);
			set_label (Event_const.selection_label);
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
