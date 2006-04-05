indexing
	description: "[
		Objects that represent a multiple, vertically oriented split area,
		that contains a number of explorer bar items. The old version of EiffelStudio
		used an explorer bar, and this class is its replacement.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLORER_BAR
	
inherit
	MULTIPLE_SPLIT_AREA
		redefine
			initialize
		end
		
	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end
		
create
	make
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {MULTIPLE_SPLIT_AREA}
			create item_list.make (default_item_list_size)
		end
		
	make (a_parent: EB_TOOL_MANAGER; use_explorer_style: BOOLEAN; full_max: BOOLEAN) is
			-- Create `Current' with parent, `a_parent', using explorer style if `use_explorer_style', 
			-- and maximizing its tools fully in `a_parent' if `full_max'.
		require
			a_parent_not_void: a_parent /= Void
		do
			default_create
			explorer_style := use_explorer_style
			full_maximize := full_max
			explorer_bar_manager := a_parent
			hide_disabled_minimize_button
			
				-- Connect events required as call backs to EiffelStudio routines.
			docked_in_actions.extend (agent dock_completed)
			docked_out_actions.extend (agent docked_external)
			Maximize_actions.extend (agent item_maximized)
			restore_actions.extend (agent item_restored)
		end		

feature -- Access

	explorer_bar_manager: EB_TOOL_MANAGER
			-- Parent of the bar.
			
	explorer_style: BOOLEAN
			-- Use the explorer style? (i.e one visible item at most)

	full_maximize: BOOLEAN
			-- Can the bar take the whole window?

	item_list: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]
			-- List of all items in the bar.
			
	explorer_item: EB_EXPLORER_BAR_ITEM is
			-- First item, Void if none
		do
			Result := item_list.first
		end
		
	is_maximized: BOOLEAN is
			-- Is an item in `Current' maximized?
		local
			cur: CURSOR
		do
			if full_maximize then
				from
					cur := item_list.cursor
					item_list.start
				until
					Result or item_list.after
				loop
					Result := item_list.item.is_maximized
					item_list.forth
				end
				item_list.go_to (cur)
			end
		ensure
			position_not_changed: linear_representation.index = old linear_representation.index
		end
			
	add (an_item: like explorer_item) is
			-- Add `item' at the first available slot.
		require
			an_item_not_void: an_item /= Void
		local
			insert_pos: INTEGER
			custom_box: EV_BOX
		do
			item_list.extend (an_item)
			if an_item.is_visible then
					-- As `add' is only called when tools are created in order,
					-- the insert pos does not vary. See `show' from EB_EXPLORER_BAR_WIDGET
					-- for a full implemenetation of gathering `insert_pos' and inserting at a
					-- paticular index.
				insert_pos := item_list.index_of (an_item, 1)
				insert_widget (an_item.widget, an_item.title, insert_pos.min (count + 1), default_insert_height)
				if an_item.is_closeable then
					enable_close_button (an_item.widget)
				else
					enable_close_button_as_grayed (an_item.widget)
				end
				custom_box := customizeable_area_of_widget (an_item.widget)
				custom_box.extend (an_item.mini_toolbar_holder)
				custom_box.disable_item_expand (an_item.mini_toolbar_holder)
				if an_item.header_addon /= Void then
					custom_box.extend (an_item.header_addon)
				end
			end
		end
		
	on_item_restored (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been restored in `Current'.
		require
			an_item_not_void: an_item /= Void
		do
			restore_item (an_item.widget)
		end
		
	on_item_minimized (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been minimized in `Current'.
		require
			an_item_not_void: an_item /= Void
		do
			if not is_item_minimized (an_item.widget) then
				minimize_item (an_item.widget)
			end
		end
		
	on_item_maximized (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been maximized in `Current'.
		require
			an_item_not_void: an_item /= Void
		do
			maximize_item (an_item.widget)
			item_maximized (an_item.widget)
		end
		
	on_item_hidden (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been hidden in `Current'.
		require
			an_item_not_void: an_item /= Void
		local
			development_window: EB_DEVELOPMENT_WINDOW
		do
			development_window ?= explorer_bar_manager
			if development_window /= Void then
				development_window.remove_tool_window (an_item.widget)
			end
			if count = 0 then
					-- If `an_item' is hidden, and was the last tool,
					-- `Current' must be closed, as it is now empty.
				explorer_bar_manager.close_bar (Current)
			end
		end

	item_maximized (a_widget: EV_WIDGET) is
			-- `a_widget' has been maximized in `Current'.
		require
			a_widget_not_void: a_widget /= Void
		local
			cursor: CURSOR
		do
			cursor := item_list.cursor
				-- Must mark all other items as non maximized.
				-- This is a "brute force" method, as their is no easy way
				-- to know when an expanded items state changes as a result of 
				-- another item becoming expanded.
			from
				item_list.start
			until
				item_list.off
			loop
				if item_list.item.widget /= a_widget then
					item_list.item.internal_set_restored
				end
				item_list.forth
			end

--Where is this preference??
--See above			
--			if full_maximize and boolean_resource_value ("editor_maximized", True) then
				explorer_bar_manager.close_all_bars_except (Current)
--			end
			item_list.go_to (cursor)
		ensure
			item_list_index_not_changed: item_list.index = old item_list.index
		end
		
	item_restored (a_widget: EV_WIDGET) is
			-- `a_widget' has been restored in `Current'.
		require
			a_widget_not_void: a_widget /= Void
		local
			restored_item: EB_EXPLORER_BAR_ITEM
			cursor: CURSOR
		do
			cursor := item_list.cursor
			from
				item_list.start
			until
				item_list.off
			loop
				if item_list.item.widget = a_widget then
					restored_item := item_list.item
				end
				item_list.forth
			end
			check
				restored_item_found: restored_item /= Void
			end
			restored_item.internal_set_restored
			restored_item.explorer_bar_manager.restore_bars
			item_list.go_to (cursor)
		ensure
			item_list_index_not_changed: item_list.index = old item_list.index
		end

	on_item_shown (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been shown.
		require
			an_item_not_void: an_item /= Void
		local
			curr_item: EB_EXPLORER_BAR_ITEM
			cursor: CURSOR
		do
			cursor := item_list.cursor
			explorer_bar_manager.force_display_bar (Current)

				-- One item at most if explorer bar style.
			if explorer_style then
				from
					item_list.start
				until
					item_list.after
				loop
					curr_item := item_list.item
					if curr_item /= an_item and an_item.is_closeable and then curr_item.is_closeable then
						curr_item.close
					end
					item_list.forth
				end
			end
			item_list.go_to (cursor)
		ensure
			item_list_index_not_changed: item_list.index = old item_list.index
		end

	save_to_resource: ARRAY [STRING] is
			-- Save representation of `Current' into `Result', ready for storage
			-- as a preference.
		local
			curr_item: like explorer_item
			l_parent: EV_WINDOW
			i: INTEGER
			state: STRING
			cur: CURSOR
		do
			cur := item_list.cursor
			create Result.make (1, item_list.count * 6) 
			from
				item_list.start
				i := 1 
			until
				item_list.after
			loop
				curr_item := item_list.item
				Result.put (curr_item.title, i)
				if curr_item.is_visible then
					if external_representation.has (curr_item.widget) then
						state := "external"
					elseif is_item_minimized (curr_item.widget) then
						state := "minimized"
					elseif is_item_maximized (curr_item.widget) then
						state := "maximized"
					else	
						state := "visible"
					end
				else
					state := "closed"
				end
				Result.put (state, i + 1)
				if state.is_equal ("external") then
					l_parent := parent_window (curr_item.widget)
					Result.put ((l_parent.x_position - explorer_bar_manager.window.x_position).out, i + 2)
					Result.put ((l_parent.y_position - explorer_bar_manager.window.y_position).out, i + 3)
					Result.put (l_parent.width.out, i + 4)	
					Result.put (l_parent.height.out, i + 5)
				else
					Result.put ("0", i + 2)
					Result.put ("0", i + 3)
					Result.put ("0", i + 4)
					Result.put (curr_item.widget.height.out, i + 5)
				end

					-- prepare next iteration			
				i := i + 6
				item_list.forth
			end
			item_list.go_to (cur)
		ensure
			position_consitent: item_list.index = old item_list.index
		end

	load_from_resource (a_layout: ARRAY [STRING]) is
			-- Build contents and structure of `Current' from `a_layout',
			-- corresponding to that built by `save_to_resource'.
		require
			layout_not_void: a_layout /= Void
		local
			curr_item: like explorer_item
			item_state: STRING
			i, j: INTEGER
			item_height: STRING
			all_heights: ARRAYED_LIST [INTEGER]
			a_height: INTEGER
			has_maximized_tool: BOOLEAN
			items_by_name: HASH_TABLE [EB_EXPLORER_BAR_ITEM, STRING]
			temp_layout: ARRAY [STRING]
			minimized_count: INTEGER
		do
				-- Clear `item_list' and store all items in `items_by_name', hashed
				-- by their names, for retrieval based on the current settings in `layout'.
			create items_by_name.make (item_list.count)
			from
				item_list.start
			until
				item_list.is_empty
			loop
				items_by_name.put (item_list.item, item_list.item.title)
				item_list.item.close
				item_list.remove
			end

				-- Now perform special processing which parses `a_layout' and removes any invalid
				-- items which prevents EiffelStudio from crashing if a tool that is not in `item_list'
				-- is referenced. We simply do not add the tool to `temp_layout'. This fix has been added
				-- in response to a bug reported by David Hollenberg where the call stack tool was saved within
				-- the left panel non debug layout. I believe this problem was duw to the result of an old bug that did
				-- not properly clear the externally docked tools when debug specific tools such as the
				-- call stack were docked out while the bugger execution is fixed. Therefore, this problem should be fixed
				-- but the protection has been added in case something occurs. We should not rely on this code, but
				-- fix the problem at the source when it can be found. Julian.
			create temp_layout.make (a_layout.lower, a_layout.lower - 1)
			from
				i := a_layout.lower
				j := i
			until
				i > a_layout.upper
			loop
				if i \\ 6 = 1 then
					curr_item := items_by_name.item (a_layout.item(i))
					if curr_item /= Void then
						temp_layout.conservative_resize (temp_layout.lower, temp_layout.upper + 6)
						temp_layout.put (a_layout.item (i), j)
					else
						check
							invalid_tool_contained: False
						end
						i := i + 5
							-- Needed to counter against the adding of one in the main body of the loop.
						j := j - 1
					end
				else
					temp_layout.put (a_layout.item (i), j)
				end
				i := i + 1
				j := j + 1
			end

			
				-- Block rebuilding of `Current' until further notice. This is because a
				-- lot of building is to take place, and it is optimal to perform it once at
				-- the end.
			block
			
				-- Rebuild contents of `item_list' to ensure their order matches that of
				-- `temp_layout'. As the order may change, it is possible that it may be different
				-- between standard and debugging layouts, hence the need to rebuild this.
			from
				i := temp_layout.lower
			until
				i > temp_layout.upper
			loop
				item_list.extend (items_by_name.item (temp_layout.item(i)))
				item_state := temp_layout.item(i + 1)
				if item_state.is_equal ("maximized") then
					has_maximized_tool := True
				end
					-- prepare next iteration
				i := i + 6
			end
			
				-- Reset all items to their default states.
			create all_heights.make (item_list.count)
			from
				i := temp_layout.lower
			until
				i > temp_layout.upper
			loop
				curr_item := items_by_name.item (temp_layout.item(i))
				check
					curr_item_not_void: curr_item /= Void
				end
				curr_item.reset
				i := i + 6
			end
			
				-- Clear all items from `Current'.
			wipe_out
			
				-- Now perform a pass, updating the status of all items contained as
				-- required.
			from
				i := temp_layout.lower
			until
				i > temp_layout.upper
			loop
				item_state := temp_layout.item(i + 1)
				item_height := temp_layout.item(i + 5)
				check
					item_height_is_integer: item_height.is_integer
				end
				a_height := item_height.to_integer
				check
					item_height_is_integer: item_height.is_integer
				end
				a_height := item_height.to_integer
				if not item_state.is_equal ("closed") and not item_state.is_equal ("external") then
					all_heights.extend (a_height) 	
				end
				curr_item := items_by_name.item (temp_layout.item(i))
				check
					curr_item_not_void: curr_item /= Void
				end
				if item_state.is_equal ("minimized") then
					if not curr_item.is_visible then
							--| FIXME, this is a major hack to stop large widgets
							--| expanding a window while minimized.
						curr_item.widget.hide
						curr_item.show
					end
				elseif item_state.is_equal ("external") then
					curr_item.show_external (explorer_bar_manager.window.x_position + (temp_layout.item(i + 2)).to_integer, explorer_bar_manager.window.y_position + (temp_layout.item(i + 3)).to_integer, (temp_layout.item(i + 4)).to_integer, (temp_layout.item(i + 5)).to_integer)				
				elseif item_state.is_equal ("visible") or item_state.is_equal ("maximized") then
					curr_item.show	
				end
				i := i + 6
			end
				-- Now perform a final pass, updating all minimized and maximized items.
				-- This is because tools may only be minimized and maximized correctly when the other tools
				-- are contained.
			from
				i := temp_layout.lower
			until
				i > temp_layout.upper
			loop
				curr_item := items_by_name.item (temp_layout.item(i))
				check
					curr_item_not_void: curr_item /= Void
				end
				item_state := temp_layout.item(i + 1)
				item_height := temp_layout.item(i + 5)
				check
					item_height_is_integer: item_height.is_integer
				end
				a_height := item_height.to_integer
				
					-- The protection here is for the case where we have switched from
					-- show multiple tools to show a single tool mode. We must ignore minimization
					-- and maximization for any tools that are not actually contained in `Current'.
					-- There may be a better way to perform this, such as preprocessing the data
					-- and removing invalid entries. Julian.
				if linear_representation.has (curr_item.widget) then
					if item_state.is_equal ("minimized") and not has_maximized_tool then
						minimized_count := minimized_count + 1
						
							--| FIXME this is not true in the case where we are only showing a single tool.
							--| Should we pre-prune all of the data so there is only a single item?
							--| I think it only occurs in the case where you switch from regular mode to single and restart. Julian.
						--check
						--		not_all_items_minimized: minimized_count < count
						--end
						if minimized_count < count then
							if not curr_item.is_minimized then
									curr_item.minimize
							end
						end
					elseif item_state.is_equal ("maximized") then
						curr_item.maximize
					end
				end
				i := i + 6
			end
				-- Unblock internal locking of `Current'.
			unblock

			if not all_heights.is_empty then
					-- Now replace heights, as `Current' was blocked during the re-building.
				if not explorer_style then
						-- It is possible that there are heights, even though the single explorer
						-- bar style is selected. This occurs when you switch to explorer bar style while
						-- more than one tool is displayed, and then restart EiffelStudio. In this case,
						-- perform no resizing, as the heights are not valid.
					set_heights_no_resize (all_heights)
				end
			else
				explorer_bar_manager.close_bar (Current)
			end
		end
		
	unmaximize is
			-- If an item is maximized, unmaximize it.
		local
			cur: CURSOR
		do
			from
				cur := item_list.cursor
				item_list.start
			until
				item_list.after
			loop
				if item_list.item.is_maximized then
					item_list.item.restore
				end
				item_list.forth
			end
			item_list.go_to (cur)
		end

feature {EB_EXPLORER_BAR_ITEM} -- Implementation

	prune_item (an_item: EB_EXPLORER_BAR_ITEM) is
			-- Prune `an_item' from `Current'.
		require
			an_item_not_void: an_item /= Void
		do
			item_list.prune_all (an_item)
		end
		
	docked_external (a_widget: EV_WIDGET) is
			-- `a_widget' has been docked externally, perform necessary processing.
		require
			a_widget_not_void: a_widget /= Void
		local
			tool_window: EB_TOOL_WINDOW
			development_window: EB_DEVELOPMENT_WINDOW
		do
			if count = 0 then
					-- If final tool contained was docked externally, then hide `Current'.
				explorer_bar_manager.close_bar (Current)
			end
			
			development_window ?= explorer_bar_manager
			
				-- Build a tool window representation, permitting external tool to be tracked by top level window.
			create tool_window.make_with_info (parent_window (a_widget), a_widget, development_window,
				parent_window (a_widget).x_position - development_window.window.screen_x,
				parent_window (a_widget).y_position - development_window.window.screen_y)
				
				-- Update `tool_window' based on movement of `window'.
			tool_window.window.move_actions.force_extend (agent tool_window_moved (?, ?, tool_window))
		end
		
feature {NONE} -- Implementation

	dock_completed (a_widget: EV_WIDGET) is
			-- A dock has completed in `Current', so
			-- must update `item_list' to reflect this change.
		require
			a_widget_not_void: a_widget /= Void
		local
			clone_item_list: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]
			new_order: ARRAYED_LIST [INTEGER]
			inserted_explorer_bar_item: EB_EXPLORER_BAR_ITEM
			development_window: EB_DEVELOPMENT_WINDOW
		do
				-- Stop tracking of widget by parent, if it was external.
				-- If `a_widget' was not, then `remove_tool_window' does nothing.
			development_window ?= explorer_bar_manager
			development_window.remove_tool_window (a_widget)

			clone_item_list := item_list.twin
			create new_order.make (item_list.count)
			item_list.wipe_out
			from
				clone_item_list.start
			until
				clone_item_list.off
			loop
				if clone_item_list.item.widget = a_widget then
					inserted_explorer_bar_item := clone_item_list.item
				end
				if linear_representation.has (clone_item_list.item.widget) then
					item_list.go_i_th (linear_representation.index_of (clone_item_list.item.widget, 1).min (item_list.count + 1))
					item_list.put_left (clone_item_list.item)
				end
				clone_item_list.forth
			end
			check
				inserted_explorer_bar_item_not_void: inserted_explorer_bar_item /= Void
			end
			from
				clone_item_list.start
			until
				clone_item_list.off
			loop
				if not linear_representation.has (clone_item_list.item.widget) then
					item_list.go_i_th (clone_item_list.index)
					item_list.put_left (clone_item_list.item)
				end
				clone_item_list.forth
			end
			
			on_item_shown (inserted_explorer_bar_item)

				-- Ensure that the close buttons is updated for the tool.			
			if inserted_explorer_bar_item.is_closeable then
				enable_close_button (inserted_explorer_bar_item.widget)
			else
				enable_close_button_as_grayed (inserted_explorer_bar_item.widget)
			end
		end
		
	tool_window_moved (an_x_position, a_y_position: INTEGER; tool_window: EB_TOOL_WINDOW) is
			-- tool window `tool_window' has moved to position `an_x_position', `y_position', so
			-- store new psitional settings relevent to its development window.
		require
			tool_window_not_void: tool_window /= Void
		do
			tool_window.set_x_position (an_x_position - tool_window.development_window.window.screen_x)
			tool_window.set_y_position (a_y_position - tool_window.development_window.window.screen_y)
		end
		
	default_insert_height: INTEGER is 150
			-- Default height new tools are inserted as.
			
	default_item_list_size: INTEGER is 6;
			-- Default size of `item_list'.
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_EXPLORER_BAR
