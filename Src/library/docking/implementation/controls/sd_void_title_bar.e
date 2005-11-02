indexing
	description: "Objects that represent a void title, which means it shows nothing."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_VOID_TITLE_BAR

inherit
	SD_TITLE_BAR
		rename
			make as make_title_bar
		redefine
			set_title,
			set_stick,
			enable_focus_color,
			disable_focus_color
		end

create
	make
	
feature {NONE} -- Initlization method.

	make is
			-- Creation method.
		do
			default_create
			set_minimum_height (0)
		end

feature -- Redefine
	
	set_title (a_title: STRING) is
			-- Do nothing.
		do
		end
	
	set_stick (a_bool: BOOLEAN) is
			-- Do nothing.
		do
		end
	
	enable_focus_color is
			-- Do nothing.
		do	
		end
	
	disable_focus_color is
			-- Do nothing.
		do
		end
		
end
