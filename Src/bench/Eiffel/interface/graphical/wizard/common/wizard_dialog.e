indexing

	description:
		"Dialog used to display the for a wizard.";
	date: "$Date$";
	revision: "$Revision$"

class WIZARD_DIALOG

inherit
	FORM_D
		redefine
			set_default
		end
creation
	make

feature -- Graphical User Interface

	set_default is
		local	
			sep: THREE_D_SEPARATOR
		do
			set_width (300);
			!! action_form.make ("action_form", Current);
			!! sep.make ("", Current);
			sep.set_horizontal (True);
			!! button_form.make ("button_form", Current);

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

			!! previous_button.make ("Previous", button_form);
			!! abort_button.make ("Cancel", button_form);
			!! next_button.make ("Next", button_form);
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

end -- class WIZARD_DIALOG
