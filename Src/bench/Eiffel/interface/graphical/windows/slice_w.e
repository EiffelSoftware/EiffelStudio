indexing

	description:	
		"Window to enter special object bounds for inspection.";
	date: "$Date$";
	revision: "$Revision$"

class SLICE_W 

inherit

	COMMAND_W;
	NAMER;
	ASCII
		rename
			star as ascii_star,
			dot as ascii_dot,
			plus as ascii_plus
		end;
	EB_FORM_DIALOG
		rename
			make as form_dialog_create
		end;
	WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_composite: COMPOSITE; cmd: SLICE_COMMAND) is
			-- Create a special object slice window.
		local
			button_form, bounds_form: FORM;
			ok_button, apply_button, cancel_button: PUSH_B;
			from_label, to_label: LABEL;
			sep: THREE_D_SEPARATOR
		do
			form_dialog_create (Interface_names.n_X_resource_name, a_composite);
			set_title (Interface_names.t_Slice_w);

			!!bounds_form.make (new_name, Current);
			bounds_form.set_fraction_base (4);
			attach_top (bounds_form, 10);
			attach_left (bounds_form, 10);
			attach_right (bounds_form, 10);

			!!sep.make (Interface_names.t_Empty, Current);
			!!from_label.make (new_name, bounds_form);
			from_label.set_text ("From: ");
			from_label.set_right_alignment;
			!!to_label.make (new_name, bounds_form);
			to_label.set_text ("To: ");
			to_label.set_right_alignment;
			!!from_field.make (new_name, bounds_form);
			from_field.set_width (40);
			from_field.set_height (26);
			!!to_field.make (new_name, bounds_form);
			to_field.set_width (40);
			to_field.set_height (26);

			bounds_form.attach_top (from_label, 0);
			bounds_form.attach_bottom (from_label, 0);
			bounds_form.attach_right_position (from_label, 1);
			bounds_form.attach_left (from_label, 0);

			bounds_form.attach_top (from_field, 0);
			bounds_form.attach_bottom (from_field, 1);
			bounds_form.attach_left_position (from_field, 1);
			bounds_form.attach_right_position (from_field, 2);

			bounds_form.attach_top (to_label, 0);
			bounds_form.attach_bottom (to_label, 0);
			bounds_form.attach_left_position (to_label, 2);
			bounds_form.attach_right_position (to_label, 3);

			bounds_form.attach_top (to_field, 0);
			bounds_form.attach_bottom (to_field, 1);
			bounds_form.attach_left_position (to_field, 3);
			bounds_form.attach_right (to_field, 0);

			attach_left (sep, 1);
			attach_right (sep, 1);
			attach_top_widget (bounds_form, sep, 5);

			!!button_form.make (new_name, Current);
			button_form.set_fraction_base (17);
			attach_left (button_form, 10);
			attach_bottom (button_form, 10);
			attach_right (button_form, 10);
			attach_bottom_widget (button_form, sep, 5);

			!!ok_button.make (Interface_names.b_Ok, button_form);
			!!apply_button.make (Interface_names.b_Apply, button_form);
			!!cancel_button.make (Interface_names.b_Cancel, button_form);
			button_form.attach_left (ok_button, 0);
			button_form.attach_top (ok_button, 0);
			button_form.attach_bottom (ok_button, 0);
			button_form.attach_right_position (ok_button, 5);
			button_form.attach_left_position (apply_button, 6);
			button_form.attach_top (apply_button, 0);
			button_form.attach_bottom (apply_button, 0);
			button_form.attach_right_position (apply_button, 11);
			button_form.attach_left_position (cancel_button, 12);
			button_form.attach_right (cancel_button, 0);
			button_form.attach_top (cancel_button, 0);
			button_form.attach_bottom (cancel_button, 0);

			ok_button.add_activate_action (Current, ok_it);
			apply_button.add_activate_action (Current, apply_it);
			cancel_button.add_activate_action (Current, cancel_it);
			associated_command := cmd;
			set_composite_attributes (Current);
			realize
		end;

feature -- Access
	
	call is
			-- Popup the slice window, with the capacity of the last
			-- special object displayed in that window if any.
		local
			sp_capacity: INTEGER
		do
			last_lower := associated_command.sp_lower;
			last_upper := associated_command.sp_upper;
			sp_capacity := associated_command.sp_capacity - 1;
			if sp_capacity < 0 then
					-- The associated text_window never displayed
					-- a special object.
				from_field.set_text ("");
				to_field.set_text ("")
			else
				from_field.set_text ("0");
				to_field.set_text (sp_capacity.out)
			end;
			display;
		end;

feature {NONE} -- Properties

	ok_it: ANY is
			-- Argument for the command
		once
			!!Result
		end;

	apply_it: ANY is
			-- Argument for the command
		once
			!!Result
		end;

	cancel_it: ANY is
			-- Argument for the command
		once
			!!Result
		end;

	associated_command: SLICE_COMMAND;

	from_field, to_field: TEXT_FIELD;

	last_lower, last_upper: INTEGER;

feature {NONE} -- Implementation

	work (argument: ANY) is
		local
			sp_lower, sp_upper: INTEGER;
			lower_string, upper_string: STRING
        do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = cancel_it then
				sp_lower := last_lower;
				sp_upper := last_upper
			else
				lower_string := clone (from_field.text);
				lower_string.left_adjust;
				lower_string.right_adjust;
				if lower_string.is_integer then
					sp_lower := lower_string.to_integer
				else
					sp_lower := -1
				end;	
				upper_string := clone (to_field.text);
				upper_string.left_adjust;
				upper_string.right_adjust;
				if upper_string.is_integer then
					sp_upper := upper_string.to_integer
				else
					sp_upper := -1
				end	
			end;
			if 
				sp_lower /= associated_command.sp_lower or
				sp_upper /= associated_command.sp_upper
			then
				associated_command.set_sp_bounds (sp_lower, sp_upper);
				associated_command.execute (Current)
			end;
			if argument /= apply_it then
				popdown
			end
		end;

invariant

	from_field_exists: from_field /= Void;
	to_field_exists: to_field /= Void

end -- class SLICE_W
