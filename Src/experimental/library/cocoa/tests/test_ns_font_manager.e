note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
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
			manager: NS_FONT_MANAGER
			font: NS_FONT
			font2: NS_FONT
		do
			create env
			create font.system_font_of_size (12.0)
			font2 := env.shared_font_manager.convert_font_to_size (font, 8.0)
			assert ("New font size", (font2.point_size - 8.0).abs < .001)
		end

end
