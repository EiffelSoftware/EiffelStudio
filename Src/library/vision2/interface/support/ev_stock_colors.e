indexing
	description:
		"Facilities for accessing standardized colors."
	keywords: "color, default"
	date: "$Date$"
	revision: "$Revision$"

--| FIXME these comments sound a bit silly IMHO. - sam

class
	EV_DEFAULT_COLORS

feature -- Access

	White: EV_COLOR is
			-- White color named "white"
		once
			create Result.make_with_rgb (1, 1, 1)
			Result.set_name ("white")
		end

	Black: EV_COLOR is
			-- Black color named "black"
		once
			create Result.make_with_rgb (0, 0, 0)
			Result.set_name ("black")
		end

	Grey, Gray: EV_COLOR is
			-- Grey color named "grey"
		once
			create Result.make_with_rgb (0.7, 0.7, 0.7)
			Result.set_name ("grey")
		end

	Dark_grey, Dark_gray: EV_COLOR is
			-- Dark grey color named "dark grey"
		once
			create Result.make_with_rgb (0.5, 0.5, 0.5)
			Result.set_name ("dark grey")
		end

	Blue: EV_COLOR is
			-- Blue color named "blue"
		once
			create Result.make_with_rgb (0, 0, 1)
			Result.set_name ("blue")
		end

	Dark_blue: EV_COLOR is
			-- Dark blue color named "dark blue"
		once
			create Result.make_with_rgb (0, 0, 0.5)
			Result.set_name ("dark blue")
		end

	Cyan: EV_COLOR is
			-- Cyan color named "cyan"
		once
			create Result.make_with_rgb (0, 1, 1)
			Result.set_name ("cyan")
		end

	Dark_cyan: EV_COLOR is
			-- Dark cyan color named "dark cyan"
		once
			create Result.make_with_rgb (0, 0.5, 0.5)
			Result.set_name ("dark cyan")
		end

	Green: EV_COLOR is
			-- Green color named "green"
		once
			create Result.make_with_rgb (0, 1, 0)
			Result.set_name ("green")
		end

	Dark_green: EV_COLOR is
			-- Dark green color named "dark green"
		once
			create Result.make_with_rgb (0, 0.5, 0)
			Result.set_name ("dark green")
		end

	Yellow: EV_COLOR is
			-- Yellow color named "yellow"
		once
			create Result.make_with_rgb (1, 1, 0)
			Result.set_name ("yellow")
		end

	Dark_yellow: EV_COLOR is
			-- Dark yellow color named "dark yellow"
		once
			create Result.make_with_rgb (0.5, 0.5, 0)
			Result.set_name ("dark yellow")
		end

	Red: EV_COLOR is
			-- Red color named "red"
		once
			create Result.make_with_rgb (1, 0, 0)
			Result.set_name ("red")
		end

	Dark_red: EV_COLOR is
			-- Dark red color named "dark red"
		once
			create Result.make_with_rgb (0.5, 0, 0)
			Result.set_name ("dark red")
		end

	Magenta: EV_COLOR is
			-- Magenta color named "magenta"
		once
			create Result.make_with_rgb (1, 0, 1)
			Result.set_name ("magenta")
		end

	Dark_magenta: EV_COLOR is
			-- Dark magenta color named "dark magenta"
		once
			create Result.make_with_rgb (0.5, 0, 0.5)
			Result.set_name ("dark magenta")
		end

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Used for dialog box background.
			-- Name: "color dialog".
		do
			Result := default_color_imp.Color_3d_face
			Result.set_name ("color dialog")
		end

	Color_3d_highlight: EV_COLOR is
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		do
			Result := default_color_imp.Color_3d_highlight
			Result.set_name ("color highlight")
		end

	Color_3d_shadow: EV_COLOR is
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		do
			Result := default_color_imp.Color_3d_shadow
			Result.set_name ("color shadow")
		end

	Color_read_only: EV_COLOR is
			-- Used for background of editable when read-only.
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
			Result.force (Gray)
			Result.force (Grey)
			Result.force (Dark_gray)
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
		end

feature {NONE} -- Implementation

	default_color_imp: EV_DEFAULT_COLORS_IMP is
			-- Responsible for interaction with the native graphics toolkit.
		once
			create Result
		end

invariant
	White_not_void: White /= Void
	Black_not_void:  Black /= Void
	Grey_not_void:  Grey /= Void
	Gray_not_void:  Gray /= Void
	Dark_grey_not_void:  Dark_grey /= Void
	Dark_gray_not_void:  Dark_gray /= Void
	Blue_not_void:  Blue /= Void
	Dark_blue_not_void:  Dark_blue /= Void
	Cyan_not_void:  Cyan /= Void
	Dark_cyan_not_void:  Dark_cyan /= Void
	Green_not_void:  Green /= Void
	Dark_green_not_void:  Dark_green /= Void
	Yellow_not_void:  Yellow /= Void
	Dark_yellow_not_void:  Dark_yellow /= Void
	Red_not_void:  Red /= Void
	Dark_red_not_void:  Dark_red /= Void
	Magenta_not_void:  Magenta /= Void
	Dark_magenta_not_void:  Dark_magenta /= Void
	Color_dialog_not_void:  Color_dialog /= Void
	Color_read_only_not_void:  Color_read_only /= Void
	Color_read_write_not_void:  Color_read_write /= Void
	Default_background_color_not_void:  Default_background_color /= Void
	Default_foreground_color_not_void:  Default_foreground_color /= Void
	All_colors_not_void:  All_colors /= Void
	All_colors_count_is_sixteen: All_colors.count = 18

end -- class EV_DEFAULT_COLORS

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/06/07 17:28:08  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.11  2000/05/12 19:27:28  pichery
--| Added colors `Color_3d_face', `Color_3d_highlight',
--| `Color_3d_shadow'.
--|
--| Revision 1.6.4.2  2000/05/13 03:29:40  pichery
--| Added new colors
--|
--| Revision 1.6.4.1  2000/05/03 19:10:04  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.9  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
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
