note
	description: "Tests for EV_TOOLBAR"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_TOOLBAR

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	toolbar_with_button_icons
		note
			testing: "execution/isolated"
		local
			toolbar: EV_TOOL_BAR
			tool_bar_button: EV_TOOL_BAR_BUTTON
			window: EV_TITLED_WINDOW
			stock_pixmaps: EV_STOCK_PIXMAPS
		do
			create stock_pixmaps
			create toolbar

			create tool_bar_button.make_with_text ("Button 1")
			tool_bar_button.set_pixmap (stock_pixmaps.default_window_icon)
			toolbar.extend (tool_bar_button)

			create tool_bar_button.make_with_text ("Button 2")
			toolbar.extend (tool_bar_button)

			create window
			window.extend (toolbar)
			window.show
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
