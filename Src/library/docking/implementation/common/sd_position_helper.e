indexing
	description: "Helper to set dialog positions."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_POSITION_HELPER

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method
		do
			create internal_shared
		end

feature -- Command

	set_dialog_position (a_dialog: EV_POSITIONABLE; a_prefer_x, a_prefer_y: INTEGER) is
			-- Set dialog position base on screen size.
		require
			a_dialog_not_void: a_dialog /= Void
		local
			l_screen: SD_SCREEN
			l_rect: EV_RECTANGLE
		do
			create l_screen
			create l_rect.make (l_screen.virtual_left, l_screen.virtual_top, l_screen.virtual_width, l_screen.virtual_height)
			if l_rect.has_x_y (a_dialog.width + a_prefer_x, a_dialog.height + a_prefer_y + internal_shared.title_bar_height) then
				-- If enough space set position base on left top corner.
				a_dialog.set_position (a_prefer_x, a_prefer_y + internal_shared.title_bar_height)
			elseif l_rect.has_x_y (a_prefer_x, a_prefer_y + a_dialog.height + internal_shared.title_bar_height) then
				-- If enough space set position base on right top corner.
				a_dialog.set_position (a_prefer_x - a_dialog.width, a_prefer_y + internal_shared.title_bar_height)
			elseif l_rect.has_x_y (a_prefer_x + a_dialog.width, a_prefer_y - a_dialog.height) then
				-- If enough space set position base on left bottom corner.
				a_dialog.set_position (a_prefer_x, a_prefer_y - a_dialog.height)
			elseif l_rect.has_x_y (a_prefer_x - a_dialog.width, a_prefer_y - a_dialog.height) then
				-- If enough space set positon base on right bottom corner.
				a_dialog.set_position (a_prefer_x - a_dialog.width, a_prefer_y - a_dialog.height)
			else
				check not_possible_in_this_case: False end
			end
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.
end
