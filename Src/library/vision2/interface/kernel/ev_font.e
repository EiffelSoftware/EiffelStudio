indexing
	description:
		"Eiffel Vision font. Representation of a typeface.%N%
		%Appearance is specified in terms of font family, height, shape and%N%
		%weight. The local system font closest to the specification will be%N%
		%displayed. A specific font name may optionally be specified.%N%
		%(see `set_preferred_face')"
	status: "See notice at end of class"
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT 

inherit
	EV_ANY
		redefine
			implementation,
			is_equal,
			copy,
			is_in_default_state
		end

	EV_FONT_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_family, a_weight, a_shape, a_height: INTEGER) is
			-- Create with `a_family', `a_weight', `a_shape' and `a_height'.
		require
			a_family_valid: valid_family (a_family)
			a_weight_valid: valid_weight (a_weight)
			a_shape_valid: valid_shape (a_shape)
			a_height_bigger_than_zero: a_height > 0
		do
			default_create
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
		end

feature -- Access

	family: INTEGER is
			-- Font category. Can be any of the Ev_font_family_* constants
			-- defined in EV_FONT_CONSTANTS.
			-- Default: Ev_font_family_sans
		do
			Result := implementation.family
		ensure
			bridge_ok: Result = implementation.family
		end

	weight: INTEGER is
			-- Preferred font thickness. Can be any of the Ev_font_weight_*
			-- constants defined in EV_FONT_CONSTANTS.
			-- Default: Ev_font_weight_regular
		do
			Result := implementation.weight
		ensure
			bridge_ok: Result = implementation.weight
		end

	shape: INTEGER is
			-- Preferred font slant. Can be any of the Ev_font_shape_*
			-- constants defined in EV_FONT_CONSTANTS.
			-- Default: Ev_font_shape_regular
		do
			Result := implementation.shape
		ensure
			bridge_ok: Result = implementation.shape
		end

	height: INTEGER is
			-- Preferred font height in pixels.
			-- Default: 8
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
		end

	preferred_face: STRING is
			-- Preferred typeface.
			-- Overrides `family' if found on current system.
		do
			Result := implementation.preferred_face
		ensure
			bridge_ok: Result = implementation.preferred_face
		end 

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Assign  `a_family' to `family'.
		require
			a_family_valid: valid_family (a_family)
		do
			implementation.set_family (a_family)
		ensure
			family_assigned: family = a_family
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' to `weight'.
		require
			a_weight_valid: valid_weight (a_weight)
		do
			implementation.set_weight (a_weight)
		ensure
			weight_assigned: weight = a_weight
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' to `shape'.
		require
			a_shape_valid: valid_shape (a_shape)
		do
			implementation.set_shape (a_shape)
		ensure
			shape_assigned: shape = a_shape
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' to `height'.
		require
			a_height_bigger_than_zero: a_height > 0
		do
			implementation.set_height (a_height)
		ensure
			height_assigned: height = a_height
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER) is
			-- set all the four parameters
		require
			a_family_valid: valid_family (a_family)
			a_weight_valid: valid_weight (a_weight)
			a_shape_valid: valid_shape (a_shape)
			a_height_bigger_than_zero: a_height > 0
		do
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
		end

	set_preferred_face (a_preferred_face: STRING) is
			-- Set `a_preferred_face' to `preferred_face'.
		require
			a_preferred_face_not_void: a_preferred_face /= Void
		do
			implementation.set_preferred_face (a_preferred_face)
		ensure
			preferred_face_assigned: preferred_face = a_preferred_face
		end

	remove_preferred_face is
			-- Set `a_preferred_face' to Void.
		do
			implementation.remove_preferred_face
		ensure
			preferred_face_void: preferred_face = Void
 		end

feature -- Status report

	name: STRING is
			-- Face name chosen by toolkit.
		do
			Result := implementation.name
		ensure
			bridge_ok: Result.is_equal (implementation.name)
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		do
			Result := implementation.ascent 
		ensure
			bridge_ok: Result = implementation.ascent
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		do
			Result := implementation.descent 
		ensure
			bridge_ok: Result = implementation.descent
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
			-- If font is proportional, returns the average width.
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
			Result := implementation.maximum_width
		ensure
			bridge_ok: Result = implementation.maximum_width
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		require
			a_string_not_void: a_string /= Void
		do
			Result := implementation.string_width (a_string)
		ensure
			bridge_ok: Result = implementation.string_width (a_string)
			positive: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
			-- Measured in dots per inch. If return value is zero, the
			-- resolution is not known.
		do
			Result := implementation.horizontal_resolution
		ensure
			bridge_ok: Result = implementation.horizontal_resolution
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
			-- Measured in dots per inch. If return value is zero, the
			-- resolution is not known.
		do
			Result := implementation.vertical_resolution
		ensure
			bridge_ok: Result = implementation.vertical_resolution
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different widths?
		do
			Result := implementation.is_proportional
		ensure
			bridge_ok: Result = implementation.is_proportional
		end

feature -- Basic operations

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have same appearance?
		do
			Result := family = other.family and then
				weight = other.weight and then
				shape = other.shape and then
				height = other.height and then
				(preferred_face = other.preferred_face or else
				preferred_face.is_equal (other.preferred_face))
		end

	copy (other: like Current) is
			-- Update `Current' with all attributes of `other'.
		do
			set_family (other.family)
			set_weight (other.weight)
			set_shape (other.shape)
			set_height (other.height)
			if other.preferred_face /= Void then
				set_preferred_face (other.preferred_face)
			end
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_FONT_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_FONT_IMP} implementation.make (Current)
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_ANY} Precursor and then
				family = Ev_font_family_sans and then
				weight = Ev_font_weight_regular and then
				shape = Ev_font_shape_regular and then
				preferred_face = Void
				--| Nothing about size since they are different
				--| on each platform. (Win: 8; GTK: 11)
				--| FIXME there should be a 
		end

feature -- Obsolete

	set_name (str: STRING) is
			-- Make `str' the new name of the string.
		obsolete
			"Use either set_family or set_preferred_face."
		do
			check
				not_used_anymore: False
			end
		end

	set_system_name (str: STRING) is
			-- Make `str' the new name of the string.
		obsolete
			"Use either set_family or set_preferred_face."
		do
			check
				not_used_anymore: False
			end
		end

	system_name: STRING is
			-- Platform dependent font name.
		obsolete
			"Platform dependent so not a vision feature."
		do
			Result := implementation.system_name
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and information available (except for name)?
		obsolete
			"Is this needed?"
 		do
 			Result := implementation.is_standard
 		end

invariant
	family_valid: valid_family (family)
	weight_valid: valid_weight (weight)
	shape_valid: valid_shape (shape)
	height_bigger_than_zero: height > 0
	ascent_bigger_than_zero: ascent > 0
	descent_bigger_than_zero: descent > 0
	height_positive: height > 0
	ascent_positive: ascent > 0
	descent_positive: descent > 0
	width_of_empty_string_equals_zero: string_width("") = 0
	horizontal_resolution_non_negative: horizontal_resolution >= 0
	vertical_resolution_non_negative: vertical_resolution >= 0

end -- class EV_FONT

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.15  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.6.20  2000/02/07 20:55:50  pichery
--| - added feature "set_values" to EV_FONT
--| - fixed some bugs (replaced 0 with 0.0 - because DOUBLE were expected)
--|   in the class ASSIGN_ATTEMPT
--|
--| Revision 1.14.6.19  2000/01/28 20:02:21  oconnor
--| released
--|
--| Revision 1.14.6.18  2000/01/27 19:30:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.6.17  2000/01/25 01:20:42  brendel
--| Improved comments.
--|
--| Revision 1.14.6.16  2000/01/24 20:14:53  oconnor
--| added comments
--|
--| Revision 1.14.6.15  2000/01/21 20:09:11  brendel
--| Improved contracts.
--| Added feature `copy'.
--|
--| Revision 1.14.6.14  2000/01/21 19:35:56  king
--| Altered naming conventions of > 0 assertions to be positive instead of
--| greater_than_zero
--|
--| Revision 1.14.6.13  2000/01/21 19:16:09  king
--| Commented out resolution invariants as they do not hold for some fonts in
--| GTK
--|
--| Revision 1.14.6.12  2000/01/18 18:09:30  brendel
--| Corrected `is_equal'.
--| Added `is_in_default_state'.
--|
--| Revision 1.14.6.11  2000/01/18 17:42:46  brendel
--| Added redefine of is_equal.
--|
--| Revision 1.14.6.10  2000/01/18 17:30:41  king
--| Added `is_equal'.
--|
--| Revision 1.14.6.9  2000/01/17 17:41:18  brendel
--| Fixed spelling error(s).
--|
--| Revision 1.14.6.8  2000/01/17 17:36:49  oconnor
--| comments and formatting
--|
--| Revision 1.14.6.7  2000/01/17 17:17:16  brendel
--| Removed commented out invariant.
--|
--| Revision 1.14.6.6  2000/01/17 17:15:50  brendel
--| Moved comment about default values to features.
--| Commented out invariant that will not hold.
--|
--| Revision 1.14.6.5  2000/01/11 00:59:51  king
--| Changed note in indexing clause.
--|
--| Revision 1.14.6.4  2000/01/10 19:14:06  king
--| Changed interface.
--| Improved comments.
--| Improved contracts.
--| set_name is now obsolete.
--|
--| Revision 1.14.6.3  1999/12/17 21:00:59  rogers
--| make_with_name, make_with_system and set implementation have been commented
--| out. They need to be re-implemented as required.
--|
--| Revision 1.14.6.2  1999/12/01 21:46:43  brendel
--| Added FIXME with suggestion for `minimum_width'.
--|
--| Revision 1.14.6.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.4  1999/11/04 23:10:53  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.14.2.3  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
