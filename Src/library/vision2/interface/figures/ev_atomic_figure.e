indexing
	description:
		"A figure that has no childs."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ATOMIC_FIGURE

inherit
	EV_FIGURE
		redefine
			default_create
		select
			out
		end

	EV_DRAWABLE_CONSTANTS
		undefine
			default_create,
			out
		end

	EV_TESTABLE_NON_WIDGET
		undefine
			default_create,
			out
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with default attributes.
		do
			create foreground_color.make_with_rgb (0, 0, 0)
			line_width := 1
			logical_function_mode := Ev_drawing_mode_copy
			{EV_FIGURE} Precursor
		end

	make_for_test is
			-- Create interesting.
		do
			default_create
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				random_real / 2 + 0.5,
				random_real / 2 + 0.5,
				random_real / 2 + 0.5))
			set_line_width (random_from_range (1, 8))
			set_random_values_for_points
		end

feature -- Access

	foreground_color: EV_COLOR
			-- The color of text, lines, etc.

	line_width: INTEGER
			-- The width in pixels of the line, when a line is drawn.

	logical_function_mode: INTEGER
			-- Logical function to be used in Graphic Context.

feature -- Status setting

	set_foreground_color (color: EV_COLOR) is
			-- Set line/text-color to `color'.
		require
			color_exists: color /= Void
		do
			foreground_color := color
		end

	set_line_width (width: INTEGER) is
			-- Set line-width to `width'.
		require
			width_non_negative: width >= 0
		do
			line_width := width
		end

	set_logical_function_mode (mode: INTEGER) is
			-- Set line-width to `width'.
		require
			mode_valid: mode >= 0 and then mode <= 15
		do
			logical_function_mode := mode
		end

feature -- Miscellaneous

	test_widget: EV_WIDGET is
			-- Pixmap displaying `Current'.
		local
			p: EV_PIXMAP
			a_world: EV_FIGURE_WORLD
			a_projector: EV_STANDARD_PROJECTION
			n: INTEGER
		do
			create p.make_with_size (300, 100)
			create a_world
			a_world.extend (Current)
			create a_projector.make (a_world, p)
			a_projector.project
			p.set_foreground_color (create {EV_COLOR}.make_with_rgb (0.7, 0.7, 0.7))
			p.set_font (create {EV_FONT})
			from n := 1 until n > point_count loop
				p.draw_text (3, n * 12 + 3,
					"(" + get_point_by_index (n).x_abs.out +
					", " + get_point_by_index (n).y_abs.out + ")")
				n := n + 1
			end
			Result := p
		end

feature {NONE} -- Implementation

	set_random_values_for_points is
			-- Set all points to have random values for testing purposes.
		local
			n: INTEGER
		do
			from n := 1 until n > point_count loop
				get_point_by_index (n).set_x (random_from_range (3, 297))
				get_point_by_index (n).set_y (random_from_range (3, 97))
				n := n + 1
			end
		end

	random_from_range (a_min, a_max: INTEGER): INTEGER is
			-- Any integer between `a_min', `a_max'.
		do
			random.forth
			Result := (random.real_item * (a_max - a_min)).rounded + a_min
		end

	random_real: DOUBLE is
			-- Double value in range [0, 1].
		do
			random.forth
			Result := random.real_item
		end

	random: RANDOM is
			-- Generator.
		once
			create Result.make
		end

invariant
	foreground_color_exists: foreground_color /= Void
	line_width_non_negative: line_width >= 0

end -- class EV_ATOMIC_FIGURE
