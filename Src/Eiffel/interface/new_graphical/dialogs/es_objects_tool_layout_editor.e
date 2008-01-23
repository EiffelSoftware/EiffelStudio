indexing
	description: "Dialog to manage debugger's objects tool's layout ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_TOOL_LAYOUT_EDITOR

inherit
	ES_TOOL_DIALOG
		redefine
			on_after_initialized
		end

	ES_OBJECTS_GRID_SPECIFIC_LINE_CONSTANTS
		rename
			stack_id as position_stack,
			current_object_id as position_current,
			arguments_id as position_arguments,
			locals_id as position_locals,
			result_id as position_result,
			dropped_id as position_dropped
		export
			{NONE} all
		end

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	on_after_initialized is
            -- Use to perform additional creation initializations, after the UI has been created.		
		do
			Precursor {ES_TOOL_DIALOG}

			set_button_text (dialog_buttons.yes_button, interface_names.b_apply)
			set_button_action_before_close (dialog_buttons.yes_button, agent on_apply)
			set_button_text (dialog_buttons.no_button, interface_names.b_reset)
			set_button_action_before_close (dialog_buttons.no_button, agent on_reset)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)
		end

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			vb: EV_VERTICAL_BOX
		do
			create grid
			grid.set_column_count_to (1)
			grid.set_row_count_to (1)
			grid.enable_single_item_selection
			grid.enable_row_height_fixed
			register_action (grid.item_select_actions, agent on_grid_item_selected)
			register_action (grid.item_deselect_actions, agent on_grid_item_unselected)
			register_action (grid.key_release_actions, agent key_pressed_on_grid)

			create vb
			vb.set_border_width (1)
			vb.set_background_color (colors.stock_colors.black)
			vb.extend (grid)

			a_container.extend (vb)

			register_kamikaze_action (show_actions, agent update)
			register_action (show_actions, agent refresh)
			register_action (dialog.resize_actions, agent refresh)
		ensure then
			grid_attached: grid /= Void
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_edit_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.m_objects_tool_layout_editor_title
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.yes_no_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := {ES_DIALOG_BUTTONS}.yes_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := {ES_DIALOG_BUTTONS}.yes_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
			-- Note: The default cancel button is set on show, so if you want to change the
			--       default cancel button after the dialog has been shown, please see the implmentation
			--       of `show' to see how it is done.
		once
			Result := {ES_DIALOG_BUTTONS}.cancel_button
		end

feature {NONE} -- Access

	objects_tool: ES_OBJECTS_TOOL
			-- Access to debugger object tool
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
		do
			Result ?= development_window.shell_tools.tool ({ES_OBJECTS_TOOL})
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
		end


feature {NONE} -- User interface elements

	grid: EV_GRID

	button_arrow_up, button_arrow_down: SD_TOOL_BAR_BUTTON

feature {NONE} -- Actions

	update is
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			gids: LIST [STRING]
			l_keys: TWO_WAY_SORTED_SET [STRING]
			gid: STRING
			g: ES_OBJECTS_GRID
			lines: LIST [INTEGER]

			glab: EV_GRID_CHECKABLE_LABEL_ITEM
			i, j, k: INTEGER
			pos_entries: ARRAY [INTEGER]
			pos_titles, pos_tooltips: ARRAY [STRING_32]
			pos_missings: ARRAYED_LIST [INTEGER]
			l_has_all: BOOLEAN
		do
			gids := objects_tool.panel.objects_grid_ids
			grid.clear
			grid.set_row_count_to (0)
			if gids.count > 0 then

				grid.set_column_count_to (gids.count)

				create l_keys.make
				l_keys.append (gids)

				pos_entries := objects_tool.panel.position_entries

				create pos_titles.make (pos_entries.lower, pos_entries.upper)
				pos_titles[position_stack] := Interface_names.l_stack_information
				pos_titles[position_current] := Interface_names.l_current_object
				pos_titles[position_arguments] := Interface_names.l_arguments
				pos_titles[position_locals] := Interface_names.l_locals
				pos_titles[position_result] := Interface_names.l_result
				pos_titles[position_dropped] := Interface_names.l_dropped_references

				create pos_tooltips.make (pos_entries.lower, pos_entries.upper)
				pos_tooltips[position_stack] := Interface_names.f_stack_information
				pos_tooltips[position_current] := Interface_names.f_current_object
				pos_tooltips[position_arguments] := Interface_names.f_arguments
				pos_tooltips[position_locals] := Interface_names.f_locals
				pos_tooltips[position_result] := Interface_names.f_result
				pos_tooltips[position_dropped] := Interface_names.f_dropped_references

				from
					i := 1
					l_keys.start
				until
					l_keys.after
				loop
					gid := l_keys.item_for_iteration

					create pos_missings.make_from_array (pos_entries.deep_twin)
					l_has_all := True

					g := objects_tool.panel.objects_grid (gid)
					grid.column (i).set_title (g.name)
					grid.column (i).set_data (gid)
					lines := objects_tool.panel.ids_from_objects_grid (gid)
					if lines /= Void then
						from
							j := 1
							lines.start
						until
							lines.after
						loop
							k := lines.item_for_iteration
							pos_missings.prune_all (k)
							create glab.make_with_text (pos_titles[k])
							glab.set_tooltip (pos_tooltips[k])
							glab.set_is_checked (True)
							glab.set_data (k.out)
							grid.set_item (i, j, glab)
							j := j + 1
							lines.forth
						end
						l_has_all := pos_missings.is_empty
						if not l_has_all then
							from
								pos_missings.start
							until
								pos_missings.after
							loop
								k := pos_missings.item_for_iteration
								if k > 0 then
									create glab.make_with_text (pos_titles[k])
									glab.set_tooltip (pos_tooltips[k])
									glab.set_is_checked (False)
									glab.set_data (k.out)
									grid.set_item (i, j, glab)
									j := j + 1
								end
								pos_missings.forth
							end
						end
					end
					i := i + 1
					l_keys.forth
				end
				refresh
			end
		end

	refresh is
			-- Refresh due to show or resize action
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			i: INTEGER
			m,w: INTEGER
		do
			if grid.row_count > 0 then
				m := grid.column (1).required_width_of_item_span (1, grid.row_count)
			end
			if grid.width < grid.column_count * m then
				grid.set_minimum_width (grid.column_count * m + 90)
			else
				w := grid.width // grid.column_count
				from
					i := 1
				until
					i > grid.column_count
				loop
					grid.column (i).set_width (w)
					i := i + 1
				end
			end
			if grid.row_count > 0 then
				grid.set_minimum_height (30 + grid.row_height * (1 + grid.row_count))
			end
		end

	on_grid_item_selected (gi: EV_GRID_ITEM) is
			-- item selected
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if gi /= Void and then gi.parent /= Void then
				if gi.row.index > 1 then
					button_arrow_up.enable_sensitive
				else
					button_arrow_up.disable_sensitive
				end
				if gi.row.index < gi.parent.row_count then
					button_arrow_down.enable_sensitive
				else
					button_arrow_down.disable_sensitive
				end
			end
		end

	on_grid_item_unselected (gi: EV_GRID_ITEM) is
			-- item unselected
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			button_arrow_up.disable_sensitive
			button_arrow_down.disable_sensitive
		end

	key_pressed_on_grid (k: EV_KEY) is
			--
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			i: EV_GRID_ITEM
			ch: EV_GRID_CHECKABLE_LABEL_ITEM
			lst: LIST [EV_GRID_ITEM]
		do
			lst := grid.selected_items
			if not lst.is_empty then
				i := lst.first
				inspect k.code
				when {EV_KEY_CONSTANTS}.key_numpad_subtract then
					if ev_application.ctrl_pressed then
						move_cell_by (i, -1)
					end
				when {EV_KEY_CONSTANTS}.key_numpad_add then
					if ev_application.ctrl_pressed then
						move_cell_by (i, +1)
					end
				when {EV_KEY_CONSTANTS}.key_space then
					ch ?= i
					if ch /= Void then
						ch.set_is_checked (not ch.is_checked)
					end
				else
				end
			end
		end

	move_cell_by (a_cell: EV_GRID_ITEM; by: INTEGER) is
			--
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			i,o: EV_GRID_ITEM
			lst: LIST [EV_GRID_ITEM]
			c,r: INTEGER
		do
			i := a_cell
			if i = Void then
				lst := grid.selected_items
				if not lst.is_empty then
					i := lst.first
				end
			end
			if i /= Void then
				r := i.row.index
				if
					(by > 0 and then r + by <= grid.row_count)
					or (by < 0 and then r + by >= 1)
				then
					c := i.column.index
					o := grid.item (c, r + by)
					grid.remove_item (c, r)
					grid.set_item (c, r + by, i)
					grid.set_item (c, r, o)
					i.enable_select
				end
			end
		end

feature {NONE} -- Action handlers

	on_apply is
			-- Called when the Apply button is pressed.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			i,j,nb: INTEGER
			s: STRING
			ar: ARRAY [STRING]
			g: EV_GRID_CHECKABLE_LABEL_ITEM
		do
			from
				nb := 0
				i := 1
			until
				i > grid.column_count
			loop
				nb := nb + 1
				from
					j := 1
				until
					j > grid.row_count
				loop
					g ?= grid.item (i, j)
					if g /= Void and then g.is_checked then
						nb := nb + 1
					end
					j := j + 1
				end
				i := i + 1
			end
			create ar.make (1, nb)
			from
				nb := 1
				i := 1
			until
				i > grid.column_count
			loop
				s ?= grid.column (i).data
				check s /= Void end
				ar.put ("#" + s, nb)
				nb := nb + 1

				from
					j := 1
				until
					j > grid.row_count
				loop
					g ?= grid.item (i, j)
					if g /= Void and then g.is_checked then
						s ?= g.data
						ar.put (s, nb)
						nb := nb + 1
					end
					j := j + 1
				end
				i := i + 1
			end
			objects_tool.panel.change_objects_layout_preference_value (ar)

				-- Prevents dialog from being closed
			veto_close
		ensure then
			is_close_vetoed: is_close_vetoed
		end

	on_reset is
			-- Called when the Reset button is pressed.
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
		do
			objects_tool.panel.reset_objects_grids_contents_to_default
			update

				-- And then apply the reset
			on_apply

				-- Prevents dialog from being closed
			veto_close
		ensure then
			is_close_vetoed: is_close_vetoed
		end

	on_cancel is
			-- Called when the Cancel button is pressed.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
		end

feature {NONE} -- Factory

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		do
			create Result.make (2)
			create button_arrow_up.make
			button_arrow_up.set_pixel_buffer (stock_pixmaps.general_move_up_icon_buffer)
			register_action (button_arrow_up.select_actions, agent move_cell_by (Void, -1))
			button_arrow_up.disable_sensitive
			button_arrow_up.set_tooltip (interface_names.f_move_item_up)
			Result.put_last (button_arrow_up)

			create button_arrow_down.make
			button_arrow_down.set_pixel_buffer (stock_pixmaps.general_move_down_icon_buffer)
			register_action (button_arrow_down.select_actions, agent move_cell_by (Void, 1))
			button_arrow_down.disable_sensitive
			button_arrow_down.set_tooltip (interface_names.f_move_item_down)
			Result.put_last (button_arrow_down)
		ensure then
			button_arrow_up_attached: button_arrow_up /= Void
			button_arrow_down_attached: button_arrow_down /= Void
		end

;indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
