indexing
	description: "Objects that represent a world of figures.%
		%It is up to the projection object what to do with it."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_WORLD

inherit
	EV_FIGURE_GROUP
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Create with a white background.
		do
			Precursor
			create background_color.make_rgb (255, 255, 255)
		end

feature -- Access

	background_color: EV_COLOR
			-- The color used to clear the drawing device.

invariant
	background_color_exists: background_color /= Void

end -- class EV_FIGURE_WORLD
