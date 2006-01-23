indexing
	description: "Objects that represent a void title, which means it shows nothing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end
