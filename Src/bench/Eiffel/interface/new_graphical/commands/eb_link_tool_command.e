indexing
	description	: "Command to change links layout."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_LINK_TOOL_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			menu_name
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform on the whole diagram.
		local
			l_all_saved_edges: like all_saved_edges
			l_world: EIFFEL_WORLD
		do
			l_all_saved_edges := all_saved_edges
			l_world := tool.world
			if current_button.is_selected then
				l_world.enable_right_angles
				l_world.apply_right_angles
				history.register_named_undoable (
					interface_names.t_diagram_put_right_angles_cmd,
					[<<agent l_world.enable_right_angles, agent l_world.apply_right_angles, agent toggle_button>>],
					[<<agent l_world.disable_right_angles, agent undo_apply_right_angles (l_all_saved_edges), agent toggle_button>>])
			else
				l_world.disable_right_angles
				l_world.remove_right_angles
				history.register_named_undoable (
					interface_names.t_diagram_remove_right_angles_cmd,
					[<<agent l_world.disable_right_angles, agent l_world.remove_right_angles, agent toggle_button>>],
					[<<agent l_world.enable_right_angles, agent l_world.apply_right_angles, agent toggle_button>>])
			end
			current_button.set_tooltip (tooltip)
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
	
				link_tool_dialog.preset (tool.world.is_labels_shown)
	
				client_stone ?= a_stone
				if client_stone /= Void then
					link_tool_dialog.set_strings (client_stone.source.feature_names)
					link_tool_dialog.set_for_client_link
				else
						--| FIXME: `disable_user_resize' makes the development window
						--| go to the background when closing `link_tool_dialog'.
					link_tool_dialog.set_maximum_size (link_tool_dialog.width, link_tool_dialog.height)
				end
	
				link_tool_dialog.show_relative_to_window (tool.development_window.window)
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			current_button := Result
			initialize_toolbar_item (Result, display_text, use_gray_icons)
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
					if link_tool_dialog.applied then
						lf.reset
						lf.retrieve_edges (saved_edges)
						project
					end
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

	tooltip: STRING is
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

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_link_tool
		end

	menu_name: STRING is
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
			l_item: TUPLE [EIFFEL_LINK_FIGURE, LIST [EG_EDGE]]
			l_figure: EIFFEL_LINK_FIGURE
			l_saved_edges: LIST [EG_EDGE]
		do
			from
				edge_lists.start
			until
				edge_lists.after
			loop
				l_item := edge_lists.item
				l_figure ?= l_item.item (1)
				l_saved_edges ?= l_item.item (2)
				l_figure.reset
				l_figure.retrieve_edges (l_saved_edges)
				edge_lists.forth
			end
		end
		
	toggle_button is
			-- Toggle button without execution.
		do
			current_button.select_actions.block
			current_button.toggle
			current_button.set_tooltip (tooltip)
			current_button.select_actions.resume
		end
		
feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.
	
end -- class EB_LINK_TOOL_COMMAND
