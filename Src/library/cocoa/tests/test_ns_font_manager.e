note
	description: "Tests for NS_FONT_MANAGER."
	author: "Colin"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_NS_FONT_MANAGER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_size_change
			-- Test the NSFontManager changing the font size
		local
			env: NS_ENVIRONEMENT
			font: NS_FONT
			font2: NS_FONT
		do
			create env
			create font.system_font_of_size (12.0)
			font2 := env.shared_font_manager.convert_font_to_size (font, 8.0)
			assert ("New font size", (font2.point_size - 8.0).abs < .001)
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
