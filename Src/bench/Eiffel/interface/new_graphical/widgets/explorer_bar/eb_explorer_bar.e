indexing
	description	: "Multi-split-area with headers for each part.Each part can %
				  %be minimized or hidden"
	appearance	: ".-------------.N%
				  %|   first  _ X|%N%
				  %|-------------|%N%
				  %|             |%N%
				  %|             |%N%
				  %.-------------.N%
				  %|  second  _ X|%N%
				  %|-------------|%N%
				  %|             |%N%
				  %|             |%N%
				  %|             |%N%
				  %.-------------."
	status		: "See notice at end of class"
	keywords	: "split,area, box, header"
	date		: "$Date$"
	revision	: "$Revision$"

class 
	EB_EXPLORER_BAR

create
	make

feature {NONE} -- Implementation
   
	make (a_parent: EB_EXPLORER_BAR_MANAGER; use_explorer_style: BOOLEAN; full_max: BOOLEAN) is
			-- Initialization
		do
			explorer_style := use_explorer_style
			full_maximize := full_max
			explorer_bar_manager := a_parent
			create widget

			create main_split_area
			create top_split_area
			main_split_area.extend (top_split_area)
			widget.extend (main_split_area)
			create item_list.make (6)
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Widget corresponding to the explorer bar.

	count: INTEGER
			-- Number of items in the explorer bar.

	explorer_bar_manager: EB_EXPLORER_BAR_MANAGER
			-- Parent of the bar.

	explorer_style: BOOLEAN
			-- Use the explorer style? (i.e one visible item at most)

	full_maximize: BOOLEAN
			-- Can the bar take the whole window?

	item_list: ARRAYED_LIST [like item]
			-- List of all items in the bar.

	item: EB_EXPLORER_BAR_ITEM is
			-- First item, Void if none
		do
			Result := item_list.first
		end

	visible_count: INTEGER is
			-- Number of visible items.
		local
			cur: CURSOR
		do
			from
				cur := item_list.cursor
				item_list.start
			until
				item_list.after
			loop
				if item_list.item.is_visible then
					Result := Result + 1
				end
				item_list.forth
			end
			item_list.go_to (cur)
		end

	restored_count: INTEGER is
			-- Number of restored (i.e visible and not minimized) items.
		local
			curr_item: like item
			cur: CURSOR
		do
			from
				cur := item_list.cursor
				item_list.start
			until
				item_list.after
			loop
				curr_item := item_list.item
				if curr_item.is_visible and then (not curr_item.is_minimized) then
					Result := Result + 1
				end
				item_list.forth
			end
			item_list.go_to (cur)
		end

	is_show_requested: BOOLEAN is
			-- Are one or more items visible?
		do
			Result := visible_count > 0
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
		end

feature -- Status Report

	is_text_on_button: BOOLEAN
			-- Is there a text displayed in the toggle button as well as a pixmap?

feature {EB_EXPLORER_BAR_MANAGER} -- Status setting

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

feature -- Element change

	add (an_item: like item) is
			-- Add `item' at the first available slot.
			--
			-- Call `repack_widgets' to have the changes takes
			-- effect. 
		require
			parent_of_item_is_current: an_item.parent = Current
		do
			if explorer_style then
				an_item.disable_minimizable
				an_item.disable_maximizable
			end
			item_list.extend (an_item)
		end

	prune (an_item: like item) is
			-- Prune `an_item' from the list of managed explorer_bar_item's.
			--
			-- Call `repack_widgets' to have the changes takes
			-- effect. 
		require
			parent_of_item_is_current: an_item.parent = Current
		do
			item_list.prune_all (an_item)
		end

	repack_widgets is
			-- Repack the widgets according to the new state.
		do
			build_layout (True)
		end

	refresh_splitter is
		do
			if main_split_area /= Void and then not main_split_area.is_empty then
				main_split_area.set_split_position (main_split_position.
					max (main_split_area.minimum_split_position).min
					(main_split_area.maximum_split_position))
			end
			if top_split_area /= Void and then not top_split_area.is_empty then
				top_split_area.set_split_position (top_split_position.
					max (top_split_area.minimum_split_position).min
					(top_split_area.maximum_split_position))
			end
		end

feature -- Load/Save

	save_to_resource: ARRAY [STRING] is
		local
			curr_item: like item
			i: INTEGER
			state: STRING
			cur: CURSOR
		do
			cur := item_list.cursor
				-- Save splitter positions.
			if top_split_area /= Void then
				top_split_position := top_split_area.split_position
			end
			if main_split_area /= Void then
				main_split_position := main_split_area.split_position
			end

			create Result.make (1, item_list.count + 2) 
			from
				item_list.start
				i := 1 
			until
				item_list.after
			loop
				curr_item := item_list.item
				if curr_item.is_visible then
					if curr_item.is_minimized then
						state := "minimized"
					else
						state := "visible"
					end
				else
					state := "closed"
				end
				Result.put (state, i)

					-- prepare next iteration
				item_list.forth
				i := i + 1
			end
			Result.put (top_split_position.out, i)
			i := i + 1
			Result.put (main_split_position.out, i)
			item_list.go_to (cur)
		end

	load_from_resource (a_layout: ARRAY [STRING]) is
			-- Set the layout corresponding to `a_layout' and repack the widgets.
		local
			curr_item: like item
			item_state: STRING
			pos: STRING
			i: INTEGER
			c: CURSOR
		do
				--| Do not compute layouts when items are restored/minimized... since it would be superfluous.
			no_recompute := True
			from
				item_list.start
				i := a_layout.lower
			until
				item_list.after or i >= a_layout.upper
			loop
				-- Save position in list (the position might be changed by some
				-- calls to `show', `restore', ...)
				c := item_list.cursor

				curr_item := item_list.item
				item_state := a_layout @ i

				if item_state.is_equal ("minimized") then
					if not curr_item.is_visible then
						curr_item.show	
					end
					if not curr_item.is_minimized then
						curr_item.minimize
					end
				elseif item_state.is_equal ("visible") then
					if not curr_item.is_visible then
						curr_item.show	
					end
					if curr_item.is_minimized then
						curr_item.restore
					end
				elseif item_state.is_equal ("closed") then
					if curr_item.is_visible and then curr_item.is_closeable then
						curr_item.close
					end
				end
				
					-- prepare next iteration
				item_list.go_to (c)
				item_list.forth
				i := i + 1
			end
			
				-- Retrieve the position of the splitters.
			if a_layout.count >= 2 then
				pos := a_layout @ (a_layout.count - 1)
				if pos.is_integer then
					top_split_position := pos.to_integer
				end
				pos := a_layout @ (a_layout.count)
				if pos.is_integer then
					main_split_position := pos.to_integer
				end
			end
--			if i <= a_layout.upper and then (a_layout @ i).is_integer then
--				top_split_position := (a_layout @ i).to_integer
--			end
--			i := i + 1
--			if i <= a_layout.upper and then (a_layout @ i).is_integer then
--				main_split_position := (a_layout @ i).to_integer
--			end

			no_recompute := False
				-- Build the retrieved layout.
			if visible_count = 0 then
				explorer_bar_manager.close_bar (Current)
			else
				build_layout (False)
			end
		end

feature {EB_EXPLORER_BAR_ITEM} -- Item actions

	on_item_maximized (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been maximized.
		local
			conv_win: EB_WINDOW
		do
			conv_win ?= explorer_bar_manager
			if conv_win /= Void then
				conv_win.lock_update
			end

			repack_widgets

			if conv_win /= Void then
				conv_win.unlock_update
			end
		end

	on_item_minimized (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been minimized.
		local
			conv_win: EB_WINDOW
		do
			conv_win ?= explorer_bar_manager
			if conv_win /= Void then
				conv_win.lock_update
			end

			if restored_count = 0 then
				restore_item_different_from (an_item)
			else
					-- Simply repack the widgets.
				repack_widgets
			end

			if conv_win /= Void then
				conv_win.unlock_update
			end
		end

	on_item_restored (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been restored.
		local
			conv_win: EB_WINDOW
		do
			conv_win ?= explorer_bar_manager
			if conv_win /= Void then
				conv_win.lock_update
			end

			repack_widgets

			if conv_win /= Void then
				conv_win.unlock_update
			end
		end

	on_item_shown (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been shown.
		local
			conv_win: EB_WINDOW
			curr_item: EB_EXPLORER_BAR_ITEM
		do
			if not safety_flag then
				safety_flag := True

				conv_win ?= explorer_bar_manager
				if conv_win /= Void then
					conv_win.lock_update
				end

				explorer_bar_manager.force_display_bar (Current)

					-- One item at most.
				if explorer_style then
					from
						item_list.start
					until
						item_list.after
					loop
						curr_item := item_list.item
						if curr_item /= an_item and then curr_item.is_closeable then
							curr_item.close
						end
						item_list.forth
					end
				end
	
				repack_widgets

				if conv_win /= Void then
					conv_win.unlock_update
				end
				
				safety_flag := False
			end
		end

	on_item_hidden (an_item: EB_EXPLORER_BAR_ITEM) is
			-- `an_item' has been hidden/closed.
		local
			conv_win: EB_WINDOW
		do
			if not safety_flag then
				safety_flag := True

				conv_win ?= explorer_bar_manager
				if conv_win /= Void then
					conv_win.lock_update
				end

				if visible_count = 0 then
					explorer_bar_manager.close_bar (Current)
					repack_widgets
				else
					if restored_count = 0 then
							-- The only restored item has been closed,
							-- so we restore an arbitrary item.
						restore_item_different_from (an_item)
					else
							-- Simply repack the widgets.
						repack_widgets
					end
				end

				if conv_win /= Void then
					conv_win.unlock_update
				end

				safety_flag := False
			end
		end

feature {NONE} -- Implementation (attributes)

	no_recompute: BOOLEAN
			-- We may forbid all recomputations, to prevent unnecessary ones.

	build_layout (save_splitter: BOOLEAN) is
			-- Repack the widgets according to the new state.
		local
			restored_items: ARRAYED_LIST [like item]
			minimized_items: ARRAYED_LIST [like item]
			maximized_item: like item
			curr_item: like item
			max_main, height: INTEGER
			first_item: EV_WIDGET
			second_item: EV_WIDGET
			third_item: EV_WIDGET
			cur: CURSOR
		do
			cur := item_list.cursor
			if not no_recompute then
				height := widget.height
				if save_splitter then
						-- Save splitter positions.
					if top_split_area /= Void then
						top_split_position := top_split_area.split_position
					end
					if main_split_area /= Void then
						main_split_position := main_split_area.split_position
						max_main := main_split_area.maximum_split_position
					end
				end
	
					-- Build minimized items & restored items.
				create minimized_items.make (5)
				create restored_items.make (5)
	
				from
					item_list.start
				until
					item_list.after
				loop
					curr_item := item_list.item
					if curr_item.is_visible then
						if curr_item.is_maximized then
							maximized_item := curr_item
						elseif curr_item.is_minimized then
							minimized_items.extend (curr_item)
						else
							restored_items.extend (curr_item)
						end
					end
					item_list.forth
				end
	
				if maximized_item /= Void then
					if full_maximize then
						explorer_bar_manager.close_all_bars_except (Current)
					end
					widget.wipe_out
					widget.extend (build_item_display (maximized_item))
				else
					explorer_bar_manager.restore_bars
	
						-- If there is more than 3 restored items, minimize them.
					from
						restored_items.start
					until
						restored_items.count <= 3
					loop
						minimized_items.extend (restored_items.item)
						restored_items.remove
					end
	
						-- Display restored items
					if restored_items.count > 0 then
						explorer_bar_manager.display_bar (Current)
					else
						explorer_bar_manager.close_bar (Current)
					end
					inspect restored_items.count
					when 3 then
						if main_split_position = 0 or top_split_position = 0 then
							top_split_position := height // 3
							main_split_position := 2 * height // 3
						end
	
						create main_split_area
						create top_split_area
						main_split_area.enable_flat_separator
						top_split_area.enable_flat_separator
						first_item := build_item_display (restored_items @ 1)
						second_item := build_item_display (restored_items @ 2)
						third_item := build_item_display (restored_items @ 3)
						top_split_area.set_first (first_item)
						top_split_area.set_second (second_item)
						top_split_area.enable_item_expand (first_item)
						top_split_area.disable_item_expand (second_item)
						main_split_area.set_first (top_split_area)
						main_split_area.set_second (third_item)
						main_split_area.enable_item_expand (top_split_area)
						main_split_area.disable_item_expand (third_item)
						widget.wipe_out
						widget.extend (main_split_area)
						debug ("DEBUGGER_INTERFACE")
							io.putstring ("%NMain position: " + main_split_position.out + "%N")
							io.putstring ("Top position: " + top_split_position.out + "%N")
						end
						if save_splitter then
							main_split_area.set_split_position (main_split_position.max
										(main_split_area.minimum_split_position).
										min (main_split_area.maximum_split_position))
							top_split_area.set_split_position (
								top_split_position.max (top_split_area.minimum_split_position).
								min (top_split_area.maximum_split_position))
							main_split_position := main_split_area.split_position
							top_split_position := top_split_area.split_position
						end
					when 2 then
						if main_split_position = 0 then
							main_split_position := height // 2
						end
	
						create main_split_area
						top_split_area := Void
						main_split_area.enable_flat_separator
						first_item := build_item_display (restored_items @ 1)
						second_item := build_item_display (restored_items @ 2)
						main_split_area.set_first (first_item)
						main_split_area.set_second (second_item)
						main_split_area.enable_item_expand (first_item)
						main_split_area.disable_item_expand (second_item)
						widget.wipe_out
						widget.extend (main_split_area)
						debug ("DEBUGGER_INTERFACE")
							io.putstring ("%NMain position (no top): " + main_split_position.out + "%N")
						end
						if save_splitter then
							main_split_area.set_split_position (main_split_position.max
										(main_split_area.minimum_split_position).
										min (main_split_area.maximum_split_position))
							main_split_position := main_split_area.split_position
						end
					when 1 then
						main_split_area := Void
						top_split_area := Void
						widget.wipe_out
						widget.extend (build_item_display (restored_items @ 1))
					when 0 then
						main_split_area := Void
						top_split_area := Void
						widget.wipe_out
					end
	
						-- Display minimized items
					from
						minimized_items.start
					until
						minimized_items.after
					loop
						first_item := build_minimized_item_display (minimized_items.item)
						widget.extend (first_item)
						widget.disable_item_expand (first_item)
						minimized_items.forth
					end
				end
			end
			item_list.go_to (cur)
		end

	build_item_display (curr_item: like item): EV_WIDGET is
		local
			frame: EV_FRAME
			vbox: EV_VERTICAL_BOX
			curr_header: EV_FRAME
			curr_widget: EV_WIDGET
		do
			create frame
			create vbox
			curr_header := curr_item.header
			curr_widget := curr_item.widget
			if curr_header.parent /= Void then
				curr_header.parent.prune_all (curr_header)
			end
			if curr_widget.parent /= Void then
				curr_widget.parent.prune_all (curr_widget)
			end
			vbox.extend (curr_header)
			vbox.disable_item_expand (curr_header)
			vbox.extend (curr_widget)
	
			frame.set_style (Frame_constants.Ev_frame_lowered)
			frame.extend (vbox)

			Result := frame
		end

	build_minimized_item_display (curr_item: like item): EV_WIDGET is
		local
			curr_header: EV_FRAME
		do
			curr_header := curr_item.header
			if curr_header.parent /= Void then
				curr_header.parent.prune_all (curr_header)
			end
			Result := curr_header
		end

	restore_item_different_from (a_given_item: EB_EXPLORER_BAR_ITEM) is
			-- Restore the first item found different from `a_given_item'.
			-- If no other item than `a_given_item' is minimized, `a_given_item' is
			-- restored.
			--
			-- Note: This function call `{EB_EXPLORER_BAR_ITEM}.restore' which cause
			-- a call to `on_item_restored'.
		local
			curr_item: like item
			minimized_item: like item
		do
				-- Look for the first minimized item different from `an_item', and
				-- restore it.
			from
				item_list.start
			until
				minimized_item /= Void or else item_list.after
			loop
				curr_item := item_list.item
				if curr_item /= a_given_item and then curr_item.is_visible and then curr_item.is_minimized then
					minimized_item := curr_item
				end
				item_list.forth
			end
			
			if minimized_item = Void then
					-- The item is the only one in the explorer bar, it can't be
					-- minimized.
				minimized_item := a_given_item
			end
			
				-- Restore the selected minimized item.
				-- `item.restore' will call `on_item_restored' which will cause
				-- the call to `repack_widgets'.
			minimized_item.restore
		end

	main_split_area: EB_VERTICAL_SPLIT_AREA
			-- Main split area, when needed.

	main_split_position: INTEGER
			-- Position of splitter for `main_split_area'.

	top_split_area: EB_VERTICAL_SPLIT_AREA
			-- Split area located in the first cell of `main_split_area', when needed.

	top_split_position: INTEGER
			-- Position of splitter for `top_split_area'.

	safety_flag: BOOLEAN
			-- Safety flag to avoid reentrance.

feature {NONE} -- Constants

	Frame_constants: EV_FRAME_CONSTANTS is
		once
			create Result
		end

	Pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

end -- class EB_EXPLORER_BAR

