indexing

	description: 
		"Graphical values for the graphical window.";
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
			comment_format :=	format_creation (
					Graphical_resources.comment_color.valid_actual_value,
					Graphical_resources.comment_font.valid_actual_value)
			string_text_format := format_creation (
					Graphical_resources.string_text_color.valid_actual_value,
					Graphical_resources.string_text_font.valid_actual_value)
			default_text_format := format_creation (
					Graphical_resources.default_text_color.valid_actual_value,
					Graphical_resources.default_text_font.valid_actual_value)
			class_format := format_creation (
					Graphical_resources.class_color.valid_actual_value,
					Graphical_resources.class_font.valid_actual_value)
			cluster_format := format_creation (
					Graphical_resources.cluster_color.valid_actual_value,
					Graphical_resources.cluster_font.valid_actual_value)
			feature_format := format_creation (
					Graphical_resources.feature_color.valid_actual_value,
					Graphical_resources.feature_font.valid_actual_value)
			object_format := format_creation (
					Graphical_resources.object_color.valid_actual_value,
					Graphical_resources.object_font.valid_actual_value)
			error_format := format_creation (
					Graphical_resources.error_color.valid_actual_value,
					Graphical_resources.error_font.valid_actual_value)
			breakable_format := format_creation (
					Graphical_resources.breakable_color.valid_actual_value,
					Graphical_resources.breakable_font.valid_actual_value)
			keyword_format := format_creation (
					Graphical_resources.keyword_color.valid_actual_value,
					Graphical_resources.keyword_font.valid_actual_value)
			symbol_format := format_creation (
					Graphical_resources.symbol_color.valid_actual_value,
					Graphical_resources.symbol_font.valid_actual_value)
			html_format := format_creation (
					Graphical_resources.html_color.valid_actual_value,
					Graphical_resources.html_font.valid_actual_value)
		end

feature -- Access

	comment_format: WEL_CHARACTER_FORMAT;
			-- Comment format

	string_text_format: WEL_CHARACTER_FORMAT;
			-- String format for text

	default_text_format: WEL_CHARACTER_FORMAT;
			-- String format for text

	class_format: WEL_CHARACTER_FORMAT;
			-- Class format for text

	cluster_format: WEL_CHARACTER_FORMAT;
			-- Cluster format for text

	feature_format: WEL_CHARACTER_FORMAT;
			-- Feature format for text

	object_format: WEL_CHARACTER_FORMAT;
			-- Object format for text

	error_format: WEL_CHARACTER_FORMAT;
			-- Object format for text

	breakable_format: WEL_CHARACTER_FORMAT
			-- Format to be used for object text

	keyword_format: WEL_CHARACTER_FORMAT
			-- Keyword format for text

	symbol_format: WEL_CHARACTER_FORMAT
			-- Symbol format for text

	html_format: WEL_CHARACTER_FORMAT
			-- Symbol format for text

feature {NONE} -- Implementation

	format_creation (a_color: COLOR; a_font: FONT): WEL_CHARACTER_FORMAT is
			-- Create a character for with `a_color' and `a_font'
		require
			valid_color: a_color /= Void;	
			valid_font: a_font /= Void
		local
			c_ref: WEL_COLOR_REF
			f_w: FONT_WINDOWS
			l_font: WEL_LOG_FONT
		do
			!! Result.make;
			c_ref ?= a_color.implementation;
			Result.set_text_color (c_ref)	
			f_w ?= a_font.implementation;
			l_font ?= f_w.wel_log_font;
			Result.set_face_name (l_font.face_name);
			Result.set_height (l_font.height);
			Result.set_char_set (l_font.char_set);

			if l_font.weight = 700 then	
				Result.set_bold
			else
				Result.unset_bold
			end;

			if l_font.italic then	
				Result.set_italic
			else
				Result.unset_italic
			end;

			if l_font.underlined then
				Result.set_underline
			else
				Result.unset_underline
			end

			if l_font.strike_out then
				Result.set_strike_out
			else
				Result.unset_strike_out
			end


			Result.set_pitch_and_family (l_font.pitch_and_family);
		end

feature -- Removal

	wipe_out_graphical_values is
			-- Wipe out the graphical values.
		do
			comment_format := Void;
			string_text_format := Void;
			default_text_format := Void;
			class_format := Void;
			feature_format := Void;
			object_format := Void;
			error_format := Void;
			breakable_format := Void;
			keyword_format := Void;
			symbol_format := Void
		end

end -- class GRAPHICAL_VALUES
