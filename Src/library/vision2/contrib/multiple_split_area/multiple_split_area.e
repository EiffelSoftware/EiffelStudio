indexing
	description: "Objects that represent a split area that will hold multiple items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLE_SPLIT_AREA
	
inherit
	EV_VERTICAL_SPLIT_AREA
		rename
			extend as cell_extend,
			count as cell_count,
			linear_representation as old_linear_representation,
			wipe_out as split_area_wipe_out
		export
			{MULTIPLE_SPLIT_AREA_TOOL_HOLDER, MULTIPLE_SPLIT_AREA} all
			{ANY} parent, width, height, resize_actions, set_minimum_height, is_show_requested, is_destroyed
		redefine
			initialize
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_SPLIT_AREA}
			create linear_representation.make (4)
			create external_representation.make (4)
			create all_holders.make (4)
			create all_split_areas.make (4)
			create stored_splitter_widths.make (4)
			create minimized_states.make (4)
			all_split_areas.extend (Current)
			disabled_minimize_button_shown := True
		end

feature -- Access

	disabled_minimize_button_shown: BOOLEAN
		-- Are disabled minimize buttons displayed?
			
	disabled_close_button_shown: BOOLEAN
		-- Are close buttons displayed (disabled) for widgets that may not be closed?
		
	show_disabled_close_button: BOOLEAN is
			-- Ensure `disabled_close_button_shown' is `True'.
		do
			disabled_close_button_shown := True
		end
	
	hide_disabled_close_button: BOOLEAN is
			-- Ensure `disable_close_button_shown' is `False'.
		do
			disabled_close_button_shown := False
		end
			
	show_disabled_minimize_button is
			-- Ensure `disabled_minimize_button_shown' is `True'.
		do
			disabled_minimize_button_shown := True
		end
	
	hide_disabled_minimize_button is
			-- Ensure `disabled_minimize_button_shown' is `False'.
		do
			disabled_minimize_button_shown := False
		end

	count: INTEGER is
			-- Number of widgets actually within `Current', does not include any
			-- widgets that are currently docked out. Therefore, when a widget is
			-- docked out, `count' is reduced by one.
		do
			Result := linear_representation.count
		ensure
			result_valid: Result >= 0
		end
		
	is_item_minimized (a_widget: EV_WIDGET): BOOLEAN is
			-- Is `a_widget' minimized in `Current'?
		require
			widget_contained: linear_representation.has (a_widget)
		do
			Result := holder_of_widget (a_widget).is_minimized
		end
		
	is_item_maximized (a_widget: EV_WIDGET): BOOLEAN is
			-- Is `a_widget' maximized in `Current'?
		require
			widget_contained: linear_representation.has (a_widget)
		do
			if maximized_tool /= Void then
				Result := maximized_tool.tool = a_widget	
			end
		ensure
			Result_consistent: Result implies maximized_tool /= Void
		end
		
	is_item_external (a_widget: EV_WIDGET): BOOLEAN is
			-- Is `a_widget' currently external to `Current'?
			-- i.e. has been docked out.
		require
			widget_not_void: a_widget /= Void
		do
			Result := external_representation.has (a_widget)
		ensure
			Result_consistent: Result implies external_representation.has (a_widget)
		end
		
	original_index_of_external_item (a_widget: EV_WIDGET): INTEGER is
			-- `Result' is original index of `a_widget' in `Current' before
			-- it was made external.
		require
			widget_not_void: a_widget /= Void
			item_is_external: is_item_external (a_widget)
		do
			Result := holder_of_widget (a_widget).position_docked_from
		ensure
			Result_positive: Result >= 1
		end

	top_widget_resizing: BOOLEAN
		-- Does the top widget displayed in `Current' resize vertically as `Current' is resized?
		-- If False, the bottom widget will be resized vertically instead.
	
	linear_representation: ARRAYED_LIST [EV_WIDGET]
		-- All widgets held in `Current'. This only includes widgets that
		-- are not currently docked out of `Current'. See `external_widgets'
		-- for these. Ordered as displayed in `Current'.
		
	external_representation: ARRAYED_LIST [EV_WIDGET]
		-- All widgets that have been inerted into `Current' but are presently
		-- docked out of `Current'. No paticular order is guaranteed.
		
	docked_out_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when a widget is docked out of `Current'.
		do
			if docked_out_actions_internal = Void then
				create docked_out_actions_internal
			end
			Result := docked_out_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	docked_in_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed after a widget has been docked in to `Current'.
		do
			if docked_in_actions_internal = Void then
				create docked_in_actions_internal
			end
			Result := docked_in_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	close_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- 	Actions to be performed after close icon is selected.
		do
			if close_actions_internal = Void then
				create close_actions_internal
			end	
			Result := close_actions_internal
		end
		
	minimize_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed after a minimize icon is selected.
		do
			if minimize_actions_internal = Void then
				create minimize_actions_internal
			end	
			Result := minimize_actions_internal
		end
		
	maximize_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed after a maximize icon is selected.
		do
			if maximize_actions_internal = Void then
				create maximize_actions_internal
			end	
			Result := maximize_actions_internal
		end
		
	restore_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed after an item has been restored.
		do
			if restore_actions_internal = Void then
				create restore_actions_internal
			end	
			Result := restore_actions_internal
		end

	customizeable_area_of_widget (widget: EV_WIDGET): EV_HORIZONTAL_BOX is
			-- `Result' is an EV_HORIZONTAL_BOX contained in the header of the tool
			-- surrounding `widget' which permits you to customize the tools appearence
			-- in `Current'. You should not unparent, `Result' or do anything dangerous
			-- to this widget, and it should be simply used to insert and remove
			-- widgets for customization as required.
		require
			widget_contained: linear_representation.has (widget) or
				external_representation.has (widget)
		do
			Result := holder_of_widget (widget).customizeable_area
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	enable_top_widget_resizing is
			-- Ensure `top_widget' resizing is `True'.
			--| FIXME does not keep original positions.
		do
			top_widget_resizing := True
			rebuild
		ensure
			top_resizing: top_widget_resizing = True
		end
		
	disable_top_widget_resizing is
			-- Ensure `top_widget' resizing is `False'.
			--| FIXME does not keep original positions.
		do
			top_widget_resizing := False
			rebuild
		ensure
			not_top_resizing: top_widget_resizing = False
		end
		
	enable_close_button_as_grayed (widget: EV_WIDGET) is
			-- Display a grayed out close button for `widget'.
		require
			widget_not_void: widget /= Void
			may_enable_close_button: linear_representation.has (widget) or is_item_external (widget)
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			holder := holder_of_widget (widget)
			holder.enable_close_button_as_grayed
		end
		
		
	enable_close_button (widget: EV_WIDGET) is
			-- Display a close button for `widget'.
		require
			widget_not_void: widget /= Void
			may_enable_close_button: linear_representation.has (widget) or is_item_external (widget)
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			holder := holder_of_widget (widget)
			holder.enable_close_button
		end
		
	disable_close_button (widget: EV_WIDGET) is
			-- hide the close button for `widget'.
		require
			widget_not_void: widget /= Void
			may_disable_close_button: linear_representation.has (widget) or is_item_external (widget)
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			holder := holder_of_widget (widget)
			holder.disable_close_button
		end

	resize_widget_to (a_widget: EV_WIDGET; a_height: INTEGER) is
			-- Resize `a_widget' to `a_height' pixels.
		require
			widget_not_void: a_widget /= Void
			has_widget: linear_representation.has (a_widget) or is_item_external (a_widget)
			height_positive: a_height >= 0
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			holder := holder_of_widget (a_widget)
--			from
--				all_holders.start
--			until
--				all_holders.off
--			loop
--				if all_holders.item /= holder then
--					max_size := max_size + all_holders.item.minimum_height
--				end
--				all_holders.forth
--			end
--			max_size := height - max_size
			holder.simulate_minimum_height (a_height + holder_tool_height)--.min (max_size))
			if Platform_is_windows then
				holder.remove_simulated_height
			else
				application.do_once_on_idle (agent holder.remove_simulated_height)
			end
		end
		
	is_blocked: BOOLEAN

	block is
			-- 
		do
			is_blocked := True
		end
		
	unblock is
		do
			is_blocked := False
		end

	set_maximize_pixmap (pixmap: EV_PIXMAP) is
			-- Use `pixmap' as image on maximize buttons.
		require
			pixmap_not_void: pixmap /= Void
		do
			maximize_pixmap := pixmap.twin
		end
		
	set_minimize_pixmap (pixmap: EV_PIXMAP) is
			-- Use `pixmap' as image on minimize buttons.
		require
			pixmap_not_void: pixmap /= Void
		do
			minimize_pixmap := pixmap.twin
		end
		
	set_close_pixmap (pixmap: EV_PIXMAP) is
			-- Use `pixmap' as image on close buttons.
		require
			pixmap_not_void: pixmap /= Void
		do
			close_pixmap := pixmap.twin
		end

	set_restore_pixmap (pixmap: EV_PIXMAP) is
			-- Use `pixmap' as image on restore buttons.
		require
			pixmap_not_void: pixmap /= Void
		do
			restore_pixmap := pixmap.twin
		end

	extend (widget: EV_WIDGET; name: STRING) is
			-- Add `widget' to end with default height of 150 pixels.
		require
			widget_not_void: widget /= Void
			name_not_void: name /= Void
		do
			insert_widget (widget, name, count + 1, 150)
		ensure
			has_widget: linear_representation.has (widget)
			count_increased: linear_representation.count = old linear_representation.count + 1
		end

	insert_widget (widget: EV_WIDGET; name: STRING; position, desired_height: INTEGER) is
			-- Insert `widget' into `Current' at position `position' with height `desired_height'.
		require
			widget_not_void: widget /= Void
			position_valid: position >= 1 and position <= count + 1
			not_contained: not linear_representation.has (widget)
			name_not_void: name /= Void
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			locked_in_here: BOOLEAN
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here and parent_window (Current) /= Void then
				parent_window (Current).lock_update	
			end		
			store_heights_pre_insertion
			
			create holder.make_with_tool (widget, name, Current)
			linear_representation.go_i_th (position)
			linear_representation.put_left (widget)
			all_holders.go_i_th (position)
			all_holders.put_left (holder)
				-- If there is a tool maximized in `Current', then
				-- add `widget' accordingly.
			if maximized_tool /= Void then
				holder.silent_set_minimized
				holder.disable_minimize_button
					-- We must updated the stored minimized states.
				if position = minimized_states.count + 1 then
					minimized_states.extend (False)
				else
					minimized_states.go_i_th (position)
					minimized_states.put_left (False)
				end
			end
			rebuild	

			restore_heights_post_insertion (holder, desired_height)
			if locked_in_here and parent_window (Current) /= Void then
				parent_window (Current).unlock_update
			end
		ensure
			contained: linear_representation.has (widget)
			count_increased: linear_representation.count = old linear_representation.count + 1
		end

	add_external (widget: EV_WIDGET; window: EV_WINDOW; name: STRING; position, an_x, a_y, a_width, a_height: INTEGER) is
			-- Add `widget' to `Current' as an external tool with name `name', a restore position of `position'
			-- for when it is returned back to `Current', and a dialog screen size and position of `an_x', `a_y',
			-- `a_width' and `a_height'. This effectively restores a tool as if it had already been dragged
			-- out of `Current'.
		require
			widget_not_void: widget /= Void
			widget_not_parented: widget.parent = Void
			window_not_void: window /= Void
			name_not_void: name /= Void
			size_valid: a_width > 0 and a_height > 0
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			dialog: MULTIPLE_SPLIT_AREA_DOCKABLE_DIALOG
		do
			create holder.make_with_tool (widget, name, Current)
			holder.set_position_docked_from (position)
			all_holders.extend (holder)
			external_representation.extend (widget)
			holder.minimize_button.disable_sensitive
			holder.maximize_button.disable_sensitive
			create dialog
			holder.main_box.parent.prune_all (holder.main_box)
			dialog.extend (holder.main_box)
			dialog.enable_closeable
			dialog.close_request_actions.wipe_out
			dialog.close_request_actions.extend (agent holder.destroy_dialog_and_restore (dialog))
			dialog.set_position (an_x, a_y)
			dialog.set_size (a_width, a_height)
			dialog.show_relative_to_window (window)
		ensure
			added_externally: external_representation.has (widget)
			not_in_linear_rep: not linear_representation.has (widget)
		end

	remove (a_widget: EV_WIDGET) is
			-- Remove `a_widget' from `Current'
		require
			a_widget_not_void: a_widget /= Void
			contained: linear_representation.has (a_widget) or is_item_external (a_widget)
		local
			locked_in_here: BOOLEAN
			original_index: INTEGER
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here and parent_window (Current) /= Void then
				parent_window (Current).lock_update	
			end
			store_positions

				-- Now update the stored positions so that on restoration, the removed
				-- widget position is added to the resizeable widget. This ensures that the size of
				-- only the adjustable widget is affected
			original_index := linear_representation.index_of (a_widget, 1)
			if not is_item_external (a_widget) then
				if not is_item_minimized (a_widget) then
					stored_splitter_widths.put_i_th (stored_splitter_widths.first + stored_splitter_widths.i_th (original_index), 1)
				end
				stored_splitter_widths.go_i_th (original_index)
				stored_splitter_widths.remove
			end

			if is_item_maximized (a_widget) then
				restore_item (a_widget)
			end
			remove_implementation (a_widget)
			rebuild
			if not is_blocked then
				restore_stored_positions
			end
			if locked_in_here and parent_window (Current) /= Void then
				parent_window (Current).unlock_update
			end
		ensure
			remove: not linear_representation.has (a_widget)
			widget_not_parented: a_widget.parent = Void
			count_decreased: old linear_representation.has (a_widget) implies linear_representation.count = old linear_representation.count - 1
		end
		
	wipe_out is
			-- Remove all items from `Current'.
			-- We have to call `remove_implementation' instead of `remove',
			-- as do not want to call `rebuild' during the wipe out. This
			-- also means that we must explicitly wipe out `all_split_areas'
			-- ourself.
		local
			index: INTEGER
			dockable_dialog: EV_DOCKABLE_DIALOG
			tool: EV_WIDGET
		do
			rebuilding_locked := True
			stored_splitter_widths.wipe_out
			all_split_areas.wipe_out
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				index := linear_representation.index
				remove_implementation (linear_representation.item)
			end
			from
				external_representation.start
			until
				external_representation.off
			loop
				tool := external_representation.item
				dockable_dialog ?= parent_window (tool)
				check
					parent_window_was_dialog: dockable_dialog /= Void
				end
				dockable_dialog.wipe_out
				dockable_dialog.destroy
				if tool.parent /= Void then
					tool.parent.prune_all (tool)
				end
				external_representation.remove
			end
			rebuilding_locked := False
		ensure
			empty: count = 0
			no_external_tools: external_representation.is_empty
		end
		
	maximize_item (a_widget: EV_WIDGET) is
			-- maximize `a_widget'.
		require
			has_widget: linear_representation.has (a_widget)
			widget_not_maximized: not is_item_maximized (a_widget)
		local
			tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			locked_in_here: BOOLEAN
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				parent_window (Current).lock_update	
			end		
			tool_holder := holder_of_widget (a_widget)
			tool_holder.enable_maximized
			maximize_tool (tool_holder)
			tool_holder.maximize_button.set_pixmap (restore_pixmap)
			tool_holder.maximize_button.set_tooltip (restore_string)
			tool_holder.label.disable_dockable
			if locked_in_here then
				parent_window (Current).unlock_update
			end
			maximize_actions.call ([a_widget])
		ensure
			is_maximized: is_item_maximized (a_widget)
		end
		
	minimize_item (a_widget: EV_WIDGET) is
			-- Minimize `a_widget'.
		require
			has_widget: linear_representation.has (a_widget)
			widget_not_minimized: not is_item_minimized (a_widget)
		local
			tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			locked_in_here: BOOLEAN
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				parent_window (Current).lock_update	
			end		
			tool_holder := holder_of_widget (a_widget)
			tool_holder.enable_minimized
			tool_holder.set_restore_height (a_widget.height)
			minimize_tool (tool_holder)
			tool_holder.minimize_button.set_pixmap (restore_pixmap)
			tool_holder.minimize_button.set_tooltip (restore_string)

			if locked_in_here then
				parent_window (Current).unlock_update
			end
			minimize_actions.call ([a_widget])
		ensure
			is_minimized: is_item_minimized (a_widget)
		end
		
	set_item_restore_height (a_widget: EV_WIDGET; a_height: INTEGER) is
			-- Associate a restore height with item `a_widget'.
			-- This height will be used when `a_widget' is restored from
			-- a minimized of maximized state.
		require
			has_widget: linear_representation.has (a_widget)
			widget_maximized_or_minimized: is_item_maximized (a_widget) or
				is_item_minimized (a_widget)
			height_valid: a_height >= 0 
		local
			tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			tool_holder := holder_of_widget (a_widget)
			tool_holder.set_restore_height (a_height)
		end
	
	restore_item (a_widget: EV_WIDGET) is
			-- Restore representation of `a_widget' within `Current'.
		require
			has_widget: linear_representation.has (a_widget)
			widget_maximized_or_minimized: is_item_maximized (a_widget) or
				is_item_minimized (a_widget)
		local
			tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			locked_in_here: BOOLEAN
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				parent_window (Current).lock_update	
			end		
			tool_holder := holder_of_widget (a_widget)
			
			if tool_holder.is_maximized then
				restore_maximized_tool (tool_holder, True)
				tool_holder.maximize_button.set_pixmap (maximize_pixmap)
				tool_holder.label.enable_dockable
			else
				restore_minimized_tool (tool_holder)
				tool_holder.minimize_button.set_pixmap (minimize_pixmap)
				tool_holder.minimize_button.set_tooltip ("Minimize")
			end
			restore_actions.call ([a_widget])
			if locked_in_here then
				parent_window (Current).unlock_update
			end
		ensure
			--	widget_normal_state: not is_item_maximized (a_widget) and not is_item_minimized (a_widget)
			-- Does not hold in all situations, as a widget may be maximized while minimized, and in this
			-- situation, must go back to minimized state.
		end
		
	set_heights_no_resize (heights: ARRAYED_LIST [INTEGER]) is
			-- Adjust heights of contents based on `heights' as a guide,
			-- but ensure that `Current' is not resized unless the
			-- minimum sizes of each widget force it to be so.
		require
			heights_not_void: heights /= Void
		local
			desired_height: INTEGER
			excess_space: INTEGER
			diff_from_min: INTEGER
			widget: EV_WIDGET
			non_minimized_count: INTEGER
		do
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item.is_minimized then
					desired_height := desired_height + holder_tool_height
				elseif all_holders.item.is_external then
				else
					non_minimized_count := non_minimized_count + 1
					desired_height := desired_height + holder_tool_height + heights.i_th (non_minimized_count)
				end
				all_holders.forth
			end
			desired_height := desired_height + (non_minimized_count - 1) * splitter_width
			excess_space := desired_height - height
			if top_widget_resizing then
					from
						heights.start
					until
						heights.off or excess_space <= 0
					loop
						widget := linear_representation.i_th (heights.index)
						if not is_item_minimized (widget) then
							diff_from_min := (heights.item - widget.minimum_height).min (excess_space)
							excess_space := excess_space - diff_from_min
							heights.replace (heights.item - diff_from_min)
						end
						heights.forth
					end
				else
--					from
--						pre_insertion_holders.finish
--						pre_insertion_heights.finish
--					until
--						pre_insertion_holders.off or space_to_share <= 0
--					loop
--						diff_from_min := (pre_insertion_heights.item - pre_insertion_holders.item.minimum_height).min (space_to_share)
--						space_to_share := space_to_share - diff_from_min
--						pre_insertion_heights.replace (pre_insertion_heights.item - diff_from_min)
--						pre_insertion_holders.back
--						pre_insertion_heights.back
--					end
				end
			set_heights (heights)
		end
		
		
	set_heights (heights: ARRAYED_LIST [INTEGER]) is
			-- Adjust heights of contents based on `heights'.
		require
			heights_not_void: heights /= Void
		local
			locked_in_here: BOOLEAN
		do
			locked_in_here := (create {EV_ENVIRONMENT}).application.locked_window = Void
			if locked_in_here then
				parent_window (Current).lock_update	
			end
			if top_widget_resizing then
				from
					all_split_areas.start
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.maximum_split_position)	
					end
					all_split_areas.forth
				end
			else
				from
					all_split_areas.finish
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.minimum_split_position)						
					end
					all_split_areas.back
				end
			end
			from
				heights.start
			until
				heights.off
			loop
				if not is_item_minimized (linear_representation.i_th (heights.index)) then
					resize_widget_to (linear_representation.i_th (heights.index), heights.item)
				end
				heights.forth
			end
			if locked_in_here then
				parent_window (Current).unlock_update
			end
		end

	place_holder_inside_insert_structure (a_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER): EV_VERTICAL_BOX is
			-- `Result' is a vertical box containing a vertical box representing `upper_box' of `a_holder',
			-- `a_holder' itself and a vertical box representing `lower_box' of `a_holder'.
		require
			holder_not_void: a_holder /= Void
		do
			create Result
			Result.extend (create {EV_VERTICAL_BOX})
			Result.extend (a_holder)
			Result.extend (create {EV_VERTICAL_BOX})
			Result.disable_item_expand (Result.i_th (1))
			Result.disable_item_expand (Result.i_th (3))
		ensure
			Result_not_void: result /= Void
			result_filled_correctly: Result.count = 3 and result.i_th (2) = a_holder
		end

feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Implementation

	rebuilding_locked: BOOLEAN
		-- Will calls to `rebuild' have no effect?

	rebuild is
			-- Rebuild complete widget structure of `Current'.
		local
			split_area: EV_VERTICAL_SPLIT_AREA
			current_split_area: EV_SPLIT_AREA
			current_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			cursor: CURSOR
		do
			if not rebuilding_locked then
				cursor := linear_representation.cursor
				split_area_wipe_out
				all_split_areas.wipe_out
				unparent_all_holders
				all_split_areas.extend (Current)
				if count = 1 then
					cell_extend (place_holder_inside_insert_structure (holder_of_widget (linear_representation.i_th (1))))
				elseif count = 2 then
					cell_extend (place_holder_inside_insert_structure (holder_of_widget (linear_representation.i_th (1))))
					cell_extend (place_holder_inside_insert_structure (holder_of_widget (linear_representation.i_th (2))))
					if top_widget_resizing then
						enable_item_expand (first)
						disable_item_expand (second)				
					end
				elseif count /= 0 then
					from
						linear_representation.start
						current_split_area := Current
					until
						linear_representation.off
					loop
						if top_widget_resizing then
							current_holder := holder_of_widget (linear_representation.i_th (linear_representation.count - linear_representation.index + 1))
							current_split_area.set_second (place_holder_inside_insert_structure (current_holder))
						else
							current_holder := holder_of_widget (linear_representation.item)
							current_split_area.set_first (place_holder_inside_insert_structure (current_holder))
						end
						
						if linear_representation.index = linear_representation.count - 1 then
							linear_representation.forth
							check
								at_last_position: linear_representation.index = linear_representation.count
							end
							if top_widget_resizing then
								current_holder := holder_of_widget (linear_representation.i_th (1))
								current_split_area.set_first (place_holder_inside_insert_structure (current_holder))
							else
								current_holder := holder_of_widget (linear_representation.item)
								current_split_area.set_second (place_holder_inside_insert_structure (current_holder))
							end
						else
							create split_area
							all_split_areas.extend (split_area)
							if top_widget_resizing then
								current_split_area.set_first (split_area)
							else
								current_split_area.set_second (split_area)
							end
							current_split_area := split_area
						end
						linear_representation.forth
					end
					if top_widget_resizing then
						reverse_split_areas
					end
				end
				minimize_all_tools
				update_all_minimize_buttons			
				linear_representation.go_to (cursor)
			end
		end
		
	reverse_split_areas is
			-- Reverse disable item expand state of all split areas,
			-- so that the direction of `Current' is reversed.
			-- Only required in `top_resizing_mode'.
		require
			in_top_resizing_mode: top_widget_resizing
		local
			split_area: EV_SPLIT_AREA
		do
			from
				all_split_areas.start
			until
				all_split_areas.off or all_split_areas.count = 1
			loop
				split_area := all_split_areas.item
				split_area.enable_item_expand (split_area.first)
				split_area.disable_item_expand (split_area.second)
				all_split_areas.forth
			end
		end
		
	split_area_index (holder_index: INTEGER): INTEGER is
			-- Index of split area containing `holder_index'.
		require
			holder_index_valid: holder_index >= 1 and holder_index <= linear_representation.count
		do
			if top_widget_resizing then
				Result := all_split_areas.count - holder_index + 2
			else
				Result := holder_index
			end
		end
		
feature {MULTIPLE_SPLIT_AREA_TOOL_HOLDER} -- Implementation
	
	all_split_areas: ARRAYED_LIST [EV_SPLIT_AREA]
		-- All split areas constituting `Current'.

	all_holders: ARRAYED_LIST [MULTIPLE_SPLIT_AREA_TOOL_HOLDER]
		-- All holders within `Current', includes externally docked holders.

	maximize_pixmap: EV_PIXMAP
		-- Pixmap associated with maximize buttons.
	
	minimize_pixmap: EV_PIXMAP
		-- Pixmap associated with minimize buttons.
	
	close_pixmap: EV_PIXMAP
		-- Pixmap associated with close buttons.
	
	restore_pixmap: EV_PIXMAP
		-- Pixmap associated with restore buttons.
	
	initialize_docking_areas (a_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- Set up docking areas to allow the docking of `a_holder'.
		require
			a_holder_not_void: a_holder /= Void
		local
			index_of_tool: INTEGER
			vertical_box: EV_VERTICAL_BOX
			cell: EV_CELL
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			counter: INTEGER
		do	
				-- Only retrieve the index if `a_holder' is not external.
				-- otherwise, `index_of_tool' is initialized to 0.
			if not external_representation.has (a_holder.tool) then
				index_of_tool := index_of_holder (a_holder)
			end
			
			from
				counter := 1
			until
				counter > count
			loop
				holder := holder_of_widget (linear_representation.i_th (counter))
				if linear_representation.has (a_holder.tool) and (counter < index_of_tool or
					counter > index_of_tool + 1) or not linear_representation.has (a_holder.tool) then
					
						--|FIXME this is a temporary workaround/limitation when you try to move an undocked widget that
						-- has only minimized widgets between itself and the edge, to the edge. No longer allowed
						-- AS it caused an infinited loop. Julian.
					if not a_holder.has_recursive (holder.upper_box) then
						vertical_box := holder.upper_box
						create cell
						cell.set_data (counter)
						vertical_box.extend (cell)
						vertical_box.disable_item_expand (cell)
						cell.enable_docking
						holder.set_real_target (cell)
					end
				end
				if counter = count and index_of_tool /= count then
						-- As `holder' is the last holder, we must perform special processing, so
						-- that the final position may be docked to.
					if index_of_tool + 1 /= counter then
							-- If `a_holder' is immediately above `holder', then
							-- do not allow docking to the top, as it is already
							-- positioned there.
						holder.label_box.set_real_target (cell)
					end
					create cell
					cell.set_data (counter + 1)
					vertical_box := holder.lower_box
					vertical_box.extend (cell)
					vertical_box.disable_item_expand (cell)
					cell.enable_docking
					holder.tool.set_real_target (cell)
				end
				counter := counter + 1
			end
		end
		
	remove_docking_areas is
			-- Remove all docking areas added as result of last call to
			-- `initialize_docking_areas'.
		local
			cell: EV_CELL
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			box: EV_BOX
		do
			from
				all_holders.start
			until
				all_holders.off
			loop
				holder := all_holders.item
				holder.remove_real_target
				holder.tool.remove_real_target
				holder.label_box.remove_real_target
				if not holder.is_external then
					box := holder.upper_box
					from
						box.start
					until
						box.off						
					loop
							-- We do not wish to remove any minimized items contained in `upper_box',
							-- only the cells added during call to `initialize_docking_areas'.
							-- Therefore, we check that they are cells with data to qualify this.
						cell ?= box.item
						if cell /= Void and then cell.data /= Void then
							box.remove
						else
							box.forth
						end					
					end
					box := holder.lower_box
					from
						box.start
					until
						box.off						
					loop
							-- We do not wish to remove any minimized items contained in `upper_box',
							-- only the cells added during call to `initialize_docking_areas'.
							-- Therefore, we check that they are cells with data to qualify this.
						cell ?= box.item
						if cell /= Void and then cell.data /= Void then
							box.remove
						else
							box.forth
						end
					end
				end
				all_holders.forth
			end
		end
		
	
	maximize_tool (a_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- Maximize `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			if maximized_tool /= Void then
				maximized_tool.silent_set_minimized
				maximized_tool.disable_minimize_button
				maximized_tool.remove_maximized_restore
				maximized_tool.silent_remove_maximized
				maximized_tool.label.enable_dockable
				maximized_tool.maximize_button.set_tooltip (Maximize_string)
				a_tool.silent_remove_minimized
				a_tool.enable_minimize_button
				a_tool.tool.show
			else
				from
					all_holders.start
					minimized_states.wipe_out
					minimized_states.start
				until
					all_holders.off
				loop
					if all_holders.item.is_minimized then
						minimized_states.extend (True)
					else
						minimized_states.extend (False)
					end
					if not external_representation.has (all_holders.item.tool) then
							-- State must not change if external.
						if all_holders.item /= a_tool then
							all_holders.item.silent_set_minimized
						else
							all_holders.item.silent_remove_minimized
							all_holders.item.tool.show
						end
							-- Must always disable the minimize button.
						all_holders.item.disable_minimize_button
					end
					all_holders.forth
				end
				store_positions
			end
			maximized_tool := a_tool
			rebuild
		ensure
			tool_maximized: maximized_tool = a_tool
		end
		
	restore_maximized_tool (tool_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER; must_rebuild: BOOLEAN) is
			-- Ensure maximized tool `tool_holder' is no longer maximized,
			-- and update state of `Current' to reflect this.
			-- Rebuild `Current' if `must_rebuild'.
		require
			tool_holder_not_void: tool_holder /= Void
			tool_holder_maximized: tool_holder.is_maximized
		local
			space_to_share, diff_from_min, index: INTEGER
			height_to_share: INTEGER
		do
			tool_holder.disable_maximized
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item /= tool_holder then
					all_holders.item.silent_remove_minimized
					if not external_representation.has (all_holders.item.tool) then
						all_holders.item.enable_minimize_button
					end
					if not (minimized_states @ all_holders.index) then
						all_holders.item.tool.show
					end
				else
					all_holders.item.enable_minimize_button
				end
				if minimized_states @ all_holders.index then
					all_holders.item.silent_set_minimized
				end
				all_holders.forth
			end
			tool_holder.maximize_button.set_tooltip (maximize_string)
			maximized_tool := Void
			if must_rebuild then
				rebuild
				
			index := linear_representation.index_of (tool_holder.tool, 1)
--			stored_splitter_widths.go_i_th (index)
--			stored_splitter_widths.replace (tool_holder.restore_height)
--			space_to_share := tool_holder.restore_height + splitter_width
				--	
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				if not is_item_minimized (linear_representation.item) then
					height_to_share := height_to_share + stored_splitter_widths.i_th (linear_representation.index) + holder_tool_height + splitter_width
				else
					height_to_share := height_to_share + holder_tool_height
				end
				linear_representation.forth
			end
			height_to_share := height_to_share - splitter_width
			space_to_share := height_to_share - height
			if top_widget_resizing then
					from
						linear_representation.start
						stored_splitter_widths.start
					until
						linear_representation.off or space_to_share <= 0
					loop
						if linear_representation.item /= tool_holder.tool and not is_item_minimized (linear_representation.item) then
							diff_from_min := (stored_splitter_widths.item - linear_representation.item.minimum_height).min (space_to_share)
							space_to_share := space_to_share - diff_from_min
							stored_splitter_widths.replace (stored_splitter_widths.item - diff_from_min)
						end
						linear_representation.forth
						stored_splitter_widths.forth
					end
			end
			if space_to_share > 0 then
				stored_splitter_widths.go_i_th (index)
				stored_splitter_widths.replace (stored_splitter_widths.item - space_to_share)-- + splitter_width)
			end
				restore_stored_positions
			end
		ensure
			not_maximized: not tool_holder.is_maximized
			no_maximized_tool: maximized_tool = Void
		end
		
	store_positions is
			-- Store all positions of splitters.
		local
			widget: EV_WIDGET
		do
			stored_splitter_widths.wipe_out
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				widget := linear_representation.item
			--	if is_item_minimized (widget) then
			--		stored_splitter_widths.extend (0)
			--	else
					stored_splitter_widths.extend (linear_representation.item.height)--holder_of_widget (linear_representation.item).height)
			--	end
				linear_representation.forth
			end
		end
		
	restore_stored_positions is
			-- Restore all positions of splitters from `store_positions'.
		do	
			if top_widget_resizing then
				from
					all_split_areas.start
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.maximum_split_position)	
					end
					all_split_areas.forth
				end
			else
				from
					all_split_areas.finish
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.minimum_split_position)						
					end
					all_split_areas.back
				end
			end
			
--			from
--				linear_representation.start
--			until
--				linear_representation.off
--			loop
--				if not is_item_minimized (linear_representation.item) then
--					height_to_share := height_to_share + stored_splitter_widths.i_th (linear_representation.index) + holder_tool_height + splitter_width
--				else
--					height_to_share := height_to_share + holder_tool_height
--				end
--				linear_representation.forth
--			end
--			height_to_share := height_to_share - splitter_width
--			print ("height : " + height.out + "%N")
--			print ("height_to_share : " + height_to_share.out + "%N")
--			
			from
				stored_splitter_widths.start
			until
				stored_splitter_widths.off
			loop
				if not is_item_minimized (linear_representation.i_th (stored_splitter_widths.index)) then
					resize_widget_to (linear_representation.i_th (stored_splitter_widths.index), stored_splitter_widths.item)
				end
				stored_splitter_widths.forth
			end
--			if top_widget_resizing then
--					-- We now reverse all of the split area positions which is necessary
--					-- when `top_widget_resizing'.
--				from
--					all_split_areas.start
--				until
--					all_split_areas.off
--				loop
--					split_area := all_split_areas.item
--					if split_area.full then
--						split_area.set_split_position ((split_area.maximum_split_position))
--					end
--					all_split_areas.forth
--				end
--			end
--			from
--				stored_splitter_widths.start
--			until
--				stored_splitter_widths.off
--			loop
--				split_area := all_split_areas.i_th (stored_splitter_widths.index)
--				if split_area /= Void and then split_area.full then
--						-- As `Current' may have been reduced smaller than it was when the tool was maximized,
--						-- we must restrict the resetting of the spit position to the maximum now allowed.
--					split_area.set_split_position ((stored_splitter_widths.item.min (split_area.maximum_split_position)).max (split_area.minimum_split_position))
--				end
--				stored_splitter_widths.forth
--			end
			
			 	-- Now remove all stored positions.
			 stored_splitter_widths.wipe_out
		end
	
	stored_splitter_widths: ARRAYED_LIST [INTEGER]
		-- All splitter widths stored when 
	
	minimized_states: ARRAYED_LIST [BOOLEAN]
		-- List of all minimized states while a tool is maximized.

	minimize_tool (a_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- Ensure that `a_tool' is displayed minimized in `Current'.
		require
			a_tool_not_void: a_tool /= Void
		local
			lower_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			position_of_tool: INTEGER
			cursor: CURSOR
		do
			cursor := all_holders.cursor
				-- Firstly hide the actual widget of the tool, so that its minimum size
				-- has no effect.
			a_tool.tool.hide

			position_of_tool := index_of_holder (a_tool)
			if position_of_tool = 1 or else all_minimized (1, position_of_tool - 1) then
				remove_tool_from_parent (a_tool)
				lower_holder := all_holders.i_th (next_non_minimized_down (position_of_tool))
				transfer_box_contents (a_tool.upper_box, lower_holder.upper_box)
				lower_holder.upper_box.extend (a_tool.parent)
					-- Now transfer all contents of `a_tool' upper bar?
					-- This would keep all the minimized widgets together in the same box????
					-- Not sure if it needs to be done.
					
				transfer_box_contents (a_tool.lower_box, lower_holder.upper_box)
				
				update_all_minimize_buttons
			else
				remove_tool_from_parent (a_tool)
				lower_holder := i_th_holder (position_of_tool - 1)
				lower_holder.lower_box.extend (a_tool.parent)
				update_all_minimize_buttons
			end
			all_holders.go_to (cursor)
		ensure
			index_of_holders_not_changed: all_holders.index = old all_holders.index
		end
		
	restore_minimized_tool (a_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- Ensure that `a_tool' is no longer displayed as minimized.
		require
			tool_not_void: a_tool /= Void
			tool_parented: a_tool.parent /= Void
			tool_minimized: a_tool.is_minimized
		local
			space_to_share, diff_from_min: INTEGER
			index: INTEGER
			height_to_share: INTEGER
		do
			store_positions
--			original_parent ?= a_tool.parent
--			remove_tool_from_parent (a_tool)
--			index_of_tool := index_of_holder (a_tool)
--			
--			
--			from
--				linear_representation.go_i_th (index_of_tool - 1)
--			until
--				linear_representation.off
--			loop
--				if is_item_minimized (linear_representation.item) then
--					tool_holder := holder_of_widget (linear_representation.item)
--					tool_holder.parent.prune (tool_holder)
--					a_tool.upper_box.put_front (tool_holder)
--				end
--				linear_representation.back
--			end
--			from
--				linear_representation.go_i_th (index_of_tool + 1)
--			until
--				linear_representation.off
--			loop
--				if is_item_minimized (linear_representation.item) then
--					tool_holder := holder_of_widget (linear_representation.item)
--					tool_holder.parent.prune (tool_holder)
--					a_tool.lower_box.extend (tool_holder)
--				end
--				linear_representation.forth
--			end
			
			a_tool.disable_minimized
			
--			if all_split_areas.valid_index (split_area_index (index_of_tool)) then
--				parent_split_area := all_split_areas.i_th (split_area_index (index_of_tool))
--			end
--			if parent_split_area = Void then
--				parent_split_area := all_split_areas.i_th (all_split_areas.count)
--			end
--			restore_parent_split_areas (parent_split_area)
--			
--				-- The first two cases handle when we have two widgets inside a single split area.
--			if all_holders.last = a_tool and then not top_widget_resizing then
--				parent_split_area.set_second (a_tool)
--			elseif index_of_holder (a_tool) = 2 and then top_widget_resizing then
--				parent_split_area.set_second (a_tool)
--			elseif parent_split_area.first = Void then
--				parent_split_area.set_first (a_tool)
--			else
--				parent_split_area.set_second (a_tool)
--			end
--			update_expanded_state_of_all_split_areas
--			
--			update_all_minimize_buttons
--			
--				-- Now must update any minimized tools that were parented in the
--				-- same box as `a_tool'. We now recalculate which box they should be
--				-- held in.
--			if original_parent /= void and not original_parent.is_empty then
--				widgets := box_contents (original_parent)
--				from
--					widgets.start
--				until
--					widgets.off
--				loop
--					current_holder ?= widgets.item
--					check
--						item_was_holder: current_holder /= Void
--					end
--					minimize_tool (current_holder)
--					widgets.forth
--				end
--			end
--	
--				-- Calculate the maximum restore height that is permitted, based on `height' of `Current',
--				-- and minimum sizes of all items contained. This may be used to prevent `Current' from
--				-- resizing.
--			maximum_insert_height := height
--			tool_holder_height := a_tool.minimum_height - a_tool.tool.minimum_height
--			from
--				linear_representation.start
--			until
--				linear_representation.off
--			loop
--				if linear_representation.item /= a_tool then
--					-- As the tool of `holder' is already in `linear_representation' at this point,
--					-- we must ignore it in the calculations.
--					
--						-- Must not forget to handle items that are minimized correctly.
--						-- Those that are minimized are not displayed, only the holder.
--					if linear_representation.item.is_displayed then
--						maximum_insert_height := maximum_insert_height - linear_representation.item.minimum_height - tool_holder_height
--					else
--						maximum_insert_height := maximum_insert_height - tool_holder_height
--					end
--				end
--				linear_representation.forth
--			end
--
--			insert_height := a_tool.restore_height.min (maximum_insert_height).max (0)						
--			
--			resize_widget_to (a_tool.tool, insert_height)

			rebuild
			
			
			index := linear_representation.index_of (a_tool.tool, 1)
--			stored_splitter_widths.go_i_th (index)
--			stored_splitter_widths.replace (a_tool.restore_height)
--			space_to_share := a_tool.restore_height + splitter_width
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				if not is_item_minimized (linear_representation.item) then
					height_to_share := height_to_share + stored_splitter_widths.i_th (linear_representation.index) + holder_tool_height + splitter_width
				else
					height_to_share := height_to_share + holder_tool_height
				end
				linear_representation.forth
			end
			height_to_share := height_to_share - splitter_width
			space_to_share := height_to_share - height
			
			
			if top_widget_resizing then
					from
						linear_representation.start
						stored_splitter_widths.start
					until
						linear_representation.off or space_to_share <= 0
					loop
						if linear_representation.item /= a_tool.tool and not is_item_minimized (linear_representation.item) then
							diff_from_min := (stored_splitter_widths.item - linear_representation.item.minimum_height).min (space_to_share)
							space_to_share := space_to_share - diff_from_min
							stored_splitter_widths.replace (stored_splitter_widths.item - diff_from_min)
						end
						linear_representation.forth
						stored_splitter_widths.forth
					end
			end
			if space_to_share > 0 then
				stored_splitter_widths.go_i_th (index)
				stored_splitter_widths.replace (stored_splitter_widths.item - space_to_share)-- + splitter_width)
			end
		--	
--			from
--				linear_representation.start
--			until
--				linear_representation.off
--			loop
--				if linear_representation.item /= a_tool.tool and not is_item_minimized (linear_representation.item) then
--					height_to_share := height_to_share + stored_splitter_widths.i_th (linear_representation.index) + holder_tool_height + splitter_width
--				else
--					height_to_share := height_to_share + holder_tool_height
--				end
--				linear_representation.forth
--			end
--			height_to_share := height_to_share - splitter_width
--			print ("height : " + height.out + "%N")
--			print ("height_to_share : " + height_to_share.out + "%N")
			
			
			restore_stored_positions
				-- Now show the widget of the tool, as it was
				-- hidden when minimized.
			a_tool.tool.show
		ensure
			not_minimized: not a_tool.is_minimized
		end
		
	transfer_box_contents (original_box, new_box: EV_BOX) is
			-- Transfer all contents of `original_box' to `new_box'.
		require
			original_box_not_void: original_box /= Void
			new_box_not_void: new_box /= Void
		local
			widget: EV_WIDGET
		do
			from
				original_box.start
			until
				original_box.is_empty
			loop
				widget := original_box.item
				original_box.remove
				new_box.extend (widget)
			end
		ensure
			count_increased: new_box.count = old new_box.count + old original_box.count
		end
		
	remove_tool_structure (a_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- `Remove' box containing `a_tool' and its upper and lower bars from
			-- the boxes parent.
		require
			immediate_tool_parent_not_void: a_tool.parent /= Void
		local
			l_parent: EV_CONTAINER
		do
			l_parent := a_tool.parent
			check
				l_parent_not_void: l_parent /= Void
			end
			l_parent.parent.prune_all (l_parent)
		ensure
			tool_unparented: a_tool.parent.parent = Void
		end

	remove_tool_from_parent (a_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER) is
			-- Remove `a_tool' from its `parent', and if the parent is a 
			-- split area, remove empty split areas.
		require
			tool_not_void: a_tool /= Void
		local
			split_area: EV_SPLIT_AREA
		do
			split_area ?= a_tool.parent.parent			
			remove_tool_structure (a_tool)
				-- We must now unparent the split area if it is empty and
				-- is the last split area in the control.
			if split_area /= Void then
				remove_parent_split_areas_bottom (split_area)	
			end
		ensure
			tool_not_parented: a_tool.parent.parent = Void
		end
	
	remove_parent_split_areas_bottom (split_area: EV_SPLIT_AREA) is
			-- Remove all split areas in `all_split_areas', from `split_area'
			-- to first, if empty.
		require
			split_area_not_void: split_area /= Void
		local
			counter: INTEGER
			current_split_area, parent_split_area: EV_SPLIT_AREA
		do
			from
				counter := all_split_areas.index_of (split_area, 1)
			until
				counter <= 1
			loop
				parent_split_area ?= all_split_areas.i_th (counter - 1)
				current_split_area ?= all_split_areas.i_th (counter)
				if current_split_area.is_empty then
					parent_split_area.prune_all (current_split_area)
				else
					counter := 1
				end
				counter := counter - 1
			end
		end
		
	remove_parent_split_areas_top (split_area: EV_SPLIT_AREA) is
			-- Remove all split areas in `all_split_areas', from `split_area'
			-- to last, if empty.
		require
			split_area_not_void: split_area /= Void
		local
			counter: INTEGER
			current_split_area, parent_split_area: EV_SPLIT_AREA
		do
			from
				counter := all_split_areas.index_of (split_area, 1)
			until
				counter = all_split_areas.count + 1 or
					all_split_areas.last = split_area
			loop
				parent_split_area ?= all_split_areas.i_th (counter + 1)
				if parent_split_area /= Void then
					current_split_area ?= all_split_areas.i_th (counter)
					if current_split_area.is_empty then
						parent_split_area.prune_all (current_split_area)
					else
						counter := all_split_areas.count
					end			
				else
					counter := all_split_areas.count
				end
				counter := counter + 1
			end
		end
	
	restore_parent_split_areas (split_area: EV_SPLIT_AREA) is
			-- Restore all unparented split areas from `split_area',
			-- until the parent split area is not Void.
		require
			split_area_not_void: split_area /= Void
		local
			parent_split_area: EV_SPLIT_AREA
			new_parent_split_area: EV_SPLIT_AREA
		do
			from
				parent_split_area ?= split_area
			until
				parent_split_area.parent /= Void
			loop
				new_parent_split_area := all_split_areas.i_th (all_split_areas.index_of (parent_split_area, 1) - 1)
				if top_widget_resizing then
					new_parent_split_area.set_first (parent_split_area)
				else
					new_parent_split_area.set_second (parent_split_area)
				end
				parent_split_area := new_parent_split_area
			end
		end

	next_non_minimized_down (current_position: INTEGER): INTEGER is
			-- `Result' is next index of tool in `Current' from index `current_position'
			-- that is not minimized or not external.
		require
			valid_position: current_position >= 1 and current_position <= count
		do
			from
				all_holders.go_i_th (current_position)
			until
				all_holders.off or Result /= 0
			loop
				if not all_holders.item.is_minimized and not external_representation.has (all_holders.item.tool) then
					Result := all_holders.index
				end
				all_holders.forth
			end
		ensure
			index_valid: Result >= 1 and Result <= linear_representation.count + external_representation.count
		end
		
		
	minimize_all_tools is
			-- Call `minimize_tool' for every tool in `Current'.
			-- This is used after we rebuild the complete contents of `Current'.
		local
			cursor: CURSOR
		do
			cursor := all_holders.cursor
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item.is_minimized then
					minimize_tool (all_holders.item)
				end
				all_holders.forth
			end
			all_holders.go_to (cursor)
		ensure
			index_not_changed: all_holders.index = old all_holders.index
		end
		
		
	update_all_minimize_buttons is
			-- Ensure that the minimized buttons are updated to a valid state.
			-- Only the minimize buttons of non external holders are modified.
			-- If a tool is maximized in `Current', then ensure that all minimize
			-- buttons are disabled.
			-- If there is one less minimized tool than `count', we must disable the
			-- tools minimize button, as not all tools may be minimized at once.
		local
			minimized_count: INTEGER
			maximized_holder, non_minimized_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			cursor: CURSOR
		do
			cursor := all_holders.cursor
			maximized_holder := maximized_tool
			from
				all_holders.start
			until
				all_holders.off
			loop
				if not all_holders.item.is_external then
					if maximized_holder /= Void then
						all_holders.item.disable_minimize_button
					else
						all_holders.item.enable_minimize_button
					end
					if all_holders.item.is_minimized then
						minimized_count := minimized_count + 1
					else
						non_minimized_holder := all_holders.item
					end
				end
				all_holders.forth
			end
			if minimized_count = count - 1 then
				non_minimized_holder.disable_minimize_button
			end
			all_holders.go_to (cursor)
		ensure
			index_not_changed: all_holders.index = old all_holders.index
		end
		
		
	all_minimized (lower, upper: INTEGER): BOOLEAN is
			-- Are all items from position `lower' inclusive to `position `upper'
			-- minimized?
		require
			lower_valid: lower >= 1 and lower <=upper
			upper_valid: upper <= count
		do
			Result := True
			from
				all_holders.go_i_th (lower)
			until
				all_holders.index > upper
			loop
				if not all_holders.item.is_minimized then
					Result := False
				end
				all_holders.forth
			end
		end
		
	all_maximized (lower, upper: INTEGER): BOOLEAN is
			-- Are all items from position `lower' inclusive to `position `upper'
			-- maximized?
		require
			lower_valid: lower >= 1 and lower <=upper
			upper_valid: upper <= count
		do
			Result := True
			from
				all_holders.go_i_th (lower)
			until
				all_holders.index > upper
			loop
				if not all_holders.item.is_maximized then
					Result := False
				end
				all_holders.forth
			end
		end
		
	unparent_all_holders is
			-- Ensure all items in `all_holders' are not parented.
		local
			current_parent: EV_CONTAINER
		do
			from
				all_holders.start
			until
				all_holders.off
			loop
				current_parent := all_holders.item.parent
				if current_parent /= Void then
					current_parent.prune_all (all_holders.item)
				end
				all_holders.forth
			end
		end
		
	holder_of_widget (a_widget: EV_WIDGET): MULTIPLE_SPLIT_AREA_TOOL_HOLDER is
			-- `Result' is tool holder containing `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
			linear_representation.has (a_widget) or external_representation.has (a_widget)
		local
			cursor: CURSOR
			current_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		do
			cursor := all_holders.cursor
			from
				all_holders.start
			until
				Result /= Void
			loop
				current_holder := all_holders.item
				if current_holder /= Void and then current_holder.tool = a_widget then
					Result := all_holders.item
				end
				all_holders.forth
			end
			all_holders.go_to (cursor)
		ensure
			result_not_void: Result /= Void
			position_not_changed: all_holders.index = old all_holders.index
		end
		
	index_of_holder (a_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER): INTEGER is
			-- `Result' is index of `a_holder' within `Current'.
			-- Ignores any holders that are docked out, so will not correspond to
			-- `all_holders.i_th'.
		require
			a_holder_not_void: a_holder /= Void
			holder_not_external: not a_holder.is_external
		do
			Result := linear_representation.index_of (a_holder.tool, 1)
		ensure
			valid_result: Result >= 1 and Result <= count
		end
		
	i_th_holder (an_index: INTEGER): MULTIPLE_SPLIT_AREA_TOOL_HOLDER IS
			-- `Result' is i_th holder in current, not excluding any externally docked
			-- holders. Therefore, you may not simply query `all_holders.i_th', as this includes
			-- the external holders.
		require
			index_valid: an_index >= 1 and an_index <= count
		local
			widget_at_index: EV_WIDGET
		do
			widget_at_index := linear_representation.i_th (an_index)
			Result := holder_of_widget (widget_at_index)
		ensure
			Result_not_void: Result /= Void
		end
		
	update_for_holder_position_change (a_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER; new_position: INTEGER) is
			-- Update `linear_representation' and `all_holders' to reflect a change of
			-- position from `original_position' to `new_position'.
			-- Passing 0 as `original_position' means the holder was not contained in `Current',
			-- Hence in this case, no pruning is performed.
		require
			a_holder_not_void: a_holder /= Void
			new_position_positive: new_position >= 1 and new_position <= count + 1
		local
			real_new_position: INTEGER
			widget: EV_WIDGET
			original_position: INTEGER
		do
			original_position := linear_representation.index_of (a_holder.tool, 1)
			if original_position < new_position and original_position /= 0 then
				real_new_position := new_position - 1
			else
				real_new_position := new_position
			end
			widget := a_holder.tool
			if original_position /= 0 then
				linear_representation.go_i_th (original_position)
				linear_representation.remove
			end
			linear_representation.go_i_th (real_new_position)
			linear_representation.put_left (widget)

				-- Note that we cannot use the same original position for both
				-- `linear_representation' and `all_holders', as `all_holders' includes
				-- tools that may be docked externally whereas `linear_representation' does not.
				-- This was leading to problems where we ended up with the same holder
				-- container in `all_holders' twice, causing `Current' to crash. Julian.
			original_position := all_holders.index_of (a_holder, 1)
			check
				original_position_not_zero: original_position /= 0
			end
			if original_position < new_position then
				real_new_position := new_position - 1
			else
				real_new_position := new_position
			end
			all_holders.go_i_th (original_position)
			all_holders.remove
			all_holders.go_i_th (real_new_position)
			all_holders.put_left (a_holder)
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
		ensure
			shown_implies_result_not_void: widget.is_displayed implies Result /= Void
		end
		
	set_holder_tool_height (a_height: INTEGER) is
			-- Assign `a_height' to `holder_tool_height'.
		require
			a_height_positive: a_height > 0
		do
			holder_tool_height := a_height
		end
		
feature {NONE} -- Implementation

	docked_out_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
		-- Internal docked out actions, fired when a widget has been
		-- docked out of `Current'.
	
	docked_in_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
		-- Internal docked in actions, fired when a widget has been
		-- docked in to `Current'.
		
	close_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
	
	restore_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
	
	maximize_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
	
	minimize_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE

	pre_insertion_heights: ARRAYED_LIST [INTEGER]
		-- All positions stored by last call to `store_heights_pre_insertion', used to
		-- restore by subsequent call to `restore_heights_post_insertion'.
		
	pre_insertion_holders: ARRAYED_LIST [MULTIPLE_SPLIT_AREA_TOOL_HOLDER]
		-- All holders of `Current'. One for each widget.
	
	maximized_tool: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
		-- Holder currently maximized in `Current', or `Void' if none.

	box_contents (box: EV_BOX): ARRAYED_LIST [EV_WIDGET] is
			-- `Result' is contents of `box' as an ARRAYED_LIST.
			-- `box' remains unchanged.
		require
			box_not_void: box /= Void
		local
			cursor: EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
		do
			cursor := box.cursor
			create Result.make (box.count)
			from
				box.start
			until
				box.off
			loop
				Result.extend (box.item)
				box.forth
			end
			box.go_to (cursor)
		ensure
			Result_not_void: Result /= Void
			Result_count_consistent: Result.count = box.count
			box_count_unchanged: box.count = old box.count
			box_index_consistent: old box.index = box.index
		end

	remove_implementation (a_widget: EV_WIDGET) is
			-- Implementation for removal, without a rebuilding step. This allows features
			-- such as `wipe_out' to remove all widgets without rebuilding the complete structure
			-- for each removal. 
		require
			a_widget_not_void: a_widget /= Void
			contained: linear_representation.has (a_widget) or is_item_external (a_widget)
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			first_minimized: EV_WIDGET
			minimized_count: INTEGER
			dialog: EV_DOCKABLE_DIALOG
		do
			holder := holder_of_widget (a_widget)
			if maximized_tool /= Void then
					-- Remove representation from `minimized_states'.
				minimized_states.go_i_th (all_holders.index_of (holder, 1))
				minimized_states.remove
			end
			
				-- Must handle the case where an item is removed, and all remaining items are minimized.
				-- The first must be unminimized.
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				if linear_representation.item /= a_widget and is_item_minimized (linear_representation.item) then
					minimized_count := minimized_count + 1
					if first_minimized = Void then
							-- Set `first_minimized' if `Void' so it may be used if all widgets are minimized.
						first_minimized := linear_representation.item
					end
				end
				linear_representation.forth
			end
			if count > 1 and minimized_count = count - 1 then
				restore_minimized_tool (holder_of_widget (first_minimized))
				holder_of_widget (first_minimized).minimize_button.set_pixmap (minimize_pixmap)
			end
			
			all_holders.prune_all (holder)
				-- Must also unparent the holder, which must be
				-- parented for it to be contained in `Current'.
				-- Unless `wipe_out' is being called as part of the insertion
				-- process.
			if holder.parent /= Void then
				holder.parent.prune_all (holder)
			end
				-- Now actually remove `a_widget' from its holder.
			if a_widget.parent /= Void then
				dialog ?= parent_window (a_widget)
				a_widget.parent.prune_all (a_widget)
				if dialog /= Void then
					dialog.destroy
				end
			end
			
				-- If `holder' was the maximized tool, then update
				-- accordingly.
			if maximized_tool = holder then
				restore_maximized_tool (holder, False)
				maximized_tool := Void
			end
			
			if holder.is_minimized then
					-- If a holder is minimized when removed, the widget is hidden,
					-- hence the need to re-show it.
				a_widget.show
			end
			
				-- Remove corresponding item from `stored_splitter_widths'.
			--stored_splitter_widths.go_i_th (linear_representation.index_of (a_widget, 1))
				--| FIXME what happens if you have multiple items minimized before the
				--| item you are removing? The stored splitter widths does not have enough items.
				--| FIXME, why is there no remove here?
			if is_item_external (a_widget) then
				external_representation.go_i_th (external_representation.index_of (a_widget, 1))
				external_representation.remove
			else
				linear_representation.go_i_th (linear_representation.index_of (a_widget, 1))
				linear_representation.remove
			end
			holder.destroy
		ensure
			remove: not linear_representation.has (a_widget)
			count_decreased: old linear_representation.has (a_widget) implies linear_representation.count = old linear_representation.count - 1
		end
		
	store_heights_pre_insertion is
			-- Store all heights of non external holders before insertion
			-- of a new widget.
		local
			holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			cursor: CURSOR
		do
			cursor := linear_representation.cursor
			create pre_insertion_heights.make (count)
			create pre_insertion_holders.make (count)
			from
				linear_representation.start
			until
				linear_representation.off
			loop
				holder := holder_of_widget (linear_representation.item)
			--		-- Must not include minimized and maximized items, as they are placed in `upper_box'
			--		-- and `lower_box'.
			--	holder_height := holder.height - holder.lower_box.height - holder.upper_box.height
				pre_insertion_heights.extend (linear_representation.item.height)
				pre_insertion_holders.extend (holder)
				linear_representation.forth
			end
			linear_representation.go_to (cursor)
		ensure
			index_not_changed: linear_representation.index = old linear_representation.index
		end	
		
	restore_heights_post_insertion (holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER; a_height: INTEGER) is
			-- Restore `holder' into `Current' at height `a_height'. This will perform a
			-- "best fit" and attempt to leave other holds at same size, with minimal
			-- adjustment.
		require
			holder_not_void: holder /= Void
			height_valid: a_height > 0
		local
			local_holder: MULTIPLE_SPLIT_AREA_TOOL_HOLDER
			stored_height: INTEGER
			space_to_share: INTEGER
			diff_from_min: INTEGER
			cursor: CURSOR
			tool_holder_height: INTEGER
		do
		if not is_blocked then
			cursor := linear_representation.cursor;
			
				-- Firstly, reduce all split areas to their minimums. This permits us to call
				-- `simulate_minimum_height' which will restore the widget back to its proper height.
				-- If we did not make all split areas as small as possible, then the hieght simulation
				-- would not be able to reduce the height of an item as necessary.
			if top_widget_resizing then
				from
					all_split_areas.start
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.maximum_split_position)	
					end
					all_split_areas.forth
				end
			else
				from
					all_split_areas.finish
				until
					all_split_areas.off
				loop
					if all_split_areas.item.full then
						all_split_areas.item.set_split_position (all_split_areas.item.minimum_split_position)						
					end
					all_split_areas.back
				end
			end

			-- Calculate the height of a tool holder.
		tool_holder_height := holder_tool_height


		space_to_share := a_height + holder_tool_height + splitter_width
			
			if space_to_share > 0 then
				-- If space must be shared, share between all holders, starting with "lowest priority" which is
				-- the holder that may be resized, based on `top_widget_resizing' and then work down each holder in turn
				-- until there is no more space to share.
				if top_widget_resizing then
					from
						pre_insertion_holders.start
						pre_insertion_heights.start
					until
						pre_insertion_holders.off or space_to_share <= 0
					loop
						if not pre_insertion_holders.item.is_minimized then
							diff_from_min := (pre_insertion_heights.item - pre_insertion_holders.item.tool.minimum_height).min (space_to_share)
							space_to_share := space_to_share - diff_from_min
							pre_insertion_heights.replace (pre_insertion_heights.item - diff_from_min)
						end
						pre_insertion_holders.forth
						pre_insertion_heights.forth
					end
				else
					from
						pre_insertion_holders.finish
						pre_insertion_heights.finish
					until
						pre_insertion_holders.off or space_to_share <= 0
					loop
						diff_from_min := (pre_insertion_heights.item - pre_insertion_holders.item.tool.minimum_height).min (space_to_share)
						space_to_share := space_to_share - diff_from_min
						pre_insertion_heights.replace (pre_insertion_heights.item - diff_from_min)
						pre_insertion_holders.back
						pre_insertion_heights.back
					end
				end
			end
		
			pre_insertion_holders.go_i_th (linear_representation.index_of (holder.tool, 1))
			pre_insertion_holders.put_left (holder)
			
			pre_insertion_heights.go_i_th (linear_representation.index_of (holder.tool, 1))
			if space_to_share = 0 then
				pre_insertion_heights.put_left (a_height)
			else
				pre_insertion_heights.put_left ((a_height - space_to_share - splitter_width - holder_tool_height).max (holder.tool.minimum_height))	
			end
			
			
				-- Now iterate through all `positions' and restore. We must handle the iteration in reverse, depending on
				-- the state of `top_resizing'. This ensures that no matter which way `Current' resizes, it will
				-- always reduce the holder that resizes first.
			if top_widget_resizing then
				from
					pre_insertion_holders.finish
				until
					pre_insertion_holders.off
				loop
					local_holder := pre_insertion_holders.item
					if not local_holder.is_minimized then
						stored_height := pre_insertion_heights.i_th (pre_insertion_holders.index)
						resize_widget_to (local_holder.tool, stored_height)
					end
					pre_insertion_holders.back
				end
			else
--				from
--					linear_representation.start
--				until
--					linear_representation.index > linear_representation.count - 1 and holder_restored
--				loop
--					if holder_of_widget (linear_representation.item) = holder then
--						holder.simulate_minimum_height (insert_height + tool_holder_height)
--						holder.remove_simulated_height
--						holder_restored := True
--					else
--						an_index := pre_insertion_holders.index_of (holder_of_widget (linear_representation.item), 1)
--						local_holder := pre_insertion_holders.i_th (an_index)
--						stored_height := pre_insertion_heights.i_th (an_index)
--						local_holder.simulate_minimum_height (stored_height + tool_holder_height)
--						local_holder.remove_simulated_height
--					end
--					linear_representation.forth
--				end
			end
			linear_representation.go_to (cursor)
		end
		ensure
			index_not_changed: linear_representation.index = old linear_representation.index
		end

	update_expanded_state_of_all_split_areas is
			-- Ensure that expanded state of all split areas is correct.
		local
			cursor: CURSOR
			split_area: EV_SPLIT_AREA
		do
			if top_widget_resizing then
				cursor := all_split_areas.cursor
				from
					all_split_areas.start
				until
					all_split_areas.off
				loop
					split_area := all_split_areas.item
					if split_area.full then
						split_area.enable_item_expand (split_area.first)
						split_area.disable_item_expand (split_area.second)
					end
					all_split_areas.forth
				end
				all_split_areas.go_to (cursor)
			end
		ensure
			index_not_changed: old all_split_areas.index = all_split_areas.index
		end

	platform_is_windows: BOOLEAN is
			-- Is `Current' executing on Windows platform?
		once
			Result := (create {PLATFORM}).is_windows
		end
		
	application: EV_APPLICATION is
			-- Application for `Current'. May not be a Once, as it is
			-- possible to change the application.
		do
			Result := (create {EV_ENVIRONMENT}).application
		end
		
	holder_tool_height: INTEGER
			-- Height of tools that surround each widget within `Current'.

	restore_string: STRING is "Restore"
	maximize_string: STRING is "Maximize"
	minimize_string: STRING is "Minimize"
		
invariant
	linear_representation_not_void: linear_representation /= Void
	all_holders_not_void: all_holders /= Void
	all_split_areas_not_void: all_split_areas /= Void
	stored_splitter_widths_not_void: stored_splitter_widths /= Void
	external_representation_not_void: external_representation /= Void
	minimized_states_not_void: minimized_states /= Void

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




end -- class MULTIPLE_SPLIT_AREA

