
class TEXT_MODIFIED_EV 

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
			Result := - Event_const.text_modified_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.scr_t_modify_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.scr_t_modify_label
		end;

	eiffel_text: STRING is "add_modify_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			text: TEXT_C
		do
			text ?= a_context;
			Result := not (text = Void)
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	the command represented by `a_cmd_instance' to 
			-- `a_context' according to the kind of event.
		local
			text_widget: TEXT
		do
			text_widget ?= a_widget
			if text_widget /= Void then
				text_widget.add_modify_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			text_widget: TEXT
		do
			text_widget ?= a_widget
			if text_widget /= Void then
				text_widget.remove_modify_action (a_command, Void)
			end
		end

end
