note
	description: "Cocoa implementation for SD_SYSTEM_SETTER."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_SETTER_IMP

inherit
	SD_SYSTEM_SETTER

	EV_ANY_HANDLER

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
		local
			l_widget_imp: EV_DRAWING_AREA_IMP
			path: NS_BEZIER_PATH
			l_color: NS_COLOR
		do
			l_widget_imp ?= a_widget.implementation
			check
				l_widget_imp /= Void
			end
			l_widget_imp.prepare_drawing
			create l_color.control_color
			l_color.set
			create path.make_with_rect (create {NS_RECT}.make_rect (a_rect.x, a_rect.y, a_rect.width, a_rect.height))
			path.fill
			l_widget_imp.finish_drawing
		end

end
