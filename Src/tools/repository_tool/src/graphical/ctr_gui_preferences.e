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
			date_formatting_pref := factory.new_string_preference_value (manager, namespace + ".date_formatting", "")
			diff_viewer_command_pref := factory.new_string_preference_value (manager, namespace + ".diff_viewer_command", "")
		end

feature -- Access

	auto_mark_read_pref: BOOLEAN_PREFERENCE

	date_formatting_pref: STRING_PREFERENCE

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
