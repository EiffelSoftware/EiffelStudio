note
	description: "[
					Completable text field
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMPLETABLE_TEXT_FIELD

inherit
	COMPLETABLE_TEXT_FIELD
		redefine
			can_complete
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Init

	make
			-- Initialization
		do
			default_create
			set_preferred_height_agent (agent (preferences.metric_tool_data).criterion_completion_list_height)
			set_preferred_width_agent (agent (preferences.metric_tool_data).criterion_completion_list_width)
		end

feature -- Query

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN
			-- `a_key' can activate text completion?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				Result := a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
			end
		end

note
        copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
        source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
