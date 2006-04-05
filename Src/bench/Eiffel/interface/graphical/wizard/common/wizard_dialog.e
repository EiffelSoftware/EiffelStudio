indexing

	description:
		"Dialog used to display the for a wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class WIZARD_DIALOG

inherit
	FORM_D
		redefine
			set_default
		end
create
	make

feature -- Graphical User Interface

	set_default is
		local	
			sep: THREE_D_SEPARATOR
		do
			set_width (300);
			create action_form.make ("action_form", Current);
			create sep.make ("", Current);
			sep.set_horizontal (True);
			create button_form.make ("button_form", Current);

			button_form.set_fraction_base (3);

			attach_left (sep, 2);
			attach_right (sep, 2);

			attach_bottom (button_form, 0);
			attach_left (button_form, 0);
			attach_right (button_form, 0);
			
			attach_top (action_form, 0);
			attach_left (action_form, 0);
			attach_right (action_form, 0);

			attach_bottom_widget (sep, action_form, 5);
			attach_bottom_widget (button_form, sep, 5);

			create previous_button.make ("Previous", button_form);
			create abort_button.make ("Cancel", button_form);
			create next_button.make ("Next", button_form);
			previous_button.set_insensitive;
			next_button.set_insensitive;

			button_form.attach_left (previous_button, 1);
			button_form.attach_left (next_button, 1);
			button_form.attach_right_position (previous_button, 1);
			button_form.attach_right_position (next_button, 1)
			button_form.attach_right (next_button, 1);
			button_form.attach_right (abort_button, 1);
			button_form.attach_left_position (next_button, 2);
			button_form.attach_left_position (abort_button, 2);
			button_form.attach_left_position (abort_button, 1);
			button_form.attach_right_position (abort_button, 2);

			button_form.attach_bottom (previous_button, 5);
			button_form.attach_bottom (abort_button, 5);
			button_form.attach_bottom (next_button, 5)
		end;

feature -- Settings

	set_next_label (s: STRING) is
			-- Change label of `next_button' to `s'.
		require
			non_void_text: s /= Void
		do
			next_button.set_text (s)
		ensure
			text_set: equal (next_button.text, s)
		end;

	set_abort_label (s: STRING) is
			-- Change label of `abort_button' to `s'.
		require
			non_void_text: s /= Void
		do
			abort_button.set_text (s)
		ensure
			text_set: equal (abort_button.text, s)
		end;

	set_previous_label (s: STRING) is
			-- Change label of `previous_button' to `s'.
		require
			non_void_text: s /= Void
		do
			previous_button.set_text (s)
		ensure
			text_set: equal (previous_button.text, s)
		end;

feature -- Sensitivity

	set_next_sensitive is
			-- Set `next_button' sensitive.
		do
			next_button.set_sensitive
		end;

	set_next_insensitive is
			-- Set `next_button' insensitive.
		do
			next_button.set_insensitive
		end;

	set_abort_sensitive is
			-- Set `abort_button' sensitive.
		do
			abort_button.set_sensitive
		end;

	set_abort_insensitive is
			-- Set `abort_button' insensitive.
		do
			abort_button.set_insensitive
		end;

	set_previous_sensitive is
			-- Set `previous_button' sensitive.
		do
			previous_button.set_sensitive
		end;

	set_previous_insensitive is
			-- Set `previous_button' insensitive.
		do
			previous_button.set_insensitive
		end;

feature -- Forms

	button_form: FORM;
			-- Form at the bottom of the dialog to display buttons.

	action_form: FORM;
			-- Form at the top of the dialog to display
			-- action specific stuff.	

	global_form: FORM;
			-- Form to display all other forms.

feature {WIZARD} -- Buttons

	previous_button: PUSH_B;
			-- Button to go to previous step.

	abort_button: PUSH_B;
			-- Button to Abort the Wizard;

	next_button: PUSH_B;
			-- Button to go to next step.

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

end -- class WIZARD_DIALOG
