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
			make as rc_make,
			foreground_color as rc_foreground_color,
			background_color as rc_background_color
		redefine
			init_colors
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PREFERENCE_TOOL) is
			-- Initialize Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool;
			!! resources.make;

			!! font.make (associated_category.font, Current);
			!! text_font.make (associated_category.text_font, Current);
			!! default_text_font.make (associated_category.default_text_font, Current);
			!! comment_font.make (associated_category.comment_font, Current);
			!! string_text_font.make (associated_category.string_text_font, Current);
			!! class_font.make (associated_category.class_font, Current);
			!! feature_font.make (associated_category.feature_font, Current);
			!! object_font.make (associated_category.object_font, Current);
			!! error_font.make (associated_category.error_font, Current);
			!! breakable_font.make (associated_category.breakable_font, Current);
			!! keyword_font.make (associated_category.keyword_font, Current);
			!! symbol_font.make (associated_category.symbol_font, Current);

			!! text_background_color.make (associated_category.text_background_color, Current);
			!! text_foreground_color.make (associated_category.text_foreground_color, Current);
			!! background_color.make (associated_category.background_color, Current);
			!! foreground_color.make (associated_category.foreground_color, Current);
			!! progress_bar_color.make (associated_category.progress_bar_color, Current);
			!! string_text_color.make (associated_category.string_text_color, Current);
			!! default_text_color.make (associated_category.default_text_color, Current);
			!! stop_color.make (associated_category.stop_color, Current);
			!! breakable_color.make (associated_category.breakable_color, Current);
			!! symbol_color.make (associated_category.symbol_color, Current);
			!! class_color.make (associated_category.class_color, Current);
			!! feature_color.make (associated_category.feature_color, Current);
			!! error_color.make (associated_category.error_color, Current);
			!! object_color.make (associated_category.object_color, Current);
			!! comment_color.make (associated_category.comment_color, Current);
			!! keyword_color.make (associated_category.keyword_color, Current);
			!! highlight_line_background_color.make (associated_category.highlight_line_background_color, Current);
			!! highlight_line_foreground_color.make (associated_category.highlight_line_foreground_color, Current);
			!! selected_clickable_background_color.make (associated_category.selected_clickable_background_color, Current);
			!! selected_clickable_foreground_color.make (associated_category.selected_clickable_foreground_color, Current);

			resources.extend (font);
			resources.extend (default_text_font);
			resources.extend (comment_font);
			resources.extend (string_text_font);
			resources.extend (class_font);
			resources.extend (feature_font);
			resources.extend (object_font);
			resources.extend (error_font);
			resources.extend (breakable_font);
			resources.extend (keyword_font);
			resources.extend (symbol_font);

			resources.extend (text_background_color);
			resources.extend (background_color);
			resources.extend (foreground_color);
			resources.extend (progress_bar_color);
			resources.extend (string_text_color);
			resources.extend (default_text_color);
			resources.extend (stop_color);
			resources.extend (breakable_color);
			resources.extend (symbol_color);
			resources.extend (class_color);
			resources.extend (feature_color);
			resources.extend (error_color);
			resources.extend (object_color);
			resources.extend (comment_color);
			resources.extend (keyword_color);
			resources.extend (highlight_line_background_color);
			resources.extend (highlight_line_foreground_color);
			resources.extend (selected_clickable_background_color);
			resources.extend (selected_clickable_foreground_color);
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

			button.set_selected (False);

			rc_make (name, a_parent)
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
			Result := Pixmaps.bm_System
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		once
			Result := Pixmaps.bm_System_dot
		end;

feature {NONE} -- Resources

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
    symbol_font: FONT_PREF_RES
 
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
    selected_clickable_foreground_color: COLOR_PREF_RES

end -- class GRAPHICAL_PREF_CAT
