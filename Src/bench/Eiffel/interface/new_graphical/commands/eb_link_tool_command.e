indexing
	description	: "Command to change links layout."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_LINK_TOOL_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform on the whole diagram.
		local
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			d.hide_links
			project
			d.use_right_angles
			d.show_links
			project
			history.register_named_undoable (
				Interface_names.t_Diagram_put_right_angles_cmd,
				[<<d~hide_links, ~project, d~redo_right_angles, d~show_links, ~project>>],
				[<<d~hide_links, ~project, d~undo_right_angles, d~show_links, ~project>>])
		end

	execute_with_link_stone (a_stone: LINK_STONE) is
			-- Change `a_stone' layout as the user wants.
		local
			stone_midpoints: LINKED_LIST [LINK_MIDPOINT]
			lf: LINK_FIGURE
			x_pos, y_pos: INTEGER
			d: CONTEXT_DIAGRAM
			client_stone: CLIENT_STONE
			screen: EV_SCREEN
		do
			create saved_midpoints.make
			current_stone := a_stone
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			if a_stone.source.world = d then
				create link_tool_dialog
				link_tool_dialog.set_link_tool_command (Current)
	
					-- Save current link midpoints.
				lf := a_stone.source
				link_tool_dialog.set_link_figure (lf)
				stone_midpoints := lf.midpoints
				from
					stone_midpoints.start
				until
					stone_midpoints.after
				loop
					saved_midpoints.put_front (stone_midpoints.item)
					stone_midpoints.forth
				end
	
				create screen
				x_pos := screen.pointer_position.x - link_tool_dialog.width // 2
				y_pos := screen.pointer_position.y - link_tool_dialog.height // 2
				link_tool_dialog.set_position (x_pos, y_pos)
	
				link_tool_dialog.preset (d.labels_shown)
	
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

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_link_stone)
		end

feature {EB_LINK_TOOL_DIALOG} -- Implementation

	on_dialog_closed is
			-- The user made his mind.
		local
			lf: LINK_FIGURE
			new_midpoints, stone_midpoints: LINKED_LIST [LINK_MIDPOINT]
		do
			lf := link_tool_dialog.link_figure
			
				-- We need to check that `lf' is still on the diagram.
			if lf.world /= Void then
				if not link_tool_dialog.cancelled then
					if not lf.is_reflexive then
						create new_midpoints.make
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
						
							-- Save current link midpoints.
						stone_midpoints := lf.midpoints
						from
							stone_midpoints.start
						until
							stone_midpoints.after
						loop
							new_midpoints.put_front (stone_midpoints.item)
							stone_midpoints.forth
						end
													
						if link_tool_dialog.handle_left_selected then
							history.register_named_undoable (
								Interface_names.t_Diagram_put_one_handle_left_cmd,
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (new_midpoints), 
									lf~show, ~project>>],
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (saved_midpoints),
									lf~show, ~project>>])
						elseif link_tool_dialog.handle_right_selected then			
							history.register_named_undoable (
								Interface_names.t_Diagram_put_one_handle_right_cmd,
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (new_midpoints),
									lf~show, ~project>>],
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (saved_midpoints),
									lf~show, ~project>>])
						elseif link_tool_dialog.two_handles_left_selected then			
							history.register_named_undoable (
								Interface_names.t_Diagram_put_two_handles_left_cmd,
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (new_midpoints),
									lf~show, ~project>>],
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (saved_midpoints),
									lf~show, ~project>>])
						elseif link_tool_dialog.two_handles_right_selected then			
							history.register_named_undoable (
								Interface_names.t_Diagram_put_two_handles_right_cmd,
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (new_midpoints),
									lf~show, ~project>>],
								[<<lf~hide, ~project, lf~reset, lf~retrieve_midpoints (saved_midpoints),
									lf~show, ~project>>])
						elseif link_tool_dialog.reset_selected then
							history.do_named_undoable (
								Interface_names.t_Diagram_remove_handles_cmd,
								[<<lf~hide, ~project, lf~reset, lf~show, ~project>>],
								[<<lf~retrieve_midpoints (saved_midpoints), ~project>>])
						end
					end
				else
					if link_tool_dialog.applied then
						lf.reset
						lf.retrieve_midpoints (saved_midpoints)
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

feature {NONE} -- Implementation

	current_stone: LINK_STONE
			-- Last dropped stone.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_link_tool
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Put right angles"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Link tool"
		end

	name: STRING is "Link_tool"
			-- Name of the command. Used to store the command in the
			-- preferences.

	link_tool_dialog: EB_LINK_TOOL_DIALOG
			-- Associated widget.
			
	saved_midpoints: LINKED_LIST [LINK_MIDPOINT]
			-- Backup of previous link midpoints.
	
end -- class EB_LINK_TOOL_COMMAND
