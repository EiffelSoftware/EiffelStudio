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
			interface
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

feature {NONE} -- Implementation

	interface: EV_CHARACTER_FORMAT

end -- class EV_CHARACTER_FORMAT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

