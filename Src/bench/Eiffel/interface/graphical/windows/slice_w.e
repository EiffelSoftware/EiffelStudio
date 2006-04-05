indexing

	description:	
		"Window to enter special object bounds for inspection."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	SHARED_PLATFORM_CONSTANTS

create

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

			create bounds_form.make (new_name, Current);
			bounds_form.set_fraction_base (4);
			attach_top (bounds_form, 5);
			attach_left (bounds_form, 5);
			attach_right (bounds_form, 5);

			create sep.make (Interface_names.t_Empty, Current);
			create from_label.make (new_name, bounds_form);
			from_label.set_text ("From: ");
			from_label.set_right_alignment;
			create to_label.make (new_name, bounds_form);
			to_label.set_text ("To: ");
			to_label.set_right_alignment;
			create from_field.make (new_name, bounds_form);
			from_field.set_width (50);
			create to_field.make (new_name, bounds_form);
			to_field.set_width (50);

			if Platform_constants.is_windows then
				bounds_form.set_height (24)	
			end

			bounds_form.attach_top (from_label, 0);
			bounds_form.attach_right_position (from_label, 1);
			bounds_form.attach_left (from_label, 0);

			bounds_form.attach_top (from_field, 0);
			bounds_form.attach_left_position (from_field, 1);
			bounds_form.attach_right_position (from_field, 2);

			bounds_form.attach_top (to_label, 0);
			bounds_form.attach_left_position (to_label, 2);
			bounds_form.attach_right_position (to_label, 3);

			bounds_form.attach_top (to_field, 0);
			bounds_form.attach_left_position (to_field, 3);
			bounds_form.attach_right (to_field, 0);

			attach_left (sep, 1);
			attach_right (sep, 1);
			attach_bottom_widget (sep, bounds_form, 0);

			create button_form.make (new_name, Current);
			button_form.set_fraction_base (17);
			attach_left (button_form, 5);
			attach_bottom (button_form, 5);
			attach_right (button_form, 5);
			attach_bottom_widget (button_form, sep, 5);

			create ok_button.make (Interface_names.b_Ok, button_form);
			create apply_button.make (Interface_names.b_Apply, button_form);
			create cancel_button.make (Interface_names.b_Cancel, button_form);
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
			create Result
		end;

	apply_it: ANY is
			-- Argument for the command
		once
			create Result
		end;

	cancel_it: ANY is
			-- Argument for the command
		once
			create Result
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SLICE_W
