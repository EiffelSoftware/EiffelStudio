indexing
	description: "Container only contain SD_NOTEBOOK_TABs"
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
			{SD_NOTEBOOK_TAB_DRAWER_IMP}
				implementation
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			default_create
			create  internal_shared
			create internal_tabs.make (3)

			expose_actions.extend (agent on_expose)
			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_enter_actions.extend (agent on_pointer_enter)
			pointer_leave_actions.extend (agent on_pointer_leave)
			set_minimum_height (internal_shared.title_bar_height)

			drop_actions.extend (agent on_drop_action)
			drop_actions.set_veto_pebble_function (agent on_drop_actions_veto_pebble)
		end

feature -- Command

	extend (a_tab: SD_NOTEBOOK_TAB) is
			-- Extend `a_tab' into Current
		require
			not_void: a_tab /= Void
		do
			if not internal_tabs.has (a_tab) then
				-- It's behaviour like a set, but ARRAYED_SET don't have enough features we want.
				internal_tabs.extend (a_tab)
				a_tab.set_font (font)
				a_tab.set_parent (Current)
				on_expose (0, 0, width, height)
			end
		ensure
			has: has (a_tab)
		end

	prune (a_tab: SD_NOTEBOOK_TAB) is
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

	set_tab_position (a_tab: SD_NOTEBOOK_TAB; a_index: INTEGER) is
			-- Set `a_tab' at position `a_index'.		
		do
			internal_tabs.start
			internal_tabs.prune (a_tab)
			internal_tabs.go_i_th (a_index)
			internal_tabs.put_left (a_tab)
			on_expose (0, 0, width, height)
		end

	swap (a_tab_1, a_tab_2: SD_NOTEBOOK_TAB) is
			-- Swap position of `a_tab_1' and `a_tab_2'.
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

	enable_capture (a_tab: SD_NOTEBOOK_TAB) is
			-- Enable user input capture
		require
			has: has (a_tab)
		do
			captured_tab := a_tab
			enable_capture_vision2
		ensure
			set: captured_tab = a_tab
		end

	disable_capture (a_tab: SD_NOTEBOOK_TAB) is
			-- Disable user input capture.
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

	item_x (a_tab: SD_NOTEBOOK_TAB): INTEGER is
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

	index_of (a_tab: SD_NOTEBOOK_TAB): INTEGER is
			-- Index of `a_tab'
		require
			not_void: a_tab /= Void
		do
			Result := internal_tabs.index_of (a_tab, 1)
		ensure

		end

	i_th (a_index: INTEGER): SD_NOTEBOOK_TAB is
			-- Tab at `a_index'.
		require
			valid: internal_tabs.valid_index (a_index)
		do
			Result := internal_tabs.i_th (a_index)
		end

	has (a_tab: SD_NOTEBOOK_TAB): BOOLEAN is
			-- If Current has `a_tab'?
		do
			Result := internal_tabs.has (a_tab)
		end

	count: INTEGER is
			-- Count
		do
			Result := internal_tabs.count
		end

	tabs: like internal_tabs is
			-- All tabs in Current.
		do
			Result := internal_tabs.twin
		end

feature {NONE} -- Agents

	on_expose (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32) is
			-- Handle expose actions.
		local
			l_target: EV_RECTANGLE
		do
			from
				create l_target.make (a_x, a_y, a_width, a_height)
				internal_tabs.start
			until
				internal_tabs.after
			loop
				if l_target.intersects (internal_tabs.item.rectangle) then
					internal_tabs.item.on_expose
				end
				internal_tabs.forth
			end
		end

	on_pointer_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle pointer motion actions.
		do

			if captured_tab /= Void then
				captured_tab.on_pointer_motion (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			elseif pointer_entered then
				from
					internal_tabs.start
				until
					internal_tabs.after
				loop
					if internal_tabs.item.is_displayed then
						if internal_tabs.item.rectangle.has_x_y (a_x, a_y) and internal_tabs.item.is_hot then
							internal_tabs.item.on_pointer_motion (a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						elseif internal_tabs.item.rectangle.has_x_y (a_x, a_y) then
							internal_tabs.item.on_pointer_enter
						elseif internal_tabs.item.is_hot then
							internal_tabs.item.on_pointer_leave
						end
					end
					internal_tabs.forth
				end
			end
		end

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle pointer press actions.
		do
			if captured_tab /= Void then
				captured_tab.on_pointer_press (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			else
				from
					internal_tabs.start
				until
					-- the internal_tabs.index maybe 2 more than internal_tabs.count?
					-- So we can't use after here.
					internal_tabs.index > internal_tabs.count
				loop
					if internal_tabs.item.rectangle.has_x_y (a_x, a_y) and internal_tabs.item.is_displayed then
						internal_tabs.item.on_pointer_press (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
					internal_tabs.forth
				end
			end
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle pointer release actions.
		do
			if captured_tab /= Void then
				captured_tab.on_pointer_release (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			else
				from
					internal_tabs.start
				until
					internal_tabs.after
				loop
					if internal_tabs.item.rectangle.has_x_y (a_x, a_y) and internal_tabs.item.is_displayed then
						internal_tabs.item.on_pointer_release (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
					internal_tabs.forth
				end
			end
		end

	on_pointer_enter is
			-- Handle pointer enter actions
		local
			l_screen: EV_SCREEN
			l_x: INTEGER
			l_found: BOOLEAN
		do
			pointer_entered := True
			if captured_tab = Void then
				create l_screen
				l_x := l_screen.pointer_position.x - screen_x
				from
					internal_tabs.start
				until
					internal_tabs.after or l_found
				loop
					if l_x < internal_tabs.item.x + internal_tabs.item.width then
						l_found := True
						internal_tabs.item.on_pointer_enter
					end
					internal_tabs.forth
				end
			end
		ensure
			set: pointer_entered
		end

	on_pointer_leave is
			-- Handle pointer leave actions
		require
			entered: pointer_entered = True
		local
			l_x: INTEGER
			l_found: BOOLEAN
		do
			pointer_entered := False
			if captured_tab = Void then
				from
					internal_tabs.start
				until
					internal_tabs.after or l_found
				loop
					if internal_tabs.item.is_hot  then
						l_found := True
						internal_tabs.item.on_pointer_leave
					end
					if internal_tabs.islast and l_found = False then
						internal_tabs.item.on_pointer_leave
					end
					internal_tabs.forth
				end
			end
		ensure
			cleared: pointer_entered = False
		end

	on_drop_action (a_pebble: ANY) is
			-- Handle drop actions.
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			l_tab := tab_under_pointer
			if l_tab /= Void then
				check accept:l_tab.drop_actions.accepts_pebble (a_pebble) end
				l_tab.drop_actions.call ([a_pebble])
			end
		end

	on_drop_actions_veto_pebble (a_pebble: ANY): BOOLEAN is
			-- Handle veto pebble drop actions.
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			l_tab := tab_under_pointer
			if l_tab /= Void then
				Result := l_tab.drop_actions.accepts_pebble (a_pebble)
			end
		end

feature -- Implementation

	pointer_entered: BOOLEAN
			-- If pointer enter actions called?
			-- We have this flag for the same reason as SD_TOOL_BAR's pointer_entered.

	tab_at (a_x: INTEGER): SD_NOTEBOOK_TAB is
			--  Tab at `a_x' which is relative position
		require
			valid: a_x >= 0 and a_x <= width
		do
			from
				internal_tabs.start
			until
				internal_tabs.after or Result /= Void
			loop
				if item_x (internal_tabs.item) <= a_x and a_x <= item_x (internal_tabs.item) + internal_tabs.item.width then
					Result := internal_tabs.item
				end
				internal_tabs.forth
			end
		ensure
			not_void: Result /= Void
		end

	tab_under_pointer: SD_NOTEBOOK_TAB is
			-- Tab at `a_screen_x'.
		local
			l_screen: EV_SCREEN
			l_relative_x: INTEGER
		do
			create l_screen
			l_relative_x := l_screen.pointer_position.x - screen_x
			if l_relative_x >= 0 and l_relative_x <= width then
				Result := tab_at (l_relative_x)
			end
		end

	captured_tab: SD_NOTEBOOK_TAB
			-- Tab which enabled capture

	internal_shared: SD_SHARED
			-- All sigletons.

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current.
invariant

	not_void: internal_tabs /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end
