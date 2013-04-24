note
	description:
		"[
			Character format containing color, font and effects information for text formatting.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state,
			is_equal,
			copy,
			out
		end

create
	default_create,
	make_with_font,
	make_with_font_and_color,
	make_with_values

feature {NONE} -- Initialization

	make_with_font (a_font: EV_FONT)
			-- Create `Current' with font `a_font'.
		require
			font_not_void: a_font /= Void
		do
			default_create
			set_font (a_font)
			changed := True
		ensure
			font_set: font.is_equal (a_font)
		end

	make_with_font_and_color (a_font: EV_FONT; a_color, a_background_color: EV_COLOR)
			-- Create `Current' with font `a_font', color `a_color' and
			-- background_color `a_background_color'.
		require
			font_not_void: a_font /= Void
			color_not_void: a_color /= Void
			background_color_not_void: a_background_color /= Void
		do
			default_create
			set_font (a_font)
			set_color (a_color)
			set_background_color (a_background_color)
			changed := True
		ensure
			font_set: font.is_equal (a_font)
			color_set: color.is_equal (a_color)
		end

	make_with_values (a_font: EV_FONT; a_color, a_background_color: EV_COLOR; an_effect: EV_CHARACTER_FORMAT_EFFECTS)
			-- Create `Current' with font `a_font', color `a_color', background color `a_background_color' and effects `an_effect'.
		require
			font_not_void: a_font /= Void
			color_not_void: a_color /= Void
			background_color_not_void: a_background_color /= Void
			effect_not_void: an_effect /= Void
		do
			default_create
			set_font (a_font)
			set_color (a_color)
			set_background_color (a_background_color)
			set_effects (an_effect)
			changed := True
		ensure
			font_set: font.is_equal (a_font)
			color_set: color.is_equal (a_color)
			effect_set: effects.is_equal (an_effect)
		end

feature -- Access

	font: EV_FONT
			-- Font of the current format.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.font
		ensure
			Result_not_void: Result /= Void
		end

	color: EV_COLOR
			-- Color of the current format.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.color
		ensure
			Result_not_void: Result /= Void
		end

	effects: EV_CHARACTER_FORMAT_EFFECTS
			-- Character format effects applicable to `font'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.effects
		ensure
			Result_not_void: Result /= Void
		end

	background_color: EV_COLOR
			-- Background color of the current format.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Make `a_font' the new font.
		require
			not_destroyed: not is_destroyed
			font_not_void: a_font /= Void
		do
			implementation.set_font (a_font)
			changed := True
		ensure
			font_set: font.is_equal (a_font)
		end

	set_color (a_color: EV_COLOR)
			-- Make `a_color' the new color.
		require
			not_destroyed: not is_destroyed
			color_not_void: a_color /= Void
		do
			implementation.set_color (a_color)
			changed := True
		ensure
			color_set: color.is_equal (a_color)
		end

	set_background_color (a_color: EV_COLOR)
			-- Make `a_color' the new background_color.
		require
			not_destroyed: not is_destroyed
			color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
			changed := True
		ensure
			color_set: background_color.is_equal (a_color)
		end

	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS)
			-- Make `an_effect' the new `effects'.
		require
			not_destroyed: not is_destroyed
			effect_not_void: an_effect /= Void
		do
			implementation.set_effects (an_effect)
			changed := True
		ensure
			effects_set: effects.is_equal (an_effect)
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `Current' considered equal to `other'?
		do
			Result := other.color.is_equal (color) and
				other.background_color.is_equal (background_color) and
				other.font.is_equal (font) and
				other.effects.is_equal (effects)
		end

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := implementation.out
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := color.is_equal ((create {EV_STOCK_COLORS}).black) and
			background_color.is_equal ((create {EV_STOCK_COLORS}).white) and
			effects.is_in_default_state
		end

feature -- Duplication

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			if implementation = Void then
				default_create
			end
				-- No need to copy the objects since we get a copy from `other'.
			implementation.set_color (other.color)
			implementation.set_background_color (other.background_color)
			implementation.set_font (other.font)
			implementation.set_effects (other.effects)
		end

feature {EV_RICH_TEXT_I, EV_RICH_TEXT_BUFFERING_STRUCTURES_I} -- Implementation

	hash_value: detachable STRING
			-- A hashable representation of `Current'.
		do
			if internal_out = Void or changed then
				internal_out := out
				changed := False
			end
			Result := internal_out
		end

	internal_out: detachable STRING
		-- Internal representation of last call to `out'. Buffered for speed, used in `hash_value'.

	changed: BOOLEAN
		-- Does `internal_out' require recomputation?

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_CHARACTER_FORMAT_I
			-- Implementation of the current object

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- Create implementation of drawing area.
		do
			create {EV_CHARACTER_FORMAT_IMP} implementation.make
		end

invariant
	font_not_void: font /= Void
	color_not_void: color /= Void
	effects_not_void: effects /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHARACTER_FORMAT











