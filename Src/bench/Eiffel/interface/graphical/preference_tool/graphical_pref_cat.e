indexing

	description:
		"Abstract notion of category of resources used for graphical values."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			create font.make (associated_category.font);
			create text_font.make (associated_category.text_font);
			create default_text_font.make (associated_category.default_text_font);
			create comment_font.make (associated_category.comment_font);
			create string_text_font.make (associated_category.string_text_font);
			create class_font.make (associated_category.class_font);
			create cluster_font.make (associated_category.cluster_font);
			create feature_font.make (associated_category.feature_font);
			create object_font.make (associated_category.object_font);
			create error_font.make (associated_category.error_font);
			create breakable_font.make (associated_category.breakable_font);
			create keyword_font.make (associated_category.keyword_font);
			create symbol_font.make (associated_category.symbol_font);
			create html_font.make (associated_category.html_font);

			create text_background_color.make (associated_category.text_background_color);
			create text_foreground_color.make (associated_category.text_foreground_color);
			if not Platform_constants.is_windows then
				create focus_label_color.make (associated_category.focus_label_color)
				create progress_bar_color.make (associated_category.progress_bar_color);
				create highlight_line_background_color.make (associated_category.highlight_line_background_color);
				create highlight_line_foreground_color.make (associated_category.highlight_line_foreground_color);
			end;
			create foreground_color.make (associated_category.foreground_color);
			create string_text_color.make (associated_category.string_text_color);
			create default_text_color.make (associated_category.default_text_color);
			create stop_color.make (associated_category.stop_color);
			create breakable_color.make (associated_category.breakable_color);
			create symbol_color.make (associated_category.symbol_color);
			create html_color.make (associated_category.html_color);
			create class_color.make (associated_category.class_color);
			create cluster_color.make (associated_category.cluster_color);
			create feature_color.make (associated_category.feature_color);
			create error_color.make (associated_category.error_color);
			create object_color.make (associated_category.object_color);
			create comment_color.make (associated_category.comment_color);
			create keyword_color.make (associated_category.keyword_color);

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
			create button.make (Current, a_button_parent);
			create menu_entry.make (Current, a_menu);
			create holder.make (button, menu_entry);

			make_row_column (name, a_parent)
		end;

	init_colors is
			-- Initialize the colors of the page.
		local
			att: WINDOW_ATTRIBUTES
		do
			create att;
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
	highlight_line_foreground_color: COLOR_PREF_RES;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class GRAPHICAL_PREF_CAT
