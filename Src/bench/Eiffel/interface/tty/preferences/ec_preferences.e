indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_PREFERENCES

create
	make
	
feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			create misc_data.make (a_preferences)
			create feature_tool_data.make (a_preferences)
			create flat_short_data.make (a_preferences)
		end		

feature {EB_SHARED_PREFERENCES} -- Access

	flat_short_data: EB_FLAT_SHORT_DATA
		-- Preference data for class flat short.

	feature_tool_data: EB_FEATURE_TOOL_DATA
		-- Preference data for the feature tool.

	misc_data: EB_MISC_DATA
		-- Misc data.  This should be removed.  neilc

invariant
	feature_tool_data_not_void: feature_tool_data /= Void
	misc_data_not_void: misc_data /= Void
	flat_short_data_not_void: flat_short_data /= Void

end -- class EC_PREFERENCES
