indexing
	description: "$EiffelGraphicalCompiler$ basic colors table"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COLOR_TABLE

inherit
	EV_BASIC_COLORS

feature -- Constants

	color_table: HASH_TABLE [EV_COLOR, STRING] is
			--
		once
			Create Result.make (16)

			Result.put (white, "white")
			Result.put (black, "black")
			Result.put (grey, "grey")
			Result.put (dark_grey, "dark grey")
			Result.put (blue, "blue")
			Result.put (dark_blue, "dark blue")
			Result.put (cyan, "cyan")
			Result.put (dark_cyan, "dark cyan")
			Result.put (green, "green")
			Result.put (dark_green, "dark green")
			Result.put (yellow, "yellow")
			Result.put (dark_yellow, "dark yellow")
			Result.put (red, "red")
			Result.put (dark_red, "dark red")
			Result.put (magenta, "magenta")
			Result.put (dark_magenta, "dark magenta")
		ensure
			sixteen_colors: Result.count = 16
		end

	color_from_table (s: STRING): EV_COLOR is
			-- color named `s' in the table
			-- black if color `s' is not in table
		local
			c: EV_COLOR
		do
			c := color_table.item (s)

			if c = Void then
				Create Result.make
				Result.set_name (s)
			else
				Result := deep_clone (c)
			end
		end

end -- class EB_COLOR_TABLE
