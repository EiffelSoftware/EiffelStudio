indexing

	description:
		"Abstract notion of category of resources used for graphical values.";
	date: "$Date$";
	revision: "$Revision$"

class GRAPHICAL_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Graphical_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		rename
			foreground_color as rc_foreground_color,
			background_color as rc_background_color
		redefine
			init_colors
		end;
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			!! font.make (associated_category.font);
			!! text_font.make (associated_category.text_font);
			!! default_text_font.make (associated_category.default_text_font);
			!! comment_font.make (associated_category.comment_font);
			!! string_text_font.make (associated_category.string_text_font);
			!! class_font.make (associated_category.class_font);
			!! cluster_font.make (associated_category.cluster_font);
			!! feature_font.make (associated_category.feature_font);
			!! object_font.make (associated_category.object_font);
			!! error_font.make (associated_category.error_font);
			!! breakable_font.make (associated_category.breakable_font);
			!! keyword_font.make (associated_category.keyword_font);
			!! symbol_font.make (associated_category.symbol_font);
			!! html_font.make (associated_category.html_font);

			!! text_background_color.make (associated_category.text_background_color);
			!! text_foreground_color.make (associated_category.text_foreground_color);
			if not Platform_constants.is_windows then
				!! focus_label_color.make (associated_category.focus_label_color)
				!! progress_bar_color.make (associated_category.progress_bar_color);
				!! highlight_line_background_color.make (associated_category.highlight_line_background_color);
				!! highlight_line_foreground_color.make (associated_category.highlight_line_foreground_color);
			end;
			!! foreground_color.make (associated_category.foreground_color);
			!! string_text_color.make (associated_category.string_text_color);
			!! default_text_color.make (associated_category.default_text_color);
			!! stop_color.make (associated_category.stop_color);
			!! breakable_color.make (associated_category.breakable_color);
			!! symbol_color.make (associated_category.symbol_color);
			!! html_color.make (associated_category.html_color);
			!! class_color.make (associated_category.class_color);
			!! cluster_color.make (associated_category.cluster_color);
			!! feature_color.make (associated_category.feature_color);
			!! error_color.make (associated_category.error_color);
			!! object_color.make (associated_category.object_color);
			!! comment_color.make (associated_category.comment_color);
			!! keyword_color.make (associated_category.keyword_color);

			resources.extend (font);
			resources.extend (text_font);
			resources.extend (breakable_font);
			resources.extend (class_font);
			resources.extend (cluster_font);
			resources.extend (comment_font);
			resources.extend (default_text_font);
			resources.extend (error_font);
			resources.extend (feature_font);
			resources.extend (keyword_font);
			resources.extend (object_font);
			resources.extend (string_text_font);
			resources.extend (symbol_font);
			resources.extend (html_font);

			resources.extend (foreground_color);
			resources.extend (text_background_color);
			resources.extend (text_foreground_color);

			resources.extend (breakable_color);
			resources.extend (class_color);
			resources.extend (cluster_color);
			resources.extend (comment_color);
			resources.extend (default_text_color);
			resources.extend (error_color);
			resources.extend (feature_color);
			resources.extend (keyword_color);
			resources.extend (object_color);
			resources.extend (stop_color);
			resources.extend (string_text_color);
			resources.extend (symbol_color);
			resources.extend (html_color);
			if not Platform_constants.is_windows then
				resources.extend (focus_label_color);
				resources.extend (highlight_line_background_color);
				resources.extend (highlight_line_foreground_color);
				resources.extend (progress_bar_color);
			end;
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Current and `a_parent' as `parent'.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			!! button.make (Current, a_button_parent);
			!! menu_entry.make (Current, a_menu);
			!! holder.make (button, menu_entry);

			make_row_column (name, a_parent)
		end;

	init_colors is
			-- Initialize the colors of the page.
		local
			att: WINDOW_ATTRIBUTES
		do
			!! att;
			att.set_composite_attributes (Current)
		end

feature -- Properties

	name: STRING is "Graphical preferences"
			-- Current's name

	symbol: PIXMAP is
			-- Current's symobl for being unselected
		once
			Result := Pixmaps.bm_Graph
		end;

feature {NONE} -- Resources

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
	html_font: FONT_PREF_RES

	text_background_color,
	text_foreground_color,
	foreground_color,
	focus_label_color,
	progress_bar_color,
	string_text_color,
	default_text_color,
	stop_color,
	breakable_color,
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
	highlight_line_foreground_color: COLOR_PREF_RES

end -- class GRAPHICAL_PREF_CAT
