
class KEY_RELEASE_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.key_release_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.key_release_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.key_release_label
		end;

	eiffel_text: STRING is "add_key_release_action (";	

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		do
			a_widget.add_key_release_action (a_command, Void)
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		do
			a_widget.remove_key_release_action (a_command, Void)
		end

end
