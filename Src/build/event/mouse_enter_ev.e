
class MOUSE_ENTER_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_enter_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_Enter_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_enter_label
		end;

	eiffel_text: STRING is "add_enter_action (";	

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	the command represented by `a_cmd_instance' to 
			-- `a_context' according to the kind of event.
		do
			a_widget.add_enter_action (a_command, Void)
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		do
			a_widget.remove_enter_action (a_command, Void)
		end

end
