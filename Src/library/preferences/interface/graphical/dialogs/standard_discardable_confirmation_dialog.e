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
				confirmation_text: STRING; check_label: STRING; app_prefs: PREFERENCES) is
			-- Initialize `Current' based on these values.
			-- `res_name' is the name of the boolean preference corresponding
			-- to this dialog.
			-- See `buttons_count', `confirmation_message_label', `check_button_label'
			-- for information on the other parameters.
		require
			valid_preferences: app_prefs /= Void
			valid_button_count: button_count > 0 and button_count < 4
			valid_confirmation_text: confirmation_text /= Void
			valid_check_label: check_label /= Void
		do
			preferences := app_prefs
			buttons_count := button_count
			preference_name := res_name
			confirmation_message_label := confirmation_text
			check_button_label := check_label
			default_create
		ensure
			status_set: buttons_count = button_count and
						res_name.is_equal (preference_name) and
						confirmation_text.is_equal (confirmation_message_label) and
						check_label.is_equal (check_button_label)
		end

feature -- Access

	assume_ok: BOOLEAN is
			-- Should `OK' be assumed?
		local
			l_pref: BOOLEAN_PREFERENCE
		do
			l_pref ?= preferences.get_preference (preference_name)
			Result := l_pref /= Void and then not l_pref.value
		end

	buttons_count: INTEGER
			-- Number of buttons (OK, OK/Cancel, Yes/No/Cancel).

	check_button_label: STRING
			-- Label displayed next to the check box.

	confirmation_message_label: STRING
			-- Main explanatory label displayed in the dialog.

	preference_name: STRING
			-- Name of the preference relative to `Current' in the preferences.

feature -- Basic operations

	is_boolean_preference (s: STRING): BOOLEAN is
			-- Does `s' represent a boolean preference?
		require
			valid_string: s /= Void and not s.is_empty
		local
			r: BOOLEAN_PREFERENCE
		do
			r ?= preferences.get_preference (s)
			Result := r /= Void
		end

feature -- Inapplicable

feature {NONE} -- Implementation

	save_check_button_state (checked: BOOLEAN) is
			-- Update the preferences state.
		local
			l_pref: BOOLEAN_PREFERENCE
		do
			l_pref ?= preferences.get_preference (preference_name)
			if l_pref /= Void then
				l_pref.set_value (not checked)
			end
		end

invariant
	valid_attributes:
			preference_name /= Void and then
			is_boolean_preference (preference_name) and
			buttons_count > 0 and buttons_count < 4 and
			check_button_label /= Void and
			confirmation_message_label /= Void

end -- class STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
