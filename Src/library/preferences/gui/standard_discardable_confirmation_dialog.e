indexing
	description: "Standard discardable dialog for EiffelStudio.%
			%Same functionalities as a discardable dialog, %
			%but not deferred to avoid having too many classes."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	STANDARD_DISCARDABLE_CONFIRMATION_DIALOG

inherit
	DISCARDABLE_CONFIRMATION_DIALOG

create
	make_initialized

feature {NONE} -- Initialization

	make_initialized (button_count: INTEGER; res_name: STRING;
				confirmation_text: STRING; check_label: STRING) is
			-- Initialize `Current' based on these values.
			-- `res_name' is the name of the boolean resource corresponding
			-- to this dialog.
			-- See `buttons_count', `confirmation_message_label', `check_button_label'
			-- for information on the other parameters.
		require
			valid_button_count: button_count > 0 and button_count < 4
			valid_preference: is_boolean_resource (res_name)
			valid_confirmation_text: confirmation_text /= Void
			valid_check_label: check_label /= Void
		do
			buttons_count := button_count
			resource_name := res_name
			confirmation_message_label := confirmation_text
			check_button_label := check_label
			default_create
		ensure
			status_set: buttons_count = button_count and
						res_name.is_equal (resource_name) and
						confirmation_text.is_equal (confirmation_message_label) and
						check_label.is_equal (check_button_label)
		end

feature -- Access

	assume_ok: BOOLEAN is
			-- Should `OK' be assumed?
		do
			Result := not boolean_resource_value (resource_name, True)
		ensure then
			in_sync_with_preferences: Result = not boolean_resource_value (resource_name, True)
		end

	buttons_count: INTEGER
			-- Number of buttons (OK, OK/Cancel, Yes/No/Cancel).

	check_button_label: STRING
			-- Label displayed next to the check box.

	confirmation_message_label: STRING
			-- Main explanatory label displayed in the dialog.

	resource_name: STRING
			-- Name of the resource relative to `Current' in the preferences.

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	is_boolean_resource (s: STRING): BOOLEAN is
			-- Does `s' represent a boolean resource?
		require
			valid_string: s /= Void and not s.is_empty
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			Result := r /= Void
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	save_check_button_state (checked: BOOLEAN) is
			-- Update the preferences state.
		do
			set_boolean_resource (resource_name, not checked)
		end

invariant
	valid_attributes:
			resource_name /= Void and then
			is_boolean_resource (resource_name) and
			buttons_count > 0 and buttons_count < 4 and
			check_button_label /= Void and
			confirmation_message_label /= Void

end -- class STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
