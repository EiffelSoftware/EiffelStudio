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
			minimize_button.select_actions.extend (agent minimize)
			minimize_button.set_tooltip (minimize_tooltip)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap (clone (parent_area.maximize_pixmap))
			maximize_button.select_actions.extend (agent maximize)
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
		end
		
		
	docking_ended is
			-- A dock has ended, so close dialog, and restore `Current'
		local
			dialog: EV_DOCKABLE_DIALOG
			tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			box: EV_VERTICAL_BOX
			original_position, new_position: INTEGER
			above: BOOLEAN
		do
			parent_area.store_positions
			original_position := parent_area.all_holders.index_of (Current, 1)
			parent_window (parent_area).lock_update
			dialog := parent_dockable_dialog (tool)
			if dialog /= Void then
				dialog.close_request_actions.wipe_out
				dialog.close_request_actions.extend (agent destroy_dialog_and_restore (dialog))
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
		
	destroy_dialog_and_restore (dialog: EV_DOCKABLE_DIALOG) is
			-- Destroy `dialog' and restore `Current' into `parent_area'.
		require
			dialog_not_void: dialog /= Void
			parented_in_dialog: parent_dockable_dialog (tool) = dialog
		do
			tool.parent.prune_all (tool)
			parent_area.linear_representation.prune_all (tool)
			parent_area.all_holders.prune_all (Current)
			dialog.destroy
			parent_window (parent_area).lock_update
			parent_area.insert_widget (tool, display_name, original_parent_position.min (parent_area.count + 1))
			parent_window (parent_area).unlock_update
		ensure
			put_back_in_split_area: parent_area.linear_representation.has (tool)
		end
		
	original_parent_position: INTEGER
		-- Original position of `Current' in `parent_area' at creation time.

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

feature -- Access

	command_tool_bar: EV_TOOL_BAR
		-- A toolbar with specific commands related to `tool',
		-- or Void if not set.

	tool: EV_WIDGET
		-- Tool in `Current'.
		
	minimized: BOOLEAN
		-- Is `Current' minimized?
		
	maximized: BOOLEAN
		-- Is `Current' maximized?
		
	disable_minimized is
			-- Assign `False' to `minimized'.
		do
			minimized := False
		end
		
	disable_maximized is
			-- Assign `False' to `maximized'.
		do
			maximized := False
		end
		
--	reset_minimize_button is
--			-- Restore original pixmap to `minimize_button'.
--		do
--		end
--		
--	reset_maximize_button is
--			-- Restore original pixmap to `maximize_button'.
--		do
--		end
		
	disable_minimize_button is
			--
		do
			minimize_button.disable_sensitive
		end
		
	enable_minimize_button is
			--
		do
			minimize_button.enable_sensitive
		end
		
	enable_close_button is
			--
		do
			if close_button.parent = Void then
				tool_bar.extend (close_button)
			end
		end
		
	disable_close_button is
			--
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
		
		
	update_position_in_parent is
			-- Assign position of `Current' in `parent_area' to `original_parent_position'.
			-- This is used when restoring after a dockable dialog containing `Current' is
			-- closed.
		require
			parent_area_not_void: parent_area /= Void
		do
			original_parent_position := parent_area.all_holders.index_of (Current, 1)
		ensure
			result_valid: original_parent_position >= 1 and original_parent_position <= parent_area.all_holders.count
		end
		

feature {NONE} -- Implementation

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

	minimize is
			-- Minimize `Current' if not minimized, restore otherwise.
		do
			parent_window (parent_area).lock_update
			minimized := not minimized
			if minimized then
				set_restore_height (height)
				parent_area.minimize_tool (Current)
				minimize_button.set_pixmap (parent_area.restore_pixmap)
				minimize_button.set_tooltip ("Restore")
				label.disable_dockable
			else
				parent_area.restore_tool (Current)
				minimize_button.set_pixmap (parent_area.minimize_pixmap)
				minimize_button.set_tooltip ("Minimize")
				label.enable_dockable
			end
			parent_window (parent_area).unlock_update
		end
		
	close is
			--
		do
			
		end
		
		

	maximize is
			-- Maximize `Current' if not maxamized, restore otherwise.
		do
			parent_window (parent_area).lock_update
			maximized := not maximized
			if maximized then
				parent_area.maximize_tool (Current)
				maximize_button.set_pixmap (parent_area.restore_pixmap)
				maximize_button.set_tooltip ("Restore")
				label.disable_dockable
			else
				parent_area.restore_maximized_tool (Current)
				maximize_button.set_pixmap (parent_area.maximize_pixmap)
				label.enable_dockable
			end
			parent_window (parent_area).unlock_update
		end
		
feature {MULTIPLE_SPLIT_AREA} -- Implementation

	silent_set_minimized is
			--
		do
			minimized := True
		end
		
	silent_remove_minimized is
			--
		do
			minimized := False
		end
		
	silent_remove_maximized is
			--
		do
			maximized := False
		end
		

feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Implementation

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
