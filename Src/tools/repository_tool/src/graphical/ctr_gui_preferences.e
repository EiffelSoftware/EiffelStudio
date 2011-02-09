note
	description: "Summary description for {CTR_GUI_PREFERENCES}."
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_GUI_PREFERENCES

inherit
	CTR_PREFERENCES
		redefine
			factory, load_preferences
		end

create
	make

feature {NONE} -- Access

	factory: GRAPHICAL_PREFERENCE_FACTORY

	load_preferences
		do
			Precursor

			auto_mark_read_pref := factory.new_boolean_preference_value (manager, namespace + ".auto_mark_read", True)
			auto_mark_read_pref.set_description ("Automatically mark the selected log as read")

			auto_move_to_next_log_direction_pref := factory.new_integer_preference_value (manager, namespace + ".auto_move_to_next_log_direction", +1)
			auto_move_to_next_log_direction_pref.set_description ("When marking a log as read, automatically move to next log (+1), previous log (-1), or do not auto move (0)")

			info_tool_changes_expanded_pref := factory.new_boolean_preference_value (manager, namespace + ".tools.info.changes_expanded", False)
			info_tool_changes_expanded_pref.set_hidden (True)

			date_formatting_pref := factory.new_string_preference_value (manager, namespace + ".date_formatting", "")

			initialize_gmt_offset_preferences

			smart_date_kind_pref := factory.new_array_preference_value (manager, namespace + ".smart_date_kind",
					<<
						{CTR_DATE_TIME_UTILITY}.smart_date_none_kind_string,
						{CTR_DATE_TIME_UTILITY}.smart_date_duration_kind_string,
						{CTR_DATE_TIME_UTILITY}.smart_date_short_kind_string
					>>)
			smart_date_kind_pref.set_is_choice (True)

			diff_viewer_command_pref := factory.new_string_preference_value (manager, namespace + ".diff_viewer_command", "")
		end

feature -- Access

	initialize_gmt_offset_preferences
		local
			s: STRING
		do
			s := (create {CTR_GMT_OFFSET_UTILITY}).gmt_offset_string

			gmt_offset_pref := factory.new_string_preference_value (manager, namespace + ".gmt_offset", s)
			gmt_offset_pref.set_default_value (s)
		end

	auto_mark_read_pref: BOOLEAN_PREFERENCE

	auto_move_to_next_log_direction_pref: INTEGER_PREFERENCE
			-- True: next, False: previous

	info_tool_changes_expanded_pref: BOOLEAN_PREFERENCE

	smart_date_kind_pref: ARRAY_PREFERENCE

	date_formatting_pref: STRING_PREFERENCE

	gmt_offset_pref: STRING_PREFERENCE

	diff_viewer_command_pref: STRING_PREFERENCE

	color_preference (a_name: STRING; a_fallback_value: EV_COLOR): COLOR_PREFERENCE
		local
			pn: STRING
			p: detachable COLOR_PREFERENCE
		do
			create pn.make_from_string (namespace)
			pn.append_character ('.')
			pn.append (a_name)

			if preferences.has_preference (pn) then
				if attached {COLOR_PREFERENCE} preferences.get_preference (pn) as cp then
					p := cp
				else
					check preference_found: False end
				end
			end
			if p /= Void then
				Result := p
			else
				Result := factory.new_color_preference_value (manager, pn, a_fallback_value)
			end
		ensure
			result_attached: Result /= Void
		end

end
