indexing
	description: "Button displaying a color"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COLOR_BUTTON

inherit
	EV_BUTTON

creation
	make,
	make_with_color

feature {NONE} -- Initialization

	make_with_color (par: EV_CONTAINER; a_color: EV_COLOR) is
		do
			make (par)
			set_color (a_color)
		end

feature -- Access

	color: EV_COLOR is
			-- color displayed by Current
		do
			Result := background_color
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- sets color according to a_color
		require
			a_color_non_void: a_color /= Void
		do
			set_background_color (a_color)
		ensure
			set: color = a_color
		end

end -- class EB_COLOR_BUTTON
