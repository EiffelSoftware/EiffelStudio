note
	description:
		"Implementation of widget foreground colors for Windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COLORED_FOREGROUND_WINDOWS

inherit
	WEL_COLOR_CONSTANTS

feature 

	foreground_color: COLOR
			-- Foreground color of current widget
		local
			color_ref: COLOR_IMP
		do
			Result := private_foreground_color
			if Result = Void then
				create Result.make
				color_ref ?= Result.implementation
				color_ref.make_system (Color_windowtext)
			end
		end

	private_foreground_color: COLOR
			-- Implementation of the foreground color

	set_foreground_color (c: COLOR)
			-- Set the foreground color of current widget.
		do
			private_foreground_color := c
			if exists then
				invalidate
			end
		end

	update_foreground_color
			-- Update the foregreound color of current widget.
		do
		end

	invalidate
			-- Invalidate the window
		deferred
		end

	exists: BOOLEAN
			-- Does the Widget exist?
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COLORED_FOREGROUND_WINDOWS

