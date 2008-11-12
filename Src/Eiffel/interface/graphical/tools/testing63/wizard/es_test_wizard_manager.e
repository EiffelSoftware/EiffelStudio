indexing
	description: "Summary description for {ES_TEST_WIZARD_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER

	ES_SHARED_LOCALE_FORMATTER

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_development_window: EB_DEVELOPMENT_WINDOW)
			-- Initialize `Current'.
		do
			create wizard_info.make
			make_and_show (a_development_window.window, create {ES_TEST_WIZARD_INITIAL_WINDOW}.make_window (a_development_window, wizard_info))
		end

feature -- Access

	wizard_title: STRING_32 is
			-- <Precursor>
		do
			Result := local_formatter.translation ("New eiffel test")
		end

	wizard_icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_testing_icon

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width /= 60 or Result.height /= 60 then
				Result.set_size (60, 60)
			end
		end

	wizard_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_blue

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width < 165 or Result.height < 312 then
				Result.set_size (165, 312)
			end
		end

	wizard_window_icon: EV_PIXMAP
			-- <Precursor>
		do
		end

feature {NONE} -- Access

	wizard_info: ES_TEST_WIZARD_INFORMATION
			-- Information

end
