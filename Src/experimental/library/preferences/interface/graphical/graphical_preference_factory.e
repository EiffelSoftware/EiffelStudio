note
	description: "Helper class for creating graphical preference types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_PREFERENCE_FACTORY

inherit
	BASIC_PREFERENCE_FACTORY

feature -- Access

	new_color_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_COLOR): COLOR_PREFERENCE
			-- Add a new color preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [EV_COLOR, COLOR_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_font_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_FONT): FONT_PREFERENCE
			-- Add a new font preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [EV_FONT, FONT_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_shortcut_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: TUPLE [alt: BOOLEAN; ctrl: BOOLEAN; shift: BOOLEAN; key_string: READABLE_STRING_GENERAL]): SHORTCUT_PREFERENCE
			-- Add a new shortcut preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
			valid_fallback_value: a_fallback_value.count = 4
		local
			l_fallback_value: TUPLE [alt: BOOLEAN; ctrl: BOOLEAN; shift: BOOLEAN; key_string: STRING_32]
		do
			l_fallback_value := [a_fallback_value.alt, a_fallback_value.ctrl, a_fallback_value.shift, a_fallback_value.key_string.as_string_32]
			Result := (create {PREFERENCE_FACTORY [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_32], SHORTCUT_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, l_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.same_string_general (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_color_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_COLOR): COLOR_PREFERENCE
		obsolete "Use `new_color_preference_value` [2017-05-31]."
		do
			Result := new_color_preference_value (a_manager, a_name, a_fallback_value)
		end
	new_font_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_FONT): FONT_PREFERENCE
		obsolete "Use `new_font_preference_value` [2017-05-31]."
		do
			Result := new_font_preference_value (a_manager, a_name, a_fallback_value)
		end
	new_shortcut_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING]): SHORTCUT_PREFERENCE
		obsolete "Use `new_shortcut_preference_value` [2017-05-31]."
		do
			Result := new_shortcut_preference_value (a_manager, a_name, a_fallback_value)
		end


note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
