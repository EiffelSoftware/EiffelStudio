indexing
	description:
		"Implementation of widget foreground colors for Windows"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COLORED_FOREGROUND_WINDOWS

inherit
	WEL_COLOR_CONSTANTS

feature 

	foreground_color: COLOR is
			-- Foreground color of current widget
		local
			color_ref: COLOR_IMP
		do
			Result := private_foreground_color
			if Result = Void then
				!! Result.make
				color_ref ?= Result.implementation
				color_ref.make_system (Color_windowtext)
			end
		end

	private_foreground_color: COLOR
			-- Implementation of the foreground color

	set_foreground_color (c: COLOR) is
			-- Set the foreground color of current widget.
		do
			private_foreground_color := c
			if exists then
				invalidate
			end
		end

	update_foreground_color is
			-- Update the foregreound color of current widget.
		do
		end

	invalidate is
			-- Invalidate the window
		deferred
		end

	exists: BOOLEAN is
			-- Does the Widget exist?
		deferred
		end

end -- class COLORED_FOREGROUND_WINDOWS



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

