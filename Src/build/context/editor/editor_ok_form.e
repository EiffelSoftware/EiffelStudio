
deferred class EDITOR_OK_FORM 

inherit

	EDITOR_FORM



	
feature {NONE}

	separator: SEPARATOR_G;

	create_ok_button is
		local
			ok_button: PUSH_BG;
		do
			!!ok_button.make (O_k_button, Current);
			ok_button.add_activate_action (command, editor);
			!!separator.make (S_eparator, Current);
			separator.set_single_line;
			separator.set_horizontal (true);

			set_fraction_base (16);
			attach_left (ok_button, 10);
			attach_right_position (ok_button, 7);
			attach_left (separator, 10);
			attach_right (separator, 10);
			attach_bottom (ok_button, 10);
			attach_bottom_widget (ok_button, separator, 5);
			detach_top (ok_button);
		end;

	command: CONTEXT_CMD is
			-- Command to execute to update the context
		deferred
		end;

end
