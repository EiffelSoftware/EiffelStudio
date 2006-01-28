indexing
	description: "Objects that surround a tool with a title%
		%and minimize and maximize buttons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLE_SPLIT_AREA_TOOL_HOLDER

inherit
	EV_HORIZONTAL_BOX

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: EV_WIDGET; a_display_name: STRING; a_parent: MULTIPLE_SPLIT_AREA) is
			-- Create `Current', and initalize with
			-- tool `a_tool'. Use `display_name' for title of `a_tool'.
		require
			tool_not_void: a_tool /= Void
			display_name_not_void: a_display_name /= Void
			parent_not_void: a_parent /= Void
		local
			vertical_box: EV_VERTICAL_BOX
			frame: EV_FRAME
			temp_cell: EV_CELL
			l_platform: PLATFORM
		do
			default_create
			parent_area := a_parent
			tool := a_tool

			create main_box
			extend (main_box)
			create minimum_size_cell
			extend (minimum_size_cell)
			disable_item_expand (minimum_size_cell)
			create label_box

			create l_platform
			if l_platform.is_windows then
				create frame
				frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
				main_box.extend (frame)
			end

			create vertical_box

			if l_platform.is_windows then
				frame.extend (vertical_box)
			else
				main_box.extend (vertical_box)
			end
			create frame
			frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_raised)
			vertical_box.extend (frame)
			frame.extend (label_box)
			create label.make_with_text (a_display_name)
			display_name := a_display_name
			label.align_text_left
			label_box.extend (label)
			label_box.disable_item_expand (label)
			create temp_cell
			temp_cell.set_minimum_width (8)
			label_box.extend (temp_cell)
			label_box.disable_item_expand (temp_cell)
			create customizeable_area
			label_box.extend (customizeable_area)
			label_box.set_data (display_name)
			create tool_bar
			create minimize_button
			minimize_button.set_pixmap (parent_area.minimize_pixmap.twin)
			minimize_button.select_actions.extend (agent change_minimized_state)
			minimize_button.set_tooltip (minimize_tooltip)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap (parent_area.maximize_pixmap.twin)
			maximize_button.select_actions.extend (agent change_maximized_state)
			maximize_button.set_tooltip (maximize_tooltip)
			tool_bar.extend (maximize_button)
			create close_button
			close_button.set_pixmap (parent_area.close_pixmap.twin)
			close_button.select_actions.extend (agent close)
			close_button.set_tooltip (close_tooltip)
			label_box.extend (tool_bar)
			label_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (frame)
			parent_area.set_holder_tool_height (main_box.height)
			vertical_box.extend (a_tool)

				-- Set up docking for `Current'.
			label.enable_dockable
			label.set_real_source (main_box)
			label.dock_ended_actions.extend (agent docking_ended)
			label.dock_started_actions.extend (agent docking_started)
		ensure
			parent_area_set: parent_area = a_parent
		end

feature {MULTIPLE_SPLIT_AREA, MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Access

	lower_box: EV_VERTICAL_BOX is
			-- `Result' is lower box associated with `Current'. Minimized tools
			-- below `Current' in `parent_area' are inserted within here.
		require
			parent_area_not_void: parent_area /= Void
			not_external: not is_external
		local
			l_parent: EV_VERTICAL_BOX
		do
			l_parent ?= parent
			check
				l_parent_not_void: l_parent /= Void
			end
			Result ?= l_parent.i_th (3)
		ensure
			result_not_void: Result /= Void
		end

	upper_box: EV_VERTICAL_BOX is
			-- `Result' is upper box associated with `Current'. Minimized tools
			-- above `Current' in `parent_area' are inserted within here.
		require
			parent_area_not_void: parent_area /= Void
			not_external: not is_external
		local
			l_parent: EV_VERTICAL_BOX
		do
			l_parent ?= parent
			check
				l_parent_not_void: l_parent /= Void
			end
			Result ?= l_parent.i_th (1)
		ensure
			result_not_void: Result /= Void
		end

	main_box: EV_VERTICAL_BOX
		-- Main box, directly parented in `Current'.

	is_external: BOOLEAN is
			-- Is `Current' external to `parent_area' and
			-- therefore contained in a dockable dialog?
		do
			Result := parent_dockable_dialog (main_box) /= Void
				-- Note that we do not check `Current', as `main_box'
				-- is pruned from `Current' during the external dock, and only
				-- re-inserted when the dialog is closed.
		end

	is_minimized: BOOLEAN
		-- Is `Current' minimized?

	is_maximized: BOOLEAN
		-- Is `Current' maximized?

	position_docked_from: INTEGER
		-- Position of `Current' at time it was docked from `parent_area'.
		-- Used as the index within `parent_area' to restore `Current' when a dockable
		-- dialog containing `Current' is closed.

feature {MULTIPLE_SPLIT_AREA, MULTIPLE_SPLIT_AREA_TOOL_HOLDER}-- Access

	command_tool_bar: EV_TOOL_BAR
		-- A toolbar with specific commands related to `tool',
		-- or Void if not set.

	tool: EV_WIDGET
		-- Tool in `Current'.

	disable_minimized is
			-- Assign `False' to `minimized'.
		do
			is_minimized := False
		ensure
			not_minimized: not is_minimized
		end

	enable_minimized is
			-- Assign `True' to `minimized'.
		do
			is_minimized := True
		ensure
			minimized: is_minimized
		end

	disable_maximized is
			-- Assign `False' to `maximized'.
		do
			is_maximized := False
		ensure
			not_maximized: not is_maximized
		end

	enable_maximized is
			-- Assign `True' to `maximized'.
		do
			is_maximized := True
		ensure
			maximized: is_maximized
		end

	disable_minimize_button is
			-- Ensure `minimize_button' is non sensitive.
		do
			if not parent_area.disabled_minimize_button_shown then
				tool_bar.prune (minimize_button)
			end
			minimize_button.disable_sensitive
		end

	enable_minimize_button is
			-- Ensure `minimize_button' is sensitive.
		do
			if not parent_area.disabled_minimize_button_shown and not tool_bar.has (minimize_button) then
				tool_bar.go_i_th (1)
				tool_bar.put_left (minimize_button)
			end
			minimize_button.enable_sensitive
		end

	enable_close_button is
			-- Ensure a close button is displayed for `Current'.
		do
			if close_button.parent = Void then
				tool_bar.extend (close_button)
			end
		end

	enable_close_button_as_grayed is
			-- Ensure a close button is displayed as grayed for `Current'.
		do
			if close_button.parent = Void then
				tool_bar.extend (close_button)
			end
			close_button.disable_sensitive
		end

	disable_close_button is
			-- Ensure no close button is displayed for `Current'.
		do
			if close_button.parent /= Void then
				close_button.parent.prune_all (close_button)
			end
		end

	remove_maximized_restore is
			-- Ensure that `maximize_button' displays the maximize pixmap.
		do
			maximize_button.set_pixmap (parent_area.maximize_pixmap)
		end

feature {MULTIPLE_SPLIT_AREA, MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Implemnetation

	parent_area: MULTIPLE_SPLIT_AREA
		-- Parent of `Current'.

	restore_height: INTEGER
		-- Height to restore to `Current'.

	set_restore_height (a_height: INTEGER) is
			-- Assign `a_height' to `restore_height'.
		require
			a_height_positive: a_height > 0
		do
			restore_height := a_height
		ensure
			restore_height_set: restore_height = a_height
		end

	simulate_minimum_height (a_height: INTEGER) is
			-- Force `Current' to be displayed at least `a_height', as
			-- if a minimum size had been set. `Current' will not be reduced if
			-- larger. We cannot directly assign a minimum_height as
			-- this changes the behaviour of containers.
		require
			a_height_positive: a_height >= 0
		do
			minimum_size_cell.set_minimum_height (a_height)
		ensure
			minimum_height_simulated: minimum_size_cell.minimum_height = a_height
		end

	remove_simulated_height is
			-- Remove any "minimum" height set through `simulate_minimum_height'.
		do
			minimum_size_cell.set_minimum_height (0)
		ensure
			minimum_size_removed: minimum_size_cell.minimum_height = 0
		end

	set_position_docked_from (a_position: INTEGER) is
			-- Assign `a_position' to `position_docked_from'.
		require
			a_position >= 1
		do
			position_docked_from := a_position
		ensure
			position_set: position_docked_from = a_position
		end


feature {MULTIPLE_SPLIT_AREA} -- Implementation

	destroy_dialog_and_restore (dialog: EV_DOCKABLE_DIALOG) is
			-- Destroy `dialog' and restore `Current' into `parent_area'.
		require
			dialog_not_void: dialog /= Void
			parented_in_dialog: parent_dockable_dialog (tool) = dialog
		local
			tool_height: INTEGER
			locked_in_here, is_expanded: BOOLEAN
			original_parent_window: EV_WINDOW
			widget: EV_WIDGET
		do
			tool_height := main_box.height
			tool.parent.prune_all (tool)
			parent_area.all_holders.prune_all (Current)
			dialog.destroy
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				original_parent_window := parent_window (parent_area)
				if original_parent_window /= Void then
					original_parent_window.lock_update
				end
			end
			parent_area.external_representation.prune_all (tool)
			parent_area.insert_widget (tool, display_name, (position_docked_from.min (parent_area.count + 1)).max (1), tool_height)

				-- Now take all widgets inserted into `customizeable_area' of `Current',
				-- and associated them with `tool' in `parent_area', so that the
				-- customization is not lost.
			from
				customizeable_area.start
			until
				customizeable_area.is_empty
			loop
				widget := customizeable_area.item
				is_expanded := customizeable_area.is_item_expanded (widget)
				customizeable_area.remove
				parent_area.customizeable_area_of_widget (tool).extend (widget)
				if not is_expanded then
					parent_area.customizeable_area_of_widget (tool).disable_item_expand (widget)
				end
			end
			if original_parent_window /= Void then
				original_parent_window.unlock_update
			end
			parent_area.docked_in_actions.call ([tool])
		ensure
			put_back_in_split_area: parent_area.linear_representation.has (tool)
		end

feature {MULTIPLE_SPLIT_AREA} -- Implementation

	parent_dockable_dialog (widget: EV_WIDGET): EV_DOCKABLE_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: widget /= Void
		local
			dialog: EV_DOCKABLE_DIALOG
		do
			dialog ?= widget.parent
			if dialog = Void then
				if widget.parent /= Void then
					Result := parent_dockable_dialog (widget.parent)
				end
			else
				Result := dialog
			end
		end

	customizeable_area: EV_HORIZONTAL_BOX
		-- An area which may be customized by a user. Located between
		-- the name label and minimize maximize tool bar.

feature {NONE} -- Implementation

	docking_started is
			-- Respond to dock starting on `Current'.
		do
			parent_area.store_positions
			parent_area.initialize_docking_areas (Current)
			if parent_dockable_dialog (main_box) = Void then
				original_height := height
				original_width := width
			end
		end

	original_height, original_width: INTEGER
		-- Original width and height before dock.

	docking_ended is
			-- A dock has ended, so close dialog, and restore `Current'
		local
			dialog: EV_DOCKABLE_DIALOG
			original_position, new_position: INTEGER
			original_parent_window: EV_WINDOW
			locked_in_here: BOOLEAN
			minimized_count: INTEGER
			tool_holder: like Current
			parent_rep: LINEAR [EV_WIDGET]
			horizontal_box: EV_HORIZONTAL_BOX
			widget: EV_WIDGET
			temp_value: INTEGER
		do
			original_position := parent_area.linear_representation.index_of (tool, 1)
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				original_parent_window := parent_window (parent_area)
				if original_parent_window /= Void then
					original_parent_window.lock_update
				end
			end

			dialog := parent_dockable_dialog (tool)
			if dialog /= Void then
				parent_area.remove_docking_areas
				parent_area.store_positions
				check
					parent_area_not_void: parent_area /= Void
				end
				if is_minimized then
						-- Remove minimized state from `Current' as it has
						-- been docked out of the multiple split area.
					disable_minimized
					minimize_button.set_pixmap (parent_area.minimize_pixmap)
					tool.show
					dialog.set_height (default_external_docked_height)
				end

				dialog.close_request_actions.wipe_out
				dialog.close_request_actions.extend (agent destroy_dialog_and_restore (dialog))
				position_docked_from := parent_area.linear_representation.index_of (tool, 1)
				parent_area.linear_representation.prune_all (tool)
				if not parent_area.is_item_external (tool) then
					parent_area.external_representation.extend (tool)
				end
					-- Now must check that the number of minimized items is not equal
					-- to the number of items still remaining. If this is the case,
					-- one must be removed from its minimized state.
				parent_rep := parent_area.linear_representation
				from
					parent_rep.start
				until
					parent_rep.off
				loop
					if parent_area.holder_of_widget (parent_rep.item).is_minimized then
						minimized_count := minimized_count + 1
					end
					parent_rep.forth
				end
				if parent_area.count > 0 and then minimized_count = parent_area.count then
					parent_rep.start
						-- Ensure that we select the first item
					tool_holder := parent_area.holder_of_widget (parent_rep.item)
					tool_holder.disable_minimized
					tool_holder.minimize_button.set_pixmap (parent_area.minimize_pixmap)
					tool_holder.tool.show
				end

					-- This ensures that we only set the height when `Current' has just been docked from
					-- `parent_area'.
				if not (original_height = 0 and original_width = 0) then
					dialog.set_width (original_width + (dialog.width - dialog.item.width))
					dialog.set_height (original_height + (dialog.height - dialog.item.height))
				end
				minimize_button.disable_sensitive
				maximize_button.disable_sensitive
				parent_area.store_positions
				parent_area.rebuild
				parent_area.restore_stored_positions
				if not (original_height = 0 and original_width = 0) then
					parent_area.docked_out_actions.call ([tool])
				end
			end
			if parent /= Void then
				parent.prune (Current)
			end
				-- `main_box' is moved during a transport, so we must re-insert it
				-- in `Current'
			if dialog = Void then
				if main_box.parent /= Void then
					check
						data_is_integer: main_box.parent.data.out.is_integer
					end
					new_position := main_box.parent.data.out.to_integer
					check
						position_retrieved: new_position > 0
					end
					main_box.parent.prune_all (main_box)
					extend (main_box)
				end
					-- If `original_position' = 0, the tool is being docked back from
					-- a dockable dialog via the docking mechanism, not by closing the
					-- dialog via the cross.
				if original_position = 0 then
					parent_area.all_holders.prune_all (Current)
						-- Must now remove the tool from its parent, part of `Current'.
					tool.parent.prune_all (tool)

						-- Remove `tool' from the external representation.
					parent_area.external_representation.prune_all (tool)

						-- FIXME Need to insert the tool back at its current size.
						-- However, at this point, we have no access to its previous size. If
						-- the size was stored when a dock began (`dock_started_actions'), then it could be
						-- restored here. Julian 09/15/03
					parent_area.insert_widget (tool, display_name, new_position, tool.minimum_height.max (100))

						-- Now copy all contents of customizeable area into new holder area.
					horizontal_box := parent_area.customizeable_area_of_widget (tool)
					from
						customizeable_area.start
					until
						customizeable_area.is_empty
					loop
						widget := customizeable_area.item
						customizeable_area.remove
						horizontal_box.extend (widget)
					end
				else
						-- Now swap the stored positions of the two items that have just changed places.
						-- This ensures that they do not resize. The positions were originally generated at
						-- the start of the dock, so must take into account the re-ordering.
					temp_value := parent_area.stored_splitter_widths.i_th (original_position)
					parent_area.stored_splitter_widths.go_i_th (new_position)
					parent_area.stored_splitter_widths.put_left (temp_value)
					if new_position >= original_position then
						parent_area.stored_splitter_widths.go_i_th (original_position)
					else
						parent_area.stored_splitter_widths.go_i_th (original_position + 1)
					end
					parent_area.stored_splitter_widths.remove
					--parent_area.stored_splitter_widths.put_i_th (parent_area.stored_splitter_widths.i_th (new_position.min (parent_area.count)), original_position)
					--parent_area.stored_splitter_widths.put_i_th (temp_value, new_position.min (parent_area.count))

					parent_area.update_for_holder_position_change (Current, new_position)
					parent_area.rebuild
					parent_area.restore_stored_positions
				end
				parent_area.docked_in_actions.call ([tool])
			end
			if original_parent_window /= Void then
				original_parent_window.unlock_update
			end

				-- Reset `original_width' and `original_height' so that we no longer assume that
				-- we have just been docked from `parent_area'.
			original_height := 0
			original_width := 0
		end

	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: widget /= Void
		local
			window: EV_WINDOW
		do
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := parent_window (widget.parent)
				end
			else
				Result := window
			end
		end

	change_minimized_state is
			-- Minimize `Current' if not minimized, restore otherwise.
		do
			if not is_minimized then
				parent_area.minimize_item (tool)
			else
				parent_area.restore_item (tool)
			end
		end

	close is
			-- Respond to a user selecting the close icon.
		do
			parent_area.close_actions.call ([tool])
		end

	calculate_restore_height (tool_height: INTEGER): INTEGER is
			-- Calculate height at which `Current' will be restored in `parent_area'.
			-- `tool_height' is the current height, which is the desired height, however
			-- if this is too large, it will expand `parent_area', hence we must constrain
			-- it to the allowable space.
		require
			tool_height_valid: tool_height >= 0
		local
			minimum_height_sum: INTEGER
			all_holders: ARRAYED_LIST [MULTIPLE_SPLIT_AREA_TOOL_HOLDER]
			a_cursor: CURSOR
		do
			all_holders := parent_area.all_holders
			a_cursor := all_holders.cursor
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item /= Current and then not all_holders.item.is_external then
					minimum_height_sum := minimum_height_sum  + all_holders.item.minimum_height
				end
				all_holders.forth
			end
			Result := tool_height.min (parent_area.height - minimum_height_sum)
			all_holders.go_to (a_cursor)
		ensure
			index_not_changed: old parent_area.all_holders.index = parent_area.all_holders.index
			result_valid: Result >= 0 and Result <= tool_height
		end


	change_maximized_state is
			-- Maximize `Current' if not maxamized, restore otherwise.
		do
			if is_maximized then
				parent_area.restore_item (tool)
			else
				parent_area.maximize_item (tool)
			end
		end

feature {MULTIPLE_SPLIT_AREA} -- Implementation

	silent_set_minimized is
			-- Ensure `is_minimized' is `True' with no side effects.
		do
			is_minimized := True
		ensure
			minimized: is_minimized = True
		end

	silent_remove_minimized is
			-- Ensure `is_minimized' is `False' with no side effects.
		do
			is_minimized := False
		ensure
			not_minimized: is_minimized = False
		end

	silent_remove_maximized is
			-- Ensure `is_maximized' is `True' with no side effects.
		do
			is_maximized := False
		ensure
			not_maximized: is_maximized = False
		end

feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER, MULTIPLE_SPLIT_AREA} -- Implementation

	label_box: EV_HORIZONTAL_BOX
		-- Box containing label and customizeable tool bar area.

	maximize_button, minimize_button, close_button: EV_TOOL_BAR_BUTTON
		-- Buttons representing minimize and maximize commands.

	display_name: STRING
			-- Name associated with `tool' when displayed in `Current'.

	label: EV_LABEL
			-- Label used to display name of tool.

	tool_bar: EV_TOOL_BAR
		-- Tool bar used to display minimize, maximize and close buttons.

	minimize_tooltip: STRING is "Minimize"
		-- String displayed as tooltip on minimize button

	maximize_tooltip: STRING is "Maximize"
		-- String displayed as tooltip on maximize button

	close_tooltip: STRING is "Close"
		-- String displayed as tooltip on close button.

	minimum_size_cell: EV_CELL
		-- A cell contained in `Current' which permits a minimum size to be simulated
		-- without altering the resizing behaviour of `Current'. Has no screen space,
		-- but force `height' of current to be adjusted as necessary.

	default_external_docked_height: INTEGER is 100
		-- Default height applied to all tools docked externally if they were minimized.

invariant
	minimum_size_cell_empty: minimum_size_cell.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MULTIPLE_SPLIT_AREA_TOOL_HOLDER

