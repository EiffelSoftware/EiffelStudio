indexing
	description: "Custom/efficient text control"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TEXT

inherit
	EV_WEL_CONTAINER
		export
			{NONE} all
		redefine
			create_implementation,
			implementation
		end

create
	default_create

feature -- Access

	line_count: INTEGER is
			-- Line count in text
		do
			Result := implementation.line_count
		ensure
			valid_count: Result >= 0
		end

	first_visible_line: INTEGER is
			-- Upper most visible line
		do
			Result := implementation.first_visible_line
		ensure
			valid_indext: Result >= 0
		end

	visible_lines_count: INTEGER is
			-- Number of visible lines
		do
			Result := implementation.visible_lines_count
		ensure
			valid_count: Result >= 0
		end
		
feature -- Basic Operations

	set_text (a_text: STRING) is
			-- Set rich edit text with `a_text'
		require
			non_void_text: a_text /= Void
		do
			implementation.set_text (a_text)
		end
	
	save (a_file_name: STRING) is
			-- Save content to `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
		do
			implementation.save (a_file_name)
		end

	scroll_to_line (a_line: INTEGER) is
			-- Scroll to line `a_line'.
		require
			valid_line: a_line > 0
		do
			implementation.scroll_to_line (a_line)
		end

	show_scroll_bars is
			-- Scroll to line `a_line'.
		do
			implementation.show_scroll_bars
		end

	hide_scroll_bars is
			-- Scroll to line `a_line'.
		do
			implementation.hide_scroll_bars
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of `Current'.
		do
			create implementation.make (Current) 
		end

	implementation: WIZARD_TEXT_IMP
			-- Implementation

end -- class WIZARD_TEXT
