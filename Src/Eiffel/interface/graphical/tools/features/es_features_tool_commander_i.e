note
	description: "[
		A commander interface for interacting with the features tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_FEATURES_TOOL_COMMANDER_I

inherit
	USABLE_I

feature -- Basic operations

	select_feature_item (a_feature: detachable E_FEATURE)
			-- Selects a feature in the feature tree
			--
			-- `a_feature': The feature to select an assocated node in the feature tree.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	select_feature_item_by_name (a_feature: attached STRING_GENERAL)
			-- Selects a feature in the feature tree, using a string name
			--
			-- `a_feature': The name of a feature to select an assocated node in the feature tree.
		require
			is_interface_usable: is_interface_usable
			not_a_feature_is_empty: not a_feature.is_empty
		deferred
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
