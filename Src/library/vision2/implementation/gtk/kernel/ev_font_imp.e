indexing

	description: "Description of a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EV_FONT_IMP 

inherit

 	EV_FONT_I

creation
	make,
	make_by_name

feature {NONE} -- Initialization

 	make (a_font: EV_FONT) is
 			-- Create a font.
 		do
			check
                                not_yet_implemented: False
                        end
 		end

	make_by_name (a_font: EV_FONT; a_name: STRING) is
			-- Create the font corresponding to the given name.
			-- The font is directly readed on a file.
		do
			check
                                not_yet_implemented: False
                        end
		end

feature -- Access

 	ascent: INTEGER is
 			-- Ascent value in pixel of the font loaded for `a_widget'
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

 	descent: INTEGER is
 			-- Descent value in pixel of the font loaded for `a_widget'
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

 	width_of_string (a_text: STRING): INTEGER is
			-- Width in pixel of `a_text' in the current font loaded for `a_widget'.
		do
		end

	average_character_width: INTEGER is
			-- Width of all characters in the font in tenth of pixel
		do
		end

	maximum_character_width: INTEGER is
			-- Width of the widest character in the font
		do
		end

 	character_set: STRING is
			-- (iso8859-1...)
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

 	family: STRING is
 			-- Family name (Courier, Helvetica...)
 		do
                        check
                                not_yet_implemented: False
                        end

 		end
	
 	foundry: STRING is
 			-- Foundry name (Adobe...)
 		do
			check
                                not_yet_implemented: False
                        end	
 		end

 	horizontal_resolution: INTEGER is
 			-- Horizontal resolution of screen for which the font is designed
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

	name: STRING is
			-- Name of the font
		do
		end

 	pixel_size: INTEGER is
 			-- Size of font in pixel
 		do
                        check
                                not_yet_implemented: False
                        end

 		end

 	point: INTEGER is
 			-- Size of font in tenth of points (1 point = 1/72 of an inch)
 		do
                        check
                                not_yet_implemented: False
                        end

 		end;

 	slant: CHARACTER is
 			-- Slant of font (o, r, i...)
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

 	vertical_resolution: INTEGER is
 			-- Vertical resolution of screen for which the font is designed
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

 	weight: STRING is
 			-- Weight of font (Bold, Medium...)
 		do
                        check
                                not_yet_implemented: False
                        end
		end

 	width: STRING is
 			-- Width of font (Normal, Condensed...)
 		do
			check
                                not_yet_implemented: False
                        end	
 		end

feature -- Status report

	is_valid: BOOLEAN is
 			-- Is the font valid in `a_widget''s display ?
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

	is_proportional: BOOLEAN is
 			-- Is the font proportional ?
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

	is_specified: BOOLEAN is
			-- Is the font specified?
		do
		end

	is_standard: BOOLEAN is
			-- Is the font standard and informations available (except for name)?
		do
		end


-- feature -- Element change
	
-- 	allocate_font is
-- 			-- Allocate font resource for `a_screen'.
-- 		require
-- 			is_specified: is_specified
-- 		do
-- 			if not is_allocated then
-- 				mel_make (display, name);
-- 				is_allocated := mel_is_valid 
-- 			end
-- 		end;

-- feature -- Status setting

 	set_name (a_name: STRING) is
-- 			-- Set `name' to `a_name'.
 		do
                        check
                                not_yet_implemented: False
                        end
 		end

-- feature -- Removal

-- 	dispose is
-- 			-- Free font resource.
-- 		do
-- 			if is_allocated then
-- 				if not is_default_font then	
-- 					destroy
-- 				end
-- 				is_allocated := False;
-- 				is_default_font := False
-- 			end
-- 		end;

-- feature {EV_FONTABLE_IMP} -- Implementation

-- 	set_default_font (a_font_list: MEL_FONT_LIST) is
-- 			-- Set the default font from `a_font_list'.
-- 		require
-- 			valid_font_list: a_font_list /= Void and then a_font_list.is_valid
-- 		local
-- 			f_context: MEL_FONT_CONTEXT;
-- 			an_entry: MEL_FONT_LIST_ENTRY;
-- 			a_font_struct: MEL_FONT_STRUCT
-- 		do
-- 			f_context := a_font_list.font_context;	
-- 			an_entry := f_context.next_entry;
-- 			if an_entry /= Void then		
-- 				an_entry.set_shared;
-- 				a_font_struct := an_entry.font_struct;
-- 				handle := a_font_struct.handle;
-- 				a_font_struct.set_shared;
-- 				-- DO NOT free the font entry for the 	
-- 				-- default font --> will cause problems later on
-- 			end;
-- 			f_context.destroy;
-- 			is_specified := True;
-- 			is_allocated := True;
-- 			is_default_font := True;
-- 		end

-- feature {EV_FONT_LIST_IMP} -- Status setting

-- 	only_set_name (a_name: STRING) is
-- 			-- Set `name' to `a_name'.
-- 		do
-- 			name := clone (a_name);
-- 			is_specified := true;
-- 		end;

-- feature {NONE} -- Implementation

-- 	private_width: STRING;
-- 			-- Width of all characters in the font in tenth of pixel

-- 	private_average_width: INTEGER;
-- 			-- Width of all characters in the font in tenth of pixel

-- 	private_character_set: STRING;
-- 			-- (iso8859-1...)

-- 	private_horizontal_resolution: INTEGER;
-- 			-- Horizontal resolution of screen for which the font is designed

-- 	private_foundry: STRING;
-- 			-- Foundry name (Adobe...)

-- 	private_is_standard: BOOLEAN;
-- 			-- Is the font standard and informations available ?
	
-- 	private_pixel_size: INTEGER;
-- 			-- Size of font in pixel

-- 	private_point: INTEGER;
-- 			-- Size of font in tenth of points (1 point = 1/72 of an inch)

-- 	private_family: STRING;
-- 			-- Family name (Courier, Helvetica...)

-- 	private_is_proportional: BOOLEAN;
-- 			-- Is the font proportional ?

-- 	private_slant: CHARACTER;
-- 			-- Slant of font (o, r, i...)

-- 	private_vertical_resolution: INTEGER;
-- 			-- Vertical resolution of screen for which the font is designed

-- 	private_weight: STRING;
-- 			-- Weight of font (Bold, Medium...)

-- 	is_parsed: BOOLEAN;
-- 			-- Is `name' parsed and values available?

-- 	parse_if_not_yet is
-- 			-- Parse `name' if it isn't yet parsed.
-- 		do
-- 			if not is_parsed then
-- 				parse_name
-- 			end
-- 		ensure
-- 			is_parsed: is_parsed
-- 		end;

-- 	parse_name is
-- 			-- Parse `name' and set values.
-- 		require
-- 			is_specified: is_specified;
-- 			not_parsed: not is_parsed
-- 		local
-- 			pos, new_pos: INTEGER;
-- 			number: INTEGER;
-- 			parsed: ARRAY [STRING]
-- 		do
-- 			is_parsed := true;
-- 			if name.item (1) = '-' then
-- 				from
-- 					pos := 1;
-- 					!! parsed.make (1, 13);
-- 					number := 1
-- 				until
-- 					(pos > name.count) or (number = 13)
-- 				loop
-- 					new_pos := next_minus (name, pos);
-- 					if pos < new_pos-1 then
-- 						parsed.put (name.substring (pos+1, new_pos-1), number)
-- 					end;
-- 					number := number+1;
-- 					pos := new_pos
-- 				end;
-- 				if pos <= name.count then
-- 					private_foundry := parsed.item (1);
-- 					private_family := parsed.item (2);
-- 					private_weight := parsed.item (3);
-- 					private_slant := parsed.item (4).item (1);
-- 					private_width := parsed.item (5);
-- 					private_pixel_size := parsed.item (7).to_integer;
-- 					private_point := parsed.item (8).to_integer;
-- 					private_horizontal_resolution := parsed.item (9).to_integer;
-- 					private_vertical_resolution := parsed.item (10).to_integer;
-- 					private_is_proportional := parsed.item (11).item (1) = 'p';
-- 					private_average_width := parsed.item (12).to_integer;
-- 					private_character_set := name.substring (pos+1, name.count);
-- 					private_is_standard := true
-- 				end
-- 			end
-- 		ensure
-- 			is_parsed: is_parsed
-- 		end;

-- 	update_widget_resource (widget_m: WIDGET_IMP) is
-- 			-- Update resource for `widget_m'.
-- 			-- Set `updated' to True if the resource was set.
-- 		local
-- 			terminal_m: TERMINAL_IMP;
-- 			fontable_m: FONTABLE_IMP;
-- 			font: EV_FONT
-- 		do
-- 			fontable_m ?= widget_m;
-- 			if fontable_m /= Void then
-- 				font := fontable_m.private_font;
-- 				if (font /= Void) and then 
-- 					(font.implementation = Current)
-- 				then
-- 					fontable_m.update_font;
-- 					number_of_users := number_of_users + 1	
-- 				end
-- 			else
-- 				terminal_m ?= widget_m;
-- 				if terminal_m /= Void then
-- 					font := terminal_m.label_font;
-- 					if (font /= Void) and then
-- 						(font.implementation = Current)
-- 					then
-- 						terminal_m.update_label_font;
-- 						number_of_users := number_of_users + 1
-- 					end
-- 					font := terminal_m.text_font;
-- 					if (font /= Void) and then
-- 						(font.implementation = Current)
-- 					then
-- 						terminal_m.update_text_font;
-- 						number_of_users := number_of_users + 1
-- 					end
-- 					font := terminal_m.button_font;
-- 					if (font /= Void) and then
-- 						(font.implementation = Current)
-- 					then
-- 						terminal_m.update_button_font;
-- 						number_of_users := number_of_users + 1
-- 					end
-- 				end
-- 			end
-- 		end; 

-- 	next_minus (a_string: STRING; pos: INTEGER): INTEGER is
-- 			-- Next minus's position after `pos' in `a_string'
-- 		require
-- 			a_string_exists: not (a_string = Void);
-- 			pos_smaller_enough: pos < a_string.count;
-- 			pos_larger_enough: pos >= 1
-- 		do
-- 			from
-- 				Result := pos+1
-- 			until
-- 				(Result > a_string.count) or else (a_string.item (Result) = '-')
-- 			loop
-- 				Result := Result+1
-- 			end
-- 		ensure
-- 			Result > pos;
-- 			Result <= a_string.count implies a_string.item (Result) = '-';
-- 			Result <= a_string.count+1
-- 		end;

end -- class EV_FONT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

