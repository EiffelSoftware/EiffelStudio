indexing
	description: "Utilities for class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_UTILITY

inherit
	EB_SHARED_PREFERENCES

feature -- Shortcut

	accelerator_from_shortcur (a_shortcut: SHORTCUT_PREFERENCE): EV_ACCELERATOR is
			-- Accelerator from `a_shortcut'
		require
			a_shortcut_attached: a_shortcut /= Void
		do
			create Result.make_with_key_combination (
					a_shortcut.key,
					a_shortcut.is_ctrl,
					a_shortcut.is_alt,
					a_shortcut.is_shift)
		ensure
			result_attached: Result /= Void
		end

	accelerator_from_preference (a_preference_name: STRING): EV_ACCELERATOR is
			-- Accelerator from preference named `a_preference_name'
		require
			a_preference_name_attached: a_preference_name /= Void
			not_a_preference_name_is_empty: not a_preference_name.is_empty
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.editor_data.shortcuts.item (a_preference_name)
			if l_shortcut /= Void then
				Result := accelerator_from_shortcur (l_shortcut)
			end
		ensure
			good_result: preferences.editor_data.shortcuts.item (a_preference_name) /= Void implies equal (Result, accelerator_from_shortcur (preferences.editor_data.shortcuts.item (a_preference_name)))
		end

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
