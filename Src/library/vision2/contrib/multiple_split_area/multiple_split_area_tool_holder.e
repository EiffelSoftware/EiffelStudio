indexing
	description: "Objects that surround a tool with a title%
		%and minimize and maximize buttons."
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
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			temp_cell: EV_CELL
		do
			default_create
			parent_area := a_parent
			tool := a_tool
			
			create main_box
			extend (main_box)
			create minimum_size_cell
			extend (minimum_size_cell)
			disable_item_expand (minimum_size_cell)
			create upper_box
			main_box.extend (upper_box)
			main_box.disable_item_expand (upper_box)
			create horizontal_box
			create frame
			frame.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			main_box.extend (frame)
			create vertical_box
			frame.extend (vertical_box)
			create frame
			frame.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_raised)
			vertical_box.extend (frame)
			frame.extend (horizontal_box)
			create label.make_with_text (a_display_name)
			display_name := a_display_name
			label.align_text_left	
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (label)
			create temp_cell
			temp_cell.set_minimum_width (8)--spacing_to_holder_tool_bar)
			horizontal_box.extend (temp_cell)
			horizontal_box.disable_item_expand (temp_cell)
			create tool_bar_cell
			horizontal_box.extend (tool_bar_cell)
			horizontal_box.set_data (display_name)
			create tool_bar
			create minimize_button
			minimize_button.set_pixmap (clone (parent_area.minimize_pixmap))
			minimize_button.select_actions.extend (agent change_minimized_state)
			minimize_button.set_tooltip (minimize_tooltip)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap (clone (parent_area.maximize_pixmap))
			maximize_button.select_actions.extend (agent change_maximized_state)
			maximize_button.set_tooltip (maximize_tooltip)
			tool_bar.extend (maximize_button)
			create close_button
			close_button.set_pixmap (clone (parent_area.close_pixmap))
			close_button.select_actions.extend (agent close)
			close_button.set_tooltip (close_tooltip)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (frame)
			vertical_box.extend (a_tool)
			create lower_box
			main_box.extend (lower_box)
			main_box.disable_item_expand (lower_box)
			
				-- Set up docking for `Current'.
			label.enable_dockable
			label.set_real_source (main_box)
			label.dock_ended_actions.extend (agent docking_ended)
			label.dock_started_actions.extend (agent docking_started)
		end
		
	docking_started is
			-- Respond to dock starting on `Current'.
		do
			--parent_window (parent_area).lock_update
			parent_area.initialize_docking_areas (Current)
			original_height := height
			original_width := width
		end
	
	original_height, original_width: INTEGER
		-- Original width and height before dock.
		
	docking_ended is
			-- A dock has ended, so close dialog, and restore `Current'
		local
			dialog: EV_DOCKABLE_DIALOG
			original_position, new_position: INTEGER
		do
			parent_area.store_positions
			original_position := parent_area.all_holders.index_of (Current, 1)
			parent_window (parent_area).lock_update
			dialog := parent_dockable_dialog (tool)
			if dialog /= Void then
				dialog.close_request_actions.wipe_out
				dialog.close_request_actions.extend (agent destroy_dialog_and_restore (dialog))
				position_docked_from := parent_area.linear_representation.index_of (tool, 1)
				parent_area.linear_representation.prune_all (tool)
				if not parent_area.is_item_external (tool) then
					parent_area.external_representation.extend (tool)
				end
				dialog.set_width (original_width)
				dialog.set_height (original_height)
			--	parent_area.rebuild
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
				parent_area.update_for_holder_position_change (original_position, new_position)
				parent_area.rebuild
				parent_area.restore_stored_positions
			end
			parent_area.remove_docking_areas
			parent_window (parent_area).unlock_update
		end
		
	position_docked_from: INTEGER
		-- Position of `Current' at time it was docked from `parent_area'.
		-- Used as the index within `parent_area' to restore `Current' when a dockable
		-- dialog containing `Current' is closed.

feature -- Basic operation

	add_command_tool_bar (a_tool_bar: EV_TOOL_BAR) is
			-- Display `a_tool_bar' within header of `Current'.
		require
			tool_bar_not_void: a_tool_bar /= Void
		do
			command_tool_bar := a_tool_bar
			if tool_bar_cell.is_empty then
				tool_bar_cell.wipe_out
			end
			tool_bar_cell.extend (a_tool_bar)
		ensure
			command_tool_bar_set: command_tool_bar = a_tool_bar
		end
		
feature {MULTIPLE_SPLIT_AREA, MULTIPLE_SPLIT_AREA_TOOL_HOLDER}-- Access
	
	lower_box, upper_box: EV_VERTICAL_BOX
	
	main_box: EV_VERTICAL_BOX
	
	is_external: BOOLEAN is
			-- Is `Current' external to `parent_area' and
			-- therefore contained in a dockable dialog?
		do
			Result := parent_dockable_dialog (Current) /= Void
		end

feature {MULTIPLE_SPLIT_AREA}-- Access

	command_tool_bar: EV_TOOL_BAR
		-- A toolbar with specific commands related to `tool',
		-- or Void if not set.

	tool: EV_WIDGET
		-- Tool in `Current'.

	is_minimized: BOOLEAN
		-- Is `Current' minimized?
		
	is_maximized: BOOLEAN
		-- Is `Current' maximized?
		
	disable_minimized is
			-- Assign `False' to `minimized'.
		do
			is_minimized := False
		ensure
			not_minimized: not is_minimized
		end
		
	enable_minimized is
			-- Assign `True' to `m-nimized'.
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
			minimize_button.disable_sensitive
		end
		
	enable_minimize_button is
			-- Ensure `minimize_button' is sensitive.
		do
			minimize_button.enable_sensitive
		end
		
	enable_close_button is
			-- Ensure a close button is displayed for `Current'.
		do
			if close_button.parent = Void then
				tool_bar.extend (close_button)
			end
		end
		
	disable_close_button is
			-- Ensure no close button is displayed for `Current'.
		do
			if close_button.parent /= Void then
				close_button.parent.prune_all (close_button)
			end
		end
		
	remove_maximized_restore is
			-- 
		do
			maximize_button.set_pixmap (parent_area.maximize_pixmap)
		end

feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Implementation

	top_insert_cell, bottom_insert_cell: EV_CELL
		
feature {MULTIPLE_SPLIT_AREA} -- Implemnetation

	parent_area: MULTIPLE_SPLIT_AREA
		-- Parent of `Current'.
		
	restore_height: INTEGER
		-- Height to restore to `Current'.
		
	set_restore_height (a_height: INTEGER) is
			--
		do
			restore_height := a_height
		end
		
	simulate_minimum_height (a_height: INTEGER) is
			--
		do
			minimum_size_cell.set_minimum_height (a_height)
		end
		
	remove_simulated_height is
			--
		do
			minimum_size_cell.set_minimum_height (0)
		end
		
feature {MULTIPLE_SPLIT_AREA} -- Implementation
		
	destroy_dialog_and_restore (dialog: EV_DOCKABLE_DIALOG) is
			-- Destroy `dialog' and restore `Current' into `parent_area'.
		require
			dialog_not_void: dialog /= Void
			parented_in_dialog: parent_dockable_dialog (tool) = dialog
		local
			tool_height: INTEGER
		do
			tool_height := tool.height
			tool.parent.prune_all (tool)
			parent_area.all_holders.prune_all (Current)
			dialog.destroy
			parent_window (parent_area).lock_update
			parent_area.external_representation.prune_all (tool)
			parent_area.insert_widget (tool, display_name, (position_docked_from.min (parent_area.count + 1)).max (1))
			
				-- Now restore the height of `tool' within `parent_area'.
				-- FIXME we should traverse through the items in `parent' area, resizing them
				-- accordingly, so that they keep their current size, and the only item that
				-- changes size is the item that may be resized.
			parent_area.resize_widget_to (tool, calculate_restore_height (tool_height))

			parent_window (parent_area).unlock_update
		ensure
			put_back_in_split_area: parent_area.linear_representation.has (tool)
		end

feature {MULTIPLE_SPLIT_AREA} -- Implementation

	parent_dockable_dialog (widget: EV_WIDGET): EV_DOCKABLE_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
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
		
feature {NONE} -- Implementation
		
	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
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

	tool_bar_cell: EV_CELL
		-- A cell to hold `command_tool_bar'.

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
			--
		do
			is_minimized := True
		end
		
	silent_remove_minimized is
			--
		do
			is_minimized := False
		end
		
	silent_remove_maximized is
			--
		do
			is_maximized := False
		end
		

feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER, MULTIPLE_SPLIT_AREA} -- Implementation

	maximize_button, minimize_button, close_button: EV_TOOL_BAR_BUTTON
		-- Buttons representing minimize and maximize commands.
		
	display_name: STRING
			-- Name associated with `tool' when displayed in `Current'.
		
	label: EV_LABEL	
			-- Label used to display name of tool.
		
	tool_bar: EV_TOOL_BAR
		
	minimize_tooltip: STRING is "Minimize"
	
	maximize_tooltip: STRING is "Maximize"
	
	close_tooltip: STRING is "Close"
	
	minimum_size_cell: EV_CELL

end -- class MULTIPLE_SPLIT_AREA_TOOL_HOLDER
