indexing
	description	: "Shared attributes specific to the flat/short form."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FLAT_SHORT_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature {EB_SHARED_PREFERENCES} -- Value

	feature_clause_order: ARRAY [STRING] is
		do
			Result := feature_clause_order_preference.value
		end

	excluded_indexing_items: ARRAY [STRING] is
		do
			Result := excluded_indexing_items_preference.value
		end

feature {NONE} -- Preference

	feature_clause_order_preference: ARRAY_PREFERENCE
	excluded_indexing_items_preference: ARRAY_PREFERENCE
	
feature {NONE} -- Preference Strings
	
	feature_clause_order_string: STRING is "tools.browsing_tools.feature_clause_order"
	excluded_indexing_items_string: STRING is "tools.context_tool.excluded_indexing_items"

feature {NONE} -- Defaults

	default_feature_clause_order: ARRAY [STRING] is
			-- 
		once
			Result := <<"Initialization","Access","Measurement","Comparison","Status report","Status setting","Cursor movement","Element change","Removal","Resizing","Transformation","Conversion","Duplication","Miscellaneous","Basic operations","Obsolete","Inapplicable","Implementation","*">>	
		end

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "flat_short")	
		
			feature_clause_order_preference := l_manager.new_array_resource_value (l_manager, feature_clause_order_string, default_feature_clause_order)
			excluded_indexing_items_preference := l_manager.new_array_resource_value (l_manager, excluded_indexing_items_string, <<"revision", "date", "status">>)
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void	
	feature_clause_order_preference_not: feature_clause_order_preference /= Void
	excluded_indexing_items_preferencenot_void: excluded_indexing_items_preference /= Void

end -- class EB_FLAT_SHORT_DATA

