indexing
	description: "Data panel used for capturing graphical parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		export
			{NONE} all
		end
	EB_GRAPHICAL_DATA
		rename
			Graphical_resources as parameters
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

			create combo_text.make (Current)

			resources.extend (combo_text)

			create windows_text.make_with_resource (Void, parameters.windows_text)
			create normal_text.make_with_resource (Void, parameters.normal_text)
			create default_text.make_with_resource (Void, parameters.default_text)
			create comment_text.make_with_resource (Void, parameters.comment_text)
			create string_text.make_with_resource (Void, parameters.string_text)
			create class_text.make_with_resource (Void, parameters.class_text)
			create cluster_text.make_with_resource (Void, parameters.cluster_text)
			create feature_text.make_with_resource (Void, parameters.feature_text)
			create object_text.make_with_resource (Void, parameters.object_text)
			create error_text.make_with_resource (Void, parameters.error_text)
			create breakable_text.make_with_resource (Void, parameters.breakable_text)
			create keyword_text.make_with_resource (Void, parameters.keyword_text)
			create symbol_text.make_with_resource (Void, parameters.symbol_text)
			create html_text.make_with_resource (Void, parameters.html_text)

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

--			create font.make_with_resource (Current, parameters.font)
--			create text_font.make_with_resource (Current, parameters.text_font)
--			create default_text_font.make_with_resource (Current, parameters.default_text_font)
--			create comment_font.make_with_resource (Current, parameters.comment_font)
--			create string_text_font.make_with_resource (Current, parameters.string_text_font)
--			create class_font.make_with_resource (Current, parameters.class_font)
--			create cluster_font.make_with_resource (Current, parameters.cluster_font)
--			create feature_font.make_with_resource (Current, parameters.feature_font)
--			create object_font.make_with_resource (Current, parameters.object_font)
--			create error_font.make_with_resource (Current, parameters.error_font)
--			create breakable_font.make_with_resource (Current, parameters.breakable_font)
--			create keyword_font.make_with_resource (Current, parameters.keyword_font)
--			create symbol_font.make_with_resource (Current, parameters.symbol_font)
--			create html_font.make_with_resource (Current, parameters.html_font)
--
--			create text_background_color.make_with_resource (Current, parameters.text_background_color)
--			create text_foreground_color.make_with_resource (Current, parameters.text_foreground_color)
--			if not Platform_constants.is_windows then
--				create focus_label_color.make_with_resource (Current, parameters.focus_label_color)
--				create progress_bar_color.make_with_resource (Current, parameters.progress_bar_color)
--				create highlight_line_background_color.make_with_resource (Current, parameters.highlight_line_background_color)
--				create highlight_line_foreground_color.make_with_resource (Current, parameters.highlight_line_foreground_color)
--			end
--			create foregrnd_color.make_with_resource (Current, parameters.foreground_color)
--			create string_text_color.make_with_resource (Current, parameters.string_text_color)
--			create default_text_color.make_with_resource (Current, parameters.default_text_color)
--			create stop_color.make_with_resource (Current, parameters.stop_color)
--			create breakable_color.make_with_resource (Current, parameters.breakable_color)
--			create symbol_color.make_with_resource (Current, parameters.symbol_color)
--			create html_color.make_with_resource (Current, parameters.html_color)
--			create class_color.make_with_resource (Current, parameters.class_color)
--			create cluster_color.make_with_resource (Current, parameters.cluster_color)
--			create feature_color.make_with_resource (Current, parameters.feature_color)
--			create error_color.make_with_resource (Current, parameters.error_color)
--			create object_color.make_with_resource (Current, parameters.object_color)
--			create comment_color.make_with_resource (Current, parameters.comment_color)
--			create keyword_color.make_with_resource (Current, parameters.keyword_color)
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

	symbol: EV_PIXMAP is
			-- Current's symobl for being unselected
		do
			Result := Pixmaps.bm_Graph
		end

feature {NONE} -- Implementation

	text_background_color,
	focus_label_color,
	progress_bar_color,
	stop_color: EB_COLOR_RESOURCE_DISPLAY

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
