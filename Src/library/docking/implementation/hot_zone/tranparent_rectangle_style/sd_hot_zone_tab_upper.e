indexing
	description: "SD_HOT_ZONEs for SD_TAB_ZONE_UPPERs."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB_UPPER

inherit
	SD_HOT_ZONE_TAB
		redefine
			update_feedback
		end
create
	make

feature {NONE} -- Redefine

	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE) is
			-- Redefine
		local
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
			l_rect: like internal_rectangle
			l_center_rect, l_top_rect: EV_RECTANGLE
		do
			l_rect := a_rect
			l_shared := internal_shared
			l_icons := l_shared.icons

			if a_rect = internal_rectangle_left then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_right then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_top then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_bottom then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_center then
				create l_center_rect.make (internal_rectangle.left, internal_rectangle.top + internal_shared.title_bar_height, internal_rectangle.width, internal_rectangle.height - internal_shared.title_bar_height)
				create l_top_rect.make (internal_rectangle.left + internal_shared.title_bar_height, internal_rectangle.top, internal_shared.title_bar_height * 3, internal_shared.title_bar_height)
				internal_shared.feedback.draw_transparency_rectangle_for_tab (l_top_rect, l_center_rect)
			end
		end

--	set_rectangle (a_rect: EV_RECTANGLE) is
--			-- Redefine
--		do
--
--		end

end
