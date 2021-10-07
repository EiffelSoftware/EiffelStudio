note
	description: "Tools extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_TOOLS

inherit
	ESTUDIO_DEBUG_EXTENSION
		redefine
			new_menu_item
		end

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Execution

	execute
		do
		end

	build_debug_sub_menu (a_menu: EV_MENU)
			-- Builds the debug submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: EV_MENU_ITEM
		do
				--| UUID Generator
			create l_menu_item.make_with_text_and_action ("UUID Generator", agent on_generate_uuid)
			a_menu.extend (l_menu_item)

				--| Memory tool
			create l_menu_item.make_with_text_and_action ("Memory Analyzer", agent on_launch_memory_analyzer)
			a_menu.extend (l_menu_item)

				--| GUI debug inspector tool
			create l_menu_item.make_with_text_and_action ("GUI Inspector", agent on_setup_gui_inspector)
			a_menu.extend (l_menu_item)

			a_menu.extend (create {EV_MENU_SEPARATOR})

				--| Show memory tool
			create l_menu_item.make_with_text_and_action ("Show Memory Tool", agent on_show_memory_tool)
			a_menu.extend (l_menu_item)

				--| Show logger tool
			create l_menu_item.make_with_text_and_action ("Show Logger Tool", agent on_show_logger_tool)
			a_menu.extend (l_menu_item)

			a_menu.extend (create {EV_MENU_SEPARATOR})

				--| Recenter all floating tools
			create l_menu_item.make_with_text_and_action ("Force Show All Tools", agent on_force_show_tools)
			a_menu.extend (l_menu_item)

				--| Recenter all floating tools
			create l_menu_item.make_with_text_and_action ("Center Floating Tools", agent on_center_floating_tools)
			a_menu.extend (l_menu_item)

		end

feature {NONE} -- Actions

	on_launch_memory_analyzer
			-- Launch Memory Analyzer.
		local
			w: like ma_window
		do
			w := ma_window
			if w = Void or else w.is_destroyed then
				create w.make (eiffel_layout.library_path.extended ("memory_analyzer").name)
				ma_window := w
				w.close_request_actions.extend (agent w.hide)
				w.show
			else
				w.show
			end
		end

	on_setup_gui_inspector
		local
			l_inspector: EV_DEBUG_INSPECTOR
		do
			if attached estudio_debug_menu.window_manager.last_focused_development_window as devwin then
				create l_inspector.make
				l_inspector.register_for_window (devwin.window)
				l_inspector.open_window_inspection
			end
		end

	on_show_memory_tool
			-- Shows the integrated memory tool
		do
			estudio_debug_menu.window_manager.last_focused_development_window.shell_tools.show_tool ({ES_MEMORY_TOOL}, True)
		end

	on_show_logger_tool
			-- Shows the integrated memory tool
		do
			estudio_debug_menu.window_manager.last_focused_development_window.shell_tools.show_tool ({ES_LOGGER_TOOL}, True)
		end

	on_show_outputs_tool
			-- Shows the integrated memory tool
		do
			estudio_debug_menu.window_manager.last_focused_development_window.shell_tools.show_tool ({ES_OUTPUTS_TOOL}, True)
		end

	on_generate_uuid
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
			vb.disable_item_expand (cbut)
			l_dlg.extend (vb)
			l_dlg.set_default_cancel_button (cbut)
			cbut.hide
			l_dlg.set_width (300)
			paste_new_uuid (tf)
			if attached estudio_debug_menu.window as w then
				l_dlg.show_relative_to_window (w)
			else
				l_dlg.show
			end
		end

	on_force_show_tools
			-- Force the display of all the tools, useful when diagnosing memory leaks
		local
			l_window: detachable EB_DEVELOPMENT_WINDOW
			l_error: attached ES_ERROR_PROMPT
		do
			l_window := window_manager.last_focused_development_window
			if l_window /= Void and then l_window.is_interface_usable then
				l_window.commands.show_shell_tool_commands.linear_representation.do_all (agent (ia_cmd: ES_SHOW_TOOL_COMMAND)
						-- Show ESF tools.
					local
						l_tool: ES_TOOL [EB_TOOL]
						l_show_debug_tools: BOOLEAN
					do
						if ia_cmd /= Void and then ia_cmd.is_interface_usable then
							l_tool := ia_cmd.tool
							if l_tool /= Void and then l_tool.is_interface_usable then
								if attached {EB_DEBUGGER_MANAGER} l_tool.window.debugger_manager as l_dm then
									l_show_debug_tools := l_dm.raised
								end
								if l_show_debug_tools or else not l_tool.profile_kind.is_equal ((create {ES_TOOL_PROFILE_KINDS}).debugger) then
										-- Show a regular tool or show a debugger tool if the debugger is active.
									l_tool.show (False)
								end
							end
						end
					end)
			else
				create l_error.make_standard ("Unable to retrieve the last focused window!")
				l_error.show (window)
			end
		end

	on_center_floating_tools
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

feature {NONE} -- Basic operations

	paste_new_uuid (tf: EV_TEXTABLE)
		local
			uuid_gene: UUID_GENERATOR
		do
			create uuid_gene
			tf.set_text (uuid_gene.generate_uuid.out)
		end


feature {NONE} -- Access

	ma_window: detachable MA_WINDOW;
			-- Memory analyzer window.

feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Tools">>
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU
		do
			Result := imp_new_menu_item (a_title)
			build_debug_sub_menu (Result)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
