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

feature {RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all rsources valid for Current.
		do
			!! text_font.make ("text_font", rt.get_string
					("text_font", Void));
			!! font.make ("font", rt.get_string
					("font", Void));
			!! default_text_font.make ("default_text_font", rt.get_string
					("default_text_font", "timi14"));
			!! comment_font.make ("comment_font", rt.get_string
					("comment_font", "timr14"));
			!! string_text_font.make ("string_text_font", rt.get_string
					("string_text_font", "fixed"));
			!! class_font.make ("class_font", rt.get_string
					("class_font", "timi14"));
			!! feature_font.make ("feature_font", rt.get_string
					("feature_font", "timi14"));
			!! object_font.make ("object_font", rt.get_string
					("object_font", "timi14"));
			!! error_font.make ("error_font", rt.get_string
					("error_font", "timi14"));
			!! breakable_font.make ("breakable_font", rt.get_string
					("breakable_font", "timi14"));
			!! keyword_font.make ("keyword_font", rt.get_string
					("keyword_font", "timb14"));
			!! symbol_font.make ("symbol_font", rt.get_string
					("symbol_font", "timr14"));

			!! text_background_color.make ("text_background_color", 
					rt.get_string ("text_background_color", "white"));
			!! text_foreground_color.make ("text_foreground_color", 
					rt.get_string ("text_foreground_color", "black"));
			!! background_color.make ("background_color", rt.get_string
					("background_color", Void));
			!! foreground_color.make ("foreground_color", rt.get_string
					("foreground_color", Void));
			!! progress_bar_color.make ("progress_bar_color", rt.get_string
					("progress_bar_color", "blue"));
			!! string_text_color.make ("string_text_color", rt.get_string
					("string_text_color", "black"));
			!! default_text_color.make ("default_text_color", rt.get_string
					("default_text_color", "black"));
			!! stop_color.make ("stop_color", rt.get_string ("stop_color", "red"));
			!! breakable_color.make ("breakable_color", rt.get_string ("breakable_color", "black"));
			!! symbol_color.make ("symbol_color", rt.get_string ("symbol_color", "black"));
			!! class_color.make ("class_color", rt.get_string ("class_color", "black"));
			!! feature_color.make ("feature_color", rt.get_string ("feature_color", "black"));
			!! error_color.make ("error_color", rt.get_string ("error_color", "red"));
			!! object_color.make ("object_color", rt.get_string ("object_color", "black"));
			!! comment_color.make ("comment_color", rt.get_string ("comment_color", "red"));
			!! keyword_color.make ("keyword_color", rt.get_string ("keyword_color", "blue"));
			!! highlight_line_background_color.make ("highlight_background_line_color", 
					rt.get_string ("highlight_background_line_color", "red"));
			!! highlight_line_foreground_color.make ("highlight_foreground_line_color", 
					rt.get_string ("highlight_foreground_line_color", "white"));
			!! selected_clickable_background_color.make ("selected_background_clickable_color", 
					rt.get_string ("selected_background_clickable_color", "black"));
			!! selected_clickable_foreground_color.make ("selected_foreground_clickable_color", 
					rt.get_string ("selected_foreground_clickable_color", "white"));
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
