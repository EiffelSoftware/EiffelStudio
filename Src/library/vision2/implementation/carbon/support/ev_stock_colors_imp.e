note
	description: "List of default colors used by the system. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

create
	default_create

feature
	color_dialog: EV_COLOR
		do
			-- see get_theme_brush_as_color
			create Result
		end

	color_3d_face: EV_COLOR
			-- Color usely used for the background of dialogs
		do
			create Result
		end

	color_dialog_fg: EV_COLOR
		do
			create Result
		end

	color_3d_highlight: EV_COLOR
		do
			create Result
		end

	color_3d_shadow: EV_COLOR
		do
			create Result
		end

	color_read_only: EV_COLOR
			-- Status report
		do
			create Result
		end

	color_read_write: EV_COLOR
		do
			create Result
		end

	default_background_color: EV_COLOR
		do
			create Result
		end

	default_foreground_color: EV_COLOR
		do
			create Result
		end

note
	copyright: "Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_STOCK_COLORS_IMP

