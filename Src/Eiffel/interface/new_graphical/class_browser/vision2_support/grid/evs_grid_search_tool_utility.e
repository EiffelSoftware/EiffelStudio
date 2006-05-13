indexing
	description: "Object that provides basic utilities for search in EVS_GRID_WRAPPER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_SEARCH_TOOL_UTILITY

feature -- Actions

	keyword_not_found_actions: ACTION_SEQUENCE [ TUPLE [STRING]] is
			-- Actions to be performed when search for some keyword doesn't find any thing.
		do
			if keyword_not_found_actions_internal = Void then
				create keyword_not_found_actions_internal.make
			end
			Result := keyword_not_found_actions_internal
		ensure
			result_set: Result /= Void and then Result = keyword_not_found_actions_internal
		end

feature -- Message dialog

	show_message_dialog (a_msg: STRING; a_window: EV_WINDOW) is
			-- Display a warning dialog showing message `a_msg' in `a_window'.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		local
			l_dlg: EV_WARNING_DIALOG
		do
			create l_dlg.make_with_text (a_msg)
			if a_window /= Void then
				l_dlg.show_modal_to_window (a_window)
			else
				l_dlg.show
			end
		end

feature{NONE} -- Implementation

	keyword_not_found_actions_internal: like keyword_not_found_actions
			-- Internal item_not_found_actions

invariant
	keyword_not_fount_actions_attached: keyword_not_found_actions /= Void

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
