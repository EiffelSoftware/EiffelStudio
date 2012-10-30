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
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
		do
			create pixmap.make_with_size (123, 345)

			assert ("size_correct", pixmap.width = 123 and pixmap.height = 345)
		end

	clear
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent test_clear)
		end

	load_save
			-- Load and save
		note
			testing: "execution/isolated"
		do
			test_unicode_load_and_save
		end

feature {NONE} -- Actual Test

	test_clear
		local
			pixmap: EV_PIXMAP
			window: EV_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (red)
			pixmap.clear

			create window
			window.extend (pixmap)
			window.set_size (100, 100)
			window.show
		end

	test_unicode_load_and_save
		local
			pixmap: EV_PIXMAP
			l_u: FILE_UTILITIES
			l_file: RAW_FILE
		do
			if l_u.file_exists (image_path) then
				l_file := l_u.make_raw_file (image_path)
				l_file.delete
			end

			create pixmap
			pixmap.set_size (10, 10)
			pixmap.save_to_named_file (create {EV_PNG_FORMAT}, image_path)

			assert ("File saved.", l_u.file_exists (image_path))

			create pixmap
			pixmap.set_with_named_file (image_path)

			assert ("File loaded.", pixmap.width = 10 and then pixmap.height = 10)
		end

feature {NONE} -- Helpers

    red: EV_COLOR
    	once
    		create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}0.0, {REAL_32}0.0)
    	end

    image_path: STRING_32 = "测试图片.png";

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
