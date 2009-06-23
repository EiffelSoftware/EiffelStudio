note
	description: "Cocoa implementation for SD_SYSTEM_SETTER."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_SETTER_IMP

inherit
	SD_SYSTEM_SETTER

feature -- Command

	before_enable_capture
		do
		end

	after_disable_capture
		do
		end

	is_remote_desktop: BOOLEAN
		do
		end

	clear_background_for_theme (a_widget: EV_DRAWING_AREA; a_rect: EV_RECTANGLE)
		do
			a_widget.set_background_color (background_color)
			a_widget.clear_rectangle (a_rect.x , a_rect.y, a_rect.width, a_rect.height)
		end

feature -- Internal

	background_color: EV_COLOR
		local
			l_stock_colors: EV_STOCK_COLORS
		once
			create l_stock_colors
			Result := l_stock_colors.default_background_color
		end

end
