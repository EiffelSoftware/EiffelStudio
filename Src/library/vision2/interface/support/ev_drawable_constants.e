indexing
	description: "[
		Constants for use by and with EV_DRAWABLE.

		Note: With every drawing mode constant, a truth table is given.
		S means the source. This is the color of the pixel that is about
		to be applied. T means target. This is the color of the pixel that
		is currently on the place where the new pixel is about to be set.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, primitives, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWABLE_CONSTANTS

feature -- Constants

	Drawing_mode_copy: INTEGER is 0
			-- Normal drawing mode.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 1 |
			-- -------------
			--   1 | 0 | 1 |

	Drawing_mode_xor: INTEGER is 1
			-- Drawing mode where bitwise XOR is performed when a
			-- pixel is drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 1 |
			-- -------------
			--   1 | 1 | 0 |

	Drawing_mode_invert: INTEGER is 2
			-- Drawing mode where bits are inverted before drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 1 | 0 |
			-- -------------
			--   1 | 1 | 0 |

	Drawing_mode_and: INTEGER is 3
			-- Drawing mode where bitwise AND is performed when a
			-- pixel is drawn.
			--
			-- T\S | 0 | 1 |
			-- -------------
			--   0 | 0 | 0 |
			-- -------------
			--   1 | 0 | 1 |

	Drawing_mode_or: INTEGER is 4
			-- Drawing mode where bitwise OR is performed when a
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
			Result := a_mode = Drawing_mode_copy or else
				a_mode = Drawing_mode_xor or else
				a_mode = Drawing_mode_invert or else
				a_mode = Drawing_mode_and or else
				a_mode = Drawing_mode_or
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DRAWABLE_CONSTANTS

