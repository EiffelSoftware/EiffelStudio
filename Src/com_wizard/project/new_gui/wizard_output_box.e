indexing
	description: "Output notebook tab, can display messages, titles and errors"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_BOX

inherit
	WIZARD_OUTPUT_BOX_IMP


feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
		do
		end

feature -- Basic Operations

	display_error (a_error: STRING) is
			-- Display error `a_error' in output rich text
		do
			output_text.buffered_append ("ERROR: ", Error_format)
			output_text.buffered_append (a_error, Error_format)
			output_text.buffered_append ("%N", Error_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end
	
	display_message (a_message: STRING) is
			-- Display message `a_message' in output rich text
		do
			output_text.buffered_append (a_message, Message_format)
			output_text.buffered_append ("%N", Message_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end

	display_title (a_title: STRING) is
			-- Display title `a_title' in output rich text
		do
			output_text.buffered_append (a_title, Title_format)
			output_text.buffered_append ("%N", Title_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end

feature {NONE} -- Events Handling

	on_exit is
			-- Called by `select_actions' of `exit_button'.
		do
			((create {EV_ENVIRONMENT}).application).destroy
		end

	on_stop is
			-- Called by `select_actions' of `stop_button'.
		do
		end

feature {NONE} -- Implementation

	Red: EV_COLOR is
			-- Red
		once
			Result := (create {EV_STOCK_COLORS}).Red
		end
		
	Blue: EV_COLOR is
			-- Blue
		once
			Result := (create {EV_STOCK_COLORS}).Blue
		end

	Black: EV_COLOR is
			-- Black
		once
			Result := (create {EV_STOCK_COLORS}).Black
		end

	White: EV_COLOR is
			-- White
		once
			Result := (create {EV_STOCK_COLORS}).White
		end

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
			create Result.make_with_font_and_color (Message_font, Black, White)
		end
		
	Title_format: EV_CHARACTER_FORMAT is
			-- Format used to display warning messages
		once
			create Result.make_with_font_and_color (Title_font, Blue, White)
		end
		
	Error_format: EV_CHARACTER_FORMAT is
			-- Format used to display error messages
		once
			create Result.make_with_font_and_color (Error_font, Red, White)
		end

end -- class WIZARD_OUTPUT_BOX

