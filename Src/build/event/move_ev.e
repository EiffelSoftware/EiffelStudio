
class MOVE_EV 

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
			Result := - Event_const.move_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.move_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.move_label
		end;

	eiffel_text: STRING is "add_move_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			scale: SCALE_C
		do
			scale ?= a_context;
			Result := not (scale = Void)
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	the command represented by `a_cmd_instance' to 
			-- `a_context' according to the kind of event.
		local
			scale_widget: SCALE
		do
			scale_widget ?= a_widget
			if scale_widget /= Void then
				scale_widget.add_move_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			scale_widget: SCALE
		do
			scale_widget ?= a_widget
			if scale_widget /= Void then
				scale_widget.remove_move_action (a_command, Void)
			end
		end

end
