note
	description: "GTK implementation for SD_SYSTEM_SETTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end

