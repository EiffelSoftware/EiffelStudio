indexing

	description:
		"Resources valid for the graphical side of bench.";
	date: "$Date$";
	revision: "$Revision$"

class GRAPHICAL_CATEGORY

inherit
	RESOURCE_CATEGORY

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			!! users.make;
			!! modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all rsources valid for Current.
		do
			!! font.make ("font", rt, "");
			!! breakable_font.make ("breakable_font", rt, "timi14");
			!! class_font.make ("class_font", rt, "timi14");
			!! comment_font.make ("comment_font", rt, "timr14");
			!! default_text_font.make ("default_text_font", rt, "timi14");
			!! error_font.make ("error_font", rt, "timi14");
			!! feature_font.make ("feature_font", rt, "timi14");
			!! keyword_font.make ("keyword_font", rt, "timb14");
			!! object_font.make ("object_font", rt, "timi14");
			!! text_font.make ("text_font", rt, "");
			!! string_text_font.make ("string_text_font", rt, "fixed");
			!! symbol_font.make ("symbol_font", rt, "timr14");

			!! background_color.make ("background_color", rt, "");
			!! foreground_color.make ("foreground_color", rt, "");

			!! text_background_color.make ("text_background_color", rt, "white");
			!! text_foreground_color.make ("text_foreground_color", rt, "black");
			!! breakable_color.make ("breakable_color", rt, "black");
			!! class_color.make ("class_color", rt, "black");
			!! comment_color.make ("comment_color", rt, "red");
			!! default_text_color.make ("default_text_color", rt, "black");
			!! error_color.make ("error_color", rt, "red");
			!! feature_color.make ("feature_color", rt, "black");
			!! highlight_line_background_color.make 
					("highlight_background_line_color", rt, "red");
			!! highlight_line_foreground_color.make 
					("highlight_foreground_line_color", rt, "white");
			!! keyword_color.make ("keyword_color", rt, "blue");
			!! object_color.make ("object_color", rt, "black");
			!! progress_bar_color.make ("progress_bar_color", rt, "blue");
			!! selected_clickable_background_color.make 
					("selected_background_clickable_color", rt, "black");
			!! selected_clickable_foreground_color.make 
					("selected_foreground_clickable_color", rt, "white");
			!! stop_color.make ("stop_color", rt, "red");
			!! string_text_color.make ("string_text_color", rt, "black");
			!! symbol_color.make ("symbol_color", rt, "black");
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	font,
	text_font,
	default_text_font,
	comment_font,
	string_text_font,
	class_font,
	feature_font,
	object_font,
	error_font,
	breakable_font,
	keyword_font,
	symbol_font: FONT_RESOURCE

	text_background_color,
	text_foreground_color,
	background_color,
	foreground_color,
	progress_bar_color,
	string_text_color,
	default_text_color,
	stop_color,
	breakable_color,
	symbol_color,
	class_color,
	feature_color,
	error_color,
	object_color,
	comment_color,
	keyword_color,
	highlight_line_background_color,
	highlight_line_foreground_color,
	selected_clickable_background_color,
	selected_clickable_foreground_color: COLOR_RESOURCE

end -- class GRAPHICAL_CATEGORY
