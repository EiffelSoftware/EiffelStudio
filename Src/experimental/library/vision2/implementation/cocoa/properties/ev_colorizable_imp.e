note
	description: "Eiffel Vision colorizable. Cocoa implementation."
	author: "Daniel Furrer"
	keywords: "colorizable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLORIZABLE_IMP

inherit
	EV_COLORIZABLE_I
		redefine
			set_default_colors
		end

feature -- Access

	background_color_internal: EV_COLOR
			-- Color of face.
		do
			if attached background_color_imp as imp and then attached imp.interface as color then
				Result := color
			else
				create Result
			end
		end

	foreground_color_internal: EV_COLOR
			-- Color of foreground features like text.
		do
			if attached foreground_color_imp as imp and then attached imp.interface as color then
				Result := color
			else
				create Result
			end
		end

feature -- Status setting


	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			background_color_imp ?= a_color.implementation
			check
				background_color_imp /= Void
			end
		end

	real_set_background_color (a_c_object: POINTER; a_color: EV_COLOR)
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
		do

		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			foreground_color_imp ?= a_color.implementation
			check
				foreground_color_imp /= Void
			end
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: EV_COLOR)
			-- Implementation of `set_foreground_color'
		do
		end


	set_default_colors
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
		end

feature {NONE} -- Implementation

	background_color_imp: detachable EV_COLOR_IMP
		-- Color used for the background of `Current'

	foreground_color_imp: detachable EV_COLOR_IMP
		-- Color used for the foreground of `Current'

	Prelight_scale: REAL = 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL = 0.90912397
		-- Highlight color is this much darker than `background_color'.

end -- EV_COLORIZABLE_IMP
