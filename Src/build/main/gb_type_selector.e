indexing
	description: "Objects that allow you to select a widget type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TYPE_SELECTOR

inherit
	EV_CELL
		export
			{ANY} parent, is_displayed
		undefine
			is_in_default_state
		redefine
			initialize
		end

	GB_SUPPORTED_WIDGETS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		redefine
			default_create
		end

	GB_STORABLE_TOOL
		undefine
			default_create, copy, is_equal
		redefine
			default_create
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		redefine
			default_create
		end

	GB_DEFAULT_STATE
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

	initialize is
			-- Initialize `Current'.
			-- Fill with supported Widgets.
		do
			Precursor {EV_CELL}
			create tool_bar
			create view_mode_button
			view_mode_button.set_pixmap (pixmap_by_name ("icon_icon_view_color"))
			view_mode_button.set_tooltip ("Icon View Mode")
			view_mode_button.select_actions.extend (agent switch_view_mode)
			tool_bar.extend (view_mode_button)
			if preferences.global_data.type_selector_classic_mode then
				build_classic_view
				extend (tree)
			else
				build_icon_view
				view_mode_button.enable_select
				extend (drawing_area)

			end
		end

feature -- Access

	tool_bar: EV_TOOL_BAR
			-- A tool bar containing all buttons associated with `Current'.

	name: STRING is "Type Selector"
			-- Full name used to represent `Current'.

	is_in_classic_view_mode: BOOLEAN is
			-- Is `Current' in the classic view mode?
		do
			Result := (tree /= Void and then tree.parent /= Void) or
				(drawing_area /= Void and then drawing_area.parent = Void)
		end

feature -- Basic operation

	ensure_top_item_visible is
			-- Ensure that the topmost displayed item
			-- in `Current' is visible.
		require
			is_displayed: is_displayed
		do
			if tree.is_displayed then
					-- Note we onyl perform this if the tree mode is used.
				tree.ensure_item_visible (tree.i_th (1))
			end
		end

feature {NONE} -- Implementation

	add_tree_items (list: ARRAY [STRING]; tree_item: EV_TREE_ITEM) is
			-- Add items corresponding to contents of `list' to `tree_item'.
		require
			list_not_void: list /= Void
			tree_item_not_void: tree_item /= Void
		local
			counter: INTEGER
			new_item: GB_TREE_TYPE_SELECTOR_ITEM
		do
			from
				counter := 1
			until
				counter = list.count + 1
			loop
				create new_item.make_with_text ((list @ counter).substring (4, (list @ counter).count), components)
				tree_item.extend (new_item.item)
				counter := counter + 1
			end
		end

	build_classic_view is
			-- Build classic view mode.
		local
			tree_item1, tree_item2, tree_item3, tree_item4: EV_TREE_ITEM
		do
			create tree
			tree.set_minimum_height (tool_minimum_height)
			create tree_item1.make_with_text ("Widgets")
			tree_item1.set_pixmap (pixmap_by_name ("widgets"))
			tree.extend (tree_item1)
			create tree_item3.make_with_text ("Containers")
			tree_item3.set_pixmap (pixmap_by_name ("containers"))
			tree_item1.extend (tree_item3)
			add_tree_items (containers, tree_item3)
			create tree_item2.make_with_text ("Primitives")
			tree_item2.set_pixmap (pixmap_by_name ("primitives"))
			tree_item1.extend (tree_item2)
			add_tree_items (primitives, tree_item2)
			create tree_item4.make_with_text ("Items")
			tree_item4.set_pixmap (pixmap_by_name ("items"))
			tree.extend (tree_item4)
			add_tree_items (items, tree_item4)
				-- Expand the types when the project is started.
			tree_item2.expand
			tree_item3.expand
			tree_item1.expand
			tree_item4.expand
		end


	build_icon_view is
			-- Build icon view mode.
		local
			figure_line: EV_FIGURE_LINE
			line_color: EV_COLOR
		do
			create line_color.make_with_8_bit_rgb (220, 220, 220)
			create drawing_area
			create figure_world
			create buffer_pixmap
			create projector.make_with_buffer (figure_world, buffer_pixmap, drawing_area)
			projector.register_figure (create {FIGURE_PICTURE_WITH_DATA}, agent projector.draw_figure_picture)
			drawing_area.set_background_color ((create {EV_STOCK_COLORS}).white)
			figure_world.extend (create {EV_FIGURE_TEXT}.make_with_text ("Containers : "))
			add_figure_items (containers, figure_world)
			create figure_line
			figure_line.set_foreground_color (line_color)
			figure_world.extend (figure_line)
			figure_world.extend (create {EV_FIGURE_TEXT}.make_with_text ("Primitives : "))
			add_figure_items (primitives, figure_world)
			create figure_line
			figure_line.set_foreground_color (line_color)
			figure_world.extend (figure_line)
			figure_world.extend (create {EV_FIGURE_TEXT}.make_with_text ("Items : "))
			add_figure_items (items, figure_world)
			drawing_area.resize_actions.extend (agent drawing_area_resized)
		end

	add_figure_items (list: ARRAY [STRING]; a_world: EV_FIGURE_WORLD) is
			-- Add items corresponding to contents of `list' to `table'.
		local
			counter: INTEGER
			new_item: GB_FIGURE_TYPE_SELECTOR_ITEM
		do
			from
				counter := 1
			until
				counter = list.count + 1
			loop
				create new_item.make_with_text (list @ counter, components)
				a_world.extend (new_item.item)
				counter := counter + 1
			end
		end

	drawing_area_resized (an_x, a_y, a_width, a_height: INTEGER) is
			-- Respond to `drawing_area' resizing by re-positioning all figures
			-- and re-projecting.
		local
			x_counter, y_counter: INTEGER
			figure_picture: FIGURE_PICTURE_WITH_DATA
			figure_text: EV_FIGURE_TEXT
			figure_line: EV_FIGURE_LINE
			display_on_multiple_line: BOOLEAN
			maximum_line_width: INTEGER
			image_height: INTEGER
		do

				-- Calculate if the text and icons must be displayed on a single line.
			figure_text ?= figure_world.i_th (primitive_offset + 1)
			figure_picture ?= figure_world.i_th (primitive_offset + 2)
			image_height := figure_picture.height
			maximum_line_width := (figure_text.width + ((items_offset - primitive_offset - 2) * (figure_picture.width + spacing)))
			display_on_multiple_line := drawing_area.width  - spacing * 2 < maximum_line_width
				-- Store the maximum line width that must be used if the window is wider than the
				-- longest type list. This stops the line going to the very end of the window.
			if maximum_line_width >= drawing_area.width - figure_text.width and display_on_multiple_line then
				maximum_line_width := maximum_line_width - figure_text.width
			end
			maximum_line_width := maximum_line_width - 10

			y_counter := spacing
			x_counter := spacing
			from
				figure_world.start
			until
				figure_world.off
			loop
				figure_picture ?= figure_world.item
				if figure_picture /= Void then
						-- The current item is one of the icons, so move it to the correct position,
						-- wrapping to a new line if necessary.
					figure_picture.set_point (create {EV_RELATIVE_POINT}.make_with_position (x_counter, y_counter))
					x_counter := x_counter + figure_picture.width + spacing
					if x_counter + figure_picture.width > a_width or figure_world.index + 1 = primitive_offset or figure_world.index + 1 = items_offset then
						y_counter := y_counter + image_height + spacing + 2
						x_counter := spacing
						if figure_world.index + 1 = primitive_offset or figure_world.index + 1 = items_offset then
								-- We must wrap to a new line
							y_counter := y_counter + 2 * spacing
						end
					end
				else
					figure_text ?= figure_world.item
					if figure_text /= Void then
						figure_text.set_point (create {EV_RELATIVE_POINT}.make_with_position (x_counter, y_counter))
						x_counter := x_counter + figure_text.width + spacing
						if display_on_multiple_line then
							y_counter := y_counter + figure_text.height + spacing
							x_counter := spacing
						end
					else
						figure_line ?= figure_world.item
						figure_line.set_point_a (create {EV_RELATIVE_POINT}.make_with_position (10, y_counter - spacing - 1))
						figure_line.set_point_b (create {EV_RELATIVE_POINT}.make_with_position ((drawing_area.width - 10).min (maximum_line_width), y_counter - spacing - 1))
					end
				end
				figure_world.forth
			end
				-- Only increase or decrease size of `buffer_pixmap' in increments of 100 for performance
				-- reasons.
			if integer_truncated (drawing_area.width + 100, 100) /= buffer_pixmap.width or integer_truncated (drawing_area.height + 100, 100) /= buffer_pixmap.height then
				buffer_pixmap.set_size (integer_truncated (drawing_area.width + 100, 100), integer_truncated (drawing_area.height + 100, 100))
			end
			buffer_pixmap.clear
			figure_world.invalidate
			projector.project
		end

	switch_view_mode is
			-- Switch view mode between classic and icon.
		do
			if view_mode_button.is_selected then
				if drawing_area = Void then
					build_icon_view
				end
				wipe_out
				extend (drawing_area)
			else
				if tree = Void then
					build_classic_view
				end
				wipe_out
				extend (tree)
			end
			preferences.global_data.type_selector_classic_mode_preference.set_value (not view_mode_button.is_selected)
			preferences.preferences.save_preference (preferences.global_data.type_selector_classic_mode_preference)
		ensure
			mode_toggled: is_in_classic_view_mode = not old is_in_classic_view_mode
		end

	view_mode_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- A button to switch between view modes,
			-- either the standard view, or the compressed view.

	figure_world: EV_FIGURE_WORLD
		-- Figure world in which all items are contained when using figures.

	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector to project `figure_world' to `drawing_area'.

	buffer_pixmap: EV_PIXMAP
		-- Pixmap into which buffering is performed.

	tree: EV_TREE
		-- Tree Representation of `Current'.

	spacing: INTEGER is 4
		-- Spacing used around the figures when not `is_in_classic_view_mode'.

	containers_offset: INTEGER is 1
		-- Index of first container figure within `figure_world'.

	primitive_offset: INTEGER is
			-- Index of first primitive figure within `figure_world'.
		once
			Result := containers.count + 2
		end

	items_offset: INTEGER is
			-- Index of first item figure within `figure_world'.
		once
			Result := containers.count + primitives.count + 4
		end

feature {GB_FIGURE_TYPE_SELECTOR_ITEM} -- Implementation

	drawing_area: EV_DRAWING_AREA;
		-- Drawing area into which all figures are drawn.

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


end -- class GB_WIDGET_SELECTOR
