indexing
	description: "List of default colors used by the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BASIC_COLORS

feature -- Access

	white: EV_COLOR is
			-- White color named "white"
		once
			!! Result.make_rgb (255, 255, 255)
			Result.set_name ("white")
		ensure
			valid_result: Result /= Void
		end

	black: EV_COLOR is
			-- Black color named "black"
		once
			!! Result.make_rgb (0, 0, 0)
			Result.set_name ("black")
		ensure
			valid_result: Result /= Void
		end

	grey: EV_COLOR is
			-- Grey color named "grey"
		once
			!! Result.make_rgb (192, 192, 192)
			Result.set_name ("grey")
		ensure
			valid_result: Result /= Void
		end

	dark_grey: EV_COLOR is
			-- Dark grey color named "dark grey"
		once
			!! Result.make_rgb (128, 128, 128)
			Result.set_name ("dark grey")
		ensure
			valid_result: Result /= Void
		end

	blue: EV_COLOR is
			-- Blue color named "blue"
		once
			!! Result.make_rgb (0, 0, 255)
			Result.set_name ("blue")
		ensure
			valid_result: Result /= Void
		end

	dark_blue: EV_COLOR is
			-- Dark blue color named "dark blue"
		once
			!! Result.make_rgb (0, 0, 128)
			Result.set_name ("dark blue")
		ensure
			valid_result: Result /= Void
		end

	cyan: EV_COLOR is
			-- Cyan color named "cyan"
		once
			!! Result.make_rgb (0, 255, 255)
			Result.set_name ("cyan")
		ensure
			valid_result: Result /= Void
		end

	dark_cyan: EV_COLOR is
			-- Dark cyan color named "dark cyan"
		once
			!! Result.make_rgb (0, 128, 128)
			Result.set_name ("dark cyan")
		ensure
			valid_result: Result /= Void
		end

	green: EV_COLOR is
			-- Green color named "green"
		once
			!! Result.make_rgb (0, 255, 0)
			Result.set_name ("green")
		ensure
			valid_result: Result /= Void
		end

	dark_green: EV_COLOR is
			-- Dark green color named "dark green"
		once
			!! Result.make_rgb (0, 128, 0)
			Result.set_name ("dark green")
		ensure
			valid_result: Result /= Void
		end

	yellow: EV_COLOR is
			-- Yellow color named "yellow"
		once
			!! Result.make_rgb (255, 255, 0)
			Result.set_name ("yellow")
		ensure
			valid_result: Result /= Void
		end

	dark_yellow: EV_COLOR is
			-- Dark yellow color named "dark yellow"
		once
			!! Result.make_rgb (128, 128, 0)
			Result.set_name ("dark yellow")
		ensure
			valid_result: Result /= Void
		end

	red: EV_COLOR is
			-- Red color named "red"
		once
			!! Result.make_rgb (255, 0, 0)
			Result.set_name ("red")
		ensure
			valid_result: Result /= Void
		end

	dark_red: EV_COLOR is
			-- Dark red color named "dark red"
		once
			!! Result.make_rgb (128, 0, 0)
			Result.set_name ("dark red")
		ensure
			valid_result: Result /= Void
		end

	magenta: EV_COLOR is
			-- Magenta color named "magenta"
		once
			!! Result.make_rgb (255, 0, 255)
			Result.set_name ("magenta")
		ensure
			valid_result: Result /= Void
		end

	dark_magenta: EV_COLOR is
			-- Dark magenta color named "dark magenta"
		once
			!! Result.make_rgb (128, 0, 128)
			Result.set_name ("dark magenta")
		ensure
			valid_result: Result /= Void
		end

end -- class EV_BASIC_COLORS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
