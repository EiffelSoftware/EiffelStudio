indexing
	description:
		"[
			Implementation Interface of Character format containing color,
			font and effects information for text formatting.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHARACTER_FORMAT_I
	
inherit
	EV_ANY_I
		redefine
			interface,
			out
		end

feature -- Access

	font: EV_FONT is
			-- Font of the current format.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
	
	color: EV_COLOR is
			-- Color of the current format.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	background_color: EV_COLOR is
			-- Background color of the current format.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	out: STRING is
			-- Terse printable representation of `Current'.
		local
			value: INTEGER
			l_color: INTEGER
		do
			Result := family.out
			Result.append (name)
			Result.append (height.out)
			Result.append (weight.out)
			Result.append (shape.out)
			
			l_color := fcolor
			value := l_color |>> 16
			Result.append (value.to_integer_8.out)
			value := l_color |>> 8
			Result.append (value.to_integer_8.out)
			Result.append (l_color.to_integer_8.out)
			l_color := bcolor
			value := l_color |>> 16
			Result.append (value.to_integer_8.out)
			value := l_color |>> 8
			Result.append (value.to_integer_8.out)
			Result.append (l_color.to_integer_8.out)
			
			Result.append (is_underlined.out)
			Result.append (is_striked_out.out)
			Result.append (vertical_offset.out)
		end

feature -- Status setting
		
	set_font (a_font: EV_FONT) is
			-- Make `value' the new font.
		require
			font_not_void: a_font /= Void
		deferred
		ensure
			font_set: font.is_equal (a_font)
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color.
		require
			color_not_void: a_color /= Void
		deferred
		ensure
			color_set: color.is_equal (a_color)
		end
		
	set_background_color (a_color: EV_COLOR) is
			-- Make `value' the new background color.
		require
			color_not_void: a_color /= Void
		deferred
		ensure
			color_set: background_color.is_equal (a_color)
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'.
		require
			effect_not_void: an_effect /= Void
		deferred
		ensure
			effects_set: effects.is_equal (an_effect)
		end
		
feature {EV_RICH_TEXT_BUFFERING_STRUCTURES_I} -- Implementation

	name: STRING is
			-- Face name used by `Current'.
		deferred
		end
		
	family: INTEGER is
			-- Family used by `Current'.
		deferred
		end
		
	height: INTEGER is
			--  Height of `Current'.
		deferred
		end
		
	weight: INTEGER is
			-- Weight of `Current'.
		deferred
		end
		
	is_bold: BOOLEAN is
			-- Is `Current' bold?
		deferred
		end
		
	shape: INTEGER is
			-- Shape of `Current'.
		deferred
		end

	char_set: INTEGER is
			-- Char set used by `Current'.
		deferred
		end
		
	is_underlined: BOOLEAN is
			-- Is `Current' underlined?
		deferred
		end
		
	is_striked_out: BOOLEAN is
			-- Is `Current' striken out?
		deferred
		end
		
	vertical_offset: INTEGER is
			-- Vertical offset of `Current'.
		deferred
		end

	fcolor: INTEGER is
			-- foreground color RGB packed into 24 bit.
			-- Blue is the high part of the 24bits, with each color taking 8 bytes.
			-- Blue, Green, Red
		deferred
		end
		
	bcolor: INTEGER is
			-- background color RGB packed into 24 bit.
			-- Blue is the high part of the 24bits, with each color taking 8 bytes.
			-- Blue, Green, Red
		deferred
		end

feature {EV_ANY_I, EV_RICH_TEXT_BUFFERING_STRUCTURES_I} -- Implementation

	interface: EV_CHARACTER_FORMAT

end -- class EV_CHARACTER_FORMAT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

