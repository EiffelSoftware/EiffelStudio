note
	description:
		"Facilities used by and for ues with EV_FONT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, size, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_CONSTANTS

feature -- Constants

	Family_screen: INTEGER = 1
	Family_roman: INTEGER = 2
	Family_sans: INTEGER = 3
	Family_typewriter: INTEGER = 4
	Family_modern: INTEGER = 5

	Weight_thin: INTEGER = 6
	Weight_regular: INTEGER = 7
	Weight_bold: INTEGER = 8
	Weight_black: INTEGER = 9

	Shape_regular: INTEGER = 10
	Shape_italic: INTEGER = 11

feature -- Contract support

	valid_family (a_family: INTEGER): BOOLEAN
			-- Is `a_family' a valid family value.
		do
			Result := a_family = family_screen or else
				a_family = family_roman or else
				a_family = family_sans or else
				a_family = family_typewriter or else
				a_family = family_modern
		end

	valid_weight (a_weight: INTEGER): BOOLEAN
			-- Is `a_weight' a valid weight value.
		do
			Result := a_weight = weight_thin or else
				a_weight = weight_regular or else
				a_weight = weight_bold or else
				a_weight = weight_black
		end

	valid_shape (a_shape: INTEGER): BOOLEAN
			-- Is `a_shape' a valid shape value.
		do
			Result := a_shape = shape_regular or else
				a_shape = shape_italic
		end

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




end -- class EV_FONT_CONSTANTS

