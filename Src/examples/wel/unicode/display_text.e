indexing
	description: "Objects that ..."
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
		ensure
			result_not_void: Result /= Void
		end
			
	foreground_color: WEL_COLOR_REF is
			-- Foreground color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

end --class DISPLAY_TEXT