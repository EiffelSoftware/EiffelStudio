indexing
	description: "Eiffel Vision font. Implementation interface."
	status: "See notice at end of class"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_FONT_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	family: INTEGER is
			-- Preferred font category.
		deferred
		end

	weight: INTEGER is
			-- Preferred font thickness.
		deferred
		end

	shape: INTEGER is
			-- Preferred font slant.
		deferred
		end

	height: INTEGER is
			-- Preferred font height measured in screen pixels.
		deferred
		end

	preferred_face: STRING is
			-- Preferred user font.
			-- `family' will be ignored when not Void.
		deferred
		end 

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		require
			a_family_valid: valid_family (a_family)
		deferred
		ensure
			family_assigned: family = a_family
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		require
			a_weight_valid: valid_weight (a_weight)
		deferred
		ensure
			weight_assigned: weight = a_weight
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		require
			a_shape_valid: valid_shape (a_shape)
		deferred
		ensure
			shape_assigned: shape = a_shape
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size.
		require
			a_height_bigger_than_zero: a_height > 0
		deferred
		ensure
			height_assigned: height = a_height
		end

	set_preferred_face (a_preferred_face: STRING) is
			-- Set `a_preferred_face' as preferred font face.
		require
			a_preferred_face_not_void: a_preferred_face /= Void
		deferred
		ensure
			preferred_face_assigned: preferred_face = a_preferred_face
		end

	remove_preferred_face is
			-- Set `a_preferred_face' to Void.
		deferred
		ensure
			preferred_face_void: preferred_face = Void
		end

feature -- Status report

	name: STRING is
			-- Face name chosen by toolkit.
		deferred
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		deferred
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		deferred
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		deferred
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		deferred
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		deferred
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		deferred
		ensure
			positive: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		deferred
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		deferred
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		deferred
		end
 
feature -- Obsolete

	system_name: STRING is
			-- Platform dependent font name.
		deferred
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and informations available (except for name) ?
		deferred
 		end

feature {EV_FONT_I} -- Implementation

	interface: EV_FONT

invariant
	family_valid: valid_family (family)
	weight_valid: valid_weight (weight)
	shape_valid: valid_shape (shape)
	height_bigger_than_zero: height > 0
	ascent_bigger_than_zero: ascent > 0
	descent_bigger_than_zero: descent > 0
	width_of_empty_string_equals_zero: string_width("") = 0

	--| FIXME  IEK Does not hold true in gtk for all fonts.
	--horizontal_resolution_bigger_than_zero: horizontal_resolution > 0
	--vertical_resolution_bigger_than_zero: vertical_resolution > 0

end -- class EV_FONT_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.10  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.10.6.9  2000/01/27 19:29:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.8  2000/01/21 20:10:58  brendel
--| Improved contracts.
--|
--| Revision 1.10.6.7  2000/01/21 19:10:59  king
--| Removed resolution invariants as they fail in gtk on some fonts
--|
--| Revision 1.10.6.6  2000/01/17 17:19:27  brendel
--| Removed commented out invariant.
--|
--| Revision 1.10.6.5  2000/01/10 20:17:15  rogers
--| Removed pre-condition from string_width as the string can now be Void. An count of 0 on the string, will have Void returned.
--|
--| Revision 1.10.6.4  2000/01/10 19:14:06  king
--| Changed interface.
--| Improved comments.
--| Improved contracts.
--| set_name is now obsolete.
--|
--| Revision 1.10.6.3  2000/01/10 17:17:43  rogers
--| Removed pre-condition on string width, for compilation purposes. This is only temporary as font is be re-worked currently.
--|
--| Revision 1.10.6.2  1999/11/30 22:50:47  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.10.6.1  1999/11/24 17:30:05  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
