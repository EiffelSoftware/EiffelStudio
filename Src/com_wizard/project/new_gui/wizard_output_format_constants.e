indexing
	description: "Constants that define look of output box"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_FORMAT_CONSTANTS

feature -- Access

	Title_font: EV_FONT is
			-- Font used to diplay information and warning messages
		once
			create Result.make_with_values (feature {EV_FONT_CONSTANTS}.family_sans, feature {EV_FONT_CONSTANTS}.weight_bold, feature {EV_FONT_CONSTANTS}.shape_regular, 12)
		end
		
	Message_font: EV_FONT is
			-- Font used to diplay information and warning messages
		once
			create Result.make_with_values (feature {EV_FONT_CONSTANTS}.family_sans, feature {EV_FONT_CONSTANTS}.weight_regular, feature {EV_FONT_CONSTANTS}.shape_regular, 10)
		end
		
	Error_font: EV_FONT is
			-- Font used to diplay error messages
		once
			create Result.make_with_values (feature {EV_FONT_CONSTANTS}.family_sans, feature {EV_FONT_CONSTANTS}.weight_bold, feature {EV_FONT_CONSTANTS}.shape_regular, 10)
		end

	Message_format: EV_CHARACTER_FORMAT is
			-- Format used to display information messages
		once
			create Result.make_with_font_and_color (Message_font, (create {EV_STOCK_COLORS}).Black, (create {EV_STOCK_COLORS}).White)
		end
		
	Title_format: EV_CHARACTER_FORMAT is
			-- Format used to display warning messages
		once
			create Result.make_with_font_and_color (Title_font, (create {EV_STOCK_COLORS}).Blue, (create {EV_STOCK_COLORS}).White)
		end
		
	Warning_format: EV_CHARACTER_FORMAT is
			-- Format used to display error messages
		once
			create Result.make_with_font_and_color (Error_font, (create {EV_STOCK_COLORS}).Black, (create {EV_STOCK_COLORS}).White)
		end

	Error_format: EV_CHARACTER_FORMAT is
			-- Format used to display error messages
		once
			create Result.make_with_font_and_color (Error_font, (create {EV_STOCK_COLORS}).Red, (create {EV_STOCK_COLORS}).White)
		end

end -- class WIZARD_OUTPUT_FORMAT_CONSTANTS
