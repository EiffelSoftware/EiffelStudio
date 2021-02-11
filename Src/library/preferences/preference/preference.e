note
	description: "Resource type abstraction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCE

inherit
	PREFERENCE_EXPORTER

feature -- Modification

	set_name (new_name: STRING)
			-- Set `name' to `new_name'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			name := new_name
		ensure
			name_set: name = new_name
		end

	set_description (new_description: READABLE_STRING_GENERAL)
			-- Set `description' to `new_description'.
		require
			new_description_exists: new_description /= Void
			new_description_not_empty: not new_description.is_empty
		do
			description := new_description.to_string_32
		ensure
			description_set: attached description as d and then d.same_string_general (new_description)
		end

	set_hidden (a_flag: BOOLEAN)
			-- Set if this is hidden from user view.
		do
			is_hidden := a_flag
		ensure
			value_set: is_hidden = a_flag
		end

	set_default_value (a_value: READABLE_STRING_GENERAL)
			-- Set the value to be used for default in the event `value' is not set.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: is_string_value_validated (a_value)
		do
			internal_default_value := a_value.to_string_32
			if attached internal_change_actions as l_actions then
				l_actions.call ([Current])
			end
		ensure
			default_value_set: attached internal_default_value as l_value and then l_value.same_string_general (a_value)
		end

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: is_string_value_validated (a_value)
		deferred
		end

	select_value_from_string (s: READABLE_STRING_32)
			-- Select current value to match `s`.
			-- Same as `set_value_from_string` for a single-valued preference.
			-- Selects an item corresponding to `s` for a multi-valued preference.
		require
			is_valid_string_for_selection (s)
		deferred
		end

	reset
			-- Reset value to `default_value'.
		do
			if attached auto_preference as l_auto_preference then
				set_value_from_string (l_auto_preference.text_value)
			elseif attached default_value as l_default_value then
				set_value_from_string (l_default_value)
			end
		ensure
			is_reset: old has_default_value implies is_default_value
		end

	set_restart_required (is_required: BOOLEAN)
			-- Set 'restart_required'
		do
			restart_required := is_required
		ensure
			restart_required_set: restart_required = is_required
		end

feature -- Access

	name: STRING
			-- Name of the preference as it appears in the preference file.

	description: detachable STRING_32
			-- Description of what the preference is all about.

	default_value: detachable STRING_32
			-- Value to be used for default.
		do
			if attached auto_preference as l_auto_preference then
				Result := l_auto_preference.text_value
			else
				Result := internal_default_value
			end
		end

	string_type: STRING
			-- String description of this preference type.
		deferred
		ensure
			string_type_not_void: Result /= Void
			no_underscore: not Result.has ('_')
		end

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		deferred
		ensure
			generating_preference_type_not_void: Result /= Void
		end

	manager: PREFERENCE_MANAGER
			-- Manager to which Current belongs.

	auto_preference: detachable like Current
			-- Preference to use for auto color.

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String value for this preference.
		require
			has_value: has_value
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	has_value: BOOLEAN
			-- Does this preference have a value to use?
		deferred
		end

	has_default_value: BOOLEAN
			-- Does this preference have a default value to use?
		do
			Result := default_value /= Void	or auto_preference /= Void
		end

	is_default_value: BOOLEAN
			-- Is this preference value the same as the default value?
		do
			if attached default_value as l_default_value then
				Result := text_value.is_case_insensitive_equal (l_default_value)
			else
				check has_no_default_value: not has_default_value end
			end
		end

	is_hidden: BOOLEAN
			-- Should Current be hidden from user view?

	restart_required: BOOLEAN
			-- Is a restart required to apply the preference when changed? (Default: False)

	is_auto: BOOLEAN
			-- Is Current using auto value?

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
			-- note: this ignores the `validation_agent'
		require
			string_not_void: a_string /= Void
		deferred
		end

	is_string_value_validated (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		require
			string_not_void: a_string /= Void
		do
			if attached validation_agent as agt then
				Result := agt.item ([a_string])
			else
				Result := valid_value_string (a_string)
			end
		end

	is_valid_string_for_selection (s: READABLE_STRING_32): BOOLEAN
			-- Can the string `s` be used to select a value?
			-- Same as `is_string_value_validated` for a single-valued preference.
			-- Checks against a list of known values for a multi-valued (choice) preference.
		deferred
		end

	has_validation_agent: BOOLEAN
		do
			Result := validation_agent /= Void
		end

feature -- Validation

	validation_agent: detachable FUNCTION [READABLE_STRING_GENERAL, BOOLEAN]
			-- Validation agent to test if a READABLE_STRING_GENERAL is a valid text value for Current
			--| This can be used to validate only existing path, or existing directory, ...

feature -- Change

	set_validation_agent (agt: like validation_agent)
			-- Set `validation_agent' to `agt'.
		do
			validation_agent := agt
		end

feature -- Actions

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `value' changes, after call to `set_value'.
		do
			Result := internal_change_actions
			if Result = Void then
				create Result
				internal_change_actions := Result
			end
		ensure
			Result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	internal_change_actions: detachable like change_actions
			-- Storage for `change_actions'.

	auto_string: STRING = "auto"
			-- Auto

	internal_default_value: detachable STRING_32
			-- Internal default value

invariant
	has_manager: manager /= Void
	name_not_void: name /= Void
	has_change_actions: change_actions /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
