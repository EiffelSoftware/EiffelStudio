indexing
	description	: "Shared attributes specific to the flat/short form."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
	feature_clause_order_string: STRING is "interface.development_window.feature_clause_order"
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FLAT_SHORT_DATA

