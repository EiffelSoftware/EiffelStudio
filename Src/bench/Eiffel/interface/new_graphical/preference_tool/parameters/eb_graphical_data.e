indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_DATA

inherit
	SHARED_RESOURCES

feature {NONE} -- Resources

	window_font: EV_FONT is
		do
			Result := resources.get_font ("window_font") --, "-adobe-courier-medium-r-normal-*-12-120-*-*-*-*-*")
		end

	text_font: EV_FONT is
		do
			Result := resources.get_font ("text_font") --, "-adobe-courier-medium-r-normal-*-12-120-*-*-*-*-*")
		end

	breakable_font: EV_FONT is
		do
			Result := resources.get_font ("breakable_font") --, "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
		end

	class_font: EV_FONT is
		do
			Result := resources.get_font ("class_font") --, "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
		end

	cluster_font: EV_FONT is
		do
			Result := resources.get_font ("cluster_font") --, "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
		end

	comment_font: EV_FONT is
		do
			Result := resources.get_font ("comment_font") --, "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
		end

	default_text_font: EV_FONT is
		do
			Result := resources.get_font ("default_text_font") --, "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
		end

	error_font: EV_FONT is
		do
			Result := resources.get_font ("error_font") --, "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
		end

	feature_font: EV_FONT is
		do
			Result := resources.get_font ("feature_font") --, "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
		end

	keyword_font: EV_FONT is
		do
			Result := resources.get_font ("keyword_font") --, "-*-times-bold-r-normal-*-12-*-*-*-*-*-*")
		end

	object_font: EV_FONT is
		do
			Result := resources.get_font ("object_font") --, "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
		end

	string_text_font: EV_FONT is
		do
			Result := resources.get_font ("string_font") --, "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
		end

	symbol_font: EV_FONT is
		do
			Result := resources.get_font ("symbol_font") --, "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
		end

	html_font: EV_FONT is
		do
			Result := resources.get_font ("html_font") --, "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
		end

	window_foreground_color: EV_COLOR is
		do
			Result := resources.get_color ("window_foreground_color")
		end

	window_background_color: EV_COLOR is
		do
			Result := resources.get_color ("window_background_color")
		end

	text_background_color: EV_COLOR is
		do
			Result := resources.get_color ("text_background_color")
		end

	text_foreground_color: EV_COLOR is
		do
			Result := resources.get_color ("text_foreground_color")
		end

	breakable_color: EV_COLOR is
		do
			Result := resources.get_color ("breakable_color")
		end

	class_color: EV_COLOR is
		do
			Result := resources.get_color ("class_color")
		end

	cluster_color: EV_COLOR is
		do
			Result := resources.get_color ("cluster_color")
		end

	comment_color: EV_COLOR is
		do
			Result := resources.get_color ("comment_color")
		end

	default_text_color: EV_COLOR is
		do
			Result := resources.get_color ("default_text_color")
		end

	error_color: EV_COLOR is
		do
			Result := resources.get_color ("error_color")
		end

	feature_color: EV_COLOR is
		do
			Result := resources.get_color ("feature_color")
		end

	keyword_color: EV_COLOR is
		do
			Result := resources.get_color ("keyword_color")
		end

	object_color: EV_COLOR is
		do
			Result := resources.get_color ("object_color")
		end

	stop_color: EV_COLOR is
		do
			Result := resources.get_color ("stop_color")
		end

	string_text_color: EV_COLOR is
		do
			Result := resources.get_color ("string_text_color")
		end

	symbol_color: EV_COLOR is
		do
			Result := resources.get_color ("symbol_color")
		end

	html_color: EV_COLOR is
		do
			Result := resources.get_color ("html_color")
		end

	explanation_color: EV_COLOR is
		do
			Result := resources.get_color ("explanation_color")
		end

	background_line_color: EV_COLOR is
		do
			Result := resources.get_color ("background_line_color")
		end

	foreground_line_color: EV_COLOR is
		do
			Result := resources.get_color ("foreground_line_color")
		end

	progress_bar_color: EV_COLOR is
		do
			Result := resources.get_color ("progress_bar_color")
		end
	
end -- class EB_GRAPHICAL_DATA
