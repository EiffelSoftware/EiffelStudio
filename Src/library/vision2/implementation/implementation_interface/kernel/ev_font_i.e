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

	preferred_faces: ACTIVE_LIST [STRING]
			-- Preferred user fonts.
			-- `family' will be ignored when not Void.

feature -- Element change

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_faces: like preferred_faces) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_faces' at the same time for speed.
		require
			a_family_valid: valid_family (a_family)
			a_weight_valid: valid_weight (a_weight)
			a_shape_valid: valid_shape (a_shape)
			a_height_bigger_than_zero: a_height > 0
			a_preferred_faces_not_void: a_preferred_faces /= Void
		do
			preferred_faces := a_preferred_faces
			update_font_face
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
		end

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
		require
			a_string_not_void: a_string /= Void
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

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- `Result' is [width, height] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		require
			a_string_not_void: a_string /= Void
		local
			cur_width, cur_height: INTEGER
			index, n: INTEGER
			s: STRING
		do
			from
				n := 1
			until
				n > a_string.count
			loop
				index := a_string.index_of ('%N', n)
				if index > 0 then
					s := a_string.substring (n, index - 1)
					n := index + 1
				else
					s := a_string.substring (n, a_string.count)
					n := a_string.count + 1
				end
				cur_width := cur_width.max (string_width (s))
				cur_height := cur_height + height
			end
			Result := [cur_width, cur_height]
		end

feature {EV_FONT_I} -- Implementation

	interface: EV_FONT

	update_font_face is
			-- Update the font face according to `preferred_faces' and `family'.
		deferred
		ensure
			name_not_void: name /= Void
		end

invariant
	family_valid: is_initialized implies valid_family (family)
	weight_valid: is_initialized implies valid_weight (weight)
	shape_valid: is_initialized implies valid_shape (shape)
	height_bigger_than_zero: is_initialized implies height > 0
	ascent_bigger_than_zero: is_initialized implies ascent > 0
	descent_bigger_than_zero: is_initialized implies descent > 0
	width_of_empty_string_equals_zero: is_initialized implies string_width("") = 0

	--| FIXME  IEK Does not hold true in gtk for all fonts.
	--horizontal_resolution_bigger_than_zero: horizontal_resolution > 0
	--vertical_resolution_bigger_than_zero: vertical_resolution > 0

end -- class EV_FONT_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.15  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.4.9  2001/01/25 17:28:39  rogers
--| Set values calls `update_font_face' before setting other attributes.
--|
--| Revision 1.10.4.8  2000/10/16 14:16:56  pichery
--| Removed obsolete features
--|
--| Revision 1.10.4.7  2000/09/07 22:34:16  king
--| Added is_initialized to font invariants
--|
--| Revision 1.10.4.6  2000/08/17 22:01:24  rogers
--| Comments, formatting.
--|
--| Revision 1.10.4.5  2000/06/25 18:00:54  brendel
--| Added string_size, in a platform independent way.
--|
--| Revision 1.10.4.4  2000/06/19 17:45:50  king
--| Added post cond to update_face_name
--|
--| Revision 1.10.4.3  2000/06/17 08:21:17  pichery
--| Fixed small bug. The face was not updated after
--| a call on `set_values'.
--|
--| Revision 1.10.4.2  2000/06/15 03:37:37  pichery
--| Replaced `preferred_face' with
--| `preferred_faces'
--|
--| Revision 1.10.4.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/03/28 21:48:14  brendel
--| Added set_values, to be redefined by toolkits for speed.
--|
--| Revision 1.13  2000/03/03 00:52:37  brendel
--| Added precondition to string_width.
--|
--| Revision 1.12  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
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
--| Removed pre-condition from string_width as the string can now be Void.
--| An count of 0 on the string, will have Void returned.
--|
--| Revision 1.10.6.4  2000/01/10 19:14:06  king
--| Changed interface.
--| Improved comments.
--| Improved contracts.
--| set_name is now obsolete.
--|
--| Revision 1.10.6.3  2000/01/10 17:17:43  rogers
--| Removed pre-condition on string width, for compilation purposes.
--| This is only temporary as font is be re-worked currently.
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
