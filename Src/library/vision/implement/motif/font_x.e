
-- Description of a font.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_X 

inherit

	FONT_I;

	RESOURCES_X [FONTABLE_X]
		rename
			make as resources_x_make
		end

creation

	make

feature {FONTABLE_X}

	set_default_font (font_ptr: POINTER) is
		local
			null_pointer: POINTER
		do
			if null_pointer /= font_ptr then
				is_specified := true;
				default_font_pointer := font_ptr
			end;
		end

feature {NONE}

	default_font_pointer: POINTER;
			-- Default font pointer if name has not been specified (XFontStruct)

	has_default_font: BOOLEAN is
		local
			null_pointer: POINTER
		do
			Result := default_font_pointer /= null_pointer
		end;

	is_used_by (a_widget: WIDGET): BOOLEAN is
			-- Is `a_widget' using this resource ?
		require else
			a_widget_exists: a_widget /= Void
		local
			fontable: FONTABLE
		do
			if a_widget.is_fontable then
				fontable ?= a_widget;
				Result := (not (fontable.font = Void)) and then 
							(fontable.font.implementation = Current)
			end
		ensure then
			(number_of_uses = 0) implies (not Result)
		end; 

feature 

	ascent (a_widget: WIDGET_I): INTEGER is
			-- Ascent value in pixel of the font loaded for `a_widget'.
		require else
			a_widget_exists: not (a_widget = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		do
			Result := c_ascent (resource (a_widget.screen))
		ensure then
			valid_result: Result >= 0
		end;

	average_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := average_width_private
		ensure then
			valid_result: Result >= 0
		end;

	
feature {NONE}

	average_width_private: INTEGER;
			-- Width of all characters in the font in tenth of pixel
			-- Private attributes

	
feature 

	character_set: STRING is
			-- (iso8859-1...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			if has_default_font then
				Result := ""
			else
				Result := character_set_private
			end
		ensure then
			valid_result: Result /= Void
		end;

	
feature {NONE}

	character_set_private: STRING;
			-- (iso8859-1...)

	
feature 

	make (a_font: FONT) is
			-- Create a font.
		require
			a_font_exits: a_font /= Void
		do
			resources_x_make;
		ensure
			not is_parsed;
			not is_specified
		end;

	descent (a_widget: WIDGET_I): INTEGER is
			-- Descent value in pixel of the font loaded for `a_widget'.
		require else
			a_widget_exists: not (a_widget = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		do
			Result := c_descent (resource (a_widget.screen))
		ensure then
			valid_result: Result >= 0
		end;

	family: STRING is
			-- Family name (Courier, Helvetica...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			if has_default_font then
				Result := ""
			else
				Result := family_private
			end
		ensure then
			valid_result: Result /= Void
		end;
	
feature {NONE}

	family_private: STRING;
			-- Family name (Courier, Helvetica...)

feature 

	name: STRING;
			-- Name of the font

	foundry: STRING is
			-- Foundry name (Adobe...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			if has_default_font then
				Result := ""
			else
				Result := foundry_private
			end
		ensure then
			valid_result: Result /= Void
		end;

	
feature {NONE}

	foundry_private: STRING;
			-- Foundry name (Adobe...)

	free_resources is
			-- Free all resources.
		do
			from
				start
			until
				after
			loop
				if item.is_allocated then
					x_free_font (item.screen.screen_object, item.identifier);
					item.set_allocated (False);
				end;
				forth
			end;
			wipe_out
		end;

	
feature 

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := horizontal_resolution_private
		ensure then
			Result > 0
		end;

	
feature {NONE}

	horizontal_resolution_private: INTEGER;
			-- Horizontal resolution of screen for which the font is designed

	is_parsed: BOOLEAN;
			-- Is `name' parsed and values available ?

	
feature 

	is_proportional: BOOLEAN is
			-- Is the font proportional ?
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := is_proportional_private
		end;

	
feature {NONE}

	is_proportional_private: BOOLEAN;
			-- Is the font proportional ?

	
feature 

	is_specified: BOOLEAN;
			-- Is the font specified ?

	is_standard: BOOLEAN is
			-- Is the font standard and informations available ?
		require else
			font_specified: is_specified
		do
			parse_if_not_yet;
			Result := is_standard_private
		end;

feature {NONE}

	is_standard_private: BOOLEAN;
			-- Is the font standard and informations available ?
	
feature 

	is_valid (a_widget: WIDGET_I): BOOLEAN is
			-- Is the font valid in `a_widget''s display ?
		require else
			font_specified: is_specified
		do
			Result := true
		end;

	
feature {NONE}

	next_minus (a_string: STRING; pos: INTEGER): INTEGER is
			-- Next minus's position after `pos' in `a_string'
		require
			a_string_exists: not (a_string = Void);
			pos_smaller_enough: pos < a_string.count;
			pos_larger_enough: pos >= 1
		do
			from
				Result := pos+1
			until
				(Result > a_string.count) or else (a_string.item (Result) = '-')
			loop
				Result := Result+1
			end
		ensure
			Result > pos;
			Result <= a_string.count implies a_string.item (Result) = '-';
			Result <= a_string.count+1
		end;

	parse_name is
			-- Parse `name' and set values.
		require
			is_specified;
			not is_parsed
		local
			pos, new_pos: INTEGER;
			number: INTEGER;
			parsed: ARRAY [STRING]
		do
			is_parsed := true;
			if name.item (1) = '-' then
				from
					pos := 1;
					!! parsed.make (1, 13);
					number := 1
				until
					(pos > name.count) or (number = 13)
				loop
					new_pos := next_minus (name, pos);
					if pos < new_pos-1 then
						parsed.put (name.substring (pos+1, new_pos-1), number)
					end;
					number := number+1;
					pos := new_pos
				end;
				if pos <= name.count then
					foundry_private := parsed.item (1);
					family_private := parsed.item (2);
					weight_private := parsed.item (3);
					slant_private := parsed.item (4).item (1);
					width_private := parsed.item (5);
					pixel_size_private := parsed.item (7).to_integer;
					point_private := parsed.item (8).to_integer;
					horizontal_resolution_private := parsed.item (9).to_integer;
					vertical_resolution_private := parsed.item (10).to_integer;
					is_proportional_private := parsed.item (11).item (1) = 'p';
					average_width_private := parsed.item (12).to_integer;
					character_set_private := name.substring (pos+1, name.count);
					is_standard_private := true
				end
			end
		ensure
			is_parsed
		end;

	parse_if_not_yet is
			-- Parse `name' if it isn't yet parsed.
		do
			if not is_parsed then
				parse_name
			end
		ensure
			is_parsed
		end;

	
feature 

	pixel_size: INTEGER is
			-- Size of font in pixel
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := pixel_size_private
		ensure then
			Result > 0
		end;

	
feature {NONE}

	pixel_size_private: INTEGER;
			-- Size of font in pixel

feature 

	point: INTEGER is
			-- Size of font in tenth of points (1 point = 1/72 of an inch)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := point_private
		ensure then
			Result > 0
		end;

	
feature {NONE}

	point_private: INTEGER;
			-- Size of font in tenth of points (1 point = 1/72 of an inch)

	
feature 

	resource (a_screen: SCREEN_I): POINTER is
			-- Number of resource with the window `screen_object'
		require
			is_specified
		local
			a_resource: RESOURCE_X;
			ext_name: ANY
		do
			if has_default_font then
				Result := default_font_pointer
			else
				a_resource := find_same_display (a_screen);
				if (a_resource = Void) then
					ext_name := name.to_c;
					Result := x_load_query_font (a_screen.screen_object, $ext_name);
					!FONT_RES_X! a_resource.make (a_screen, Result, true);
					put_front (a_resource);
				else
					Result := a_resource.identifier
				end
			end
		end;

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		local
			widgets_to_update: LINKED_LIST [FONTABLE_X];
			null_pointer: POINTER
		do
			default_font_pointer := null_pointer
			free_resources;
			name := clone (a_name);
			is_specified := true;
			is_parsed := false;
			from
				widgets_to_update := objects;
				widgets_to_update.start
			until
				widgets_to_update.after
			loop
				widgets_to_update.item.update_font;
				widgets_to_update.forth
			end
		ensure then
			not is_parsed;
			is_specified implies a_name.is_equal (a_name)
		end;

	slant: CHARACTER is
			-- Slant of font (o, r, i...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := slant_private
		end;

	
feature {NONE}

	slant_private: CHARACTER;
			-- Slant of font (o, r, i...)

	
feature 

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := vertical_resolution_private
		ensure then
			Result > 0
		end;

	
feature {NONE}

	vertical_resolution_private: INTEGER;
			-- Vertical resolution of screen for which the font is designed

	
feature 

	weight: STRING is
			-- Weight of font (Bold, Medium...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			Result := weight_private
		ensure then
			not (Result = Void)
		end;

	
feature {NONE}

	weight_private: STRING;
			-- Weight of font (Bold, Medium...)

	
feature 

	width: STRING is
			-- Width of font (Normal, Condensed...)
		require else
			font_specified: is_specified;
			font_standard: is_standard
		do
			parse_if_not_yet;
			if has_default_font then
				Result := ""
			else
				Result := width_private
			end
		ensure then
			valid_result: Result /= Void
		end;

	string_width (a_widget: WIDGET_I; a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_widget'.
		require else
			a_widget_exists: not (a_widget = Void);
			a_text_exists: not (a_text = Void);
			font_specified: is_specified;
			font_valid_for_a_widget: is_valid (a_widget)
		local
			ext_name_text: ANY
		do
			ext_name_text := a_text.to_c;
			Result := c_string_width (resource (a_widget.screen), $ext_name_text)
		ensure then
			valid_result: Result >= 0
		end;

	
feature {NONE}

	width_private: STRING

feature {NONE} -- External features

	c_string_width (value: POINTER; font_name: POINTER): INTEGER is
		external
			"C"
		end;

	x_load_query_font (scr_obj: POINTER; font_name: POINTER): POINTER is
		external
			"C (Display *, char *):EIF_POINTER | <X11/Xlib.h>"
		alias
			"XLoadQueryFont"
		end;

	x_free_font (scr_obj: POINTER; value: POINTER) is
		external
			"C (Display *, XFontStruct *) | <X11/Xlib.h>"
		alias
			"XFreeFont"
		end;

	c_descent (value: POINTER): INTEGER is
		external
			"C"
		end;

	c_ascent (value: POINTER): INTEGER is
		external
			"C"
		end;

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
