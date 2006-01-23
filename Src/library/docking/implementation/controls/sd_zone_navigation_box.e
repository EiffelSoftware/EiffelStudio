indexing
	description: "Box in SD_ZONE_NAVIGATION_DIALOG, hold SD_CONTENT_LABELs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ZONE_NAVIGATION_BOX

inherit
	EV_CELL
		rename
			extend as extend_cell
		end

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method
		local
			l_first_box: EV_VERTICAL_BOX
		do
			default_create
			create internal_shared

			create internal_scroll_area
			internal_scroll_area.hide_horizontal_scroll_bar
			internal_scroll_area.hide_vertical_scroll_bar
			internal_scroll_area.set_background_color (internal_shared.tool_tip_color)
			extend_cell (internal_scroll_area)

			create internal_horizontal_box
			internal_horizontal_box.set_padding_width (internal_shared.padding_width)
			internal_scroll_area.extend (internal_horizontal_box)

			create l_first_box
			l_first_box.set_padding (internal_shared.padding_width)
			internal_horizontal_box.extend (l_first_box)
			internal_horizontal_box.disable_item_expand (l_first_box)
			l_first_box.set_background_color (internal_shared.tool_tip_color)
		end

feature -- Command

	set_max_size (a_width, a_height: INTEGER) is
			-- Set max size of current
		require
			valid: a_width > 0 and a_height > 0
		do
			max_width := a_width
			max_height := a_height
		ensure
			set: max_width = a_width and max_height = a_height
		end

	max_width, max_height: INTEGER
			-- Max width and max height of Current.

	extend (a_label: SD_CONTENT_LABEL) is
			-- Extend a_label.
		local
			l_vertical_box: EV_VERTICAL_BOX
			l_box: EV_BOX
		do
			if max_height < internal_horizontal_box.last.height + a_label.minimum_height then
				-- When not enough height, we add a new EV_VERTICAL_BOX.
				create l_vertical_box
				internal_horizontal_box.extend (l_vertical_box)
				internal_horizontal_box.disable_item_expand (l_vertical_box)
				l_vertical_box.set_background_color (internal_shared.tool_tip_color)
			end

			l_box ?= internal_horizontal_box.last
			check not_void: l_box /= Void end
			l_box.extend (a_label)
			l_box.disable_item_expand (a_label)

			if internal_horizontal_box.minimum_width <= max_width then
				internal_scroll_area.set_minimum_width (internal_horizontal_box.minimum_width)
			else
				internal_scroll_area.show_horizontal_scroll_bar
			end
			if internal_horizontal_box.minimum_height <= max_height then
				internal_scroll_area.set_minimum_height (internal_horizontal_box.minimum_height)
			else
				internal_scroll_area.show_vertical_scroll_bar
			end

		end

feature -- Query

	labels: ARRAYED_LIST [SD_CONTENT_LABEL] is
			-- All labels in Current.
		local
			l_box: EV_BOX
			l_label: SD_CONTENT_LABEL
		do
			from
				create Result.make (1)
				internal_horizontal_box.start
			until
				internal_horizontal_box.after
			loop
				l_box ?= internal_horizontal_box.item
				check not_void: l_box /= Void end
				from
					l_box.start
				until
					l_box.after
				loop
					l_label ?= l_box.item
					check not_void: l_label /= Void end
					Result.extend (l_label)
					l_box.forth
				end
				internal_horizontal_box.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box to hold EV_VERTICAL_BOXs. And EV_VERTICAL_BOX hold SD_CONTENT_LABELs.

	internal_scroll_area: EV_SCROLLABLE_AREA
			-- Scoll area which shown when not enough space.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_scroll_area_not_void: internal_scroll_area /= Void
	at_least_one_vertical_box: internal_horizontal_box.count = 1
	internal_horizontal_box_not_void: internal_horizontal_box /= Void

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
