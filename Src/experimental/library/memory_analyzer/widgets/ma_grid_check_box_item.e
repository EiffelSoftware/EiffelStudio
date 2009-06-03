note
	description: "Objects that represent a checkbox in a grid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_GRID_CHECK_BOX_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM

create
	make,
	make_with_boolean

feature {NONE} -- Initialization

	make
			-- Creation method.
		do
			default_create
			expose_actions.extend (agent draw_overlay_pixmap)
			pointer_button_press_actions.force_extend (agent handle_pointer_pressed)
			create selected_changed_actions
			set_required_width (40)
		end

	make_with_boolean (a_bool: BOOLEAN)
			-- Create the object with value to a_bool
		do
			make
			internal_selected := a_bool
		ensure
			a_bool_set: a_bool = internal_selected
		end

feature -- Status Setting

	initialize_for_tree
			-- Draw tree line to check box.
		do
			tree_line_enabled := True
		end

feature -- Access

	selected: BOOLEAN assign set_selected
			-- Is current check box selected?
		do
			Result := internal_selected
		end

	set_selected (a_bool: BOOLEAN)
			-- Set True/False to current grid item, and changed the text.
		do
			if internal_selected /= a_bool then
				internal_selected := a_bool
				if is_parented then
					redraw
				end
				selected_changed_actions.call ([Current])
			end
		end

feature -- Events

	selected_changed_actions: ACTION_SEQUENCE [TUPLE [MA_GRID_CHECK_BOX_ITEM]]
			-- Actions when user clicked the check box.

feature {NONE} -- Implementation

	tree_line_enabled: BOOLEAN
		-- Should a tree line be drawn all the way to the check box.

	handle_pointer_pressed
			-- Handle user press event.
		do
			internal_selected := not internal_selected
			from
				selected_changed_actions.start
			until
				selected_changed_actions.after
			loop
				selected_changed_actions.item.call ([Current])
				selected_changed_actions.forth
			end
		end

	draw_overlay_pixmap (a_drawable: EV_DRAWABLE)
			-- Draw the pixmap which represent whether current is selected.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			if is_selected then
				if parent.has_focus then
					a_drawable.set_foreground_color (parent.focused_selection_color)
				else
					a_drawable.set_foreground_color (parent.non_focused_selection_color)
				end
			else
				if row.background_color = Void then
					a_drawable.set_foreground_color (parent.background_color)
				else
					a_drawable.set_foreground_color (row.background_color)
				end
			end
			a_drawable.fill_rectangle (0, 0, a_drawable.width, a_drawable.height)
			if internal_selected then
				draw_selected (a_drawable)
			else
				draw_unselected (a_drawable)
			end
		end

	draw_selected (a_drawable: EV_DRAWABLE)
			-- Draw the pixmap which is represent current is seleted.
		local
			l_data: like section_data
		do
			if is_selected and then parent.has_focus then
				a_drawable.set_foreground_color (white_color)
			else
				a_drawable.set_foreground_color (black_color)
			end
			draw_unselected (a_drawable)
			a_drawable.set_line_width (check_figure_line_width)
			from
				l_data := section_data
				l_data.start
			until
				l_data.after
			loop
				draw_line_section (l_data.item, a_drawable)
				l_data.forth
			end
		end

	section_data: ARRAYED_LIST [EV_COORDINATE]
			-- Coordinate used to draw a check
		once
			create Result.make (7)
			Result.extend (create{EV_COORDINATE}.make (2, 4))
			Result.extend (create{EV_COORDINATE}.make (3, 5))
			Result.extend (create{EV_COORDINATE}.make (4, 6))
			Result.extend (create{EV_COORDINATE}.make (5, 5))
			Result.extend (create{EV_COORDINATE}.make (6, 4))
			Result.extend (create{EV_COORDINATE}.make (7, 3))
			Result.extend (create{EV_COORDINATE}.make (8, 2))
		ensure
			result_attached: Result /= Void
		end

	draw_line_section (a_coordinate: EV_COORDINATE; a_drawable: EV_DRAWABLE)
			-- Draw line sections to form a check starting from position specified by `a_coordinate'.
		require
			a_coordinate_attached: a_coordinate /= Void
			a_drawable_attached: a_drawable /= Void
		local
			l_start_x, l_start_y: INTEGER
		do
			l_start_x := figure_start_x + 2 - check_box_line_width
			l_start_y := figure_start_y + 2 - check_box_line_width
			a_drawable.draw_segment (l_start_x + a_coordinate.x, l_start_y + a_coordinate.y, l_start_x + a_coordinate.x, l_start_y + a_coordinate.y + 2)
		end

	draw_unselected (a_drawable: EV_DRAWABLE)
			-- Draw the pixmap which is represent current is unseleted.
		do
			if is_selected and then parent.has_focus then
				a_drawable.set_foreground_color (white_color)
			else
				a_drawable.set_foreground_color (black_color)
			end

			if tree_line_enabled then
				-- Draw a tree line up to the start of the check box.
				a_drawable.set_line_width (1)
				a_drawable.draw_segment (0, a_drawable.height // 2, (figure_start_x - tree_line_margin_width).max (0), a_drawable.height // 2)
			end
			a_drawable.set_line_width (check_box_line_width)
			a_drawable.draw_rectangle (figure_start_x, figure_start_y, check_figure_size, check_figure_size)
		end

	figure_start_x: INTEGER
			-- The start x position of the figure.
		do
			Result := ((width - check_figure_size) // 2 - margin_width).max (tree_line_margin_width)
		end

	figure_start_y: INTEGER
			-- The start y position of the figure.
		do
			Result := (height - check_figure_size) // 2
		end

	check_figure_size: INTEGER = 12
			-- The width/height of the check box.

	check_figure_line_width: INTEGER = 1
			-- The line width on the sign figure.

	internal_selected: BOOLEAN
			-- Whether current check box is internal_selected?

	white_color: EV_COLOR
			-- White color
		once
			create Result.make_with_rgb (1, 1, 1)
		end

	black_color: EV_COLOR
			-- Black color
		once
			create Result.make_with_rgb (0, 0, 0)
		end

	margin_width: INTEGER = 3
		-- Space between box and next item

	tree_line_margin_width: INTEGER = 3
		-- Space between tree line and box.

	check_box_line_width: INTEGER
			-- Line width for drawing check box.
		do
			if {PLATFORM}.is_windows then
				Result := 2
			else
				Result := 1
			end
		end

invariant
	selected_changed_actions_not_void: selected_changed_actions /= Void

note
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
