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
--			set_stick,
			enable_focus_color,
			disable_focus_color,
			set_show_normal_max,
			set_show_stick
		end

create
	make

feature {NONE} -- Initlization method.

	make is
			-- Creation method.
		do
			default_create
			create custom_area
			set_minimum_height (0)
		end

feature -- Redefine

	set_title (a_title: STRING) is
			-- Do nothing.
		do
		end

--	set_stick (a_bool: BOOLEAN) is
--			-- Do nothing.
--		do
--		end

	enable_focus_color is
			-- Do nothing.
		do
		end

	disable_focus_color is
			-- Do nothing.
		do
		end

	set_show_normal_max (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

invariant
	custom_area_not_void: custom_area /= Void

end
