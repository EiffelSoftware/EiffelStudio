indexing
	description: "DANGER: Experimental Class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_PARAMETERS
inherit
	EB_PARAMETERS

creation
	make

feature -- Access

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all rsources valid for Current.
		do
			create windows_text.make_default ("text_on_windows", rt, "", "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
			create breakable_text.make_default ("breakable_text", rt, "red", "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
			create class_text.make_default ("class_text", rt, "magenta", "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
			create cluster_text.make_default ("cluster_text", rt, "dark red", "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
			create comment_text.make_default ("comment_text", rt, "red", "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
			create default_text.make_default ("default_text", rt, "black", "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
			create error_text.make_default ("error_text", rt, "red", "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
			create feature_text.make_default ("feature_text", rt, "dark green", "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
			create keyword_text.make_default ("keyword_text", rt, "blue", "-*-times-bold-r-normal-*-12-*-*-*-*-*-*")
			create object_text.make_default ("object_text", rt, "dark yellow", "-*-times-medium-i-normal-*-12-*-*-*-*-*-*")
			create normal_text.make_default ("normal_text", rt, "black", "-*-courier-medium-r-*-*-12-*-*-*-*-*-*")
			create string_text.make_default ("string_text", rt, "black", "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
			create symbol_text.make_default ("symbol_text", rt, "black", "-*-times-medium-r-normal-*-12-*-*-*-*-*-*")
			create html_text.make_default ("html_text", rt, "blue", "-*-times-medium-r-*-*-12-*-*-*-*-*-*")

--			if not Platform_constants.is_windows then
--				create progress_bar_color.make_default ("progress_bar_color", rt, "blue")
--				create focus_label_color.make_default ("explanation_label", rt, "LightYellow")
--				create highlight_line_background_color.make_default ("highlight_background_line_color", rt, "red")
--				create highlight_line_foreground_color.make_default ("highlight_foreground_line_color", rt, "white")
--			end
		end

feature -- Resources

	windows_text: EB_FORMAT_RESOURCE
	normal_text: EB_FORMAT_RESOURCE
	default_text: EB_FORMAT_RESOURCE
	comment_text: EB_FORMAT_RESOURCE
	string_text: EB_FORMAT_RESOURCE
	class_text: EB_FORMAT_RESOURCE
	cluster_text: EB_FORMAT_RESOURCE
	feature_text: EB_FORMAT_RESOURCE
	object_text: EB_FORMAT_RESOURCE
	error_text: EB_FORMAT_RESOURCE
	breakable_text: EB_FORMAT_RESOURCE
	keyword_text: EB_FORMAT_RESOURCE
	symbol_text: EB_FORMAT_RESOURCE
	html_text: EB_FORMAT_RESOURCE
	text_background_color: EB_COLOR_RESOURCE
	bkground_color: EB_COLOR_RESOURCE
	progress_bar_color: EB_COLOR_RESOURCE
	highlight_line_background_color: EB_COLOR_RESOURCE
	highlight_line_foreground_color: EB_COLOR_RESOURCE
	stop_color: EB_COLOR_RESOURCE
	focus_label_color: EB_COLOR_RESOURCE

end -- class EB_GRAPHICAL_PARAMETERS
