indexing
	description: "Wizard window containing output rich edit"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_EDIT

inherit
	WEL_FRAME_WINDOW
		redefine
			default_style,
			on_wm_erase_background,
			on_size
		end

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ES_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; an_offset: INTEGER) is
			-- Intialize rich edit.
		require
			non_void_parent: a_parent /= Void	
		do
			make_child (a_parent, Title)
			set_y (an_offset)
			set_width (a_parent.width - vertical_scroll_bar_arrow_width)
			set_height (a_parent.height - an_offset)
			setup_output_edit
			font_height := output_edit.font.log_font.height
			create scroller.make (Current, 1, 1, font_height, height)
			hide_horizontal_scroll_bar
		end

feature -- Access

	output_edit: WIZARD_RICH_EDIT
			-- Embedded rich edit control

	is_title_format: BOOLEAN
			-- Should next text added in title format?

	is_warning_format: BOOLEAN
			-- Should next text added in warning format?

	is_error_format: BOOLEAN
			-- Should next text added in error format?

	Title: STRING is "Output"
			-- Window title

	font_height: INTEGER
			-- Output edit font height

feature -- Element Change

	set_title_format is
			-- Set `is_title_format' to `True'.
		do
			is_title_format := True
		ensure
			title_format: is_title_format
		end

	set_warning_format is
			-- Set `is_warning_format' to `True'.
		do
			is_warning_format := True
		ensure
			warning_format: is_warning_format
		end

	set_error_format is
			-- Set `is_error_format' to `True'.
		do
			is_error_format := True
		ensure
			error_format: is_error_format
		end

feature -- Basic Operations

	add_continuous_text (a_text: STRING) is
			-- Insert `a_text' in rich edit `edit' without ending new line.
			-- Set text format according to `title_format', `warning_format' and `error_format'.
		local
			retried: BOOLEAN
			old_height, new_height: INTEGER
		do
			if output_edit.position_from_character_index (output_edit.count).y > Max_height then
				clear
				output_edit.insert_text (Continued)
			end
			if not retried then
				old_height := output_edit.position_from_character_index (output_edit.count).y
				if is_title_format then
					output_edit.insert_text (New_line)				
					output_edit.set_character_format_word (Title_format)
					is_title_format := False
					output_edit.insert_text (a_text)
					output_edit.set_character_format_word (Text_format)
				elseif is_warning_format then
					output_edit.set_character_format_word (Warning_format)		
					is_warning_format := False
					output_edit.insert_text (a_text)
					output_edit.set_character_format_word (Text_format)
				elseif is_error_format then
					output_edit.insert_text (New_line)				
					output_edit.set_character_format_word (Error_format)
					is_error_format := False
					output_edit.insert_text (a_text)
					output_edit.set_character_format_word (Text_format)
					output_edit.insert_text (New_line)				
				else
					output_edit.insert_text (a_text)
				end
				new_height := output_edit.position_from_character_index (output_edit.count).y
				if new_height > height then
					scroller.set_vertical_range (1,  new_height - height)
					scroller.set_vertical_position (new_height -  height)
					if old_height > height then
						scroll (0, old_height - new_height)
					else
						scroll (0, height - new_height)
					end
				end
				process_messages
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end
		
	add_text (a_text: STRING) is
			-- Insert `a_text' in rich edit `edit' with ending new line.
			-- Set text format according to `title_format', `warning_format' and `error_format'.
		local
			a_complete_text: STRING
		do
			if a_text /= Void then
				a_complete_text := clone (a_text)
				a_complete_text.append (New_line)
				add_continuous_text (a_complete_text)
			end
		end

	clear is
			-- Clear window text.
		do
			setup_output_edit
			create scroller.make (Current, 1, 1, font_height, height)
			process_messages
		end

	refresh is
			-- Process messages.
		do
			process_messages
		end

feature {NONE} -- Behavior

   	on_wm_erase_background (wparam: INTEGER) is
   			-- Wm_paint message.
   			-- May be redefined to paint something on
   			-- the `paint_dc'. `invalid_rect' defines
   			-- the invalid rectangle of the client area that
   			-- needs to be repainted.
   		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			if scroller /= Void then
				scroller.set_vertical_page (height)
			end
			if output_edit /= Void then
				output_edit.set_width (width - vertical_scroll_bar_arrow_width)
			end
		end

	default_style: INTEGER is
			-- Window style
		once
			Result := Ws_child  + Ws_visible + Es_autovscroll + Ws_clipchildren + Ws_border
		end

feature {NONE} -- Implementation

	setup_output_edit is
			-- Initialize output edit.
		do
			create output_edit.make (Current, Output_edit_name, 0, 0, width, height, -1)
			output_edit.set_character_format_all (Text_format)
			output_edit.disable
			output_edit.set_text (Empty_text)
			output_edit.set_height (Max_output_edit_height)
			output_edit.set_text_limit (Max_text_limit)
			output_edit.set_width (width)
		end

	Continued: STRING is "...%N"
			-- Text displayed when output is cleared
			-- after height was greater than `Max_height'

	Max_output_edit_height: INTEGER is 32500
			-- Maximum output edit lines

	Max_height: INTEGER is 32000
			-- Maximum height before cleaning

	Max_text_limit: INTEGER is 4_000_000
			-- Maximum text length

	process_messages is
			-- Process messages in queue.
		do
			from
				win_msg.peek_all
			until
				not win_msg.last_boolean_result
			loop
				if win_msg.last_boolean_result then
					win_msg.translate
					win_msg.dispatch
				end
				win_msg.peek_all
			end
		end

	win_msg: WEL_MSG is
			-- Used by `process_messages'
		once
			!! Result.make
		end

	Text_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (10)
			Result.unset_bold
			Result.set_text_color (Text_color)
		end

	Title_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (14)
			Result.set_bold
			Result.set_text_color (Title_color)
		end

	Warning_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (10)
			Result.set_bold
			Result.set_text_color (Warning_color)
		end

	Error_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (10)
			Result.set_bold
			Result.set_text_color (Error_color)
		end
	
	Text_color: WEL_COLOR_REF is
			-- Text output color
		once
			create Result.make_rgb (0, 0, 0)
		end

	Title_color: WEL_COLOR_REF is
			-- Text output color
		once
			create Result.make_rgb (0, 0, 100)
		end

	Warning_color: WEL_COLOR_REF is
			-- Text output color
		once
			create Result.make_rgb (100, 50, 50)
		end

	Error_color: WEL_COLOR_REF is
			-- Text output color
		once
			create Result.make_rgb (150, 0, 0)
		end

	Empty_text: STRING is ""
			-- is_empty string

	Output_edit_name: STRING is "Output"
			-- Output edit name

	New_line: STRING is "%N"
			-- New line

invariant

	valid_format: (is_title_format implies (not is_warning_format and not is_error_format)) and
				(is_warning_format implies (not is_title_format and not is_error_format)) and
				(is_error_format implies (not is_warning_format and not is_title_format))

end -- class WIZARD_OUTPUT_EDIT
