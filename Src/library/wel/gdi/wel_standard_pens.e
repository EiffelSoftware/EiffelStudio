indexing
	description: "Definition of the sixteen standard pens."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STANDARD_PENS

inherit
	ANY

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
			create Result.make (default_pen_style, default_pen_width,
				white)
		ensure
			result_not_void: Result /= Void
		end

	black_pen: WEL_PEN is
			-- Black pen
		once
			create Result.make (default_pen_style, default_pen_width,
				black)
		ensure
			result_not_void: Result /= Void
		end

	grey_pen: WEL_PEN is
			-- Grey pen
		once
			create Result.make (default_pen_style, default_pen_width,
				grey)
		ensure
			result_not_void: Result /= Void
		end

	dark_grey_pen: WEL_PEN is
			-- Dark grey pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_grey)
		ensure
			result_not_void: Result /= Void
		end

	blue_pen: WEL_PEN is
			-- Blue pen
		once
			create Result.make (default_pen_style, default_pen_width,
				blue)
		ensure
			result_not_void: Result /= Void
		end

	dark_blue_pen: WEL_PEN is
			-- Dark blue pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_blue)
		ensure
			result_not_void: Result /= Void
		end

	cyan_pen: WEL_PEN is
			-- Cyan pen
		once
			create Result.make (default_pen_style, default_pen_width,
				cyan)
		ensure
			result_not_void: Result /= Void
		end

	dark_cyan_pen: WEL_PEN is
			-- Dark cyan pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_cyan)
		ensure
			result_not_void: Result /= Void
		end

	green_pen: WEL_PEN is
			-- Green pen
		once
			create Result.make (default_pen_style, default_pen_width,
				green)
		ensure
			result_not_void: Result /= Void
		end

	dark_green_pen: WEL_PEN is
			-- Dark green pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_green)
		ensure
			result_not_void: Result /= Void
		end

	yellow_pen: WEL_PEN is
			-- Yellow pen
		once
			create Result.make (default_pen_style, default_pen_width,
				yellow)
		ensure
			result_not_void: Result /= Void
		end

	dark_yellow_pen: WEL_PEN is
			-- Dark yellow pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_yellow)
		ensure
			result_not_void: Result /= Void
		end

	red_pen: WEL_PEN is
			-- Red pen
		once
			create Result.make (default_pen_style, default_pen_width,
				red)
		ensure
			result_not_void: Result /= Void
		end

	dark_red_pen: WEL_PEN is
			-- Dark red pen
		once
			create Result.make (default_pen_style, default_pen_width,
				dark_red)
		ensure
			result_not_void: Result /= Void
		end

	magenta_pen: WEL_PEN is
			-- Magenta pen
		once
			create Result.make (default_pen_style, default_pen_width,
				magenta)
		ensure
			result_not_void: Result /= Void
		end

	dark_magenta_pen: WEL_PEN is
			-- Dark magenta pen
		once
			create Result.make (default_pen_style, default_pen_width,
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




end -- class WEL_STANDARD_PENS

