indexing
	description: "Closed figures (ellipse, polygon).%
		%May be filled with a color."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLOSED_FIGURE

inherit
	EV_ATOMIC_FIGURE

feature -- Access

	fill_color: EV_COLOR
			-- The background color of the figure.
			-- If it is Void do not fill the figure.

	fill_style: INTEGER
			-- There is something like fill-style too...
			--| FIXME To be implemented

feature -- Status setting

	set_fill_color (color: EV_COLOR) is
			-- Set fill-color to `color'.
		require
			color_exists: color /= Void
		do
			fill_color := color
		end

	remove_fill_color is
			-- Do not fill this figure.
		do
			fill_color := Void
		end

end -- class EV_CLOSED_FIGURE
