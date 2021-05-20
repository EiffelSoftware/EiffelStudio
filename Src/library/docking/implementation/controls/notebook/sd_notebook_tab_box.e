note
	description: "Container only contain SD_NOTEBOOK_TABs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_BOX

inherit
	SD_DRAWING_AREA
		rename
			enable_capture as enable_capture_vision2,
			disable_capture as disable_capture_vision2
		export
			{NONE}
				enable_capture_vision2,
				disable_capture_vision2,
				set_minimum_height,
				set_minimum_size
			{SD_NOTEBOOK_TAB_AREA}
				set_minimum_width
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create  internal_shared
			create internal_tabs.make (3)

			default_create

			expose_actions.extend (agent on_expose)
			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_enter_actions.extend (agent on_pointer_enter)
			pointer_leave_actions.extend (agent on_pointer_leave)
			pointer_double_press_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do clear_pressed_flag end)

			update_size

			drop_actions.extend (agent on_drop_action)
			drop_actions.set_veto_pebble_function (agent on_drop_actions_veto_pebble)

			enable_tabable_from
			enable_tabable_to

			key_press_actions.extend (agent on_key)
			focus_in_actions.extend (agent update_focus_rectangle)
			focus_out_actions.extend (agent update_focus_rectangle)
		end

feature -- Command

	update_size
			--Update minimum height
		do
			set_minimum_height (internal_shared.Notebook_tab_height)
		end

	extend (a_tab: SD_NOTEBOOK_TAB)
			-- Extend `a_tab' into Current
		require
			not_void: a_tab /= Void
		local
			l_refresh: BOOLEAN
		do
			if not internal_tabs.has (a_tab) then
				l_refresh := True
			end
			extend_tab_imp (a_tab)
			if l_refresh then
				on_expose (0, 0, width, height)
			end
		ensure
			has: has (a_tab)
		end

	extend_tabs (a_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB])
			-- Extend `a_tabs'
			-- This feature is faster than extend one by one
		require
			not_void: a_tabs /= Void
		do
			from
				a_tabs.start
			until
				a_tabs.after
			loop
				extend_tab_imp (a_tabs.item)
				if a_tabs.islast then
					on_expose (0, 0, width, height)
				end
				a_tabs.forth
			end
		end

	prune (a_tab: SD_NOTEBOOK_TAB)
			-- Prune a tab from Current
		do
			if has (a_tab) then
				internal_tabs.start
				internal_tabs.prune (a_tab)
				on_expose (0, 0, width, height)
			end
		ensure
			pruned: not has (a_tab)
		end

	set_tab_position (a_tab: SD_NOTEBOOK_TAB; a_index: INTEGER)
			-- Set `a_tab' at position `a_index'	
		do
			internal_tabs.start
			internal_tabs.prune (a_tab)
			internal_tabs.go_i_th (a_index)
			internal_tabs.put_left (a_tab)
			on_expose (0, 0, width, height)
		end

	swap (a_tab_1, a_tab_2: SD_NOTEBOOK_TAB)
			-- Swap position of `a_tab_1' and `a_tab_2'
		require
			has: has (a_tab_1) and has (a_tab_2)
		local
			l_rect: EV_RECTANGLE
		do
			internal_tabs.go_i_th (internal_tabs.index_of (a_tab_1, 1))
			internal_tabs.swap (internal_tabs.index_of (a_tab_2, 1))

			l_rect := a_tab_1.rectangle
			l_rect.merge (a_tab_2.rectangle)
			on_expose (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
		end

	enable_capture (a_tab: SD_NOTEBOOK_TAB)
			-- Enable user input capture
		require
			has: has (a_tab)
		do
			captured_tab := a_tab
			enable_capture_vision2
		ensure
			set: captured_tab = a_tab
		end

	disable_capture (a_tab: SD_NOTEBOOK_TAB)
			-- Disable user input capture
		require
			has: has (a_tab)
			capture_called: captured_tab = a_tab or captured_tab = Void
		do
			if captured_tab /= Void then
				captured_tab := Void
				disable_capture_vision2
			end
		ensure
			cleared: captured_tab = Void
		end

feature -- Query

	item_x (a_tab: SD_NOTEBOOK_TAB): INTEGER
			-- x position of `a_tab'
		require
			has: has (a_tab)
		do
			from
				internal_tabs.start
			until
				internal_tabs.after or internal_tabs.item = a_tab
			loop
				Result := internal_tabs.item.width + Result
				internal_tabs.forth
			end
		ensure
			not_negative: Result >= 0
		end

	index_of (a_tab: SD_NOTEBOOK_TAB): INTEGER
			-- Index of `a_tab'
		require
			not_void: a_tab /= Void
		do
			Result := internal_tabs.index_of (a_tab, 1)
		ensure

		end

	i_th (a_index: INTEGER): SD_NOTEBOOK_TAB
			-- Tab at `a_index'
		require
			valid: is_tab_index_valid (a_index)
		do
			Result := internal_tabs.i_th (a_index)
		end

	has (a_tab: SD_NOTEBOOK_TAB): BOOLEAN
			-- If Current has `a_tab'?
		do
			Result := internal_tabs.has (a_tab)
		end

	count: INTEGER
			-- Count
		do
			Result := internal_tabs.count
		end

	tabs: like internal_tabs
			-- All tabs in Current
		do
			Result := internal_tabs.twin
		end

	captured_tab: detachable SD_NOTEBOOK_TAB
			-- Tab which enabled capture

	is_tab_index_valid (a_index: INTEGER): BOOLEAN
			-- If `a_index' valid?
		do
			Result := internal_tabs.valid_index (a_index)
		end

feature {NONE} -- Agents

	on_expose (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
			-- Handle expose actions
		local
			l_target: EV_RECTANGLE
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			start_drawing_session
			from
				create l_target.make (a_x, a_y, a_width, a_height)
				l_snapshot := internal_tabs.twin
				l_snapshot.start
			until
				l_snapshot.after
			loop
				l_item := l_snapshot.item
				if l_target.intersects (l_item.rectangle) then
					l_item.on_expose
				end
				l_snapshot.forth
			end
			end_drawing_session
		end

	on_pointer_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer motion actions
		local
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			if attached captured_tab as l_tab then
				l_tab.on_pointer_motion (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			elseif pointer_entered then
				from
					l_snapshot := internal_tabs
					l_snapshot.start
				until
					l_snapshot.after
				loop
					l_item := l_snapshot.item
					if l_item.is_displayed then
						if l_item.rectangle.has_x_y (a_x, a_y) and l_item.is_hot then
							l_item.on_pointer_motion (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						elseif l_item.rectangle.has_x_y (a_x, a_y) then
							l_item.on_pointer_enter
						elseif l_item.is_hot then
							l_item.on_pointer_leave
						end
						l_item.on_pointer_motion_for_tooltip (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
					l_snapshot.forth
				end
			end
		end

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer press actions
		local
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
			l_called: BOOLEAN
		do
			if attached captured_tab as l_tab then
				l_tab.on_pointer_press (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			else
				from
					l_snapshot := internal_tabs.twin
					l_snapshot.start
				until
					l_snapshot.after or l_called
				loop
					l_item := l_snapshot.item
					if l_item.rectangle.has_x_y (a_x, a_y) and l_item.is_displayed then
						l_item.on_pointer_press (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						-- One pointer press action only call one notebook tab action
						-- Otherwise, right click menu can appear more than once in one pointer press action
						-- See bug#12806
						l_called := True
					end
					l_snapshot.forth
				end
			end
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer release actions
		local
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			if attached captured_tab as l_tab then
				l_tab.on_pointer_release (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			else
				from
					l_snapshot := internal_tabs
					l_snapshot.start
				until
					l_snapshot.after
				loop
					l_item := l_snapshot.item
					if l_item.rectangle.has_x_y (a_x, a_y) and l_item.is_displayed then
						l_item.on_pointer_release (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
					l_snapshot.forth
				end
			end
		end

	on_pointer_enter
			-- Handle pointer enter actions
		local
			l_x: INTEGER
			l_found: BOOLEAN
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			pointer_entered := True
			if captured_tab = Void then
				l_x := (create {EV_SCREEN}).pointer_position.x - screen_x
				from
					l_snapshot := internal_tabs
					l_snapshot.start
				until
					l_snapshot.after or l_found
				loop
					l_item := l_snapshot.item
					if l_x < l_item.x + l_item.width then
						l_found := True
						l_item.on_pointer_enter
					end
					l_snapshot.forth
				end
			end
		ensure
			set: pointer_entered
		end

	on_pointer_leave
			-- Handle pointer leave actions
		local
			l_found: BOOLEAN
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			-- After pick and drop call this feature, pointer_entered is False, we ignore this case.
			if pointer_entered then
				pointer_entered := False
				if captured_tab = Void then
					from
						l_snapshot := internal_tabs
						l_snapshot.start
					until
						l_snapshot.after or l_found
					loop
						l_item := l_snapshot.item
						if l_item.is_hot  then
							l_found := True
							l_item.on_pointer_leave
						end
						if l_snapshot.islast and not l_found then
							l_item.on_pointer_leave
						end
						l_snapshot.forth
					end
				end
			end
		ensure
			cleared: not pointer_entered
		end

	on_drop_action (a_pebble: ANY)
			-- Handle drop actions
		do
			if attached tab_under_pointer as l_tab and then attached l_tab.drop_actions as l_drop_actions then
				check accept: l_drop_actions.accepts_pebble (a_pebble) end
				l_drop_actions.call ([a_pebble])
			end
		end

	on_drop_actions_veto_pebble (a_pebble: ANY): BOOLEAN
			-- Handle veto pebble drop actions
		do
			if attached tab_under_pointer as l_tab and then attached l_tab.drop_actions as l_drop_actions then
				Result := l_drop_actions.accepts_pebble (a_pebble)
			end
		end

	on_key (a_key: EV_KEY)
			-- Handle left/right navigation actions.
		local
			l_selected_index: INTEGER
			l_content: detachable SD_CONTENT
		do
			if (a_key.code = {EV_KEY_CONSTANTS}.key_left or a_key.code = {EV_KEY_CONSTANTS}.key_right) and then
				attached notebook as l_notebook
			then
				l_selected_index := l_notebook.selected_item_index
				if a_key.code = {EV_KEY_CONSTANTS}.key_left then
					if l_selected_index > 1 then
						l_content := l_notebook.contents.i_th (l_selected_index - 1)
					end
				else
					if l_selected_index < l_notebook.contents.count then
						l_content := l_notebook.contents.i_th (l_selected_index + 1)
					end
				end

				if l_content /= Void then
					l_notebook.select_item (l_content, True)
					l_content.focus_in_actions.call ([])

					-- The focus maybe was lost in `l_content.focus_in_actions', but we hope keep the focus, when end user press left/right in tabs area
					set_focus
				end
			end
		end

feature{NONE} -- Implementation

	extend_tab_imp (a_tab: SD_NOTEBOOK_TAB)
			-- Set information for `a_tab'
		require
			not_void: a_tab /= Void
		do
			-- It behaviour like a set, but ARRAYED_SET don't have enough features we want
			if not internal_tabs.has (a_tab) then
				internal_tabs.extend (a_tab)
				a_tab.set_font (font)
				a_tab.set_parent (Current)
			end
		end

	pointer_entered: BOOLEAN
			-- If pointer enter actions called?
			-- We have this flag for the same reason as SD_TOOL_BAR's pointer_entered

	update_focus_rectangle
			-- Draw or clear focus rectangle base on if Current has focus
		local
			l_selected: detachable SD_CONTENT
		do
			if has_parent and then attached notebook as l_notebook then
				l_selected := l_notebook.selected_item
				if l_selected /= Void then
					l_notebook.tab_by_content (l_selected).redraw_selected
				end
			end
		end

	notebook: detachable SD_NOTEBOOK
			-- Parent notebook
		do
			--| Note from review#7528237: should be detachable SD_NOTEBOOK,
			--|  since lack of assertions prevent us to use check
			if attached {SD_NOTEBOOK_TAB_AREA} parent as l_tab_area then
				Result := l_tab_area.notebook
			end
		ensure
			not_void: Result /= Void
		end

	tab_at (a_x: INTEGER): detachable SD_NOTEBOOK_TAB
			-- Tab at `a_x' which is relative position if any.
		require
			valid: a_x >= 0 and a_x <= width
		local
			l_snapshot: like internal_tabs
			l_item: SD_NOTEBOOK_TAB
		do
			from
				l_snapshot := internal_tabs.twin
				l_snapshot.start
			until
				l_snapshot.after or Result /= Void
			loop
				l_item := l_snapshot.item
				if item_x (l_item) <= a_x and a_x <= item_x (l_item) + l_item.width then
					Result := l_item
				end
				l_snapshot.forth
			end
		end

	tab_under_pointer: detachable SD_NOTEBOOK_TAB
			-- Tab at `a_screen_x'.
		local
			l_relative_x: INTEGER
		do
			l_relative_x := (create {EV_SCREEN}).pointer_position.x - screen_x
			if l_relative_x >= 0 and l_relative_x <= width then
				Result := tab_at (l_relative_x)
			end
		end

	clear_pressed_flag
			-- Clear pressed flag for Linux, because when pointer double pressed, no pointer leave will be called.
		local
			l_tabs: like tabs
		do
			from
				l_tabs := tabs
				l_tabs.start
			until
				l_tabs.after
			loop
				l_tabs.item.clear_pressed_flag
				l_tabs.forth
			end
		end

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current.

invariant

	not_void: internal_tabs /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
