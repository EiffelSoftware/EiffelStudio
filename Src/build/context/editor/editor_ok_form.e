
deferred class EDITOR_OK_FORM 

inherit

	EDITOR_FORM

feature {NONE}

	separator: SEPARATOR;

	create_ok_button is
		local
			ok_button: PUSH_B;
		do
			!!ok_button.make (Widget_names.ok_button_name, Current);
			ok_button.add_activate_action (command, editor);
			!!separator.make (Widget_names.separator, Current);
			separator.set_horizontal (true);

			set_fraction_base (16);
			attach_left (ok_button, 10);
			attach_right_position (ok_button, 7);
			attach_left (separator, 0);
			attach_right (separator, 0);
			attach_bottom (ok_button, 10);
			attach_bottom_widget (ok_button, separator, 5);
			detach_top (ok_button);
		end;

	command: CONTEXT_CMD is
			-- Command to execute to update the context
		deferred
		end;

end
