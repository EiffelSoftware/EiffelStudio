
class MOUSE_MOT3_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse_mot3_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.mouse_motion3_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.mouse_motion3_label
		end;

	eiffel_text: STRING is "add_button_motion_action (3, ";	

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	the command represented by `a_cmd_instance' to 
			-- `a_context' according to the kind of event.
		do
			a_widget.add_button_motion_action (3, a_command, Void)
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		do
			a_widget.remove_button_motion_action (3, a_command, Void)
		end

end
