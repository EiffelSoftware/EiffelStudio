
class KEY_RET_EV 

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
			Result := - Event_const.key_return_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.key_return_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.key_return_label
		end;

	eiffel_text: STRING is "set_action (%"<Key>Return%", ";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_tf: TEXT_FIELD_C;
		do
			a_tf ?= a_context;
			Result := not (a_tf = Void);
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		local
			text_field_widget: TEXT_FIELD
		do
			text_field_widget ?= a_widget
			if text_field_widget /= Void then
				text_field_widget.set_action ("<Key>Return", a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			text_field_widget: TEXT_FIELD
		do
			text_field_widget ?= a_widget
			if text_field_widget /= Void then
				text_field_widget.remove_action ("<Key>Return")
			end
		end

end
