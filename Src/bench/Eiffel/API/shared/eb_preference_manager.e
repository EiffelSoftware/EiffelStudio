indexing
	description: "Preferences manager for EiffelStudio preferencs.  Extends the default preference with new preferences resource%
		%types specific to EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCE_MANAGER

inherit
	PREFERENCE_MANAGER

	GRAPHICAL_PREFERENCE_FACTORY

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create
	make

feature -- Status Setting

	new_identified_font_resource_value (a_name: STRING; a_value: EV_IDENTIFIED_FONT): IDENTIFIED_FONT_PREFERENCE is
			-- Add a new identified font resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not known_resource (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [EV_IDENTIFIED_FONT, IDENTIFIED_FONT_PREFERENCE]}).
				new_resource (preferences, Current, a_name, a_value)
			font_factory.register_font (Result.value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: preferences.has_resource (a_name)
		end		

end -- class EB_PREFERENCE_MANAGER
