
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
			a_list: SCROLLABLE_LIST_C;
		do
			a_list ?= a_context;
			Result := not (a_context = Void);
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		local
			scrollable_list_widget: SCROLLABLE_LIST
		do
			scrollable_list_widget ?= a_widget
			if scrollable_list_widget /= Void then
				scrollable_list_widget.add_selection_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			scrollable_list_widget: SCROLLABLE_LIST
		do
			scrollable_list_widget ?= a_widget
			if scrollable_list_widget /= Void then
				scrollable_list_widget.remove_selection_action (a_command, Void)
			end
		end

end
