indexing
	description:
		"Eiffel Vision drawable constants.%N%
		%Used by EV_DRAWABLE. Inherit if you need the constants."
	note:
		"With every drawing mode constant, a truth table is given.%N%
		%S means the source. This is the color of the pixel that is about%N%
		%to be applied. T means target. This is the color of the pixel that%N%
		%is currently on the place where the new pixel is about to be set."
	status: "See notice at end of class"
	keywords: "figures, primitives, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWABLE_CONSTANTS

feature -- Constants

	Ev_drawing_mode_copy: INTEGER is 0
			-- Normal drawing mode.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 1 |
			-- -------------
			--   1 | 0 | 1 |

	Ev_drawing_mode_xor: INTEGER is 1
			-- Drawing mode where bitwise XOR is performed when a
			-- pixel is drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 1 |
			-- -------------
			--   1 | 1 | 0 |

	Ev_drawing_mode_invert: INTEGER is 2
			-- Drawing mode where bits are inverted before drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 1 | 0 |
			-- -------------
			--   1 | 1 | 0 |

	Ev_drawing_mode_and: INTEGER is 3
			-- Drawing mode where bitwise AND is performed when a
			-- pixel is drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 0 |
			-- -------------
			--   1 | 0 | 1 |

	Ev_drawing_mode_or: INTEGER is 4
			-- Drawing mode where bitwise XOR is performed when a
			-- pixel is drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 1 |
			-- -------------
			--   1 | 1 | 1 |

feature -- Contract support

	valid_drawing_mode (a_mode: INTEGER): BOOLEAN is
			-- Is `a_mode' a valid drawing mode?
		do
			Result := a_mode = Ev_drawing_mode_copy or else
				a_mode = Ev_drawing_mode_xor or else
				a_mode = Ev_drawing_mode_invert or else
				a_mode = Ev_drawing_mode_and or else
				a_mode = Ev_drawing_mode_or
		end

end -- class EV_DRAWABLE_CONSTANTS

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
--| Revision 1.2  2000/02/14 12:05:12  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.7  2000/01/28 20:00:10  oconnor
--| released
--|
--| Revision 1.1.2.6  2000/01/27 19:30:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.5  2000/01/25 22:19:43  brendel
--| Removed _enum from drawing mode constants.
--|
--| Revision 1.1.2.4  2000/01/22 00:56:33  brendel
--| Added valid_drawing_mode.
--|
--| Revision 1.1.2.3  2000/01/14 00:27:25  oconnor
--| comment tweaks
--|
--| Revision 1.1.2.2  1999/12/08 23:45:03  brendel
--| Removed redundant constants.
--| Added nice truth table for consts.
--|
--| Revision 1.1.2.1  1999/12/08 19:18:23  brendel
--| Initial.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
