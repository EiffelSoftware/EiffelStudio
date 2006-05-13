indexing
	description: "Object that represents an action sequence which get invoked when some setting changes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_SETTING_CHANGE_ACTIONS

feature -- Lock/Unlock

	lock_update is
			-- Increase `lock_count' of `setting_change_actions' by 1.
			-- Only when this `lock_count' is 0, `try_call_setting_change_actions' will succeed.
		do
			update_lock_internal := update_lock_internal + 1
		ensure
			lock_count_increased: lock_count = old lock_count + 1
		end

	unlock_update is
			-- Decrease `lock_count' of `setting_change_actions' by 1.
			-- Only when this `lock_count' is 0, `try_call_setting_change_actions' will succeed.
		require
			lock_count_non_negative: lock_count >= 0
		do
			update_lock_internal := update_lock_internal - 1
		ensure
			lock_count_increased: lock_count = old lock_count - 1
		end

feature -- Safe invocation

	try_call_setting_change_actions is
			-- Try to call actions in `setting_change_actions'.
			-- Only when this `lock_count' is 0, `try_call_setting_change_actions' will succeed.
		do
			if lock_count = 0 then
				setting_change_actions.call ([])
			end
		end

	force_call_setting_change_actions is
			-- Force to call actions in `setting_change_actions'.
		do
			setting_change_actions.call ([])
		end

feature -- Access

	lock_count: INTEGER is
			-- Lock count of `setting_change_actions'
		do
			Result := update_lock_internal
		ensure
			good_result: Result = update_lock_internal
		end

	setting_change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when setting of current tooltips changes,
			-- Usually attach redraw features in this to perform a tooltip redraw after setting
		do
			if setting_change_actions_internal = Void then
				create setting_change_actions_internal.make
			end
			Result := setting_change_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	setting_change_actions_internal: like setting_change_actions
			-- Internal `setting_change_actions'

	update_lock_internal: INTEGER
			-- Lock level, if 0, `try_update' will really perform its task, otherwise, do nothing.

invariant
	update_lock_internal_non_negative: update_lock_internal >= 0
	setting_change_actions_attached: setting_change_actions /= Void

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
