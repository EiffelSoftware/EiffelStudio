indexing
	description:
		"Closed figures filled with `background_color'."
	status: "See notice at end of class"
	keywords: "figure, atomic, filled, closed"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLOSED_FIGURE

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with default attributes.
		do
			set_background_color (Default_colors.Yellow)
			Precursor
		end

feature -- Access

	background_color: EV_COLOR
			-- Color used to fill `Current'.

feature -- Status report

	is_filled: BOOLEAN is
			-- Is this figure filled?
		do
			Result := background_color /= Void
		end

feature -- Status setting

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' to `a_color'.
		require
			a_color_exists: a_color /= Void
		do
			background_color := a_color
			invalidate
		ensure
			background_color_assigned: background_color = a_color
		end

	remove_background_color is
			-- Do not fill this figure.
		do
			background_color := Void
			invalidate
		ensure
			background_color_removed: background_color = Void
		end

end -- class EV_CLOSED_FIGURE

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
