indexing
	description	: "Command to change links layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_LINK_TOOL_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		undefine
			menu_name
		redefine
			new_sd_toolbar_item,
			initialize
		end

	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND
		redefine
			menu_name
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_r),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform on the whole diagram.
		local
			l_all_saved_edges: like all_saved_edges
			l_world: EIFFEL_WORLD
			l_string: STRING_GENERAL
		do
			if is_sensitive then
				l_all_saved_edges := all_saved_edges
				l_world := tool.world
				if not l_world.is_right_angles then
					l_world.enable_right_angles
					l_world.apply_right_angles
					enable_select
					history.register_named_undoable (
						interface_names.t_diagram_put_right_angles_cmd,
						[<<agent l_world.enable_right_angles, agent l_world.apply_right_angles, agent enable_select>>],
						[<<agent l_world.disable_right_angles, agent undo_apply_right_angles (l_all_saved_edges), agent disable_select>>])
				else
					l_world.disable_right_angles
					l_world.remove_right_angles
					disable_select
					history.register_named_undoable (
						interface_names.t_diagram_remove_right_angles_cmd,
						[<<agent l_world.disable_right_angles, agent l_world.remove_right_angles, agent disable_select>>],
						[<<agent l_world.enable_right_angles, agent l_world.apply_right_angles, agent enable_select>>])
				end
				l_string := tooltip.twin
				l_string.append (shortcut_string.as_string_32)
				current_button.set_tooltip (l_string)
			end
		end

	execute_with_link_stone (a_stone: LINK_STONE) is
			-- Change `a_stone' layout as the user wants.
		local
			lf: EIFFEL_LINK_FIGURE
			x_pos, y_pos: INTEGER
			client_stone: CLIENT_STONE
			screen: EV_SCREEN
		do
			if a_stone.source.world = tool.world then
				create link_tool_dialog
				link_tool_dialog.set_link_tool_command (Current)

					-- Save current link midpoints.
				lf := a_stone.source
				link_tool_dialog.set_link_figure (lf)
				saved_edges := lf.edges

				create screen
				x_pos := screen.pointer_position.x - link_tool_dialog.width // 2
				y_pos := screen.pointer_position.y - link_tool_dialog.height // 2
				link_tool_dialog.set_position (x_pos, y_pos)

				client_stone ?= a_stone
				if client_stone /= Void then
					link_tool_dialog.set_strings (client_stone.source.feature_names)
					link_tool_dialog.set_for_client_link
				else
						--| FIXME: `disable_user_resize' makes the development window
						--| go to the background when closing `link_tool_dialog'.
					link_tool_dialog.set_maximum_size (link_tool_dialog.width, link_tool_dialog.height)
				end

				link_tool_dialog.show_relative_to_window (tool.develop_window.window)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON is
			-- Create a new sd toolbar button for this command.
		do
			create Result.make (Current)
			current_button := Result
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
			Result.drop_actions.extend (agent execute_with_link_stone)
		end

feature {EB_LINK_TOOL_DIALOG} -- Implementation

	on_dialog_closed is
			-- The user made his mind.
		local
			lf: EIFFEL_LINK_FIGURE
			new_edges: LIST [EG_EDGE]
		do
			check
				saved_edges_not_void: saved_edges /= Void
			end
			lf := link_tool_dialog.link_figure

				-- We need to check that `lf' is still on the diagram.
			if lf.world /= Void then
				if not link_tool_dialog.cancelled then
					if not lf.is_reflexive then
						if not link_tool_dialog.reset_selected then
							lf.hide
							project
							if link_tool_dialog.handle_left_selected then
								lf.put_handle_left
							elseif link_tool_dialog.handle_right_selected then
								lf.put_handle_right
							elseif link_tool_dialog.two_handles_left_selected then
								lf.put_two_handles_left
							elseif link_tool_dialog.two_handles_right_selected then
								lf.put_two_handles_right
							end
							lf.show
							project
						end

						new_edges := lf.edges
						if link_tool_dialog.handle_left_selected then
							history.register_named_undoable (
								Interface_names.t_Diagram_put_one_handle_left_cmd,
								[<<agent lf.reset, agent lf.retrieve_edges (new_edges)>>],
								[<<agent lf.reset, agent lf.retrieve_edges (saved_edges)>>])
						elseif link_tool_dialog.handle_right_selected then
							history.register_named_undoable (
								Interface_names.t_Diagram_put_one_handle_right_cmd,
								[<<agent lf.reset, agent lf.retrieve_edges (new_edges)>>],
								[<<agent lf.reset, agent lf.retrieve_edges (saved_edges)>>])
						elseif link_tool_dialog.two_handles_left_selected then
							history.register_named_undoable (
								Interface_names.t_Diagram_put_two_handles_left_cmd,
								[<<agent lf.reset, agent lf.retrieve_edges (new_edges)>>],
								[<<agent lf.reset, agent lf.retrieve_edges (saved_edges)>>])
						elseif link_tool_dialog.two_handles_right_selected then
							history.register_named_undoable (
								Interface_names.t_Diagram_put_two_handles_right_cmd,
								[<<agent lf.reset, agent lf.retrieve_edges (new_edges)>>],
								[<<agent lf.reset, agent lf.retrieve_edges (saved_edges)>>])
						elseif link_tool_dialog.reset_selected then
							history.do_named_undoable (
								Interface_names.t_Diagram_remove_handles_cmd,
								agent lf.reset,
								agent lf.retrieve_edges (saved_edges))
						end
					end
				else
					lf.reset
					lf.retrieve_edges (saved_edges)
					project
				end
			end
			link_tool_dialog.destroy
		end

	project is
			-- Call the projector.
		do
			tool.projector.project
		end

feature -- Access

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_remove_right_angles
			else
				Result := Interface_names.f_diagram_put_right_angles
			end
		end

feature {NONE} -- Implementation

	current_stone: LINK_STONE
			-- Last dropped stone.

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_force_right_angles_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_force_right_angles_icon_buffer
		end

	menu_name: STRING_GENERAL is
			-- Name of the menu entry
		do
			Result := Interface_names.m_diagram_link_tool
		end

	name: STRING is "Link_tool"
			-- Name of the command. Used to store the command in the
			-- preferences.

	link_tool_dialog: EB_LINK_TOOL_DIALOG
			-- Associated widget.

	saved_edges: LIST [EG_EDGE]
			-- Backup of previous link midpoints.

	all_saved_edges: LIST [TUPLE [EIFFEL_LINK_FIGURE, LIST [EG_EDGE]]] is
			--
		local
			l_edges: LIST [EG_LINK_FIGURE]
			l_item: EIFFEL_LINK_FIGURE
		do
			l_edges := tool.world.flat_links
			create {ARRAYED_LIST [TUPLE [EIFFEL_LINK_FIGURE, LIST [EG_EDGE]]]} Result.make (l_edges.count)
			from
				l_edges.start
			until
				l_edges.after
			loop
				l_item ?= l_edges.item
				if l_item /= Void then
					Result.extend ([l_item, l_item.edges])
				end
				l_edges.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	undo_apply_right_angles (edge_lists: like all_saved_edges) is
			--
		local
			l_item: TUPLE [figure: EIFFEL_LINK_FIGURE; edges: LIST [EG_EDGE]]
			l_figure: EIFFEL_LINK_FIGURE
			l_saved_edges: LIST [EG_EDGE]
		do
			from
				edge_lists.start
			until
				edge_lists.after
			loop
				l_item := edge_lists.item
				l_figure := l_item.figure
				l_saved_edges := l_item.edges
				l_figure.reset
				l_figure.retrieve_edges (l_saved_edges)
				edge_lists.forth
			end
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Implementation

	current_button: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON;
			-- Current toggle button.

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

end -- class EB_LINK_TOOL_COMMAND
