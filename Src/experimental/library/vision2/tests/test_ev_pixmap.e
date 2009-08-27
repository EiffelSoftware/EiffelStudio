note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_PIXMAP

inherit
	VISION2_TEST_SET

feature -- Test routines

	create_with_size
			-- Set the text and reads it again.
		local
			pixmap: EV_PIXMAP
		do
			create pixmap.make_with_size (123, 345)

			assert ("size_correct", pixmap.width = 123 and pixmap.height = 345)
		end

	clear
			-- Set the text and reads it again.
		local
			pixmap: EV_PIXMAP
			window: EV_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (red)
			pixmap.clear

			create window
			window.extend (pixmap)
			window.show

			from until False loop
				application.process_graphical_events
				application.process_events
			end
		end

feature -- Helpers

    red: EV_COLOR
    	once
    		create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}0.0, {REAL_32}0.0)
    	end

end
