note
	description: "Summary description for {CTR_SHARED_RESOURCES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SHARED_RESOURCES

inherit
	REPOSITORY_SHARED

feature -- Access

	icons: CTR_ICONS_FACTORY
		once
			create Result
		end

	font_default: EV_FONT
		once
			create Result
		end

	message_font: EV_FONT
		once
			create Result
		end

feature -- Colors

	colors: EV_STOCK_COLORS
		once
			create Result
		end

	bgcolor_checking: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

	bgcolor_checked: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (210, 250, 210)
		end

	grid_separator_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (230, 230, 230)
		end

	info_highlight_fgcolor: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0,0,255)
		end

feature -- Fonts

	font_bold: EV_FONT
		local
			ft: like font_default
		once
			ft := font_default
			create Result.make_with_values (ft.family, {EV_FONT_CONSTANTS}.Weight_bold, ft.shape, ft.height)
		end

	font_comment: EV_FONT
		local
			ft: like font_default
		once
			ft := font_default
			create Result.make_with_values (ft.family, ft.weight, {EV_FONT_CONSTANTS}.shape_italic, ft.height)
		end

	font_read_log: EV_FONT
		once
			Result := font_default
		end

	font_unread_log: EV_FONT
		once
			Result := font_bold
		end

	font_selected_repository: EV_FONT
		once
			Result := font_bold
		end

end
