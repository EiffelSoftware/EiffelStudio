indexing
	description: "Recktangle for feedback drawing on Unix."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_RECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			create screen
			screen.set_default_colors
			screen.set_line_width (border_width)
		end

feature -- Access

	width: INTEGER
		-- Width

	height: INTEGER
		-- Height

	x_position: INTEGER
		-- x_position on the screen

	y_position: INTEGER
		-- y_positon on the screen

feature -- Drawing

	show is
			-- Show.
		do
			screen.set_invert_mode
			screen.draw_rectangle (x_position, y_position, width, height)
		end

	clear is
			-- Clear.
		do
			screen.set_invert_mode
			screen.draw_rectangle (x_position, y_position, width, height)
		end

feature -- Element change.

	set_color (a_color: EV_COLOR) is
			-- Do nothing.
		do
		end

	set_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set `width' with `a_width'.
			-- Set `height' with `a_height'.
		require
			a_width_not_negtive: a_width >= 0
			a_height_not_negtive: a_height >= 0
		do
			clear
			width := a_width
			height := a_height
			show
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		require
			a_width_not_negtive: a_width >= 0
		do
			clear
			width := a_width
			show
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'.
		require
			a_height_not_negtive: a_height >= 0
		do
			clear
			height := a_height
			show
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set `x_position' with `a_x'
			-- Set `y_position' with `a_y'
		do
			clear
			x_position := a_x
			y_position := a_y
			show
		end

feature {NONE} -- Implementation

	screen: EV_SCREEN
		-- Screen

	border_width: INTEGER is 2
		-- Border width

end

