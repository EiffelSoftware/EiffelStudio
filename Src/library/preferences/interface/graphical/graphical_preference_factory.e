indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_PREFERENCE_FACTORY
	
inherit
	BASIC_PREFERENCE_FACTORY

feature -- Access

	new_color_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: EV_COLOR): COLOR_PREFERENCE is
			-- Add a new color resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [EV_COLOR, COLOR_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_font_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: EV_FONT): FONT_PREFERENCE is
			-- Add a new font resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [EV_FONT, FONT_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	

invariant
	invariant_clause: True -- Your invariant here

end
