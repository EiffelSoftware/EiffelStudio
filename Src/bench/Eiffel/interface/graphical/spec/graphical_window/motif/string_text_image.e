indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			draw as draw_text
		end;
	TEXT_FIGURE
		redefine
			draw
		select
			draw
		end

feature -- Access

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.string_text_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.string_text_color
		end

feature -- Status report

	is_tab: BOOLEAN;
			-- Is current a tab

feature -- Status setting

	set_is_tab is
			-- Set `is_tab' to True.
		do
			is_tab := True
		ensure
			is_tab: is_tab
		end

feature -- Output

	draw (d: DRAWING_IMP; values: GRAPHICAL_VALUES; is_in_highlighted_line: BOOLEAN;
			x_offset, y_offset: INTEGER) is
			-- Draw the current text.
		do
			if not is_tab then
				draw_text (d, values, is_in_highlighted_line, x_offset, y_offset)
			end
		end;

end -- class STRING_TEXT_IMAGE
