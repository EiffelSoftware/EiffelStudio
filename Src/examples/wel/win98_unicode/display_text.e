indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_TEXT

inherit WEL_STATIC
	redefine
		background_color,
		foreground_color
	end

create
	make

feature
	
	background_color: WEL_COLOR_REF is
				-- Background color used for the background of the
				-- control
				-- Can be redefined by the user
			do
				create Result.make 
			end
			
	foreground_color: WEL_COLOR_REF is
			-- Foreground color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make
		end

end --class DISPLAY_TEXT