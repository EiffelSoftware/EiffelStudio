indexing
	description:
		"Figures that cannot contain other figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_ATOMIC_FIGURE

