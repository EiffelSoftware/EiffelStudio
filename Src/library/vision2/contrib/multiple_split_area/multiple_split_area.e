indexing
	description: "Objects that represent a split area that will hold multiple items."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLE_SPLIT_AREA
	
inherit
	GB_VERTICAL_SPLIT_AREA
		rename
			extend as cell_extend,
			count as cell_count,
			linear_representation as old_linear_representation
		export
			{NONE} all
		redefine
			initialize
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			split_area, parent_split_area: GB_VERTICAL_SPLIT_AREA
			counter: INTEGER
		do
			Precursor {GB_VERTICAL_SPLIT_AREA}
			create linear_representation.make (4)
			create all_holders.make (4)
			create all_split_areas.make (4)
			create stored_splitter_widths.make (4)
			create minimized_states.make (4)
			all_split_areas.extend (Current)
		end


feature -- Access

	count: INTEGER is
			-- Number of widgets in `Current'.
		do
			Result := linear_representation.count
		ensure
			result_valid: Result >= 0
		end
		
	top_widget_resizing: BOOLEAN
		-- Does the top widget displayed in `Current' resize vertically as `Current' is resized?
		-- If False, the bottom widget will be resized vertically insead.
	
	linear_representation: ARRAYED_LIST [EV_WIDGET]
		-- All widgets held in `Current'

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
		
	enable_close_button (widget: EV_WIDGET) is
			-- Display a close button for `widget'.
		require
			widget_not_void: widget /= Void
			linear_representation.has (widget)
		local
			holder: GB_TOOL_HOLDER
		do
			holder := holder_of_widget (widget)
			holder.enable_close_button
		end
		
	disable_close_button (widget: EV_WIDGET) is
			-- Hide the close button for `widget'.
		require
			widget_not_void: widget /= Void
			linear_representation.has (widget)
		local
			holder: GB_TOOL_HOLDER
		do
			holder := holder_of_widget (widget)
			holder.disable_close_button
		end
		

	set_maximize_pixmap (pixmap: EV_PIXMAP) is
			--
		do
			maximize_pixmap := clone (pixmap)
		end
		
	set_minimize_pixmap (pixmap: EV_PIXMAP) is
			--
		do
			minimize_pixmap := clone (pixmap)
		end
		
	set_close_pixmap (pixmap: EV_PIXMAP) is
			--
		do
			close_pixmap := clone (pixmap)
		end

	set_restore_pixmap (pixmap: EV_PIXMAP) is
			--
		do
			restore_pixmap := clone (pixmap)
		end

	extend (widget: EV_WIDGET; name: STRING) is
			-- Add `widget' to end.
		do
			insert_widget (widget, name, count + 1)
		ensure
			has_widget: linear_representation.has (widget)
		end

	insert_widget (widget: EV_WIDGET; name: STRING; position: INTEGER) is
			-- Insert `widget' into `Current' at position `position'.
		require
			widget_not_void: widget /= Void
			position_valid: position >= 1 and position <= count + 1
			not_contained: not linear_representation.has (widget)
			name_not_void: name /= Void
		local
			holder: GB_TOOL_HOLDER
			all_splitters: ARRAYED_LIST [INTEGER]
			split_area: EV_SPLIT_AREA
		do
			create holder.make_with_tool (widget, name, Current)
			linear_representation.go_i_th (position)
			linear_representation.put_left (widget)
			all_holders.go_i_th (position)
			all_holders.put_left (holder)
			holder.update_position_in_parent
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
			store_positions
			rebuild
			restore_stored_positions
		ensure
			container: linear_representation.has (widget)
			count_increased: linear_representation.count = old linear_representation.count + 1
		end
		
	remove (a_widget: EV_WIDGET) is
			-- Remove `a_widget' from `Current'
		require
			a_widget_not_void: a_widget /= Void
			contained: linear_representation.has (a_widget)
		local
			holder: GB_TOOL_HOLDER
		do
			holder := holder_of_widget (a_widget)
			if maximized_tool /= Void then
					-- Remove representation from `minimized_states'.
				minimized_states.go_i_th (all_holders.index_of (holder, 1))
				minimized_states.remove
			end
			all_holders.prune_all (holder)
				-- Must also unparent the holder, which must be
				-- parented for it to be contained in `Current'.
			holder.parent.prune_all (holder)
			linear_representation.prune_all (a_widget)
			rebuild
		ensure
			remove: not linear_representation.has (a_widget)
			count_decreased: linear_representation.count = old linear_representation.count - 1
		end
		
		
feature {GB_TOOL_HOLDER} -- Implementation
		
		
	rebuild_without_holder (a_holder: GB_TOOL_HOLDER) is
			-- Rebuild `Current' without `a_holder'.
		require
			holder_not_void: a_holder /= Void
			contained: all_holders.has (a_holder)
		do
			store_positions
			stored_splitter_widths.go_i_th (all_holders.index_of (a_holder, 1))
			stored_splitter_widths.remove

			linear_representation.prune_all (linear_representation.i_th (all_holders.index_of (a_holder, 1)))
			all_holders.prune_all (a_holder)
			rebuild
			restore_stored_positions
		ensure
			removed: not all_holders.has (a_holder)
		end
		
		
	rebuild is
			--
		local
			split_area: GB_VERTICAL_SPLIT_AREA
			old_parent: EV_CONTAINER
			current_split_area: EV_SPLIT_AREA
			current_holder: GB_TOOL_HOLDER
		do
			wipe_out
			all_split_areas.wipe_out
			unparent_all_holders
			all_split_areas.extend (Current)
			if count = 1 then
				cell_extend (all_holders.i_th (1))
			elseif count = 2 then
				cell_extend (all_holders.i_th (1))	
				cell_extend (all_holders.i_th (2))
				if top_widget_resizing then
					enable_item_expand (first)
					disable_item_expand (second)				
				end
			else
				from
					all_holders.start
					current_split_area := Current
				until
					all_holders.off
				loop
					if top_widget_resizing then
						current_holder := all_holders.i_th (all_holders.count - all_holders.index + 1)
						current_split_area.set_second (current_holder)
					else
						current_holder := all_holders.item
						current_split_area.set_first (current_holder)
					end
					
					if all_holders.index = all_holders.count - 1 then
						all_holders.forth
						if top_widget_resizing then
							current_holder := all_holders.i_th (all_holders.count - all_holders.index + 1)
							current_split_area.set_first (current_holder)
						else
							current_holder := all_holders.item
							current_split_area.set_second (current_holder)
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
					
					all_holders.forth
				end
				if top_widget_resizing then
					reverse_split_areas
				end
			end
			minimize_all_tools
			update_all_minimize_buttons
		end
		
	reverse_split_areas is
			--
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
			--
		do
			if top_widget_resizing then
				Result := all_split_areas.count - holder_index + 2
			else
				Result := holder_index
			end
		end
		
feature {GB_TOOL_HOLDER} -- Implementation
	
	all_split_areas: ARRAYED_LIST [EV_SPLIT_AREA]

	all_holders: ARRAYED_LIST [GB_TOOL_HOLDER]

	maximize_pixmap: EV_PIXMAP
	
	minimize_pixmap: EV_PIXMAP
	
	close_pixmap: EV_PIXMAP
	
	restore_pixmap: EV_PIXMAP
	
	maximize_tool (a_tool: GB_TOOL_HOLDER) is
			--
		do
			if maximized_tool /= Void then
				maximized_tool.silent_set_minimized
				maximized_tool.disable_minimize_button
				maximized_tool.remove_maximized_restore
				maximized_tool.silent_remove_maximized
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
					if all_holders.item.minimized then
						minimized_states.extend (True)
					else
						minimized_states.extend (False)
					end
					if all_holders.item /= a_tool then
						all_holders.item.silent_set_minimized
						all_holders.item.disable_minimize_button
					else
						all_holders.item.silent_remove_minimized
						all_holders.item.tool.show
					end
					all_holders.forth
				end
				store_positions
			end
			rebuild
			maximized_tool := a_tool
		end
		
	restore_maximized_tool (a_tool: GB_TOOL_HOLDER) is
			--
		do
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item /= a_tool then
					all_holders.item.silent_remove_minimized
					all_holders.item.enable_minimize_button
					all_holders.item.tool.show
				else
					all_holders.item.enable_minimize_button
				end
				if minimized_states @ all_holders.index then
					all_holders.item.silent_set_minimized
				end
				all_holders.forth
			end
			rebuild
			restore_stored_positions
			maximized_tool := Void
		end
		
	store_positions is
			-- Store all positions of splitters.
		do
			stored_splitter_widths.wipe_out
			from
				all_split_areas.start
			until
				all_split_areas.off
			loop
				stored_splitter_widths.extend (all_split_areas.item.split_position)
				all_split_areas.forth
			end
		end
		
	restore_stored_positions is
			-- Restore all positions of splitters from `store_positions'.
		local
			split_area: EV_SPLIT_AREA
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
			end
			from
				stored_splitter_widths.start
			until
				stored_splitter_widths.off
			loop
				split_area := all_split_areas.i_th (stored_splitter_widths.index)
				if split_area.full then
						-- As `Current' may have been reduced smaller than it was when the tool was maximized,
						-- we must restrict the resetting of the spit position to the maximum now allowed.
					split_area.set_split_position (stored_splitter_widths.item.min (split_area.maximum_split_position))
				end
				stored_splitter_widths.forth
			end
		end
	
	stored_splitter_widths: ARRAYED_LIST [INTEGER]
	
	minimized_states: ARRAYED_LIST [BOOLEAN]
	
	heights: ARRAYED_LIST [INTEGER]
	
	maximized_tool: GB_TOOL_HOLDER
		
	
	minimize_tool (a_tool: GB_TOOL_HOLDER) is
			-- Ensure that `a_tool' is displayed minimized in `Current'.
		local
			lower_holder, upper_holder: GB_TOOL_HOLDER
			position_of_tool: INTEGER
			cursor: CURSOR
		do
				-- Store the current height of the holder.
--			a_tool.set_restore_height (a_tool.height)
			cursor := all_holders.cursor
				-- Firstly hide the actual widget of the tool, so that its minimum size
				-- has no effect.
			a_tool.tool.hide
			
			
			position_of_tool := all_holders.index_of (a_tool, 1)
			if position_of_tool = 1 or else all_minimized (1, position_of_tool - 1) then
				remove_tool_from_parent (a_tool)
				lower_holder := all_holders.i_th (next_non_minimized_down (position_of_tool))
				transfer_box_contents (a_tool.upper_box, lower_holder.upper_box)
				lower_holder.upper_box.extend (a_tool)
					-- Now transfer all contents of `a_tool' upper bar?
					-- This would keep all the minimized widgets together in the same box????
					-- Not sure if it needs to be done.
					
				transfer_box_contents (a_tool.lower_box, lower_holder.upper_box)
				
				update_all_minimize_buttons
			else
				remove_tool_from_parent (a_tool)
				lower_holder := all_holders.i_th (position_of_tool - 1)
				lower_holder.lower_box.extend (a_tool)
				update_all_minimize_buttons
			end
			all_holders.go_to (cursor)
		ensure
			index_of_holders_not_changed: all_holders.index = old all_holders.index
		end
		
	restore_tool (a_tool: GB_TOOL_HOLDER) is
			-- Ensure that `a_tool' is no longer displayed as minimized.
		require
			tool_parented: a_tool.parent /= Void
		local
			index_of_tool: INTEGER
			parent_split_area: EV_SPLIT_AREA
			original_parent: EV_BOX
			current_holder: GB_TOOL_HOLDER
			parent_index: INTEGER
			value: INTEGER
		do
				-- Firstly show the widget of the tool, as it was
				-- hidden when minimized.
			a_tool.tool.show
			
			original_parent ?= a_tool.parent
			remove_tool_from_parent (a_tool)
			index_of_tool := all_holders.index_of (a_tool, 1)
			
			if all_split_areas.valid_index (split_area_index (index_of_tool)) then
				parent_split_area := all_split_areas.i_th (split_area_index (index_of_tool))
			end
			if parent_split_area = Void then
				parent_split_area := all_split_areas.i_th (all_split_areas.count)
			end
			restore_parent_split_areas (parent_split_area)
			
				-- The first two cases handle when we have two widgets inside a single split area.
			if all_holders.last = a_tool and then not top_widget_resizing then
				parent_split_area.set_second (a_tool)
			elseif all_holders.i_th (2) = a_tool and then top_widget_resizing then
				parent_split_area.set_second (a_tool)
			elseif parent_split_area.first = Void then
				parent_split_area.set_first (a_tool)
			else
				parent_split_area.set_second (a_tool)
			end
			
			update_all_minimize_buttons
				-- Now must update any minimized tools that were parented in the
				-- same box as `a_tool'. We now recalculate which box they should be
				-- held in.
			if original_parent /= void and not original_parent.is_empty then
				from
				until
					original_parent.is_empty
				loop
						-- We must keep returning to the start as `minimize_tool' is
						-- not a safe call.
					original_parent.start
					current_holder ?= original_parent.item
					check
						item_was_holder: current_holder /= Void
					end
					minimize_tool (current_holder)
				end
			end
			
			a_tool.simulate_minimum_height (a_tool.restore_height)
			a_tool.remove_simulated_height
			--restore_tool_size (a_tool)
--				-- Now attempt to restore the original height of the tool
--			if parent_split_area.full then
--				if not top_widget_resizing then
--					parent_split_area.set_split_position (a_tool.restore_height.min (parent_split_area.maximum_split_position))
--				else
--					parent_split_area.set_split_position ((parent_split_area.height - a_tool.restore_height).min (parent_split_area.maximum_split_position))
--				end
--			end
		end
		
--	restore_tool_size (a_tool: GB_TOOL_HOLDER) is
--			-- Attempt to restore `a_tool' to size `a_tool.restore_height'.
--		local
--			restore_height: INTEGER
--			parent_split_area: EV_SPLIT_AREA
--			maximum_position, minimum_position: INTEGER
--			split_area: EV_SPLIT_AREA
--			available_space: ARRAYED_LIST [INTEGER]
--			height_required: INTEGER
--			counter: INTEGER
--			temp: INTEGER
--		do
--			restore_height := a_tool.restore_height
--			if not top_widget_resizing then
--				parent_split_area ?= a_tool.parent
--				check
--					parent_split_area_not_void: parent_split_area /= Void
--				end
--							-- Only happens for the bottom widget.
--						if all_holders.last = a_tool then
--							restore_height := parent_split_area.height - restore_height	
--						end	
--					from
--					until
--						parent_split_area.full
--					loop
--						parent_split_area ?= parent_split_area.parent
--						check
--							parent_split_area_not_void: parent_split_area /= Void
--						end
--					end
--					maximum_position := parent_split_area.maximum_split_position
--					minimum_position := parent_split_area.minimum_split_position
--					if restore_height < minimum_position or restore_height > maximum_position then
--						create available_space.make (1)
--							split_area := parent_split_area
--						from
--						until
--							split_area = Void
--						loop
--							split_area ?= split_area.parent
--							if split_area /= Void then
--								available_space.extend (split_area.split_position - split_area.minimum_split_position)
--							end
--						end
--					end
--					if restore_height < parent_split_area.minimum_split_position or
--						restore_height > parent_split_area.maximum_split_position then
--						height_required := restore_height - parent_split_area.maximum_split_position
--						from
--							counter := 1
--						until
--							height_required = 0 or counter > available_space.count
--						loop
--							split_area ?= parent_split_area.parent
--							check
--								split_area_not_void: split_area /= Void
--							end
--							if split_area.full then
--								if available_space.i_th (counter) < height_required then
--									height_required := height_required - available_space.i_th (counter)
--									split_area.set_split_position (split_area.split_position - available_space.i_th (counter))
--								else
--									split_area.set_split_position (split_area.split_position - height_required)
--									height_required := 0
--								end
--							end
--							counter := counter + 1
--						end
--					end
--					parent_split_area.set_split_position (restore_height.min (parent_split_area.maximum_split_position))
--					do_nothing
--			end
--		end
		
		
	transfer_box_contents (original_box, new_box: EV_BOX) is
			-- Transfer all contents of `original_box' to `new_box'.
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
		
		
	remove_tool_from_parent (a_tool: GB_TOOL_HOLDER) is
			--
		local
			split_area: EV_SPLIT_AREA
		do
			split_area ?= a_tool.parent
			a_tool.parent.prune_all (a_tool)
				-- We must now unparent the split area if it is empty and
				-- is the last split area in the control.
			if split_area /= Void then
				remove_parent_split_areas_bottom (split_area)	
			end
		end
	
	remove_parent_split_areas_bottom (split_area: EV_SPLIT_AREA) is
			--
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
			--
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
			--
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
			--
		do
			from
				all_holders.go_i_th (current_position)
			until
				all_holders.off or Result /= 0
			loop
				if not all_holders.item.minimized then
					Result := all_holders.index
				end
				all_holders.forth
			end
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
				if all_holders.item.minimized then
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
			-- If there is only one expanded holder, then its minimize button should
			-- be disabled, otherwise, they should all be enabled.
		local
			minimized_count: INTEGER
			non_minimized_holder: GB_TOOL_HOLDER
			cursor: CURSOR
		do
			cursor := all_holders.cursor
			from
				all_holders.start
			until
				all_holders.off
			loop
				if all_holders.item.minimized then
					minimized_count := minimized_count + 1
				else
					non_minimized_holder := all_holders.item
					all_holders.item.enable_minimize_button
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
				if not all_holders.item.minimized then
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
				if not all_holders.item.maximized then
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
		
	holder_of_widget (a_widget: EV_WIDGET): GB_TOOL_HOLDER is
			-- `Result' is tool holder containing `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
			linear_representation.has (a_widget)
		do
			Result := all_holders.i_th (linear_representation.index_of (a_widget, 1))
		ensure
			result_not_void: Result /= Void
		end

invariant
	linear_representation_not_void: linear_representation /= Void
	all_holders_not_void: all_holders /= Void
	all_split_areas_not_void: all_split_areas /= Void
	stored_splitter_widths_not_void: stored_splitter_widths /= Void

end -- class MULTIPLE_SPLIT_AREA
