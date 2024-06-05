note
	description: "[
			Default widget for viewing and editing key shortcut preferences.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHORTCUT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			set_preference,
			change_item_widget,
			update_changes,
			refresh
		end

	PREFERENCE_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make_with_preference

feature -- Access

	preference: SHORTCUT_PREFERENCE
			-- Actual preference associated to the widget.	

	change_item_widget: SHORTCUT_PREFERENCE_GRID_EDITABLE_ITEM
			-- Widget to change the value of this preference.

	graphical_type: STRING
			-- Graphical type identifier
		do
			Result := "TEXT"
		end

feature -- Status Setting

	set_preference (new_preference: like preference)
			-- Set the preference.
		do
			Precursor (new_preference)
		end

	show
			-- Show the widget in its editable state
		do
			activate
		end

feature {NONE} -- Command

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			if valid_shortcut_text then
				preference.set_value_from_string (converted_saveable_string (change_item_widget.text))
			end
			Precursor {PREFERENCE_WIDGET}
		end

	refresh
			-- Refresh
		do
			Precursor {PREFERENCE_WIDGET}
			if attached {SHORTCUT_PREFERENCE} preference as l_preference then
				change_item_widget.set_text (l_preference.display_string)
			else
				check is_shortcut: False end
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.deactivate_actions.extend (agent on_change_item_widget_deactivated)
			if attached {SHORTCUT_PREFERENCE} preference as l_preference then
				change_item_widget.set_text (l_preference.display_string)
			else
				check is_shortcut: False end
			end
			change_item_widget.pointer_button_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do activate end)
		end

	on_change_item_widget_deactivated
			-- Triggered when `change_item_widget' is deactivated
		do
			--| We need to use idle action, otherwise the current active grid item
			--| is destroyed or replaced or invalidated too early
			--| need to investigate deeper the EV_GRID behavior
			ev_application.add_idle_action_kamikaze (agent do
					update_changes
					refresh
				end)
		end

	activate
			-- Activate the text
		do
			change_item_widget.activate
			setup_text_field
			change_item_widget.set_text_validation_agent (agent validate_preference_text)
			if
				attached change_item_widget.text_field as tf and then
				not tf.text.is_empty
			then
				tf.select_all
			end
		end

	setup_text_field
			-- Setup the text field on activation to handle properly key sequence rules.
		do
			if attached change_item_widget.text_field as tf then
				tf.key_press_actions.extend (agent on_key_pressed)
				tf.disable_edit
			else
				check has_text_field: False end
			end
		end

	on_key_pressed (a_key: EV_KEY)
			-- User is pressing a key to change the shortcut
		local
			l_app: EV_APPLICATION
			l_string,
			l_key: STRING_32
		do
			if attached {SHORTCUT_PREFERENCE} preference as l_pref then
				l_app := application
				if
					a_key.code = {EV_KEY_CONSTANTS}.key_enter and then
					not l_app.ctrl_pressed and then
					not l_app.shift_pressed and then
					not l_app.alt_pressed
				then
					change_item_widget.deactivate
				elseif l_pref.shortcut_keys.has (a_key.code) and then attached change_item_widget.text_field as tf then
					valid_shortcut_text := False
					if l_app.ctrl_pressed or l_app.alt_pressed then
						valid_shortcut_text := True
						create l_string.make_empty
						if l_app.alt_pressed then
							l_string.append (alt_text)
							l_string.append (shortcut_delimiter)
						end
						if l_app.ctrl_pressed then
							l_string.append (ctrl_text)
							l_string.append (shortcut_delimiter)
						end
						if l_app.shift_pressed then
							l_string.append (shift_text)
							l_string.append (shortcut_delimiter)
						end
						if a_key.is_alpha then
							l_key := a_key.text.as_upper
							l_string.append (l_key)
						else
							l_string.append (a_key.text)
						end
						tf.set_text (l_string)
					elseif a_key.is_function then
						valid_shortcut_text := True
						create l_string.make_empty
						if l_app.shift_pressed then
							l_string.append (shift_text)
							l_string.append (shortcut_delimiter)
						end
						l_string.append (a_key.text)
						tf.set_text (l_string)
					end
				end
			end
		end

	application: EV_APPLICATION
			--Application
		once
			Result := (create {EV_SHARED_APPLICATION}).ev_application
		end

	valid_shortcut_text: BOOLEAN
			-- Is the text entered into the `change_item_widget' a valif format for a shortcut?

    validate_preference_text (a_text: STRING_32): BOOLEAN
            -- Validate `a_text'.  Disallow input if text is not a valid shortcut key combination.
        do
            Result := valid_shortcut_text
        end

	converted_saveable_string (a_string: READABLE_STRING_32): STRING_32
			-- Convert `a_string' into saveable format.
			-- `Alt+Ctrl+Shift+Key' becomes `True+True+True+Key'
		local
			values: LIST [READABLE_STRING_32]
			l_cnt: INTEGER
			is_alt,
			is_ctrl,
			is_shift: BOOLEAN
			l_string,
			l_key: detachable READABLE_STRING_32
		do
			values := a_string.split ('+')
			create Result.make_empty
			from
				l_cnt := 1
			until
				l_cnt > values.count
			loop
				l_string := values.i_th (l_cnt)
				if l_string.is_equal (Alt_text) then
					is_alt := True
				elseif l_string.is_equal (Ctrl_text) then
					is_ctrl := True
				elseif l_string.is_equal (Shift_text) then
					is_shift := True
				else
						-- Handle the case the key is '+'
					if not a_string.is_empty and then a_string.item (a_string.count) = '+' then
						l_key := a_string.substring (a_string.last_index_of ('+', a_string.count - 1) + 1, a_string.count)
					else
						l_key := l_string.as_lower
					end
				end
				l_cnt := l_cnt + 1
			end

			Result.append_boolean (is_alt)
			Result.append (shortcut_delimiter)
			Result.append_boolean (is_ctrl)
			Result.append (shortcut_delimiter)
			Result.append_boolean (is_shift)
			Result.append (shortcut_delimiter)
			if l_key /= Void then
				Result.append (l_key)
			else
				check has_key: False end
			end
		end

invariant
	preference_attached: preference /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
