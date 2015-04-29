note
	description: "System root class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: TEST_EV_MODEL
		do
			create t
			t.test_hidden_figure
		end

feature {NONE} -- Convenience

	tests: detachable TUPLE [
		TEST_EV_APPLICATION,
		TEST_EV_BUTTON,
		TEST_EV_COLOR,
		TEST_EV_CONTAINER,
		TEST_EV_DIALOG,
		TEST_EV_DRAWING_AREA,
		TEST_EV_FONT,
		TEST_EV_GRID,
		TEST_EV_MODEL,
		TEST_EV_NOTEBOOK,
		TEST_EV_PIXEL_BUFFER,
		TEST_EV_PIXMAP,
		TEST_EV_SCREEN,
		TEST_EV_STANDARD_DIALOG,
		TEST_EV_TEXT,
		TEST_EV_TIMEOUT,
		TEST_EV_TOOLBAR,
		TEST_EV_VIEWPORT,
		TEST_EV_WINDOW,
		TEST_UNICODE]

invariant

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
