indexing
	description: "Helper class for creating graphical preference types."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_PREFERENCE_FACTORY
	
inherit
	BASIC_PREFERENCE_FACTORY

feature -- Access

	new_color_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_COLOR): COLOR_PREFERENCE is
			-- Add a new color resource with name `a_name'.  If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [EV_COLOR, COLOR_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_font_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: EV_FONT): FONT_PREFERENCE is
			-- Add a new font resource with name `a_name'.  If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [EV_FONT, FONT_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	

end
