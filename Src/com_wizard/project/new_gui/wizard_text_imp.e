indexing
	description: "Efficient implementation of rich edit"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TEXT_IMP

inherit
	EV_WEL_CONTAINER_IMP
		redefine
			initialize,
			font,
			set_font,
			hide_scroll_bars,
			show_scroll_bars,
			interface,
			on_erase_background
		end

create	
	make
		
feature {EV_ANY} -- Initialization

	initialize is
			-- Setup rich edit
		do
			Precursor {EV_WEL_CONTAINER_IMP}
			create wel_text_edit.make (Default_parent, "", 0, 0, 0, 0, -1)
			replace (wel_text_edit)
			cwin_send_message (wel_text_edit.item, feature {WEL_EM_CONSTANTS}.Em_limittext, to_wparam (0), to_lparam (0))
			wel_text_edit.set_font (Default_font)
			wel_text_edit.set_read_only
			font_height := font.height
		end

feature -- Access

	visible_lines_count: INTEGER is
			-- Number of visible lines
		do
			Result := (wel_height / font_height).truncated_to_integer + 1
		ensure
			valid_count: Result >= 0
		end

	font_height: INTEGER
			-- Height of font in pixels
		
	font: WEL_FONT is
			-- Font
		do
			Result := wel_text_edit.font
		end

	first_visible_line: INTEGER is
			-- First visible line
		do
			Result := wel_text_edit.first_visible_line
		end
		
	line_count: INTEGER is
			-- Line count in text
		do
			Result := wel_text_edit.line_count
		ensure
			valid_count: Result >= 0
		end

feature -- Element Settings
	
	set_font (a_font: WEL_FONT) is
			-- Set `font' with `a_font'.
		do
			wel_text_edit.set_font (a_font)
		end
		
feature -- Basic Operations

	set_text (a_text: STRING) is
			-- Set rich edit text with `a_text'
		require
			non_void_text: a_text /= Void
		do
			wel_text_edit.set_text (a_text)
		end
		
	save (a_file_name: STRING) is
			-- Save content to `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file_name)
				l_file.open_write
				l_file.put_string (wel_text_edit.text)
				l_file.close
			end
		rescue
			l_retried := True
			retry
		end
		
	scroll_to_line (a_line: INTEGER) is
			-- Scroll to line `a_line'.
		require
			valid_line: a_line > 0
		do
			wel_text_edit.scroll (0, a_line - first_visible_line - 1)
		end

	hide_scroll_bars is
			-- Hide vertical scroll bar
		do
			wel_text_edit.hide_scroll_bars
		end
		
	show_scroll_bars is
			-- Hide vertical scroll bar
		do
			wel_text_edit.show_scroll_bars
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: WIZARD_TEXT
			-- Interface of `Current'.

feature {NONE} -- Implementation

	wel_text_edit: WIZARD_MULTIPLE_LINE_EDIT
			-- Wel control

	Default_font: WEL_FONT is
			-- Log font
		once
			create Result.make_indirect (create {WEL_LOG_FONT}.make (10, "Lucida Console"))
		end
		
	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Disable erase background message
		do
		end

end -- class WIZARD_TEXT_IMP
