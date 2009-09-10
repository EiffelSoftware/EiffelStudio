note

	description: "[
				Command to enable/remove  or enable/disable breakpoint 
				on current line of focused flat formatter
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TOGGLE_BREAKPOINT_HERE_CMD

inherit
	EB_MENUABLE_COMMAND

	EVS_HELPERS
		export
			{NONE} all
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		end

create
	make_enable_remove,
	make_enable_disable

feature {NONE} -- Initialization

	make_enable_remove (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Create Current for enable/remove behavior
		do
			make (a_develop_window)
			enable_sensitive

			init_accelerator

			update_accelerator (develop_window.window)
		end

	make_enable_disable (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Create Current for enable/disable behavior
		do
			is_enable_disable := True
			make_enable_remove (a_develop_window)
		end

	init_accelerator
			-- Initialize accelerator
		local
			l_preference: EB_SHARED_PREFERENCES
			l_shortcut: SHORTCUT_PREFERENCE
		do
			create l_preference
			if is_enable_disable then
				l_shortcut := l_preference.preferences.debug_tool_data.enable_disable_bp_here_shortcut_preference
			else
				l_shortcut := l_preference.preferences.debug_tool_data.enable_remove_bp_here_shortcut_preference
			end
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
			l_shortcut.change_actions.extend (agent (ia_pref: SHORTCUT_PREFERENCE)
					do
						update_accelerator (develop_window.window)
						update (develop_window.window)
					end (l_shortcut)
				)
		end

feature -- Status report

	is_enable_disable: BOOLEAN
			-- Is smart toggle behavior?

feature -- Command

	execute
			-- <Precursor>
		local
			windev: EB_DEVELOPMENT_WINDOW
			retried: BOOLEAN
		do
			if not retried then
				windev := window_manager.last_focused_development_window
				if
					attached windev.tools.features_relation_tool as feat_tool and then
					attached feat_tool.widget as fw and then
					widget_has_recursive_focus (fw)
				then
					if attached feat_tool.flat_formatter as ff then
						if
							attached ff.editor.text_displayed.cursor.line as l_line and then
							attached l_line.breakpoint_token as ftok and then
							attached ftok.pebble as bp_stone
						then
							if is_enable_disable then
								bp_stone.smart_toggle_bkpt (is_enable_disable)
							else
								bp_stone.toggle_bkpt
							end
						else
							--| TODO: maybe toggle the current call stack related line ...?
						end
					end
--| TODO: Prepare for editor's support ...
--				elseif
--					attached windev.editors_manager.current_editor as curr_edit and then
--					attached curr_edit.widget as ew and then
--					widget_has_recursive_focus (ew)
--				then					
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Query

	menu_name: STRING_GENERAL
			-- Menu name
		do
			if is_enable_disable then
				Result := interface_names.m_enable_disable_breakpoint_here
			else
				Result := interface_names.m_enable_remove_breakpoint_here
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
