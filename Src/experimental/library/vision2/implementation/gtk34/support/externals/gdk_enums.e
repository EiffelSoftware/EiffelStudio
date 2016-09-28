note
	description: "All GDK enums used by Vision2"
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_ENUMS

feature -- GdkSetCapabilities

	seat_capability_none: INTEGER_32
			-- No input capabilities
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_NONE;"
		end

	seat_capability_pointer: INTEGER_32
			-- The seat has a pointer (e.g. mouse)
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_POINTER;"
		end

	seat_capability_touch: INTEGER_32
			-- The seat has touchscreen(s) attached
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_TOUCH;"
		end

	seat_capability_tablet_stylus: INTEGER_32
			-- The seat has drawing tablet(s) attached
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_TABLET_STYLUS;"
		end

	seat_capability_keyboard: INTEGER_32
			-- The seat has keyboard(s) attached
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_KEYBOARD;"
		end

	seat_capability_all_pointing: INTEGER_32
			-- The union of all pointing capabilities
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_ALL_POINTING;"
		end

	seat_capability_all: INTEGER_32
			-- The union of all capabilities
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_SEAT_CAPABILITY_ALL;"
		end
 
end
