indexing

	description: 
		"Graphical values for the graphical window.";
	date: "$Date$";
	revision: "$Revision $"

class EB_GRAPHICAL_VALUES

inherit

	EB_CONSTANTS

feature {NONE} -- Initialization

	init_graphical_values is
			-- Initialize all graphical values from 
			-- `Graphical_resources'.
		do
			comment_font :=
				Graphical_resources.comment_font.valid_actual_value
			string_text_font :=
				Graphical_resources.string_text_font.valid_actual_value
			default_text_font :=
				Graphical_resources.default_text_font.valid_actual_value
			class_font :=
				Graphical_resources.class_font.valid_actual_value
			cluster_font :=
				Graphical_resources.cluster_font.valid_actual_value
			feature_font :=
				Graphical_resources.feature_font.valid_actual_value
			object_font :=
				Graphical_resources.object_font.valid_actual_value
			error_font :=
				Graphical_resources.error_font.valid_actual_value
			breakable_font :=
				Graphical_resources.breakable_font.valid_actual_value
			keyword_font :=
				Graphical_resources.keyword_font.valid_actual_value
			symbol_font :=
				Graphical_resources.symbol_font.valid_actual_value

			text_background_color :=
				Graphical_resources.text_background_color.valid_actual_value
			text_foreground_color :=
				Graphical_resources.text_foreground_color.valid_actual_value
			progress_bar_color :=
				Graphical_resources.progress_bar_color.valid_actual_value
			string_text_color :=
				Graphical_resources.string_text_color.valid_actual_value
			default_text_color :=
				Graphical_resources.default_text_color.valid_actual_value
			stop_color :=
				Graphical_resources.stop_color.valid_actual_value
			breakable_color :=
				Graphical_resources.breakable_color.valid_actual_value
			symbol_color :=
				Graphical_resources.symbol_color.valid_actual_value
			class_color :=
				Graphical_resources.class_color.valid_actual_value
			cluster_color :=
				Graphical_resources.cluster_color.valid_actual_value
			feature_color :=
				Graphical_resources.feature_color.valid_actual_value
			error_color :=
				Graphical_resources.error_color.valid_actual_value
			object_color :=
				Graphical_resources.object_color.valid_actual_value
			comment_color :=
				Graphical_resources.comment_color.valid_actual_value
			keyword_color :=
				Graphical_resources.keyword_color.valid_actual_value
			highlighted_line_bg_color :=
				Graphical_resources.highlight_line_background_color.valid_actual_value
			highlighted_line_fg_color :=
				Graphical_resources.highlight_line_foreground_color.valid_actual_value
		end

feature -- Access

	font_max_height: INTEGER is
			-- Maximum height of a text line
			--| Find out maximum
		local
			int: INTEGER
		do
			Result := font_max_ascent + font_max_descent + 2
		end;

	font_max_ascent: INTEGER is
			-- Maximum ascent height of a text line
			--| Find out maximum
		local
			int: INTEGER
		do
			int := default_text_font.ascent;
			int := int.max (string_text_font.ascent);
			int := int.max (comment_font.ascent);
			int := int.max (keyword_font.ascent);
			int := int.max (class_font.ascent);
			int := int.max (cluster_font.ascent);
			int := int.max (feature_font.ascent);
			int := int.max (object_font.ascent);
			int := int.max (error_font.ascent);
			Result := int.max (symbol_font.ascent);
		end;

	font_max_descent: INTEGER is
			-- Maximum descent height of a text line
			--| Find out maximum
		local
			int: INTEGER
		do
			int := default_text_font.descent;
			int := int.max (string_text_font.descent);
			int := int.max (comment_font.descent);
			int := int.max (keyword_font.descent);
			int := int.max (class_font.descent);
			int := int.max (cluster_font.descent);
			int := int.max (feature_font.descent);
			int := int.max (object_font.descent);
			int := int.max (error_font.descent);
			Result := int.max (symbol_font.descent);
		end;

feature -- Font access

	comment_font: EV_FONT
			-- Font to be used

	string_text_font: EV_FONT
			-- Font used for standard text

	default_text_font: EV_FONT
			-- Default font used in format

	class_font: EV_FONT
			-- Font to be used for class text

	cluster_font: EV_FONT
			-- Font to be used for cluster text

	feature_font: EV_FONT
			-- Font to be used for feature text

	object_font: EV_FONT
			-- Font to be used for object text

	error_font: EV_FONT
			-- Font to be used for object text

	breakable_font: EV_FONT
			-- Font to be used for object text

	keyword_font: EV_FONT
			-- Font to be used

	symbol_font: EV_FONT
			-- Font to be used

feature -- Color access

	text_background_color: EV_COLOR
			-- Color for the text window

	text_foreground_color: EV_COLOR
			-- Color for the text window

	progress_bar_color: EV_COLOR
			-- Color for the progress bar

	string_text_color: EV_COLOR
			-- Foreground color of string text

	default_text_color: EV_COLOR
			-- Foreground color of default text in format

	stop_color: EV_COLOR
			-- Foreground color of stop point

	breakable_color: EV_COLOR
			-- Foreground color of breakable point

	symbol_color: EV_COLOR
			-- Foreground color of symbol

	class_color: EV_COLOR
			-- Foreground color of class text

	cluster_color: EV_COLOR
			-- Foreground color of cluster text

	feature_color: EV_COLOR
			-- Foreground color of feature text

	error_color: EV_COLOR
			-- Foreground color of error text

	object_color: EV_COLOR
			-- Foreground color of object text

	comment_color: EV_COLOR
			-- Foreground color of comment text

	keyword_color: EV_COLOR
			-- Foreground color of keyword text

	highlighted_line_bg_color: EV_COLOR
			-- Selected background color for highlighted line

	highlighted_line_fg_color: EV_COLOR
			-- Selected background color for highlighted line

	selected_clickable_fg_color: EV_COLOR is
		once
			!! Result.make;
			Result.set_name ("white")
		end;

	selected_clickable_bg_color: EV_COLOR is
		once
			!! Result.make;
			Result.set_name ("black")
		end;

end -- class EB_GRAPHICAL_VALUES
