indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP
	
inherit
	EV_RICH_TEXT_I
		redefine
			interface
		end

	EV_TEXT_IMP
		redefine
			interface
		end

create
	make

feature -- Status Report

	formatting_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		do
		end
		
	formatting_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		do
		end

 	create_caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
 			-- Create a caret move action sequence.
 		do
 		end
 			
 	create_selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
 			-- Create a selection change action sequence.
 		do
 		end
 
 
 	set_current_format (format: EV_CHARACTER_FORMAT) is
 			-- apply `format' to current caret position, applicable
 			-- to next typed characters.
 		do
 		end


	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		do
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		do
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		do
		end
	
feature -- Status report

	character_format (character_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format of character `character_index'.
		do
		end

feature -- Status setting

	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		do
		end
		
	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		do
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		do
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		do
		end

	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' to `tab_width'.
		do
		end

	tab_width: INTEGER is
			-- Default width in pixels of each tab in `Current'.
		do
		end
		
feature {NONE} -- Implementation

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
		do
		end

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP
