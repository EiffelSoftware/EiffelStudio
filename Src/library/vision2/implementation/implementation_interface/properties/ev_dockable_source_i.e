note
	description: "Implementation interface for dockable source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		-- Original position in parent. Required
		-- to restore widget later.

	is_dock_executing: BOOLEAN
			-- Is `Current' in the process of a dockable transport?
		do
			Result := source_being_docked /= Void
		end

	real_source: detachable EV_DOCKABLE_SOURCE
			-- `Result' is EV_DOCKABLE_SOURCE which should be
			-- dragged when docking begins on `Current'.

	is_dockable: BOOLEAN
		-- Is `Current' dockable?

	not_external_docking_enabled: BOOLEAN
			-- Attribute used for `is_externally_dockable'. We must implement
			-- `is_externally_dockable' this way as we have no easy solution to
			-- assign `True' to `is_externally_dockable'.

	is_external_docking_enabled: BOOLEAN
			-- Is `Current' able to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		do
			Result := not not_external_docking_enabled
		end

	not_is_external_docking_relative: BOOLEAN
			-- Will dockable dialog displayed when `Current' is docked externally
			-- be displayed relative to parent window of `Current'?
			-- Otherwise displayed as a standard window.
			-- Internal reversed value of `is_external_docking_relative' as we cannot
			-- easily initialize a BOOLE to True in this case.

	is_external_docking_relative: BOOLEAN
			-- Will dockable dialog displayed when `Current' is docked externally
			-- be displayed relative to parent window of `Current'?
			-- Otherwise displayed as a standard window.
		do
			Result := not not_is_external_docking_relative
		end

feature -- Status report

	get_next_target (a_widget: EV_WIDGET): detachable EV_DOCKABLE_TARGET
			-- `Result' is next dockable target that is `is_dockable' found by
			-- recursively seraching up the parenting structure from `current_target'.
			-- `Result' will be `Void' if none.
		require
			--current_target_not_void: current_target /= Void
			a_widget_not_void: a_widget /= Void
		local
			container: detachable EV_CONTAINER
			target: detachable EV_DOCKABLE_TARGET
			parent_widget: detachable EV_WIDGET
		do
			from
					-- We check the `parent' of `current_target' to
					-- avoid entering the loop unless necessary.
				parent_widget := a_widget.parent
				container ?= parent_widget
				target ?= container
				if attached parent_widget as l_parent_widget and then attached l_parent_widget.real_target as l_real_target and then
					l_real_target.is_docking_enabled then
					Result := l_real_target
				elseif attached target as l_target and then l_target.is_docking_enabled then
					Result := l_target
				end
			until
				Result /= Void or container = Void
			loop
				parent_widget := container.parent
				container ?= parent_widget
				target ?= container
				if parent_widget /= Void and then attached parent_widget.real_target as l_real_target and then
					l_real_target.is_docking_enabled then
					Result := l_real_target
				elseif target /= Void and then target.is_docking_enabled then
					Result := target
				end
			end
		ensure
			result_is_dockable: Result /= Void implies Result.is_docking_enabled
		end

	closest_dockable_target: detachable EV_DOCKABLE_TARGET
			-- `Result' is first dockable target that `is_dockable' found by recursively
			-- searching up through the parenting structure from the widget
			-- currently underneath the pointer position.
			-- `Result' will be `Void' if a dockable target is not found.
		local
			widget_imp_at_cursor_position: detachable EV_WIDGET_IMP
			current_target: detachable EV_DOCKABLE_TARGET
			tool_bar: detachable EV_TOOL_BAR
		do
			widget_imp_at_cursor_position := widget_imp_at_pointer_position
			if widget_imp_at_cursor_position /= Void then
				current_target ?= widget_imp_at_cursor_position.interface
				tool_bar ?= current_target
				if attached widget_imp_at_cursor_position.real_target as l_widget_real_target and
					then l_widget_real_target.is_docking_enabled then
					Result := l_widget_real_target
				elseif attached current_target as l_current_target and then l_current_target.is_docking_enabled and
					(tool_bar /= Void and then item_source_being_docked /= Void) then
						-- The last section of the above `elseif' handles tool bars as a special case.
						-- If the current target is a tool bar, and we are docking an item then the toolbar
						-- is returned. Without this check, it would not be possible to drag a toolbar as
						-- the real source of a tool bar button, if the tool bar had docking enabled.
					Result := current_target
				else
					Result:= get_next_target (widget_imp_at_cursor_position.attached_interface)
				end
			end
		ensure
			result_is_dockable: Result /= Void implies Result.is_docking_enabled
		end

feature -- Status setting

	enable_dockable
			-- Allow `Current' to be dockable
		do
			is_dockable := True
			internal_enable_dockable
		ensure
			is_dockable: is_dockable
		end

	internal_enable_dockable
			-- Platform specific implementation of `enable_dockable'.
		deferred
		end

	disable_dockable
			-- Ensure `Current' is not dockable
		do
			is_dockable := False
			internal_disable_dockable
		ensure
			not_is_dockable: not is_dockable
		end

	internal_disable_dockable
			-- Platform specific implementation of `disable_dockable'.
		deferred
		end

	set_real_source (dockable_source: EV_DOCKABLE_SOURCE)
			-- Set `dockable_source' to be the widget moved when a
			-- drag begins on `Current'.
		require
			is_dockable: is_dockable
			dockable_source_not_void: dockable_source /= Void
		do
			real_source := dockable_source
		ensure
			real_source_assigned: real_source = dockable_source
		end

	remove_real_source
			-- Ensure `real_source' is `Void'.
		require
			is_dockable: is_dockable
		do
			real_source := Void
		ensure
			real_source_void: real_source = Void
		end

	enable_external_docking
			-- Allow `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			is_dockable: is_dockable
		do
			not_external_docking_enabled := False
		ensure
			is_externally_dockable: is_external_docking_enabled
		end

	disable_external_docking
			-- Forbid `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			is_dockable: is_dockable
		do
			not_external_docking_enabled := True
		ensure
			not_externally_dockable: not is_external_docking_enabled
		end

	enable_external_docking_relative
			-- Assign `True' to `is_external_docking_relative', ensuring that
			-- a dockable dialog displayed when `Current' is docked externally
			-- is displayed relative to the top level window.
		require
			external_docking_enabled: is_external_docking_enabled
		do
			not_is_external_docking_relative := False
		ensure
			external_docking_not_relative: is_external_docking_relative
		end

	disable_external_docking_relative
			-- Assign `False' to `is_external_docking_relative', ensuring that
			-- a dockable dialog displayed when `Current' is docked externally
			-- is displayed as a standard window.
		require
			external_docking_enabled: is_external_docking_enabled
		do
			not_is_external_docking_relative := True
		ensure
			external_docking_not_relative: not is_external_docking_relative
		end

feature -- Basic operations

	complete_dock
			-- Complete a dock from `source_being_docked'.
		require
			source_being_docked: source_being_docked /= Void
		local
			target_container_interface: detachable EV_CONTAINER
			target_widget: detachable EV_WIDGET_IMP

			dialog_imp: detachable EV_DIALOG_I
			dropping_in_source: BOOLEAN
			original_widget_window: detachable EV_WINDOW
			box: detachable EV_BOX
			dockable_dialog_source: detachable EV_DOCKABLE_DIALOG
			dockable_target: detachable EV_DOCKABLE_TARGET
			tool_bar_button: detachable EV_TOOL_BAR_BUTTON
			tool_bar_button_imp: detachable EV_TOOL_BAR_BUTTON_IMP
			tool_bar: detachable EV_TOOL_BAR
			temp_parent: detachable EV_DOCKABLE_TARGET
			temp_widget_parent: detachable EV_WIDGET_IMP
			container: detachable EV_CONTAINER
			tool_bar_separator_left, tool_bar_separator_right: detachable EV_TOOL_BAR_SEPARATOR
			tool_bar_imp: detachable EV_TOOL_BAR_IMP
			temp_index: INTEGER
			original_parent: detachable EV_DOCKABLE_TARGET
			widget: detachable EV_WIDGET
			original_tool_bar: detachable EV_TOOL_BAR
			insert_index, original_index: INTEGER
			tool_bar_item: detachable EV_TOOL_BAR_ITEM
			moved_within_same_parent: BOOLEAN
			locked_in_here: BOOLEAN
			locked_in_here_window: detachable EV_WINDOW
			container_imp: detachable EV_CONTAINER_IMP
			l_widget_source_being_docked: like widget_source_being_docked
			l_item_source_being_docked: like item_source_being_docked
			l_dockable_dialog_target: like dockable_dialog_target
		do
				-- Reset `dockable_dialog_target' as it should only be created in here if required.
			dockable_dialog_target := Void

			dockable_target := closest_dockable_target
				-- Note that if the parent is not a dialog, then we do not destroy the dialog.
				-- If the parent is a dialog, it means that the drop of the newly transported widget
				-- initially created the dialog, so it is alright to destroy it again.

			l_widget_source_being_docked ?= widget_source_being_docked
			if l_widget_source_being_docked /= Void then
				dockable_dialog_source ?= l_widget_source_being_docked.parent
			else
					-- In this case, we are indirectly parented in the dialog
					-- as a temporary item holder must have been created to
					-- hold the item within the dialog.
				l_item_source_being_docked ?= item_source_being_docked
				check l_item_source_being_docked /= Void then end
				if attached l_item_source_being_docked.parent as l_parent then
					dockable_dialog_source ?= l_parent.parent
				end
			end


			tool_bar ?= dockable_target
			container ?= dockable_target
			if ((l_widget_source_being_docked /= Void and container = Void) or (l_item_source_being_docked /= Void and tool_bar = Void)) then
				dockable_target := Void
			end


			if dockable_target = Void then
				if attached originating_source as l_originating_source and then l_originating_source.is_external_docking_enabled then
					if dockable_dialog_source = Void then
							-- There is no valid target, and the source was not from an EV_DRAGABLE_DIALOG
							-- so we must insert `source_being_docked' into an EV_DRAGABLE_DIALOG.
						create l_dockable_dialog_target
						dockable_dialog_target := l_dockable_dialog_target
							-- Check whether we are dragging a widget or an item.
						if l_widget_source_being_docked /= Void and then attached l_widget_source_being_docked.top_level_window_imp as l_top_level_window_imp then
							original_widget_window := l_top_level_window_imp.interface
							original_parent ?= l_widget_source_being_docked.attached_interface.parent
							check
								original_parent_not_void: original_parent /= Void then
							end
							l_dockable_dialog_target.set_original_parent (original_parent)
							l_dockable_dialog_target.set_original_parent_index (position_in_parent (l_widget_source_being_docked))
						else

							check l_item_source_being_docked /= Void then end
							temp_widget_parent ?= l_item_source_being_docked.parent_imp
							check
								parent_is_widget: temp_widget_parent /= Void then
							end
							if attached temp_widget_parent.top_level_window_imp as l_top_level_window_imp then
								original_widget_window := l_top_level_window_imp.interface
							end
							check original_widget_window /= Void then end
							temp_parent ?= l_item_source_being_docked.attached_interface.parent
							check
								parent_not_void: temp_parent /= Void then
							end
							l_dockable_dialog_target.set_original_parent (temp_parent)
							tool_bar_button_imp ?= l_item_source_being_docked
							check
								item_was_tool_bar_button: tool_bar_button_imp /= Void then
							end
							l_dockable_dialog_target.set_original_parent_index (position_in_parent (tool_bar_button_imp))

								-- Now update the tool bar button to the left of the original position.
								-- On Windows, it does not return back to its original state.
							tool_bar ?= temp_parent
							check
								tool_bar_not_void: tool_bar /= Void then
							end
							temp_index := l_dockable_dialog_target.original_parent_index - 1
							if (not tool_bar.is_empty) and temp_index >= 1 then
									-- We protected against the state of the toolbar after the transport.
								update_buttons (tool_bar, temp_index, temp_index)
							end
						end

							-- Now check to see whether `source_being_docked' was originally
							-- disabled and parented in a box. If so, flag this so it can be restored
							-- as disabled.
						if l_widget_source_being_docked /= Void then
							box ?= l_widget_source_being_docked.attached_interface.parent
							if box /= Void and then not box.is_item_expanded (l_widget_source_being_docked.attached_interface) then
								l_dockable_dialog_target.set_expansion_was_disabled
							end
						end

						unparent_source_being_docked
							-- Handle a special case for tool bar buttons.
						if l_widget_source_being_docked /= Void then
							l_dockable_dialog_target.extend (l_widget_source_being_docked.attached_interface)
						else
							check l_item_source_being_docked /= Void then end
							create tool_bar
							l_dockable_dialog_target.extend (tool_bar)
							tool_bar_button ?= l_item_source_being_docked.interface
							check
								item_was_tool_bar_button: tool_bar_button /= Void then
							end
							tool_bar.extend (tool_bar_button)
						end

						dialog_imp ?= l_dockable_dialog_target.implementation
						check
							dialog_imp_not_void: dialog_imp /= Void then
						end
						dialog_imp.enable_closeable
						l_dockable_dialog_target.close_request_actions.extend (agent close_dockable_dialog (l_dockable_dialog_target))
						move_dialog_to_pointer (l_dockable_dialog_target)
						if attached source_being_docked as l_source_being_docked and then l_source_being_docked.is_external_docking_relative then
							check original_widget_window /= Void then end
							l_dockable_dialog_target.show_relative_to_window (original_widget_window)
						else
							l_dockable_dialog_target.show
						end
						target_container_interface ?= l_dockable_dialog_target
					else
							-- As there is no valid target, and the transport began in an EV_DRAGABLE_DIALOG
							-- we simply move the existing dialog.
						move_dialog_to_pointer (dockable_dialog_source)
					end
					if dock_ended_actions_internal /= Void then
						dock_ended_actions.call (Void)
					end
				end
			else
				dropping_in_source := True
				target_widget ?= dockable_target.implementation
				check
					target_widget_not_void: target_widget /= Void then
				end
				target_container_interface ?= target_widget.interface
			end


			if (dockable_dialog_source = Void or dockable_target /= Void) and dockable_dialog_target = Void then
					-- This section is executed if we are docking a widget not into a dockable dialog, hence
					-- we check `dockable_dialog_target' is Void, to avoid the `dock_ended_actions' being fired twice,
					-- and the rest of this section of code being executed.	
				tool_bar ?= dockable_target
				if not (tool_bar /= Void and l_widget_source_being_docked /= Void) then
					locked_in_here := attached (create {EV_ENVIRONMENT}).application as l_app and then l_app.locked_window = Void
					check l_widget_source_being_docked /= Void then end
					if locked_in_here and l_widget_source_being_docked.top_level_window /= Void then
						check container /= Void then end
						container_imp ?= container.implementation
						check
							container_not_void: container_imp /= Void then
						end
							-- FIXME This protection appears to be required as from time to
							-- time `top_level_window_imp' returns `Void'. Need to understand
							-- why and how this occurs. Julian
						if attached container_imp.top_level_window_imp as l_top_level_window_imp then
							l_top_level_window_imp.lock_update
						end
					end
					if insert_label.parent /= Void then
						unparent_source_being_docked
						replace_insert_label
					end
					if attached dockable_dialog_source as l_dockable_dialog_source then
						l_dockable_dialog_source.destroy
					end
					if dock_ended_actions_internal /= Void then
						dock_ended_actions.call (Void) -- dfgdfgdfg
					end
--					if locked_in_here and widget_source_being_docked.top_level_window /= Void then
--						widget_source_being_docked.top_level_window.unlock_update
--					end
				elseif attached dockable_dialog_source as l_dockable_dialog_source then
					move_dialog_to_pointer (l_dockable_dialog_source)
				end
			end

			if l_widget_source_being_docked = Void then
					-- We must now handle items that are supported by the docking mechanism.
				check l_item_source_being_docked /= Void then end
				tool_bar_button ?= l_item_source_being_docked.interface
					-- The only item that is currently dockable is a
					-- tool bar button hence the check.
				check
					tool_bar_button_not_void: tool_bar_button /= Void then
				end
				tool_bar ?= dockable_target
				if tool_bar /= Void then
						-- If the current target is a tool bar then
						-- remove the source of the dock and replace
						-- the temporary separator.
					if insert_sep.parent /= Void then
						original_tool_bar ?= l_item_source_being_docked.parent
						check
							original_tool_bar_not_void: original_tool_bar /= Void then
						end
						tool_bar_item ?= tool_bar_button
						check tool_bar_item /= Void then end
						insert_index := original_tool_bar.index_of (insert_sep, 1)
						original_index := original_tool_bar.index_of (tool_bar_item, 1)
						moved_within_same_parent := tool_bar_item.parent = tool_bar

						unparent_source_being_docked
						replace_insert_sep

							-- We must now provide provisions for updating the state of the tool bar buttons.
							-- In some cases, the state is affected by the transport. We provide a platform
							-- specific implementation, as any work required will depend on the exact behaviour.
					if moved_within_same_parent and then original_index = insert_index + 2 then
						update_buttons (tool_bar, insert_index + 1, insert_index + 1)
					end

							-- We have to ensure that a tool bar button does not become
							-- selected as a result of the transport ending.
						if original_tool_bar = tool_bar then
							tool_bar_imp ?= tool_bar.implementation
							check
								tool_bar_imp_not_void: tool_bar_imp /= Void then
							end
							tool_bar_imp.block_selection_for_docking
						end
					else

					-- Now handle the insertion/removal of separators.
					-- The dockable mechanism allows tool bar separators to be inserted
					-- or deleted by a user. Activated by completing a dock on the same button that
					-- it was originally started on.
					-- If the pointer is moved to the right then if there is a separator to the right,
					-- we remove it, or else, insert a separator to the left.
					-- If the pointer is moved to the left then if there is a separator to the left, then
					-- we remove it, or else, insert a separator to the right.
				tool_bar_imp ?= tool_bar.implementation
				check
					tool_bar_imp_not_void: tool_bar_imp /= Void then
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
					insert_index := tool_bar.index_of (tool_bar_button, 1)
					update_buttons (tool_bar, insert_index, insert_index)
				end
				end
				end
				if dock_ended_actions_internal /= Void then
					dock_ended_actions.call (Void)
				end
			end

					-- We must also enable any action sequences that had been blocked
			if attached source_being_docked as l_source_being_docked then
				widget ?= l_source_being_docked.interface
				if widget /= Void then
					widget.pointer_motion_actions.resume
				else
					tool_bar_button ?= l_source_being_docked.interface
					if tool_bar_button /= Void then
						tool_bar_button.pointer_motion_actions.resume
					else
						check
							type_not_supported: False then
						end
					end
				end
			end

				-- As the transport has completed, we need to ensure `source_being_docked'
				-- is now `Void'.
			source_being_docked := Void

				-- Ensure that the locked window is unlocked, if set in this feature.
			if locked_in_here and then attached (create {EV_ENVIRONMENT}).application as l_app then
				locked_in_here_window := l_app.locked_window
				if locked_in_here_window /= Void then
					locked_in_here_window.unlock_update
				end
			end
		ensure
			not_dock_executing: not is_dock_executing
			insert_separator_not_parented: insert_sep.parent = Void
			insert_label_not_parented: insert_label.parent = Void
		end

	close_dockable_dialog (dockable_dialog: EV_DOCKABLE_DIALOG)
			-- Close request received by `dockable_dialog' so
			-- restore widget contained back to its original position
			-- in its old parent if possible.
			-- We must fire `dock_ended' actions.
		local
			dialog_item: EV_WIDGET
			original_index: INTEGER
			cell: detachable EV_CELL
			widget_list: detachable EV_WIDGET_LIST
			box: detachable EV_BOX
			tool_bar, old_tool_bar: detachable EV_TOOL_BAR
			tool_bar_button: detachable EV_TOOL_BAR_BUTTON
			target_i: detachable EV_DOCKABLE_TARGET_I
			dockable_source: EV_DOCKABLE_SOURCE
		do
			dialog_item := dockable_dialog.item
			dockable_dialog.wipe_out
			cell ?= dockable_dialog.original_parent
			if cell /= Void and then cell.is_empty then
				cell.extend (dialog_item)
			end
			widget_list ?= dockable_dialog.original_parent
			if widget_list /= Void then
				original_index := dockable_dialog.original_parent_index
				if widget_list.valid_index (original_index) then
					widget_list.go_i_th (original_index)
				else
					widget_list.go_i_th (widget_list.count + 1)
				end
				widget_list.put_left (dialog_item)
				box ?= widget_list
				if box /= Void then
						-- Disable item expand if originally not expanded.
					if dockable_dialog.expansion_was_disabled then
						box.disable_item_expand (dialog_item)
					end
				end
			end
			tool_bar ?= dockable_dialog.original_parent
			if tool_bar /= Void then
				old_tool_bar ?= dialog_item
				check
					old_parent_was_tool_bar: old_tool_bar /= Void then
				end
				tool_bar_button ?= old_tool_bar.i_th (1)
				check tool_bar_button /= Void then end
				old_tool_bar.wipe_out
				original_index := dockable_dialog.original_parent_index

				if tool_bar.valid_index (original_index) then
					tool_bar.go_i_th (original_index)
				else
					tool_bar.go_i_th (tool_bar.count + 1)
				end
				tool_bar.put_left (tool_bar_button)
				dockable_source := tool_bar_button
			else
					-- If the source was not a tool bar button, then
					-- use `dialog_item' as the source.
				dockable_source := dialog_item
			end
			if attached dockable_dialog as l_dockable_dialog and then attached l_dockable_dialog.original_parent as l_original_parent then
				target_i ?= l_original_parent.implementation
			end
			check
				target_not_void: target_i /= Void then
			end
			if target_i.docked_actions_internal /= Void then
				target_i.docked_actions.call ([dockable_source])
			end

			dockable_dialog.destroy
		ensure
			dockable_dialog_destroyed: dockable_dialog.is_destroyed
		end

feature -- Inapplicable

	drag_cursor: EV_POINTER_STYLE
			-- Cursor used when `Current' is being transported.
		once
			Result := (create {EV_STOCK_PIXMAPS}).sizeall_cursor
		end


feature {NONE} -- Implementation

	widget_source_being_docked: detachable EV_WIDGET_IMP
			-- `Result' is `source_being_docked' or `Void' if
			-- it is not a widget.
		local
			widget_i: detachable EV_WIDGET
		do
				-- On Gtk items, also inherit EV_WIDGET_IMP so
				-- we protect against this by using the _I as an intermediary
				-- step.
			if attached source_being_docked as l_source_being_docked then
				widget_i ?= l_source_being_docked.interface
				if widget_i /= Void then
					Result ?= source_being_docked
				end
			end
		end

	item_source_being_docked: detachable EV_ITEM_I
			-- `Result' is `source_being_docked' or `Void' if
			-- it is not an item.
		do
			Result ?= source_being_docked
		end

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- `Result' is widget implementation at current
			-- cursor position.
		deferred
		end

	position_in_parent (a_dockable_source: EV_DOCKABLE_SOURCE_I): INTEGER
			-- `Result' is position of `a_widget' within its `parent'.
		local
			cell: detachable EV_CELL
			box: detachable EV_BOX
			a_widget: detachable EV_WIDGET
			a_tool_bar_button: detachable EV_TOOL_BAR_BUTTON
			tool_bar: detachable EV_TOOL_BAR
		do
			a_widget ?= a_dockable_source.interface
			if a_widget /= Void then
				cell ?= a_widget.parent
				if cell /= Void then
					Result := 1
				end
				box ?= a_widget.parent
				if box /= Void then
					Result := box.index_of (a_widget, 1)
				end
			else
				a_tool_bar_button ?= a_dockable_source.interface
				check
					source_was_widget_or_tool_bar_button: a_tool_bar_button /= Void then
				end
				tool_bar ?= a_tool_bar_button.parent
				check tool_bar /= Void then end
				Result := tool_bar.index_of (a_tool_bar_button, 1)
			end
		end

	initialize_transport (a_screen_x, a_screen_y: INTEGER; source: EV_DOCKABLE_SOURCE)
			-- Store platform independent settings required
			-- to execute the dragging. `a_screen_x' and `a_screen_y' are
			-- the coordinates of the mouse relative to `Current' when the transport
			-- began.
		local
			widget: detachable EV_WIDGET
			tool_bar_button: detachable EV_TOOL_BAR_BUTTON
		do
			if dock_started_actions_internal /= Void then
				dock_started_actions_internal.call (Void)
			end
				-- Now block the motion actions from the interface
			widget ?= source
			if widget /= Void then
				widget.pointer_motion_actions.block
			else
				tool_bar_button ?= source
				if tool_bar_button /= Void then
					tool_bar_button.pointer_motion_actions.block
				else
					check
						type_not_supported: False
					end
				end
			end

			if attached source.real_source as l_source_real_source then
				source_being_docked ?= l_source_real_source.implementation
			else
				source_being_docked ?= source.implementation
			end
			originating_source ?= source.implementation
			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16
		ensure
			source_being_docked_set: source_being_docked /= Void
		end

	move_dialog_to_pointer (dialog: EV_DOCKABLE_DIALOG)
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

			-- Executed when `pebble' is being moved.
		local
			counter: INTEGER
			target: detachable EV_DOCKABLE_TARGET
			container: detachable EV_CONTAINER
			box: detachable EV_BOX_IMP
			cursor: EV_DYNAMIC_LIST_CURSOR [detachable EV_WIDGET]
			cell: detachable EV_CELL_I
			insert_position: INTEGER
			dragged_index: INTEGER
			insert_label_pos: INTEGER
			tool_bar: detachable EV_TOOL_BAR_IMP
			tool_bar_button: detachable EV_TOOL_BAR_BUTTON
			veto_result: BOOLEAN
			temp_int: INTEGER
			l_top_level_window_imp: detachable EV_WINDOW_IMP
		do
			target := closest_dockable_target
			if attached widget_source_being_docked as l_widget_source_being_docked then
				-- We are transporting a widget, so we can find the EV_CONTAINER
				-- and modify the interface accordingly, to insert `insert_label' to
				-- provide graphical feedback to user.

				if target /= Void and target /= insert_label then

					 -- remove `insert_label' if the pointed target has changed
					container ?= target
					if container /= Void then
						if target.veto_dock_function /= Void then
							veto_result := True
						end
						from
							counter := 0
						until
							target = Void or (target /= Void and then target.veto_dock_function = Void) or
							(target /= Void and then target.veto_dock_function /= Void and (not veto_result))
						loop
							counter := counter + 1
							if attached target.veto_dock_function as l_veto_dock_function then
								veto_result := l_veto_dock_function.item ([l_widget_source_being_docked.attached_interface])
								if veto_result then
									target := get_next_target (container)
								end
							end
						end
						if target /= Void then
						container ?= target
						check
							container_not_void: container /= Void then
						end
							if insert_label.parent /= container then
								remove_insert_label
							end
							box ?= container.implementation
							cell ?= container.implementation

						end
					end
					if box /= Void then
						insert_position := box.insertion_position
						if insert_position /= -1 then
							if box.count = 0 or (not ((box.i_th (insert_position.min (box.count)) = insert_label) or (box.i_th ((insert_position - 1).max (1)) = insert_label))) then
								dragged_index := box.index_of (l_widget_source_being_docked.interface, 1)
								if l_widget_source_being_docked.parent = box.interface and (dragged_index = insert_position or dragged_index = insert_position - 1) then
										-- Now unparent `insert_label' as we are now pointing to our original location,
										-- or next to it, so there should be no insert label displayed.
									temp_int := box.index_of (l_widget_source_being_docked.interface, 1)
									if temp_int = insert_position or temp_int + 1 = insert_position then
										remove_insert_label
									end
								else
									if insert_label.parent /= Void then
										insert_label_pos := position_in_parent (insert_label_imp)
										if insert_label_pos < insert_position then
											insert_position := insert_position - 1
										end
									end
									l_top_level_window_imp := box.top_level_window_imp
									check l_top_level_window_imp /= Void then end
									l_top_level_window_imp.lock_update
									remove_insert_label
									cursor := box.cursor
									box.go_i_th (insert_position)
									box.put_left (insert_label)
									box.set_child_expandable (insert_label, False)
									box.go_to (cursor)
									l_top_level_window_imp.unlock_update
								end
							end
						end
					end
					if cell /= Void then
						if cell.item = Void then
							remove_insert_label
							cell.extend (insert_label)
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
				if attached target as l_target and then attached item_source_being_docked as l_item_source then
					if attached l_target.veto_dock_function as l_veto_dock_function then
						tool_bar_button ?= l_item_source.interface
						check
							we_only_support_tool_bar_buttons: tool_bar_button /= Void
						end
						if tool_bar_button /= Void then
							if not l_veto_dock_function.item ([tool_bar_button]) then
								tool_bar ?= l_target.implementation
							end
						end
					else
						tool_bar ?= l_target.implementation
					end

					if tool_bar /= Void then
						insert_position := tool_bar.insertion_position
						if insert_position /= -1 then
							if insert_position < tool_bar.count then
								insert_position := insert_position + 1
							end
							if not ((tool_bar.i_th (insert_position.min (tool_bar.count)) = insert_sep) or (tool_bar.i_th ((insert_position - 1).max (1)) = insert_sep)) then
								tool_bar_button ?= l_item_source.interface
								check
									tool_bar_button_not_void: tool_bar_button /= Void
								end
								dragged_index := tool_bar.index_of (tool_bar_button, 1)
								if l_item_source.parent = tool_bar.interface and (dragged_index = insert_position or dragged_index = insert_position - 1) then
										-- As we are pointing to the original tool bar item that
										-- is being transported, we remove `insert_sep' to illustrate
										-- that no movement will occur when the transport ends.
									remove_insert_sep
								else
									if insert_label.parent /= Void then
-- FIXME								insert_label_pos := position_in_parent (insert_sep_imp)
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

		unparent_source_being_docked
				-- Remove `widget_source_being_docked' from `parent' or
				-- `item_source_being_docked' from `parent'.
			require
				widget_or_item: widget_source_being_docked /= Void or item_source_being_docked /= Void
			do
				if attached widget_source_being_docked as l_wid_source_being_docked and then attached l_wid_source_being_docked.attached_interface.parent as l_wid_source_being_docked_parent then
					l_wid_source_being_docked_parent.prune (l_wid_source_being_docked.attached_interface)
					check
						not_parented: l_wid_source_being_docked.parent = Void
					end
				elseif attached item_source_being_docked as l_item_source_being_docked and then attached l_item_source_being_docked.attached_interface.parent as l_item_source_being_docked_parent then

					l_item_source_being_docked_parent.prune (l_item_source_being_docked.attached_interface)
					check
						not_parented: l_item_source_being_docked.parent = Void
					end
				else
					check False end
				end
			end

		replace_insert_label
				-- Replace `insert_label' with `widget_source_being_docked'.
			require
				source_not_parented: attached widget_source_being_docked as l_wid_source_being_docked and then l_wid_source_being_docked.parent = Void
				insert_label_parented: insert_label.parent /= Void
			local
				box: detachable EV_BOX
				cell: detachable EV_CELL
				target: detachable EV_DOCKABLE_TARGET_I
				l_widget_source_being_docked: like widget_source_being_docked
			do
				if attached insert_label.parent as l_parent then
					target ?= l_parent.implementation
				end
				l_widget_source_being_docked := widget_source_being_docked
				check l_widget_source_being_docked /= Void then end
				check
					target_not_void: target /= Void then
				end
				box ?= insert_label.parent
				if box /= Void then
					box.put_i_th (l_widget_source_being_docked.attached_interface, box.index_of (insert_label, 1))
				end
				cell ?= insert_label.parent
				if cell /= Void then
					cell.put (l_widget_source_being_docked.attached_interface)
				end
				if target.docked_actions_internal /= Void then
					target.docked_actions.call ([l_widget_source_being_docked.attached_interface])
				end
			ensure
				source_parented: attached widget_source_being_docked as l_wid_source_being_docked and then l_wid_source_being_docked.parent = old insert_label.parent
				insert_label_not_parented: insert_label.parent = Void
			end

		replace_insert_sep
				-- Replace `insert_sep' with item_source_being_docked'.
			require
				source_not_parented: attached item_source_being_docked as l_item_source_being_docked and then l_item_source_being_docked.parent = Void
				sep_parented: insert_sep.parent /= Void
			local
				tool_bar: detachable EV_TOOL_BAR
				tool_bar_item: detachable EV_TOOL_BAR_ITEM
				source: detachable EV_DOCKABLE_SOURCE
				insert_index, original_index: INTEGER
			do
				tool_bar ?= insert_sep.parent
				check
					parent_was_tool_bar: tool_bar /= Void then
				end
				if attached item_source_being_docked as l_item_source then
					tool_bar_item ?= l_item_source.interface
				end
				check
					tool_bar_item_not_void: tool_bar_item /= Void then
				end
				source ?= tool_bar_item
				check
					source_not_void: source /= Void then
				end
				insert_index := tool_bar.index_of (insert_sep, 1)
				tool_bar.put_i_th (tool_bar_item, tool_bar.index_of (insert_sep, 1))

					-- We must now provide provisions for updating the state of the tool bar buttons.
					-- In some cases, the state is affected by the transport. We provide a platform
					-- specific implementation, as any work required will depend on the exact behaviour.
				if original_index = insert_index + 2 then
					update_buttons (tool_bar, original_index, insert_index)
				end

				if tool_bar.implementation.docked_actions_internal /= Void then
					tool_bar.docked_actions.call ([source])
				end
			ensure
				source_parented: attached item_source_being_docked as l_item_source and then l_item_source.parent /= Void
				insert_sep_not_parented: insert_sep.parent = Void
				parent_swapped: insert_sep.parent = l_item_source.parent
			end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER)
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		require
			start_index_valid: start_index >= 1
			end_index_valid: end_index <= a_parent.count
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DOCKABLE_SOURCE note option: stable attribute end;

invariant
--	no_widget_stored_while_not_dragging: not is_dragging implies source_being_docked = Void
--	widget_stored_while_dragging: is_dragging implies source_being_docked /= Void
--	no_temporary_widget_when_no_target: is_dock_executing and then closest_dockable_target = Void implies insert_label.parent = Void
	widget_or_item_source: not (widget_source_being_docked /= Void and item_source_being_docked /= Void)
	dock_executing: is_dock_executing implies widget_source_being_docked /= Void or item_source_being_docked /= Void

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_SOURCE_I











