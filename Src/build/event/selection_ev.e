
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

	symbol: PIXMAP is
		do
			Result := Pixmaps.selection_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.selection_label
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
