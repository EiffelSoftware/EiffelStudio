indexing

	description:
		"Resources valid for the graphical side of bench.";
	date: "$Date$";
	revision: "$Revision$"

class GRAPHICAL_CATEGORY

inherit
	RESOURCE_CATEGORY;
	SYSTEM_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all rsources valid for Current.
		do
			create font.make ("font", rt, "");
			create breakable_font.make ("breakable_font", rt, "-*-courier-medium-r-*-*-12-*");
			create class_font.make ("class_font", rt, "-*-times-medium-i-normal-*-12-*");
			create cluster_font.make ("cluster_font", rt, "-*-times-medium-i-normal-*-12-*");
			create comment_font.make ("comment_font", rt, "-*-courier-medium-r-*-*-12-*");
			create default_text_font.make ("default_text_font", rt, "-*-courier-medium-r-*-*-12-*");
			create error_font.make ("error_font", rt, "-*-times-medium-r-normal-*-12-*");
			create feature_font.make ("feature_font", rt, "-*-times-medium-i-normal-*-12-*");
			create keyword_font.make ("keyword_font", rt, "-*-times-bold-r-normal-*-12-*");
			create object_font.make ("object_font", rt, "-*-times-medium-i-normal-*-12-*");
			create text_font.make ("text_font", rt, "-*-courier-medium-r-*-*-12-*");
			create string_text_font.make ("string_text_font", rt, "-*-times-medium-r-normal-*-12-*");
			create symbol_font.make ("symbol_font", rt, "-*-times-medium-r-normal-*-12-*");
			create html_font.make ("html_font", rt, "-*-courier-medium-r-*-*-12-*");

			create background_color.make ("background_color", rt, "");
			create foreground_color.make ("foreground_color", rt, "");

			create text_background_color.make ("text_background_color", rt, "white");
			create text_foreground_color.make ("text_foreground_color", rt, "black");
			create breakable_color.make ("breakable_color", rt, "red");
			create class_color.make ("class_color", rt, "magenta");
			create cluster_color.make ("cluster_color", rt, "DarkRed");
			create comment_color.make ("comment_color", rt, "red");
			create default_text_color.make ("default_text_color", rt, "black");
			create error_color.make ("error_color", rt, "red");
			create feature_color.make ("feature_color", rt, "green4");
			create keyword_color.make ("keyword_color", rt, "blue");
			create object_color.make ("object_color", rt, "brown");
			create stop_color.make ("stop_color", rt, "red");
			create string_text_color.make ("string_text_color", rt, "black");
			create symbol_color.make ("symbol_color", rt, "black");
			create html_color.make ("html_color", rt, "blue");

			if not Platform_constants.is_windows then
				create progress_bar_color.make ("progress_bar_color", rt, "blue");
				create focus_label_color.make ("explanation_label", rt, "LightYellow");
				create highlight_line_background_color.make ("highlight_background_line_color", rt, "red");
				create highlight_line_foreground_color.make ("highlight_foreground_line_color", rt, "white");
			end;
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
	cluster_font,
	feature_font,
	object_font,
	error_font,
	breakable_font,
	keyword_font,
	symbol_font,
	html_font: FONT_RESOURCE

	text_background_color,
	text_foreground_color,
	background_color,
	foreground_color,
	progress_bar_color,
	string_text_color,
	default_text_color,
	stop_color,
	breakable_color,
	focus_label_color,
	symbol_color,
	html_color,
	class_color,
	cluster_color,
	feature_color,
	error_color,
	object_color,
	comment_color,
	keyword_color,
	highlight_line_background_color,
	highlight_line_foreground_color: COLOR_RESOURCE

end -- class GRAPHICAL_CATEGORY
