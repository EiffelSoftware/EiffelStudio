indexing
	description: "Agents in EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_AGENTS

inherit
	EB_DEVELOPMENT_WINDOW_PART
		redefine
			internal_detach_entities
		end

	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_project_loaded,
			on_project_unloaded
		end

	TEXT_OBSERVER
		redefine
			on_text_reset, on_text_edited,
			on_text_back_to_its_last_saved_state,
			on_text_fully_loaded, on_cursor_moved
		end

create
	make

feature {NONE} -- Clean up

	internal_detach_entities is
			-- Detaches objects from their container
		do
			Precursor {EB_DEVELOPMENT_WINDOW_PART}
			on_customized_tools_changed_agent_internal := Void
		ensure then
			on_customized_tools_changed_agent_internal_detached: on_customized_tools_changed_agent_internal = Void
		end

feature -- Text observer Agents

	on_text_reset is
			-- The main editor has just been wiped out
			-- before loading a new file.
		local
			str: STRING_32
		do
			if not is_recycled then
				str := develop_window.title.twin.as_string_32
				if str @ 1 = '*' then
					str.keep_tail (str.count - 2)
					develop_window.set_title (str)
				end

				-- We close a UN-FOCUSED editor by pointer, we should not disable formatters if there is/are still editor(s) opened.
				if develop_window.editors_manager.editor_count <= 0 then
					develop_window.address_manager.disable_formatters
				end

				develop_window.status_bar.reset
				develop_window.status_bar.remove_cursor_position
				develop_window.set_text_edited (False)
			end
		end

	on_text_edited (unused: BOOLEAN) is
			-- The text in the editor is modified, add the '*' in the title.
			-- Gray out the formatters.
		local
			l_str: STRING_32
			l_cst: CLASSI_STONE
		do
			if not is_recycled then
				if not develop_window.text_edited then
					l_str := develop_window.title.twin.as_string_32
					if l_str @ 1 /= '*' then
						l_str.prepend ("* ")
						develop_window.set_title (l_str)
					end
					develop_window.address_manager.disable_formatters
					l_cst ?= develop_window.stone
					if l_cst /= Void then
						develop_window.Eiffel_project.Manager.class_is_edited (l_cst.class_i)
					end
					develop_window.set_text_edited (True)
				end
				if not develop_window.status_bar.message.is_equal (develop_window.interface_names.e_c_compilation_running) then
						-- We don't want the "Background C compilation in progress" message flash every time
						-- user presses a key.
					develop_window.status_bar.display_message ("")
				end
			end
		end

	on_text_back_to_its_last_saved_state is
			-- On text back to last saved state.
		local
			str: STRING_32
		do
			if not is_recycled then
				str := develop_window.title.twin.as_string_32
				if str @ 1 = '*' then
					str.keep_tail (str.count - 2)
					develop_window.set_title (str)
				end
				develop_window.update_formatters
				develop_window.set_text_edited (False)
			end
		end

	on_cursor_moved is
			-- The cursor has moved, reflect the change in the status bar.
			-- And reflect location editing in the text in features tool and address bar.
		local
			l_context_refreshing_timer: EV_TIMEOUT
		do
			if not is_recycled then
				if not develop_window.is_empty then
					develop_window.refresh_cursor_position
				end
				if develop_window.context_refreshing_timer = Void then
					create l_context_refreshing_timer.make_with_interval (100)
					develop_window.set_context_refreshing_timer (l_context_refreshing_timer)
					l_context_refreshing_timer.actions.extend (agent develop_window.refresh_context_info)
				end
				if develop_window.feature_locating then
					develop_window.context_refreshing_timer.set_interval (0)
				else
					develop_window.context_refreshing_timer.set_interval (100)
				end
			end
		end

	on_text_fully_loaded is
			-- The main editor has just been reloaded.
		do
			if not is_recycled then
				develop_window.update_paste_cmd
				develop_window.update_formatters
				if develop_window.syntax_is_correct then
					develop_window.status_bar.reset
				else
					develop_window.status_bar.display_message (develop_window.Interface_names.L_syntax_error)
				end
				if not develop_window.is_empty then
					develop_window.refresh_cursor_position
				end

				develop_window.set_text_edited (False)
			end
		end

feature -- Agents

	on_back is
			-- User pressed Alt+left.
			-- Go back in the history (or the context history).
		local
			l_history_manager: EB_HISTORY_MANAGER
			l_tool: EB_TOOL
		do
			if develop_window.tools.class_tool.has_focus then
				if develop_window.tools.class_tool.history_manager.is_back_possible then
					l_history_manager := develop_window.tools.class_tool.history_manager
					l_tool := develop_window.tools.class_tool
				end
			elseif develop_window.tools.features_relation_tool.has_focus then
				if develop_window.tools.features_relation_tool.history_manager.is_back_possible then
					l_history_manager := develop_window.tools.features_relation_tool.history_manager
					l_tool := develop_window.tools.features_relation_tool
				end
			elseif develop_window.tools.dependency_tool.has_focus then
				if develop_window.tools.dependency_tool.history_manager.is_back_possible then
					l_history_manager := develop_window.tools.dependency_tool.history_manager
					l_tool := develop_window.tools.dependency_tool
				end
			elseif develop_window.tools.diagram_tool.has_focus then
				if develop_window.tools.diagram_tool.history_manager.is_back_possible then
					l_history_manager := develop_window.tools.diagram_tool.history_manager
					l_tool := develop_window.tools.diagram_tool
				end
			elseif develop_window.history_manager.is_back_possible then
				develop_window.history_manager.back_command.execute
			end
			if l_history_manager /= Void then
				l_history_manager.back_command.execute
				if l_tool /= Void then
					l_tool.show
				end
			end
		end

	on_forth is
			-- User pressed Alt+right.
			-- Go forth in the history (or the context history).
		local
			l_history_manager: EB_HISTORY_MANAGER
			l_tool: EB_TOOL
		do
			if develop_window.tools.class_tool.has_focus then
				if develop_window.tools.class_tool.history_manager.is_forth_possible then
					l_history_manager := develop_window.tools.class_tool.history_manager
					l_tool := develop_window.tools.class_tool
				end
			elseif develop_window.tools.features_relation_tool.has_focus then
				if develop_window.tools.features_relation_tool.history_manager.is_forth_possible then
					l_history_manager := develop_window.tools.features_relation_tool.history_manager
					l_tool := develop_window.tools.features_relation_tool
				end
			elseif develop_window.tools.dependency_tool.has_focus then
				if develop_window.tools.dependency_tool.history_manager.is_forth_possible then
					l_history_manager := develop_window.tools.dependency_tool.history_manager
					l_tool := develop_window.tools.dependency_tool
				end
			elseif develop_window.tools.diagram_tool.has_focus then
				if develop_window.tools.diagram_tool.history_manager.is_forth_possible then
					l_history_manager := develop_window.tools.diagram_tool.history_manager
					l_tool := develop_window.tools.diagram_tool
				end
			elseif develop_window.history_manager.is_forth_possible then
				develop_window.history_manager.forth_command.execute
			end
			if l_history_manager /= Void then
				l_history_manager.forth_command.execute
				if l_tool /= Void then
					l_tool.show
				end
			end
		end

	on_c_compilation_starts is
			-- Enable commands when freezing or finalizing starts.
		do
			develop_window.commands.c_workbench_compilation_cmd.disable_sensitive
			develop_window.commands.c_finalized_compilation_cmd.disable_sensitive
		end

	on_c_compilation_stops is
			-- Disable commands when freezing or finalizing stops.
		do
			develop_window.commands.c_workbench_compilation_cmd.enable_sensitive
			develop_window.commands.c_finalized_compilation_cmd.enable_sensitive
		end

	on_focus is
			-- Focus gained
		require
			not_is_recycled: not is_recycled
		local
			l_editor: EB_SMART_EDITOR
			l_class_i_stone: CLASSI_STONE
			l_editor_manager: EB_EDITORS_MANAGER
		do
			if not is_recycled then
					-- Have to protect because of bug#13672. This is a hack for now.
				l_editor_manager := develop_window.editors_manager
				if l_editor_manager /= Void then
					l_editor := l_editor_manager.current_editor
				end

				if l_editor /= Void then
						-- If the class currently being edited had its read-only status changed
						-- we made sure that the editor is updated accordingly.
					l_class_i_stone ?= develop_window.stone
					if l_class_i_stone /= Void then
						if l_editor.is_read_only and develop_window.selected_formatter.is_editable then
								-- Only possible action is to go from a read-only class to a
								-- non-readonly class.
							l_editor.set_read_only (l_class_i_stone.class_i.is_read_only)
						else
								-- Here if the class is read-only and that there were
								-- already some modification being done, we don't do anything.
								-- The error will be reported only when trying to save our changes.
								-- Therefore we don't change the `is_read_only' status of the `editor'.
						end
					end
					l_editor.on_focus
				end
			end
		end

	on_project_created is
			-- Inform tools that the current project has been loaded or re-loaded.
		local
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
			create l_builder.make (develop_window)
			l_builder.build_menu_bar
			enable_commands_on_project_created

			develop_window.address_manager.on_project_created
			if develop_window.has_dll_generation then
				develop_window.show_dynamic_lib_tool.enable_sensitive
			end
			if develop_window.has_profiler then
				develop_window.commands.show_profiler.enable_sensitive
			end
			develop_window.commands.customized_formatter_command.enable_sensitive
			develop_window.commands.customized_tool_command.enable_sensitive
		end

	on_project_loaded is
			-- Inform tools that the current project has been loaded or re-loaded.
		do
			develop_window.cluster_manager.on_project_loaded
			enable_commands_on_project_loaded
			develop_window.tools.cluster_tool.on_project_loaded

			develop_window.tools.breakpoints_tool.on_project_loaded
		end

	on_project_unloaded is
			-- Inform tools that the current project will soon been unloaded.
		local
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
			disable_commands_on_project_unloaded
			develop_window.tools.cluster_tool.on_project_unloaded
			develop_window.address_manager.on_project_unloaded

			create l_builder.make (develop_window)
			l_builder.build_menu_bar

			if develop_window.has_dll_generation then
				develop_window.show_dynamic_lib_tool.disable_sensitive
			end
			if develop_window.has_profiler then
				develop_window.commands.show_profiler.disable_sensitive
			end
			develop_window.commands.customized_formatter_command.enable_sensitive
			develop_window.commands.customized_tool_command.enable_sensitive
		end

	on_customized_tools_changed (a_changed_tools: LIST [STRING]) is
			-- Action to be performed when customized tools changes			
		require
			a_changed_tools_attached: a_changed_tools /= Void
			a_changed_tools_valid: not a_changed_tools.has (Void)
		local
			l_tools: EB_DEVELOPMENT_WINDOW_TOOLS
			l_customized_tools: LIST [EB_CUSTOMIZED_TOOL]
			l_main_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
			l_unchanged_tools: LIST [EB_CUSTOMIZED_TOOL]
		do
			l_tools := develop_window.tools
			create l_main_builder.make (develop_window)
			auto_recycle (l_main_builder)

				-- Remove changed tools.
			l_customized_tools := l_tools.customized_tools_from_tools (l_tools.customizable_tools_by_id (l_tools.customizable_tools, a_changed_tools, True))
			l_customized_tools.do_all (agent l_main_builder.deregister_customized_tool)

				-- Add changed/newly added tools.
			l_customized_tools := develop_window.customized_tool_manager.tools_by_ids (a_changed_tools, True, develop_window)
			l_main_builder.register_customized_tools (l_customized_tools)

				-- Refresh titile/pixmap/stone handlers for unchanged tools.
			l_unchanged_tools := l_tools.customized_tools_from_tools (l_tools.customizable_tools_by_id (l_tools.customizable_tools, a_changed_tools, False))
			if not l_unchanged_tools.is_empty then
				l_unchanged_tools.do_all (agent l_tools.refresh_customized_tool_appearance)
			end
		end

	on_customized_tools_changed_agent: PROCEDURE [ANY, TUPLE [LIST [STRING]]] is
			-- Agent of `on_cutomized_tools_changed'
		do
			if on_customized_tools_changed_agent_internal = Void then
				on_customized_tools_changed_agent_internal := agent on_customized_tools_changed
			end
			Result := on_customized_tools_changed_agent_internal
		end

feature {NONE} -- Implementation

	enable_commands_on_project_created is
			-- Enable commands when a new project has been created (not yet compiled)
		do
			develop_window.commands.system_info_cmd.enable_sensitive
			if
				develop_window.stone /= Void and then
				not develop_window.unified_stone
			then
				develop_window.commands.send_stone_to_context_cmd.enable_sensitive
			end
			develop_window.commands.new_class_cmd.enable_sensitive
			develop_window.commands.new_library_cmd.enable_sensitive
			develop_window.commands.new_assembly_cmd.enable_sensitive
			develop_window.commands.new_cluster_cmd.enable_sensitive
		end

	enable_commands_on_project_loaded is
			-- Enable commands when a new project has been created and compiled
		do
			if develop_window.has_profiler then
				develop_window.commands.show_profiler.enable_sensitive
			end
			if develop_window.has_dll_generation then
				develop_window.show_dynamic_lib_tool.enable_sensitive
			end
			develop_window.commands.system_info_cmd.enable_sensitive
			if develop_window.unified_stone then
				develop_window.commands.send_stone_to_context_cmd.disable_sensitive
			elseif develop_window.stone /= Void then
				develop_window.commands.send_stone_to_context_cmd.enable_sensitive
			end
			develop_window.commands.delete_class_cluster_cmd.enable_sensitive
			develop_window.commands.c_workbench_compilation_cmd.enable_sensitive
			develop_window.commands.c_finalized_compilation_cmd.enable_sensitive
			develop_window.refactoring_manager.enable_sensitive
			develop_window.commands.customized_formatter_command.enable_sensitive
			develop_window.commands.customized_tool_command.enable_sensitive
		end

	disable_commands_on_project_unloaded is
			-- Enable commands when a project has been closed.
		do
			if develop_window.has_dll_generation then
				develop_window.show_dynamic_lib_tool.disable_sensitive
			end
			if develop_window.has_profiler then
				develop_window.commands.show_profiler.disable_sensitive
			end
			develop_window.commands.new_class_cmd.disable_sensitive
			develop_window.commands.new_library_cmd.disable_sensitive
			develop_window.commands.new_assembly_cmd.disable_sensitive
			develop_window.commands.new_cluster_cmd.disable_sensitive
			if not develop_window.project_manager.is_created then
				develop_window.commands.system_info_cmd.disable_sensitive
				develop_window.commands.send_stone_to_context_cmd.disable_sensitive
			end
			develop_window.commands.delete_class_cluster_cmd.disable_sensitive
			develop_window.commands.c_workbench_compilation_cmd.disable_sensitive
			develop_window.commands.c_finalized_compilation_cmd.disable_sensitive
			develop_window.refactoring_manager.disable_sensitive
			develop_window.refactoring_manager.forget_undo_redo
			develop_window.commands.customized_formatter_command.disable_sensitive
			develop_window.commands.customized_tool_command.disable_sensitive
		end

	on_customized_tools_changed_agent_internal: like on_customized_tools_changed_agent
			-- Implementation of `on_customized_tools_changed_agent'

invariant
	not_void: not is_recycled implies develop_window /= Void

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
