indexing
	description: "Objects that represent the special debug menu for eStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_MENU

inherit
	EV_MENU

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create, is_equal, copy
		end

create
	make_with_window

feature {NONE} -- Initialization

	make_with_window (w: EV_WINDOW) is
		local
			menu_item: EV_MENU_ITEM
		do
			window := w
			default_create
			set_text (compiler_version_number.version)

				--| Memory tool
			create menu_item.make_with_text_and_action ("Memory Analyzer", agent launch_memory_tool)
			extend (menu_item)

				--| Recenter all floating tools
			create menu_item.make_with_text_and_action ("Show Memory Tool", agent show_memory_tool)
			extend (menu_item)

				--| UUID Generator
			create menu_item.make_with_text_and_action ("UUID generator", agent launch_uuid_tool)
			extend (menu_item)

				--| Recompile backups
			create menu_item.make_with_text_and_action ("Replay Backup", agent launch_replay_backup_tool)
			extend (menu_item)

				--| Recenter all floating tools
			create menu_item.make_with_text_and_action ("Center Floating tools", agent center_floating_tools)
			extend (menu_item)
		end

feature {NONE} -- Actions

	launch_memory_tool is
			-- Launch Memory Analyzer.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: STRING
			l_dir: DIRECTORY_NAME
		do
			if ma_window = Void or ma_window.is_destroyed then
				create l_env
				l_path := l_env.get ("EIFFEL_SRC")
				if l_path = Void then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt ("EIFFEL_SRC not defined!", window, Void)
				else
					create l_dir.make_from_string (l_path)
					l_dir.extend_from_array (<<"library", "memory_analyzer" >>)
					create ma_window.make (l_dir)
					ma_window.close_request_actions.extend (agent ma_window.hide)
					ma_window.show
				end
			else
				ma_window.show
			end
		end

	show_memory_tool
			-- Shows the integrated memory tool
		do
			window_manager.last_focused_development_window.shell_tools.show_tool ({ES_MEMORY_TOOL}, True)
		end

	launch_uuid_tool is
			-- Launch UUID generator
		local
			l_dlg: EV_DIALOG
			vb: EV_VERTICAL_BOX
			tf: EV_TEXT_FIELD
			but, cbut: EV_BUTTON
		do
			create l_dlg.make_with_title ("UUID Generator")
			create vb
			create tf.make_with_text ("")
			create but.make_with_text_and_action ("New UUID", agent paste_new_uuid (tf))
			create cbut.make_with_text_and_action ("Close", agent l_dlg.destroy)
			vb.extend (tf)
			vb.extend (but)
			vb.extend (cbut)
			vb.disable_item_expand (tf)
			vb.disable_item_expand (but)
			vb.disable_item_expand (cbut)

			l_dlg.extend (vb)
			l_dlg.set_default_cancel_button (cbut)
			cbut.hide
			l_dlg.set_width (200)
			paste_new_uuid (tf)
			if window /= Void then
				l_dlg.show_relative_to_window (window)
			else
				l_dlg.show
			end
		end

	paste_new_uuid (tf: EV_TEXTABLE) is
		local
			uuid_gene: UUID_GENERATOR
		do
			create uuid_gene
			tf.set_text (uuid_gene.generate_uuid.out)
		end

	launch_replay_backup_tool is
			-- Launch tool that enables us to replay precisely a backup.
		do
			replay_window.window.raise
		end

feature -- center floating tools

	center_floating_tools is
		local
			dw: EB_DEVELOPMENT_WINDOW
			lst: LIST [SD_CONTENT]

			c: SD_CONTENT
			wx,wy,ww,wh: INTEGER
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void then
				lst := dw.docking_manager.contents
				if lst /= Void then
					wx := dw.window.x_position
					wy := dw.window.y_position
					ww := dw.window.width
					wh := dw.window.height
					from
						lst.start
					until
						lst.after
					loop
						c := lst.item_for_iteration
						if c /= Void and then c.is_visible and then c.is_floating then
							c.set_floating (wx + ww // 3, wy + wh // 3)
						end
						lst.forth
					end
				end
			end
		end

feature {NONE} -- Implementation

	window: EV_WINDOW
			-- Main development window.

	ma_window: MA_WINDOW;
			-- Memory analyzer window.

	replay_window: REPLAY_BACKUP_WINDOW is
			-- Replace backup window
		once
			create Result.make
		ensure
			replay_window_not_void: Result /= Void
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
