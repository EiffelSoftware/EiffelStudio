indexing
	description: "Objects that save all floating zone information."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_ZONE_DATA

create
	make

feature {NONE} -- Initlization

	make (a_screen_x, a_screen_y: INTEGER) is
			--
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
		ensure
			set_x: screen_x = a_screen_x
			set_y: screen_y = a_screen_y
		end

feature -- States report

	screen_x: INTEGER

	screen_y: INTEGER
end
