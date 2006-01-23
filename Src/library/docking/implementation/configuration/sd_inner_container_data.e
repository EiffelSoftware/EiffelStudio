indexing
	description: "Objects that store config datas about inner container which is SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_INNER_CONTAINER_DATA


feature -- Tab and Docking datas.

	titles: ARRAYED_LIST [STRING]
			-- All titles. If it's a docking zone, there is only one title.

	add_title (a_title: STRING) is
			-- Add `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			if titles = Void then
				create titles.make (1)
			end
			titles.extend (a_title)
		ensure
			added: titles.has (a_title)
		end

	split_position: INTEGER
			-- If current is a split area, this is spliter position. -1 if current spliter not full.

	set_split_position (a_value: INTEGER) is
			-- Set `split_position'.
		do
			split_position := a_value
		ensure
			set: split_position = a_value
		end

	children_left: SD_INNER_CONTAINER_DATA
			-- `Current' data's left children.

	set_children_left (a_data: like children_left) is
			-- Set `children_left'.
		require
			a_data_not_void: a_data /= Void
		do
			children_left := a_data
		ensure
			set: children_left = a_data
		end

	children_right: SD_INNER_CONTAINER_DATA
			-- `Current' data's right children.

	set_children_right (a_data: like children_right) is
			-- Set `children_right'.
		require
			a_data_not_void: a_data /= Void
		do
			children_right := a_data
		ensure
			set: children_right = a_data
		end

	parent: like Current
			-- `Current' parent data.

	set_parent (a_parent: like Current) is
			-- Set `parent'.
		require
			a_parent_not_void: a_parent /= Void
		do
			parent := a_parent
		ensure
			set: parent = a_parent
		end

	is_split_area: BOOLEAN
			-- If it is a EV_SPLIT_AREA? Otherwise it's a SD_ZONE or SD_FLOATING_ZONE.

	set_is_split_area (a_value: BOOLEAN) is
			-- Set `is_split_area'.
		do
			is_split_area := a_value
		ensure
			set: is_split_area = a_value
		end

	is_horizontal_split_area: BOOLEAN
			---If Current is a spliter, if Current is SD_HORIZONTAL_SPLIT_AREA?

	set_is_horizontal_split_area (a_value: BOOLEAN) is
			-- Set `is_horizontal_split_area'.
		do
			is_horizontal_split_area := a_value
		ensure
			set: is_horizontal_split_area = a_value
		end

feature -- Floating datas.

	set_screen_x (a_screen_x: INTEGER) is
			-- Set `screen_x'.
		do
			screen_x := a_screen_x
		ensure
			set: screen_x = a_screen_x
		end

	set_screen_y (a_screen_y: INTEGER) is
			-- Set `screen_y'.
		do
			screen_y := a_screen_y
		ensure
			set: screen_y = a_screen_y
		end

	screen_x, screen_y: INTEGER
			-- When Current is SD_FLOATING_ZONE data, screen x y position of SD_FLOATING_ZONE.

	set_width (a_width: INTEGER) is
			-- Set `width'.
		do
			width := a_width
		ensure
			set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height'.
		do
			height := a_height
		ensure
			set: height = a_height
		end

	width, height: INTEGER
			-- When Current is SD_FLOATING_ZONE data, width height of SD_FLOATING_ZONE.	

feature -- Common properties

	state: STRING
			-- One generator type name of SD_STATE and it's descendents.

	set_state (a_class_name: STRING) is
			-- Set `state'.
		do
			state := a_class_name
		end

	direction: INTEGER
			-- Direction of state. One enumeration from SD_DOCKING_MANAGER.

	set_direction (a_direction: INTEGER) is
			-- Set `direction'.
		do
			direction := a_direction
		ensure
			direction = a_direction
		end

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
