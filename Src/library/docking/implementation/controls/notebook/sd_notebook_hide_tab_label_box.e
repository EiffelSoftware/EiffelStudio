indexing
	description: "A vertical box on SD_NOTEBOOK_HIDE_TAB_DIALOG, it hold SD_NOTEBOOK_HIDE_TAB_LABELs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_HIDE_TAB_LABEL_BOX

inherit
	EV_CELL
		rename
			key_press_actions as key_press_actions_cell,
			item as item_cell,
			extend as extend_cell,
			has as has_cell
		redefine
			set_focus
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			default_create
			create key_press_actions
			create internal_scroll_area
			extend_cell (internal_scroll_area)
			internal_scroll_area.hide_horizontal_scroll_bar
			internal_scroll_area.hide_vertical_scroll_bar

			create internal_vertical_box
			internal_scroll_area.extend (internal_vertical_box)

			pointer_motion_actions.extend (agent on_pointer_motion)
			key_press_actions_cell.extend (agent on_key_press)
			focus_out_actions.extend (agent on_focus_out)
		ensure
			extended: has_cell (internal_scroll_area) and internal_scroll_area.has (internal_vertical_box)
		end

feature -- Command

	start is
			-- Move cursor to first position.
		do
			internal_vertical_box.start
		end

	forth is
			-- Move cursor to next position.
		do
			internal_vertical_box.forth
		end

	disable_item_expand (a_label: SD_CONTENT_LABEL) is
			-- Do not expand `an_item' to occupy available spare space.
		do
			internal_vertical_box.disable_item_expand (a_label)
		end

	extend (a_widget: EV_WIDGET) is
			-- Redefine
		require
			not_void: a_widget /= Void
		local
			l_label: SD_CONTENT_LABEL
		do
			internal_vertical_box.extend (a_widget)
			l_label ?= a_widget
			check only_extend_hide_tab_label: l_label /= Void end
			l_label.enable_color_actions.extend (agent on_label_enable_color (l_label))
		end

	set_focus is
			-- Redefine
		local
			l_label: SD_CONTENT_LABEL
			l_found: BOOLEAN
		do
			Precursor {EV_CELL}
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after or l_found
			loop
				l_label ?= internal_vertical_box.item
				check l_label_not_void: l_label /= Void end
				if l_label.is_non_focus_color_enabled then
					l_found := True
					l_label.enable_focus_color
				end
				internal_vertical_box.forth
			end

			if not l_found then
				l_label ?= internal_vertical_box.first
				check not_void: l_label /= Void end
				l_label.enable_focus_color
			end
		end

--	set_size (a_width: INTEGER; a_height: INTEGER) is
--			-- Set size of `internal_scroll_area'.
--		require
--			size_valid: a_width >= 0 and a_height >= 0
--		do
--			internal_scroll_area.set_minimum_size (a_width, a_height)
--		end

	show_scroll_bar is
			-- Show scroll bar.
		do
			internal_scroll_area.show_vertical_scroll_bar
		ensure
			set: internal_scroll_area.is_vertical_scroll_bar_visible
		end

	hide_scroll_bar is
			-- Hide scroll bar.
		do
			internal_scroll_area.hide_vertical_scroll_bar
		ensure
			set: not internal_scroll_area.is_vertical_scroll_bar_visible
		end

feature -- Query

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := internal_vertical_box.after
		end

	index: INTEGER is
			-- Current position.
		do
			Result := internal_vertical_box.index
		end

	index_of (a_label: SD_CONTENT_LABEL): INTEGER is
			-- Index of a_label.
		do
			Result := internal_vertical_box.index_of (a_label, 1)
		end

	label_shown_count: INTEGER is
			-- How many label shown?
		do
			Result := shown_labels.count
		end

	has (a_label: SD_CONTENT_LABEL): BOOLEAN is
			-- If current has a_label?
		do
			Result := internal_vertical_box.has (a_label)
		end

	shown_labels: ARRAYED_LIST [SD_CONTENT_LABEL] is
			-- Shown labels.
		local
			l_label: SD_CONTENT_LABEL
		do
			create Result.make (1)
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				l_label ?= internal_vertical_box.item
				check l_label_not_void: l_label /= Void end
				if internal_vertical_box.item.is_displayed then
					Result.extend (l_label)
				end
				internal_vertical_box.forth
			end
		ensure
			not_void: Result /= Void
		end

	current_focus_label: SD_CONTENT_LABEL is
			-- Label which is Current focused.
		local
			l_label: SD_CONTENT_LABEL
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				if internal_vertical_box.item.is_displayed then
					l_label ?= internal_vertical_box.item
					check not_void: l_label /= Void end
					if l_label.is_focus_color_enabled or l_label.is_non_focus_color_enabled then
						Result := l_label
					end
				end
				internal_vertical_box.forth
			end
		end

	item: SD_CONTENT_LABEL is
			-- Label at current index.
		do
			Result ?= internal_vertical_box.item
		ensure
			not_void: internal_vertical_box.item /= Void implies Result /= Void
		end

	key_press_actions: ACTION_SEQUENCE [ TUPLE [EV_KEY]]
			-- Special key press actions.

	prefered_height: INTEGER is
			-- Prefered height.
		do
			Result := internal_vertical_box.minimum_height
		end

	prefered_width: INTEGER is
			-- Predered width.
		local
			l_scroll_bar: EV_VERTICAL_SCROLL_BAR
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				if Result < internal_vertical_box.item.minimum_width then
					Result := internal_vertical_box.item.minimum_width
				end
				internal_vertical_box.forth
			end
			if internal_scroll_area.is_vertical_scroll_bar_visible then
				-- FIXIT: how to get size of scroll bar in EV_SCROLLABLE_AREA?
				create l_scroll_bar
				Result := Result + l_scroll_bar.minimum_width
			end
		end

feature {NONE} -- Implementation functions

	on_focus_out is
			-- Handle focus out actions.
		local
			l_label: SD_CONTENT_LABEL
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				l_label ?= internal_vertical_box.item
				check not_void: l_label /= Void end
				if l_label.is_focus_color_enabled then
					l_label.enable_non_focus_color
				end
				internal_vertical_box.forth
			end
		end

	on_key_press (a_key: EV_KEY) is
			-- Handle key press
		local
			l_label: SD_CONTENT_LABEL
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.Key_tab then
				key_press_actions.call ([a_key])
				from
					internal_vertical_box.start
				until
					internal_vertical_box.after
				loop
					l_label ?= internal_vertical_box.item
					check only_has_label: l_label /= Void end
					if l_label.is_focus_color_enabled then
						l_label.enable_non_focus_color
					end
					internal_vertical_box.forth
				end
			when {EV_KEY_CONSTANTS}.Key_enter then
				if label_shown_count > 0 and then current_focus_label /= Void then
					key_press_actions.call ([a_key])
				end
			when {EV_KEY_CONSTANTS}.Key_up then
				if label_shown_count > 1 then
					focus_previous
				else
					shown_labels.first.enable_focus_color
				end
			when {EV_KEY_CONSTANTS}.Key_down then
				if label_shown_count > 1 then
					focus_next
				else
					shown_labels.first.enable_focus_color
				end
			when {EV_KEY_CONSTANTS}.Key_escape then
				key_press_actions.call ([a_key])
			else

			end
		end

	on_label_enable_color (a_label: SD_CONTENT_LABEL) is
			-- Handle a_label enable color action.
		require
			a_label_not_void: a_label /= Void
		local
			l_label: SD_CONTENT_LABEL
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				if internal_vertical_box.item /= a_label then
					l_label ?= internal_vertical_box.item
					check noly_has_hide_tab_label: l_label /= Void end
					l_label.disable_focus_color
				end
				internal_vertical_box.forth
			end
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		local
			l_label: SD_CONTENT_LABEL
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				l_label ?= internal_vertical_box.item
				check only_has_hide_label: l_label /= Void end
				if internal_vertical_box.item.screen_x >= a_screen_x and internal_vertical_box.item.screen_y >= a_screen_y and
					internal_vertical_box.item.screen_x + internal_vertical_box.item.width <= a_screen_x and
						 internal_vertical_box.item.screen_y + internal_vertical_box.item.height <= a_screen_y then
					if has_focus then
						l_label.enable_focus_color
					else
						l_label.enable_non_focus_color
					end
				else
					l_label.disable_focus_color
				end
				internal_vertical_box.forth
			end
		end

	focus_next is
			-- Focus next label.
		require
			shown_count_valid: label_shown_count > 1
		local
			l_label: SD_CONTENT_LABEL
			l_shown_labels: ARRAYED_LIST [SD_CONTENT_LABEL]
		do
			l_label := current_focus_label
			l_label.disable_focus_color
			l_shown_labels := shown_labels
			if l_shown_labels.last = l_label then
				l_shown_labels.first.enable_focus_color
			else
				l_shown_labels.i_th (l_shown_labels.index_of (l_label, 1) + 1).enable_focus_color
			end
		end

	focus_previous is
			-- Focus previous label.
		require
			shown_count_valid: label_shown_count > 1
		local
			l_label: SD_CONTENT_LABEL
			l_shown_labels: ARRAYED_LIST [SD_CONTENT_LABEL]
		do
			l_label := current_focus_label
			l_label.disable_focus_color
			l_shown_labels := shown_labels
			if l_shown_labels.first = l_label then
				l_shown_labels.last.enable_focus_color
			else
				l_shown_labels.i_th (l_shown_labels.index_of (l_label, 1) - 1).enable_focus_color
			end
		end

feature {NONE}  -- Implementation attributes

	internal_scroll_area: EV_SCROLLABLE_AREA
			-- Scrollable area which contain `internal_vertical_box'.

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box which contain all SD_NOTEBOOK_HID_TAB_LABEL.

invariant

	internal_scroll_area_not_void: internal_scroll_area /= Void
	internal_vertical_box_not_void: internal_vertical_box /= Void
	key_press_actions_not_void: key_press_actions /= Void

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




end
