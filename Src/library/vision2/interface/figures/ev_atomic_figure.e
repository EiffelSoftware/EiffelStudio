indexing
	description: "A figure that has no childs."
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

feature {NONE} -- Initialization

	default_create is
			-- Create with default attributes.
		do
			create foreground_color.make_with_rgb (0, 0, 0)
			line_width := 1
			logical_function_mode := Ev_drawing_mode_copy
			{EV_FIGURE} Precursor
		end

feature -- Access

	foreground_color: EV_COLOR
			-- The color of text, lines, etc.

	line_width: INTEGER
			-- The width in pixels of the line, when a line is drawn.

	logical_function_mode: INTEGER
			-- Logical function to be used in Graphic Context.
			--| FIXME Get those constants in this class, maybe?????

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

invariant
	foreground_color_exists: foreground_color /= Void
	line_width_non_negative: line_width >= 0

end -- class EV_ATOMIC_FIGURE
