indexing
	description:
		"Eiffel Vision default colors. Standard GUI drawing colors."
	keywords: "color, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS

feature -- Access

	White: EV_COLOR is
			-- White color named "white"
		once
			create Result.make_with_rgb (1, 1, 1)
			Result.set_name ("white")
		ensure
			valid_result: Result /= Void
		end

	Black: EV_COLOR is
			-- Black color named "black"
		once
			create Result.make_with_rgb (0, 0, 0)
			Result.set_name ("black")
		ensure
			valid_result: Result /= Void
		end

	Grey: EV_COLOR is
			-- Grey color named "grey"
		once
			create Result.make_with_rgb (0.7, 0.7, 0.7)
			Result.set_name ("grey")
		ensure
			valid_result: Result /= Void
		end

	Dark_grey: EV_COLOR is
			-- Dark grey color named "dark grey"
		once
			create Result.make_with_rgb (0.5, 0.5, 0.5)
			Result.set_name ("dark grey")
		ensure
			valid_result: Result /= Void
		end

	Blue: EV_COLOR is
			-- Blue color named "blue"
		once
			create Result.make_with_rgb (0, 0, 1)
			Result.set_name ("blue")
		ensure
			valid_result: Result /= Void
		end

	Dark_blue: EV_COLOR is
			-- Dark blue color named "dark blue"
		once
			create Result.make_with_rgb (0, 0, 0.5)
			Result.set_name ("dark blue")
		ensure
			valid_result: Result /= Void
		end

	Cyan: EV_COLOR is
			-- Cyan color named "cyan"
		once
			create Result.make_with_rgb (0, 1, 1)
			Result.set_name ("cyan")
		ensure
			valid_result: Result /= Void
		end

	Dark_cyan: EV_COLOR is
			-- Dark cyan color named "dark cyan"
		once
			create Result.make_with_rgb (0, 0.5, 0.5)
			Result.set_name ("dark cyan")
		ensure
			valid_result: Result /= Void
		end

	Green: EV_COLOR is
			-- Green color named "green"
		once
			create Result.make_with_rgb (0, 1, 0)
			Result.set_name ("green")
		ensure
			valid_result: Result /= Void
		end

	Dark_green: EV_COLOR is
			-- Dark green color named "dark green"
		once
			create Result.make_with_rgb (0, 0.5, 0)
			Result.set_name ("dark green")
		ensure
			valid_result: Result /= Void
		end

	Yellow: EV_COLOR is
			-- Yellow color named "yellow"
		once
			create Result.make_with_rgb (1, 1, 0)
			Result.set_name ("yellow")
		ensure
			valid_result: Result /= Void
		end

	Dark_yellow: EV_COLOR is
			-- Dark yellow color named "dark yellow"
		once
			create Result.make_with_rgb (0.5, 0.5, 0)
			Result.set_name ("dark yellow")
		ensure
			valid_result: Result /= Void
		end

	Red: EV_COLOR is
			-- Red color named "red"
		once
			create Result.make_with_rgb (1, 0, 0)
			Result.set_name ("red")
		ensure
			valid_result: Result /= Void
		end

	Dark_red: EV_COLOR is
			-- Dark red color named "dark red"
		once
			create Result.make_with_rgb (0.5, 0, 0)
			Result.set_name ("dark red")
		ensure
			valid_result: Result /= Void
		end

	Magenta: EV_COLOR is
			-- Magenta color named "magenta"
		once
			create Result.make_with_rgb (1, 0, 1)
			Result.set_name ("magenta")
		ensure
			valid_result: Result /= Void
		end

	Dark_magenta: EV_COLOR is
			-- Dark magenta color named "dark magenta"
		once
			create Result.make_with_rgb (0.5, 0, 0.5)
			Result.set_name ("dark magenta")
		ensure
			valid_result: Result /= Void
		end

feature -- Access

	Color_dialog: EV_COLOR is
			-- Used for dialog box background.
			-- Name: "color dialog".
		do
			Result := default_color_imp.Color_dialog
			Result.set_name ("color dialog")
		end

	Color_read_only: EV_COLOR is
			-- Used background of editable when read-only.
			-- Name: "color read only".
		do
			Result := default_color_imp.Color_read_only
			Result.set_name ("color read only")
		end

	Color_read_write: EV_COLOR is
			-- Used for background of editable when write/write enabled.
			-- Name: "color read write".
		do
			Result := default_color_imp.Color_read_write
			Result.set_name ("color read write")
		end

	Default_background_color: EV_COLOR is
			-- Used for background of most widgets.
			-- Name: "default background".
		do
			Result := default_color_imp.default_background_color
			Result.set_name ("default background")
		end

	Default_foreground_color: EV_COLOR is
			-- Used for foreground of most widgets.
			-- Name: "default foreground".
		do
			Result := default_color_imp.default_foreground_color
			Result.set_name ("default foreground")
		end

feature -- Basic operations

	All_colors: LINKED_LIST [EV_COLOR] is
			-- A list of all the basic colors.
		once
			create Result.make
			Result.force (White)
			Result.force (Black)
			Result.force (Grey)
			Result.force (Dark_grey)
			Result.force (Blue)
			Result.force (Dark_blue)
			Result.force (Cyan)
			Result.force (Dark_cyan)
			Result.force (Green)
			Result.force (Dark_green)
			Result.force (Yellow)
			Result.force (Dark_yellow)
			Result.force (Red)
			Result.force (Dark_red)
			Result.force (Magenta)
			Result.force (Dark_magenta)
		ensure
			count_equals_sixteen: Result.count = 16
		end

feature {NONE} -- Implementation

	default_color_imp: EV_DEFAULT_COLORS_IMP is
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.
		once
			create Result
		end

end -- class EV_DEFAULT_COLORS

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/18 17:22:38  brendel
--| Merged EV_BASIC_COLORS into this class, making EV_BASIC_COLORS obsolete.
--|
--| Revision 1.7  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.6.6.4  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.3  2000/01/19 18:18:20  oconnor
--| comments
--|
--| Revision 1.6.6.2  2000/01/19 18:10:32  oconnor
--| comments, formatting
--|
--| Revision 1.6.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
