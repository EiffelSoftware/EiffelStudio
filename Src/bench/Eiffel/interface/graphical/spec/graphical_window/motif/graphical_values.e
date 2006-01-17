indexing

	description: 
		"Graphical values for the graphical window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPHICAL_VALUES

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
			int := default_text_font.font_ascent;
			int := int.max (string_text_font.font_ascent);
			int := int.max (comment_font.font_ascent);
			int := int.max (keyword_font.font_ascent);
			int := int.max (class_font.font_ascent);
			int := int.max (cluster_font.font_ascent);
			int := int.max (feature_font.font_ascent);
			int := int.max (object_font.font_ascent);
			int := int.max (error_font.font_ascent);
			Result := int.max (symbol_font.font_ascent);
		end;

	font_max_descent: INTEGER is
			-- Maximum descent height of a text line
			--| Find out maximum
		local
			int: INTEGER
		do
			int := default_text_font.font_descent;
			int := int.max (string_text_font.font_descent);
			int := int.max (comment_font.font_descent);
			int := int.max (keyword_font.font_descent);
			int := int.max (class_font.font_descent);
			int := int.max (cluster_font.font_descent);
			int := int.max (feature_font.font_descent);
			int := int.max (object_font.font_descent);
			int := int.max (error_font.font_descent);
			Result := int.max (symbol_font.font_descent);
		end;

feature -- Font access

	comment_font: FONT
			-- Font to be used

	string_text_font: FONT
			-- Font used for standard text

	default_text_font: FONT
			-- Default font used in format

	class_font: FONT
			-- Font to be used for class text

	cluster_font: FONT
			-- Font to be used for cluster text

	feature_font: FONT
			-- Font to be used for feature text

	object_font: FONT
			-- Font to be used for object text

	error_font: FONT
			-- Font to be used for object text

	breakable_font: FONT
			-- Font to be used for object text

	keyword_font: FONT
			-- Font to be used

	symbol_font: FONT
			-- Font to be used

feature -- Color access

	text_background_color: COLOR
			-- Color for the text window

	text_foreground_color: COLOR
			-- Color for the text window

	progress_bar_color: COLOR
			-- Color for the progress bar

	string_text_color: COLOR
			-- Foreground color of string text

	default_text_color: COLOR
			-- Foreground color of default text in format

	stop_color: COLOR
			-- Foreground color of stop point

	breakable_color: COLOR
			-- Foreground color of breakable point

	symbol_color: COLOR
			-- Foreground color of symbol

	class_color: COLOR
			-- Foreground color of class text

	cluster_color: COLOR
			-- Foreground color of cluster text

	feature_color: COLOR
			-- Foreground color of feature text

	error_color: COLOR
			-- Foreground color of error text

	object_color: COLOR
			-- Foreground color of object text

	comment_color: COLOR
			-- Foreground color of comment text

	keyword_color: COLOR
			-- Foreground color of keyword text

	highlighted_line_bg_color: COLOR
			-- Selected background color for highlighted line

	highlighted_line_fg_color: COLOR
			-- Selected background color for highlighted line

	selected_clickable_fg_color: COLOR is
		once
			create Result.make;
			Result.set_name ("white")
		end;

	selected_clickable_bg_color: COLOR is
		once
			create Result.make;
			Result.set_name ("black")
		end;

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

end -- class GRAPHICAL_VALUES
