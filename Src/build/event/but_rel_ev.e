
class BUT_REL_EV 

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
			Result := - Event_const.but_rel_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.button_release_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.button_release_label
		end;

	eiffel_text: STRING is "add_release_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_button: BUTTON_C
		do
			a_button ?= a_context;
			Result := not (a_button = Void)
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		local
			button_widget: BUTTON
		do
			button_widget ?= a_widget
			if button_widget /= Void then
				button_widget.add_release_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			button_widget: BUTTON
		do
			button_widget ?= a_widget
			if button_widget /= Void then
				button_widget.remove_release_action (a_command, Void)
			end
		end

end
