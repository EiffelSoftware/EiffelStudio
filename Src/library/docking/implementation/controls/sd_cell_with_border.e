indexing
	description: "A cell which can define which edge has a border."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	appearance:
		"[
			If set border at top, left, right, it will look like this.
			 ________________
			 | widgets       |

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CELL_WITH_BORDER

inherit
	EV_CELL
		rename
			extend as extend_cell,
			has as has_cell,
			count as count_cell,
			wipe_out as wipe_out_cell
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			default_create

			create internal_border_up
			create internal_border_bottom
			create internal_border_left
			create internal_border_right

			create internal_vertical_box
			extend_cell (internal_vertical_box)
			internal_vertical_box.extend (internal_border_up)
			internal_vertical_box.disable_item_expand (internal_border_up)

			create internal_horizontal_box
			internal_vertical_box.extend (internal_horizontal_box)
			internal_horizontal_box.extend (internal_border_left)
			internal_horizontal_box.disable_item_expand (internal_border_left)
			create internal_cell
			internal_horizontal_box.extend (internal_cell)
			internal_horizontal_box.extend (internal_border_right)
			internal_horizontal_box.disable_item_expand (internal_border_right)

			internal_vertical_box.extend (internal_border_bottom)
			internal_vertical_box.disable_item_expand (internal_border_bottom)
		end

feature -- Command

	extend (a_widget: EV_WIDGET) is
			-- Extend a_widget at border center.
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_cell.extend  (a_widget)
		ensure
			added: internal_cell.has (a_widget)
		end

	count: INTEGER is
			-- How many widgets?
		do
			Result := internal_cell.count
		end

	has (a_widget: EV_WIDGET): BOOLEAN is
			-- If has a_widget?
		do
			Result := internal_cell.has (a_widget)
		end

	wipe_out is
			-- Wipe out.
		do
			internal_cell.wipe_out
		end

	set_show_border (a_direction: INTEGER; a_show: BOOLEAN) is
			-- Set show border at a_direction base on a_show. a_direction is one enumeration from SD_DOCKING_MANAGER.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				if a_show then
					internal_border_up.show
				else
					internal_border_up.hide
				end
			when {SD_DOCKING_MANAGER}.dock_bottom then
				if a_show then
					internal_border_bottom.show
				else
					internal_border_bottom.hide
				end
			when {SD_DOCKING_MANAGER}.dock_left then
				if a_show then
					internal_border_left.show
				else
					internal_border_left.hide
				end
			when {SD_DOCKING_MANAGER}.dock_right then
				if a_show then
					internal_border_right.show
				else
					internal_border_right.hide
				end
			end
		ensure
			set:
		end

	set_border_style (a_style: INTEGER) is
			--  Set border with a_sttyle, a_style is one emueration from SD_DOCKING_MANAGER.
		require
			a_style_valid: a_style = {SD_DOCKING_MANAGER}.dock_top or a_style = {SD_DOCKING_MANAGER}.dock_bottom
				or a_style = {SD_DOCKING_MANAGER}.dock_left or a_style = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_style
			when {SD_DOCKING_MANAGER}.dock_top then
				set_show_border ({SD_DOCKING_MANAGER}.dock_top, False)
				set_show_border ({SD_DOCKING_MANAGER}.dock_bottom, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_left, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_right, True)
			when {SD_DOCKING_MANAGER}.dock_bottom then
				set_show_border ({SD_DOCKING_MANAGER}.dock_top, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_bottom, False)
				set_show_border ({SD_DOCKING_MANAGER}.dock_left, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_right, True)
			when {SD_DOCKING_MANAGER}.dock_left then
				set_show_border ({SD_DOCKING_MANAGER}.dock_top, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_bottom, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_left, False)
				set_show_border ({SD_DOCKING_MANAGER}.dock_right, True)
			when {SD_DOCKING_MANAGER}.dock_right then
				set_show_border ({SD_DOCKING_MANAGER}.dock_top, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_bottom, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_left, True)
				set_show_border ({SD_DOCKING_MANAGER}.dock_right, False)
			end
		ensure
			set:
		end


	set_border_color (a_color: EV_COLOR) is
			-- Set border color.
		require
			a_color_not_void: a_color /= Void
		do
			internal_border_up.set_background_color (a_color)
			internal_border_bottom.set_background_color (a_color)
			internal_border_left.set_background_color (a_color)
			internal_border_right.set_background_color (a_color)
		ensure
			set: internal_border_up.background_color.is_equal (a_color) and internal_border_bottom.background_color.is_equal (a_color)
				and internal_border_left.background_color.is_equal (a_color) and internal_border_right.background_color.is_equal (a_color)
		end

	set_border_width (a_width: INTEGER) is
			-- Set border width.
		require
			a_width_valid: a_width >= 0
		do
			internal_border_up.set_minimum_height (a_width)
			internal_border_bottom.set_minimum_height (a_width)
			internal_border_left.set_minimum_width (a_width)
			internal_border_right.set_minimum_width (a_width)
		ensure
			set: internal_border_up.minimum_height = a_width and internal_border_bottom.minimum_height = a_width
				and internal_border_left.minimum_width =  a_width and internal_border_right.minimum_width = a_width
		end

feature {NONE}  -- Implementation

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box which contain left border, user widget, right border.

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box which contain top border, `internal_horizontal_box', bottom border.

	internal_border_up, internal_border_bottom, internal_border_left, internal_border_right: EV_CELL
			-- Four edges border.

	internal_cell: EV_CELL;
			-- User cell.
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
