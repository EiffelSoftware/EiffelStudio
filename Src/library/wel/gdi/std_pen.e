indexing
	description: "Definition of the sixteen standard pens."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STANDARD_PENS

inherit
	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	white_pen: WEL_PEN is
			-- White pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				white)
		ensure
			result_not_void: Result /= Void
		end

	black_pen: WEL_PEN is
			-- Black pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				black)
		ensure
			result_not_void: Result /= Void
		end

	grey_pen: WEL_PEN is
			-- Grey pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				grey)
		ensure
			result_not_void: Result /= Void
		end

	dark_grey_pen: WEL_PEN is
			-- Dark grey pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_grey)
		ensure
			result_not_void: Result /= Void
		end

	blue_pen: WEL_PEN is
			-- Blue pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				blue)
		ensure
			result_not_void: Result /= Void
		end

	dark_blue_pen: WEL_PEN is
			-- Dark blue pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_blue)
		ensure
			result_not_void: Result /= Void
		end

	cyan_pen: WEL_PEN is
			-- Cyan pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				cyan)
		ensure
			result_not_void: Result /= Void
		end

	dark_cyan_pen: WEL_PEN is
			-- Dark cyan pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_cyan)
		ensure
			result_not_void: Result /= Void
		end

	green_pen: WEL_PEN is
			-- Green pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				green)
		ensure
			result_not_void: Result /= Void
		end

	dark_green_pen: WEL_PEN is
			-- Dark green pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_green)
		ensure
			result_not_void: Result /= Void
		end

	yellow_pen: WEL_PEN is
			-- Yellow pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				yellow)
		ensure
			result_not_void: Result /= Void
		end

	dark_yellow_pen: WEL_PEN is
			-- Dark yellow pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_yellow)
		ensure
			result_not_void: Result /= Void
		end

	red_pen: WEL_PEN is
			-- Red pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				red)
		ensure
			result_not_void: Result /= Void
		end

	dark_red_pen: WEL_PEN is
			-- Dark red pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_red)
		ensure
			result_not_void: Result /= Void
		end

	magenta_pen: WEL_PEN is
			-- Magenta pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				magenta)
		ensure
			result_not_void: Result /= Void
		end

	dark_magenta_pen: WEL_PEN is
			-- Dark magenta pen
		once
			!! Result.make (default_pen_style, default_pen_width,
				dark_magenta)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Access

	default_pen_width: INTEGER is
			-- Default pen width used to create the pens.
		once
			Result := 1
		ensure
			positive_result: Result >= 0
		end

	default_pen_style: INTEGER is
			-- Default pen style used to create the pens.
		once
			Result := Ps_solid
		end

end -- class WEL_STANDARD_PENS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
