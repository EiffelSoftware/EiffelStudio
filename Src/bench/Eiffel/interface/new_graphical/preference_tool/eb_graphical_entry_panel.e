indexing
	description: "Data panel used for capturing graphical parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Graphical_resources as parameters
		export
			{NONE} all
		end
	EB_ENTRY_PANEL
		redefine
			make
		end
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			Create combo_text.make (Current)

			resources.extend (combo_text)

			Create windows_text.make_with_resource (Void, parameters.windows_text)
			Create normal_text.make_with_resource (Void, parameters.normal_text)
			Create default_text.make_with_resource (Void, parameters.default_text)
			Create comment_text.make_with_resource (Void, parameters.comment_text)
			Create string_text.make_with_resource (Void, parameters.string_text)
			Create class_text.make_with_resource (Void, parameters.class_text)
			Create cluster_text.make_with_resource (Void, parameters.cluster_text)
			Create feature_text.make_with_resource (Void, parameters.feature_text)
			Create object_text.make_with_resource (Void, parameters.object_text)
			Create error_text.make_with_resource (Void, parameters.error_text)
			Create breakable_text.make_with_resource (Void, parameters.breakable_text)
			Create keyword_text.make_with_resource (Void, parameters.keyword_text)
			Create symbol_text.make_with_resource (Void, parameters.symbol_text)
			Create html_text.make_with_resource (Void, parameters.html_text)

			combo_text.add_resource_display (windows_text)
			combo_text.add_resource_display (normal_text)
			combo_text.add_resource_display (default_text)
			combo_text.add_resource_display (comment_text)
			combo_text.add_resource_display (string_text)
			combo_text.add_resource_display (class_text)
			combo_text.add_resource_display (cluster_text)
			combo_text.add_resource_display (feature_text)
			combo_text.add_resource_display (object_text)
			combo_text.add_resource_display (error_text)
			combo_text.add_resource_display (breakable_text)
			combo_text.add_resource_display (keyword_text)
			combo_text.add_resource_display (symbol_text)
			combo_text.add_resource_display (html_text)

	-- here we should select first item and launch associated event

--			combo_text.select_item (1)
--			windows_text.display (combo_text)

--			Create font.make_with_resource (Current, parameters.font)
--			Create text_font.make_with_resource (Current, parameters.text_font)
--			Create default_text_font.make_with_resource (Current, parameters.default_text_font)
--			Create comment_font.make_with_resource (Current, parameters.comment_font)
--			Create string_text_font.make_with_resource (Current, parameters.string_text_font)
--			Create class_font.make_with_resource (Current, parameters.class_font)
--			Create cluster_font.make_with_resource (Current, parameters.cluster_font)
--			Create feature_font.make_with_resource (Current, parameters.feature_font)
--			Create object_font.make_with_resource (Current, parameters.object_font)
--			Create error_font.make_with_resource (Current, parameters.error_font)
--			Create breakable_font.make_with_resource (Current, parameters.breakable_font)
--			Create keyword_font.make_with_resource (Current, parameters.keyword_font)
--			Create symbol_font.make_with_resource (Current, parameters.symbol_font)
--			Create html_font.make_with_resource (Current, parameters.html_font)
--
--			Create text_background_color.make_with_resource (Current, parameters.text_background_color)
--			Create text_foreground_color.make_with_resource (Current, parameters.text_foreground_color)
--			if not Platform_constants.is_windows then
--				Create focus_label_color.make_with_resource (Current, parameters.focus_label_color)
--				Create progress_bar_color.make_with_resource (Current, parameters.progress_bar_color)
--				Create highlight_line_background_color.make_with_resource (Current, parameters.highlight_line_background_color)
--				Create highlight_line_foreground_color.make_with_resource (Current, parameters.highlight_line_foreground_color)
--			end
--			Create foregrnd_color.make_with_resource (Current, parameters.foreground_color)
--			Create string_text_color.make_with_resource (Current, parameters.string_text_color)
--			Create default_text_color.make_with_resource (Current, parameters.default_text_color)
--			Create stop_color.make_with_resource (Current, parameters.stop_color)
--			Create breakable_color.make_with_resource (Current, parameters.breakable_color)
--			Create symbol_color.make_with_resource (Current, parameters.symbol_color)
--			Create html_color.make_with_resource (Current, parameters.html_color)
--			Create class_color.make_with_resource (Current, parameters.class_color)
--			Create cluster_color.make_with_resource (Current, parameters.cluster_color)
--			Create feature_color.make_with_resource (Current, parameters.feature_color)
--			Create error_color.make_with_resource (Current, parameters.error_color)
--			Create object_color.make_with_resource (Current, parameters.object_color)
--			Create comment_color.make_with_resource (Current, parameters.comment_color)
--			Create keyword_color.make_with_resource (Current, parameters.keyword_color)
--
--			resources.extend (font)
--			resources.extend (text_font)
--			resources.extend (breakable_font)
--			resources.extend (class_font)
--			resources.extend (cluster_font)
--			resources.extend (comment_font)
--			resources.extend (default_text_font)
--			resources.extend (error_font)
--			resources.extend (feature_font)
--			resources.extend (keyword_font)
--			resources.extend (object_font)
--			resources.extend (string_text_font)
--			resources.extend (symbol_font)
--			resources.extend (html_font)
--
--			resources.extend (foregrnd_color)
--			resources.extend (text_background_color)
--			resources.extend (text_foreground_color)
--
--			resources.extend (breakable_color)
--			resources.extend (class_color)
--			resources.extend (cluster_color)
--			resources.extend (comment_color)
--			resources.extend (default_text_color)
--			resources.extend (error_color)
--			resources.extend (feature_color)
--			resources.extend (keyword_color)
--			resources.extend (object_color)
--			resources.extend (stop_color)
--			resources.extend (string_text_color)
--			resources.extend (symbol_color)
--			resources.extend (html_color)
--			if not Platform_constants.is_windows then
--				resources.extend (focus_label_color)
--				resources.extend (highlight_line_background_color)
--				resources.extend (highlight_line_foreground_color)
--				resources.extend (progress_bar_color)
--			end
		end

feature -- Access

	name: STRING is "Graphical preferences"
			-- Current's name

	symbol: PIXMAP is
			-- Current's symobl for being unselected
		once
			Result := Pixmaps.bm_Graph
		end

feature {NONE} -- Implementation

--	font,
--	text_font,
--	default_text_font,
--	comment_font,
--	string_text_font,
--	class_font,
--	cluster_font,
--	feature_font,
--	object_font,
--	error_font,
--	breakable_font,
--	keyword_font,
--	symbol_font,
--	html_font: EB_FONT_RESOURCE_DISPLAY

	text_background_color,
--	text_foreground_color,
--	foregrnd_color,
	focus_label_color,
	progress_bar_color,
--	string_text_color,
--	default_text_color,
	stop_color,
--	breakable_color,
--	symbol_color,
--	html_color,
--	class_color,
--	cluster_color,
--	feature_color,
--	error_color,
--	object_color,
--	comment_color,
--	keyword_color,
	highlight_line_background_color,
	highlight_line_foreground_color: EB_COLOR_RESOURCE_DISPLAY

	windows_text,
	normal_text,
	default_text,
	comment_text,
	string_text,
	class_text,
	cluster_text,
	feature_text,
	object_text,
	error_text,
	breakable_text,
	keyword_text,
	symbol_text,
	html_text: EB_FORMAT_RESOURCE_DISPLAY

	combo_text: EB_COMBO_TEXT_DISPLAY

end -- class EB_GRAPHICAL_ENTRY_PANEL
