indexing
	description:
		"Figures that cannot contain other figures."
	status: "See notice at end of class"
	keywords: "figure, atomic"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ATOMIC_FIGURE

inherit
	EV_FIGURE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with default attributes.
		do
			Precursor {EV_FIGURE}
			set_foreground_color (Default_colors.Black)
			line_width := 1
		end

feature -- Access

	foreground_color: EV_COLOR
			-- Color of text, lines, etc.

	line_width: INTEGER
			-- Thickness of lines.

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?

feature -- Status setting

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		do
			foreground_color := a_color
			invalidate
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		require
			a_width_non_negative: a_width >= 0
		do
			line_width := a_width
			invalidate
		ensure
			line_width_assigned: line_width = a_width
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			dashed_line_style := True
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			dashed_line_style := False
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end
		
invariant
	foreground_color_exists: foreground_color /= Void
	line_width_non_negative: line_width >= 0

end -- class EV_ATOMIC_FIGURE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
