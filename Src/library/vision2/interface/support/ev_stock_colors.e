indexing
	description:
		"Facilities for accessing standardized colors."
	keywords: "color, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS

feature -- Access

	White: EV_COLOR is
			-- White.
		once
			create Result.make_with_rgb (1, 1, 1)
		end

	Black: EV_COLOR is
			-- Black.
		once
			create Result.make_with_rgb (0, 0, 0)
		end

	Grey, Gray: EV_COLOR is
			-- Grey.
		once
			create Result.make_with_rgb (0.7, 0.7, 0.7)
		end

	Dark_grey, Dark_gray: EV_COLOR is
			-- Dark grey.
		once
			create Result.make_with_rgb (0.5, 0.5, 0.5)
		end

	Blue: EV_COLOR is
			-- Blue.
		once
			create Result.make_with_rgb (0, 0, 1)
		end

	Dark_blue: EV_COLOR is
			-- Dark blue.
		once
			create Result.make_with_rgb (0, 0, 0.5)
		end

	Cyan: EV_COLOR is
			-- Cyan.
		once
			create Result.make_with_rgb (0, 1, 1)
		end

	Dark_cyan: EV_COLOR is
			-- Dark cyan.
		once
			create Result.make_with_rgb (0, 0.5, 0.5)
		end

	Green: EV_COLOR is
			-- Green.
		once
			create Result.make_with_rgb (0, 1, 0)
		end

	Dark_green: EV_COLOR is
			-- Dark green.
		once
			create Result.make_with_rgb (0, 0.5, 0)
		end

	Yellow: EV_COLOR is
			-- Yellow.
		once
			create Result.make_with_rgb (1, 1, 0)
		end

	Dark_yellow: EV_COLOR is
			-- Dark yellow.
		once
			create Result.make_with_rgb (0.5, 0.5, 0)
		end

	Red: EV_COLOR is
			-- Red.
		once
			create Result.make_with_rgb (1, 0, 0)
		end

	Dark_red: EV_COLOR is
			-- Dark red.
		once
			create Result.make_with_rgb (0.5, 0, 0)
		end

	Magenta: EV_COLOR is
			-- Magenta.
		once
			create Result.make_with_rgb (1, 0, 1)
		end

	Dark_magenta: EV_COLOR is
			-- Dark magenta.
		once
			create Result.make_with_rgb (0.5, 0, 0.5)
		end

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Used for dialog box background.
			-- Name: "color dialog".
		once
			Result := implementation.Color_3d_face
		end

	Color_3d_highlight: EV_COLOR is
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		once
			Result := implementation.Color_3d_highlight
		end

	Color_3d_shadow: EV_COLOR is
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		once
			Result := implementation.Color_3d_shadow
		end

	Color_read_only: EV_COLOR is
			-- Used for background of editable when read-only.
			-- Name: "color read only".
		once
			Result := implementation.Color_read_only
		end

	Color_read_write: EV_COLOR is
			-- Used for background of editable when write/write enabled.
			-- Name: "color read write".
		once
			Result := implementation.Color_read_write
		end

	Default_background_color: EV_COLOR is
			-- Used for background of most widgets.
			-- Name: "default background".
		once
			Result := implementation.default_background_color
		end

	Default_foreground_color: EV_COLOR is
			-- Used for foreground of most widgets.
			-- Name: "default foreground".
		once
			Result := implementation.default_foreground_color
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

	implementation: EV_STOCK_COLORS_IMP is
			-- Responsible for interaction with native graphics toolkit.
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

end -- class EV_STOCK_COLORS

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

