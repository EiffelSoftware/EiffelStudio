--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "List of default colors used by the system."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BASIC_COLORS

feature -- Access

	white: EV_COLOR is
			-- White color named "white"
		once
			create Result.make_with_rgb (1, 1, 1)
			Result.set_name ("white")
		ensure
			valid_result: Result /= Void
		end

	black: EV_COLOR is
			-- Black color named "black"
		once
			create Result.make_with_rgb (0, 0, 0)
			Result.set_name ("black")
		ensure
			valid_result: Result /= Void
		end

	grey: EV_COLOR is
			-- Grey color named "grey"
		once
			create Result.make_with_rgb (0.7, 0.7, 0.7)
			Result.set_name ("grey")
		ensure
			valid_result: Result /= Void
		end

	dark_grey: EV_COLOR is
			-- Dark grey color named "dark grey"
		once
			create Result.make_with_rgb (0.5, 0.5, 0.5)
			Result.set_name ("dark grey")
		ensure
			valid_result: Result /= Void
		end

	blue: EV_COLOR is
			-- Blue color named "blue"
		once
			create Result.make_with_rgb (0, 0, 1)
			Result.set_name ("blue")
		ensure
			valid_result: Result /= Void
		end

	dark_blue: EV_COLOR is
			-- Dark blue color named "dark blue"
		once
			create Result.make_with_rgb (0, 0, 0.5)
			Result.set_name ("dark blue")
		ensure
			valid_result: Result /= Void
		end

	cyan: EV_COLOR is
			-- Cyan color named "cyan"
		once
			create Result.make_with_rgb (0, 1, 1)
			Result.set_name ("cyan")
		ensure
			valid_result: Result /= Void
		end

	dark_cyan: EV_COLOR is
			-- Dark cyan color named "dark cyan"
		once
			create Result.make_with_rgb (0, 0.5, 0.5)
			Result.set_name ("dark cyan")
		ensure
			valid_result: Result /= Void
		end

	green: EV_COLOR is
			-- Green color named "green"
		once
			create Result.make_with_rgb (0, 1, 0)
			Result.set_name ("green")
		ensure
			valid_result: Result /= Void
		end

	dark_green: EV_COLOR is
			-- Dark green color named "dark green"
		once
			create Result.make_with_rgb (0, 0.5, 0)
			Result.set_name ("dark green")
		ensure
			valid_result: Result /= Void
		end

	yellow: EV_COLOR is
			-- Yellow color named "yellow"
		once
			create Result.make_with_rgb (1, 1, 0)
			Result.set_name ("yellow")
		ensure
			valid_result: Result /= Void
		end

	dark_yellow: EV_COLOR is
			-- Dark yellow color named "dark yellow"
		once
			create Result.make_with_rgb (0.5, 0.5, 0)
			Result.set_name ("dark yellow")
		ensure
			valid_result: Result /= Void
		end

	red: EV_COLOR is
			-- Red color named "red"
		once
			create Result.make_with_rgb (1, 0, 0)
			Result.set_name ("red")
		ensure
			valid_result: Result /= Void
		end

	dark_red: EV_COLOR is
			-- Dark red color named "dark red"
		once
			create Result.make_with_rgb (0.5, 0, 0)
			Result.set_name ("dark red")
		ensure
			valid_result: Result /= Void
		end

	magenta: EV_COLOR is
			-- Magenta color named "magenta"
		once
			create Result.make_with_rgb (1, 0, 1)
			Result.set_name ("magenta")
		ensure
			valid_result: Result /= Void
		end

	dark_magenta: EV_COLOR is
			-- Dark magenta color named "dark magenta"
		once
			create Result.make_with_rgb (0.5, 0, 0.5)
			Result.set_name ("dark magenta")
		ensure
			valid_result: Result /= Void
		end

feature -- Basic operations

	all_colors: LINKED_LIST [EV_COLOR] is
			-- A list of all the basic colors.
		do
			create Result.make
			Result.force (white)
			Result.force (black)
			Result.force (grey)
			Result.force (dark_grey)
			Result.force (blue)
			Result.force (dark_blue)
			Result.force (cyan)
			Result.force (dark_cyan)
			Result.force (green)
			Result.force (dark_green)
			Result.force (yellow)
			Result.force (dark_yellow)
			Result.force (red)
			Result.force (dark_red)
			Result.force (magenta)
			Result.force (dark_magenta)
		ensure
			good_count: Result.count = 16
		end

end -- class EV_BASIC_COLORS

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/02/05 05:58:47  oconnor
--| use new color class
--|
--| Revision 1.4.6.3  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.4.6.2  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
