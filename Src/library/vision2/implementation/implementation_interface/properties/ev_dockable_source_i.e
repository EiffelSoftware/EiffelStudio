indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_I
	
inherit
	EV_ANY_I
		redefine	
			interface
		end
		
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I
	
	EV_SHARED_TRANSPORT_I

feature -- Access

	original_parent_position: INTEGER
	
	is_dragging: BOOLEAN is
			-- Is `Current' being dragged.
		do
			Result := source_being_dragged /= Void
		end
		
	real_source: EV_DOCKABLE_SOURCE
			-- `Result' is EV_DOCKABLE_SOURCE which should be
			-- dragged when a drag starts on `Current'.
			
	is_dragable: BOOLEAN
		-- Is `Current' dragable?
		
	not_externally_dockable: BOOLEAN
			-- Attribute used for `is_externally_dockable'. We must implement
			-- `is_externally_dockable' this way as we have no easy solution to
			-- assign `True' to `is_externally_dockable'
			
	is_externally_dockable: BOOLEAN is
			-- Is `Current' able to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		do
			Result := not not_externally_dockable
		end

feature -- Measurement

feature -- Status report

	get_next_target (a_widget: EV_WIDGET): EV_DOCKABLE_TARGET is
			-- `Result' is next dockable target that is `is_dockable' found by
			-- recursively seraching up the parenting structure from `current_target'.
			-- `Result' will be `Void' if none.
		require
			--current_target_not_void: current_target /= Void
			a_widget_not_void: a_widget /= Void
		local
			container: EV_CONTAINER
			widget: EV_WIDGET
			target: EV_DOCKABLE_TARGET
		do
			from
					-- We check the `parent' of `current_target' to
					-- avoid entering the loop unless necessary.
				container := a_widget.parent
				target ?= container
				if target /= Void and then target.is_dockable then
					Result := target
				end
			until
				Result /= Void or container = Void
			loop
				container := container.parent
				target ?= container
				if target /= Void and then target.is_dockable then
					Result := target
				end
			end
		ensure
			result_is_dockable: Result /= Void implies Result.is_dockable
		end

	closest_dragable_target: EV_DOCKABLE_TARGET is
			-- `Result' is first dockable target that `is_dockable' found by recursively
			-- searching up through the parenting structure from the widget
			-- currently underneath the pointer position.
			-- `Result' will be `Void' if a dockable target is not found.
		local
			widget_imp_at_cursor_position: EV_WIDGET_IMP
			current_target: EV_DOCKABLE_TARGET
		do
			widget_imp_at_cursor_position := widget_imp_at_pointer_position
			if widget_imp_at_cursor_position /= Void then
				current_target ?= widget_imp_at_cursor_position.interface
				if current_target /= Void and then current_target.is_dockable then
					Result := current_target
				else
					Result:= get_next_target (widget_imp_at_cursor_position.interface)
				--else
				--	Result := get_next_target (current_target)
				end
			end
		ensure
			result_is_dockable: Result /= Void implies Result.is_dockable
		end

feature -- Status setting

	enable_drag is
			-- Allow `Current' to be dragable
		do
			is_dragable := True
			internal_enable_drag
		ensure
			is_dragable: is_dragable
		end
		
	internal_enable_drag is
			--
		deferred
		end

	disable_drag is
			-- Ensure `Current' is not dragable
		do
			is_dragable := False
			internal_disable_drag
		ensure
			not_is_dragable: not is_dragable
		end
		
	internal_disable_drag is
			--
		deferred
		end

	set_real_source (dockable_source: EV_DOCKABLE_SOURCE) is
			-- Set `dockable_source' to be the widget moved when a
			-- drag begins on `Current'.
		require
			is_dragable: is_dragable
			dockable_source_not_void: dockable_source /= Void
		do
			real_source := dockable_source
		ensure
			real_source_assigned: real_source = dockable_source
		end
		
	remove_real_source is
			-- Ensure `real_source' is `Void'.
		require
			is_dragable: is_dragable
		do
			real_source := Void
		ensure
			no_real_source: real_source = Void
		end
		
	enable_externally_dockable is
			-- Allow `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			is_dragable: is_dragable
		do
			not_externally_dockable := False
		ensure
			is_externally_dockable: not is_externally_dockable
		end
		
	disable_externally_dockable is
			-- Forbid `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			is_dragable: is_dragable
		do
			not_externally_dockable := True
		ensure
			not_externally_dockable: not is_externally_dockable
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations
			
	complete_drag is
			-- Complete a drag from `source_being_dragged'.
		require
			source_being_dragged: source_being_dragged /= Void
		local
			target_container: EV_CONTAINER_IMP
			target_container_interface: EV_CONTAINER
			target_widget: EV_WIDGET_IMP
			dialog: EV_DIALOG
			
			dialog_imp: EV_DIALOG_I
			x_pos, y_pos: INTEGER
			
			dialog2: EV_DIALOG
			original_parent_dialog_imp: EV_DIALOG_I
			dropping_in_source: BOOLEAN
			original_widget_window: EV_WINDOW
			box: EV_BOX
			dragable_dialog_source: EV_DOCKABLE_DIALOG
			dragable_target: EV_DOCKABLE_TARGET
			tool_bar_button: EV_TOOL_BAR_BUTTON
			tool_bar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			tool_bar: EV_TOOL_BAR
			temp_parent: EV_DOCKABLE_TARGET
			temp_widget_parent: EV_WIDGET_IMP
			container: EV_CONTAINER
			tool_bar_separator, tool_bar_separator_left, tool_bar_separator_right: EV_TOOL_BAR_SEPARATOR
			tool_bar_imp: EV_TOOL_BAR_IMP
			temp_index: INTEGER
			original_parent: EV_DOCKABLE_TARGET
		do
			dragable_target := closest_dragable_target
				-- Note that if the parent is not a dialog, then we do not destroy the dialog.
				-- If the parent is a dialog, it means that the drop of the newly transported widget
				-- initially created the dialog, so it is alright to destroy it again.

			if widget_source_being_dragged /= Void then
				dragable_dialog_source ?= widget_source_being_dragged.parent
			else
					-- In this case, we are indirectly parented in the dialog
					-- as a temporary item holder must have been created to
					-- hold the item within the dialog.
				dragable_dialog_source ?= item_source_being_dragged.parent.parent
			end
			
			
			tool_bar ?= dragable_target
			container ?= dragable_target
			if ((widget_source_being_dragged /= Void and container = Void) or (item_source_being_dragged /= Void and tool_bar = Void)) then
				dragable_target := Void
			end
			
			
			if dragable_target = Void then
				if originating_source.is_externally_dockable then
					if dragable_dialog_source = Void then
							-- There is no valid target, and the source was not from an EV_DRAGABLE_DIALOG
							-- so we must insert `source_being_dragged' into an EV_DRAGABLE_DIALOG.
						create dragable_dialog_target
							-- Check whether we are dragging a widget or an item.
						if widget_source_being_dragged /= Void then
							original_widget_window := widget_source_being_dragged.top_level_window_imp.interface
							original_parent ?= widget_source_being_dragged.interface.parent
							check
								original_parent_not_void: original_parent /= Void
							end
							dragable_dialog_target.set_original_parent (original_parent)
							dragable_dialog_target.set_original_parent_index (position_in_parent (widget_source_being_dragged))
						else
							-- Note that this will not work with tree items as it is not recursive.
							temp_widget_parent ?= item_source_being_dragged.parent_imp
							check
								parent_is_widget: temp_widget_parent /= Void
							end
							original_widget_window := temp_widget_parent.top_level_window_imp.interface
							temp_parent ?= item_source_being_dragged.interface.parent
							check
								parent_not_void: temp_parent /= Void
							end
							dragable_dialog_target.set_original_parent (temp_parent)
							tool_bar_button_imp ?= item_source_being_dragged
							check
								item_was_tool_bar_button: tool_bar_button_imp /= Void
							end
							dragable_dialog_target.set_original_parent_index (position_in_parent (tool_bar_button_imp))
						end
						
					--	dragable_dialog_target.move_actions.force_extend (agent display_position (dragable_dialog_target))
						
							-- Now check to see whether `source_being_dragged' was originally 
							-- disabled and parented in a box. If so, flag this so it can be restored
							-- as disabled.
						if widget_source_being_dragged /= Void then
							box ?= widget_source_being_dragged.interface.parent
							if box /= Void and then not box.is_item_expanded (widget_source_being_dragged.interface) then
								dragable_dialog_target.set_expansion_was_disabled
							end
						end
							
						unparent_source_being_dragged
							-- Handle a special case for tool bar buttons.
						if widget_source_being_dragged /= Void then
							dragable_dialog_target.extend (widget_source_being_dragged.interface)
						else
							create tool_bar
							dragable_dialog_target.extend (tool_bar)
							tool_bar_button ?= item_source_being_dragged.interface
							check
								item_was_tool_bar_button: tool_bar_button /= Void
							end
							tool_bar.extend (tool_bar_button)
						end
						
						dialog_imp ?= dragable_dialog_target.implementation
						check
							dialog_imp_not_void: dialog_imp /= Void
						end
						dialog_imp.enable_closeable
						dragable_dialog_target.close_request_actions.extend (agent close_dockable_dialog (dragable_dialog_target))
						move_dialog_to_pointer (dragable_dialog_target)
						dragable_dialog_target.show_relative_to_window (original_widget_window)
						target_container_interface ?= dragable_dialog_target
					else
							-- As there is no valid target, and the transport began in an EV_DRAGABLE_DIALOG
							-- we simply move the existing dialog.
						move_dialog_to_pointer (dragable_dialog_source)
					end
				end
			else
				dropping_in_source := True
				target_widget ?= dragable_target.implementation
				check
					target_widget_not_void: target_widget /= Void
				end
				target_container_interface ?= target_widget.interface
			end
			
			
			if dragable_dialog_source = Void or dragable_target /= Void then
				tool_bar ?= dragable_target
				if not (tool_bar /= Void and widget_source_being_dragged /= Void) then

					if insert_label.parent /= Void then
						unparent_source_being_dragged
						replace_insert_label
					end
					if dragable_dialog_source /= Void then
						dragable_dialog_source.destroy
					end
				else
					move_dialog_to_pointer (dragable_dialog_source)
				end
			end
			
			if widget_source_being_dragged = Void then
					-- We must now handle items that are supported by the docking mechanism.
				tool_bar_button ?= source_being_dragged.interface
					-- The only item that is currently dockable is a
					-- tool bar button hence the check.
				check
					tool_bar_button_not_void: tool_bar_button /= Void
				end
				tool_bar ?= dragable_target
				if tool_bar /= Void then
						-- If the current target is a tool bar then
						-- remove the source of the dock and replace
						-- the temporary separator.
					if insert_sep.parent /= Void then
						unparent_source_being_dragged
						replace_insert_sep	
					else
					
					-- Now handle the insertion/removal of separators.
					-- The dockable mechanism allows tool bar seperators to be inserted
					-- or deleted by a user. Activated by completing a dock on the same button that
					-- it was originally started on.
					-- If the pointer is moved to the right then if there is a separator to the right,
					-- we remove it, or else, insert a separator to the left.
					-- If the pointer is moved to the left then if there is a separator to the left, then
					-- we remove it, or else, insert a separator to the right.
				tool_bar_imp ?= tool_bar.implementation
				check
					tool_bar_imp_not_void: tool_bar_imp /= Void
				end
				if tool_bar.i_th (tool_bar_imp.insertion_position + 1) = tool_bar_button then
					temp_index := tool_bar.index_of (tool_bar_button, 1)
						-- Note that we need to protect our checks against the valid index of the tool bar.
					if temp_index < tool_bar.count then
						tool_bar_separator_right ?= tool_bar.i_th (temp_index + 1)
					end
					if temp_index > 1 then
						tool_bar_separator_left ?= tool_bar.i_th (temp_index - 1)	
					end
					if internal_screen.pointer_position.x > pointer_x then
						-- We have moved to the right since the transport started.
						if tool_bar_separator_right /= Void then
							tool_bar.prune (tool_bar_separator_right)
						elseif tool_bar_separator_left = Void then
							tool_bar.go_i_th (tool_bar.index_of (tool_bar_button, 1))
							tool_bar.put_left (create {EV_TOOL_BAR_SEPARATOR})
						end
					else
						-- We have moved to the left since the transport started.
						if tool_bar_separator_left /= Void then
							tool_bar.prune (tool_bar_separator_left)
						elseif tool_bar_separator_right = Void then
							tool_bar.go_i_th (tool_bar.index_of (tool_bar_button, 1) + 1)
							tool_bar.put_left (create {EV_TOOL_BAR_SEPARATOR})
						end
						
					end
				end
				end
				end
			end
			
				-- As the transport has completed, we need to ensure `source_being_dragged'
				-- is now `Void'.
			source_being_dragged := Void
		ensure
			not_dragging: not is_dragging
			insert_separator_not_parented: insert_sep.parent = Void
			insert_label_not_parented: insert_label.parent = Void
		end
		
	display_position (d: EV_DOCKABLE_DIALOG) is
			--
		do
			d.set_title (d.x_position.out + " " + d.y_position.out)
		end
		
	close_dockable_dialog (dockable_dialog: EV_DOCKABLE_DIALOG) is
			-- Close request received by `dockable_dialog' so
			-- restore widget contained back to its original position
			-- in its old parent if possible.
		local
			dialog_item: EV_WIDGET
			container: EV_CONTAINER
			original_index: INTEGER
			cell: EV_CELL
			box: EV_BOX
			tool_bar, old_tool_bar: EV_TOOL_BAR
			tool_bar_button: EV_TOOL_BAR_BUTTON
		do
	--		if not dockable_dialog.original_parent.is_full then
				dialog_item := dockable_dialog.item
				dockable_dialog.wipe_out
				cell ?= dockable_dialog.original_parent
				if cell /= Void and then cell.is_empty then
					cell.extend (dialog_item)
				end
				box ?= dockable_dialog.original_parent
				if box /= Void then
					original_index := dockable_dialog.original_parent_index
					if box.valid_index (original_index) then
						box.go_i_th (original_index)	
					else
						box.go_i_th (box.count + 1)
					end
					box.put_left (dialog_item)
						-- Disable item expand if originally not expanded.
					if dockable_dialog.expansion_was_disabled then
						box.disable_item_expand (dialog_item)
					end
				end
				tool_bar ?= dockable_dialog.original_parent
				if tool_bar /= Void then
					old_tool_bar ?= dialog_item
					check
						old_parent_was_tool_bar: old_tool_bar /= Void
					end
					tool_bar_button ?= old_tool_bar.i_th (1)
					old_tool_bar.wipe_out
					original_index := dockable_dialog.original_parent_index
					
					if tool_bar.valid_index (original_index) then
						tool_bar.go_i_th (original_index)	
					else
						tool_bar.go_i_th (tool_bar.count + 1)
					end
					tool_bar.put_left (tool_bar_button)
				end
				dockable_dialog.destroy
	--		end
		ensure
			dockable_dialog_destroyed: dockable_dialog.is_destroyed
		end
		

feature -- Obsolete

feature -- Inapplicable

	drag_cursor: EV_CURSOR is
			--
		local
			pixmap: EV_PIXMAP
		once
			create pixmap
			pixmap.set_with_named_file ("C:test_cursor.ico")
			create Result.make_with_pixmap (pixmap, 1, 1)
		end
		

feature {NONE} -- Implementation

	widget_source_being_dragged: EV_WIDGET_IMP is
			-- `Result' is `source_being_dragged' or `Void' if
			-- it is not a widget.
		do
			Result ?= source_being_dragged
		end
		
	item_source_being_dragged: EV_ITEM_IMP is
			-- `Result' is `source_being_dragged' or `Void' if
			-- it is not an item.
		do
			Result ?= source_being_dragged
		end
		
		

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- `Result' is widget implementation at current
			-- cursor position.
		deferred
		end

	position_in_parent (a_dragable_source: EV_DOCKABLE_SOURCE_IMP): INTEGER is
			-- `Result' is position of `a_widget' within its `parent'.
		local
			cell: EV_CELL
			box: EV_BOX
			a_widget: EV_WIDGET_IMP
			a_tool_bar_button: EV_TOOL_BAR_BUTTON_IMP
			tool_bar: EV_TOOL_BAR
		do
			a_widget ?= a_dragable_source
			if a_widget /= Void then
				cell ?= a_widget.parent
				if cell /= Void then
					Result := 1
				end
				box ?= a_widget.parent
				if box /= Void then
					Result := box.index_of (a_widget.interface, 1)
				end
			else
				a_tool_bar_button ?= a_dragable_source
				check
					source_was_widget_or_tool_bar_button: a_tool_bar_button /= Void
				end
				tool_bar ?= a_tool_bar_button.parent
				Result := tool_bar.index_of (a_tool_bar_button.interface, 1)
			end
		end
		

	initialize_transport (a_screen_x, a_screen_y: INTEGER; source: EV_DOCKABLE_SOURCE) is
			-- Store platform independent settings required
			-- to execute the dragging. `a_screen_x' and `a_screen_y' are
			-- the coordinates of the mouse relative to `Current' when the transport
			-- began.
		do
			if source.real_source /= Void then
				source_being_dragged ?= source.real_source.implementation
			else
				source_being_dragged ?= source.implementation
			end
			originating_source ?= source.implementation
			pointer_x := a_screen_x
			pointer_y := a_screen_y
		ensure
			source_being_dragged_set: source_being_dragged /= Void
		end
		

	move_dialog_to_pointer (dialog: EV_DOCKABLE_DIALOG) is
			-- Move dialog to pointer position, so it is positioned
			-- relative with `original_x_offset' and `original_y_offset'
			-- which were the original position of the drag.
		require
			dialog_not_void: dialog /= Void
		local
			x_pos, y_pos: INTEGER
			extra_height: INTEGER
		do
			extra_height := (dialog.height - dialog.client_height) - ((dialog.width - dialog.client_width) // 2)
		--| FIXME need to have the height of the title bar aded on here.
			x_pos := internal_screen.pointer_position.x
			y_pos := internal_screen.pointer_position.y
			dialog.set_x_position (x_pos - original_x_offset)
			dialog.set_y_position (y_pos - original_y_offset - extra_height)
		end

	execute_dragging (
			a_x, a_y: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Executed when `pebble' is being moved.
			-- Draw a rubber band from pick position to pointer position.
		local
			counter: INTEGER
			real_target: EV_PICK_AND_DROPABLE
			application: EV_APPLICATION_IMP
			target: EV_DOCKABLE_TARGET
			container: EV_CONTAINER
			vertical_box: EV_BOX_IMP
			cursor: EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
			cell: EV_CELL_IMP
			insert_position: INTEGER
			dragged_index: INTEGER
			insert_label_pos: INTEGER
			tool_bar: EV_TOOL_BAR_IMP
			tool_bar_button: EV_TOOL_BAR_BUTTON
			dragable_target: EV_DOCKABLE_TARGET
			veto_result: BOOLEAN
		do
			target := closest_dragable_target
			if widget_source_being_dragged /= Void then
				-- We are transporting a widget, so we can find the EV_CONTAINER
				-- and modify the interface accordingly, to insert `insert_label' to
				-- provide graphical feedback to user.
				
				if target /= Void and target /= insert_label then

					if widget_source_being_dragged /= Void then
						 -- remove `insert_label' if the pointed target has changed
						container ?= target 
						if container /= Void then
			--				if insert_label.parent /= container then
			--					remove_insert_label
			--				end

						--	veto_result := True
							if target.veto_dock_function /= Void then
								veto_result := True
							end
							from
							--	target.veto_dock_function = Void 
								counter := 0
							until
								target = Void or (target /= Void and then target.veto_dock_function = Void) or 
								(target /= Void and then target.veto_dock_function /= Void and (not veto_result))
							loop
								counter := counter + 1
								if target.veto_dock_function /= Void then
									target.veto_dock_function.call ([widget_source_being_dragged.interface])
									veto_result := target.veto_dock_function.last_result
									if veto_result then
										target := get_next_target (container)										
									end
								end
							end
							if target /= Void then
							container ?= target
							check
								container_not_void: container /= Void
							end
								if insert_label.parent /= container then
									remove_insert_label
								end
								vertical_box ?= container.implementation
								cell ?= container.implementation
	
							end
						--	if not veto_result then
						--	end
						end
					end
					--| FIXME Handle all supported types
					if vertical_box /= Void then
						insert_position := vertical_box.insertion_position
						if insert_position /= -1 then
							if not ((vertical_box.i_th (insert_position.min (vertical_box.count)) = insert_label) or (vertical_box.i_th ((insert_position - 1).max (1)) = insert_label)) then
								dragged_index := vertical_box.index_of (widget_source_being_dragged.interface, 1)
								if widget_source_being_dragged.parent = vertical_box.interface and (dragged_index = insert_position or dragged_index = insert_position - 1) then
									
								else
									if insert_label.parent /= Void then
										insert_label_pos := position_in_parent (insert_label_imp)
										if insert_label_pos < insert_position then
											insert_position := insert_position - 1
										end
									end
									vertical_box.top_level_window_imp.interface.lock_update
									remove_insert_label
									cursor := vertical_box.cursor
									vertical_box.go_i_th (insert_position)
									vertical_box.put_left (insert_label)
									vertical_box.interface.disable_item_expand (insert_label)
									vertical_box.go_to (cursor)
									vertical_box.top_level_window_imp.interface.unlock_update
								end
							end	
						end
					end
					if cell /= Void then
						if cell.interface.is_empty then
							remove_insert_label
							cell.interface.extend (insert_label)
						end
					end
				elseif target /= insert_label then
					
						-- As there is no valid target, the insert label should
						-- not be parented.
					remove_insert_label
				end
			else
				-- Add feedback for EV_TOOL_BAR_BUTTON here. And any other
				-- items that may be supported later.
				if target /= Void then
					if target.veto_dock_function /= Void then
						tool_bar_button ?= item_source_being_dragged.interface
						check
							we_only_support_tool_bar_buttons: tool_bar_button /= Void
						end
						if tool_bar_button /= Void then
							target.veto_dock_function.call ([tool_bar_button])
						end
					end
							
					if (not (target.veto_dock_function = Void) and then not target.veto_dock_function.last_result) or
						target.veto_dock_function = Void then
						tool_bar ?= target.implementation
					end
					if tool_bar /= Void then
						insert_position := tool_bar.insertion_position
						if insert_position /= -1 then
							if insert_position < tool_bar.count then
								insert_position := insert_position + 1	
							end
							if not ((tool_bar.i_th (insert_position.min (tool_bar.count)) = insert_sep) or (tool_bar.i_th ((insert_position - 1).max (1)) = insert_sep)) then
								tool_bar_button ?= item_source_being_dragged.interface
								check
									tool_bar_button_not_void: tool_bar_button /= Void
								end
								dragged_index := tool_bar.index_of (tool_bar_button, 1)
								if item_source_being_dragged.parent = tool_bar.interface and (dragged_index = insert_position or dragged_index = insert_position - 1) then
										-- As we are pointing to the original tool bar item that
										-- is being transported, we remove `insert_sep' to illustrate
										-- that no movememnt will occur when the transport ends.
									remove_insert_sep
								else
									if insert_label.parent /= Void then
										insert_label_pos := position_in_parent (insert_sep_imp)
										if insert_label_pos < insert_position then
											insert_position := insert_position - 1
										end
									end
									remove_insert_sep
									tool_bar.go_i_th (insert_position)
									tool_bar.put_left (insert_sep)
								end
							end
						end
					end
				else
						-- `target' will never be `insert_sep', so
						-- there is no need to test before removal.
						-- Note that we need to perform a similar check
						-- when we are dragging a widget.
					remove_insert_sep
				end
			end
		end
			
		unparent_source_being_dragged is
				-- Remove `widget_source_being_dragged' from `parent' or
				-- `item_source_being_dragged' from `parent'.
			require
				widget_or_item: widget_source_being_dragged /= Void or item_source_being_dragged /= Void
			do
				if widget_source_being_dragged /= Void then
					widget_source_being_dragged.interface.parent.prune (widget_source_being_dragged.interface)	
					check
						not_parented: widget_source_being_dragged.parent = Void
					end
				else
					item_source_being_dragged.interface.parent.prune (item_source_being_dragged.interface)	
					check
						not_parented: item_source_being_dragged.parent = Void
					end
				end
			end
			
		replace_insert_label is
				-- Replace `insert_label' with `widget_source_being_dragged'.
			require
				source_not_parented: widget_source_being_dragged.parent = Void
				insert_label_parented: insert_label.parent /= Void
			local
				box: EV_BOX
				cell: EV_CELL
			do
				box ?= insert_label.parent
				if box /= Void then
					box.put_i_th (widget_source_being_dragged.interface, box.index_of (insert_label, 1))--insert_index)
				end
				cell ?= insert_label.parent
				if cell /= Void then
					cell.put (widget_source_being_dragged.interface)
				end
			ensure
				source_parented: widget_source_being_dragged.parent /= Void
				insert_label_not_parented: insert_label.parent = Void
				parent_swapped: old insert_label.parent = widget_source_being_dragged.parent
			end
			
		replace_insert_sep is
				-- Replace `insert_sep' with item_source_being_dragged'.
			require
				source_not_parented: item_source_being_dragged.parent = Void
				sep_parented: insert_sep.parent /= Void
			local
				tool_bar: EV_TOOL_BAR
				tool_bar_item: EV_TOOL_BAR_ITEM
			do
				tool_bar ?= insert_sep.parent
				check
					parent_was_tool_bar: tool_bar /= Void
				end
				tool_bar_item ?= item_source_being_dragged.interface
				check
					tool_bar_item_not_void: tool_bar_item /= Void
				end
				tool_bar.put_i_th (tool_bar_item, tool_bar.index_of (insert_sep, 1))
			ensure
				source_parented: item_source_being_dragged.parent /= Void
				insert_sep_not_parented: insert_sep.parent = Void
				parent_swapped: old insert_sep.parent = item_source_being_dragged.parent
			end
			

feature {EV_ANY_I} -- Implementation

	interface: EV_DOCKABLE_SOURCE

invariant
--	no_widget_stored_while_not_dragging: not is_dragging implies source_being_dragged = Void
--	widget_stored_while_dragging: is_dragging implies source_being_dragged /= Void
	no_temporary_widget_when_no_target: is_dragging and then closest_dragable_target = Void implies insert_label.parent = Void
	widget_or_item_source: not (widget_source_being_dragged /= Void and item_source_being_dragged /= Void)

end -- class EV_DOCKABLE_SO