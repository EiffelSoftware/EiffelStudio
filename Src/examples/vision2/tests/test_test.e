indexing
	description: "Test of tests."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		local
			vb: EV_VERTICAL_BOX
			sa: EV_HORIZONTAL_SPLIT_AREA
		--	pix: EV_PIXMAP
		do
			first_window.set_title ("DYNAMIC_LIST test")
			create vb
			first_window.extend (vb)
			create test.make ("EV_HORIZONTAL_BOX", ~list_generator, ~item_generator)

		--	create pix
		--	pix.set_with_file (create {RAW_FILE}.make_open_read ("c:\eiffel46\bench\bitmaps\bmp\open.bmp"))
			create butt.make_with_text ("Perform test.")
		--	butt.set_pixmap (pix)

			butt.press_actions.extend (~perform)
			vb.extend (butt)
			vb.disable_child_expand (butt)
			create results_label
			vb.extend (results_label)			
			vb.disable_child_expand (results_label)
			create desc_label
			vb.extend (desc_label)
			create sa
			vb.extend (sa)
			sa.extend (create {EV_RADIO_BUTTON}.make_with_text ("B1"))
			sa.extend (create {EV_RADIO_BUTTON}.make_with_text ("B2"))
		end

	butt: EV_BUTTON
			-- Start the mayhem.

	results_label: EV_LABEL
			-- Label containing result of test.

	desc_label: EV_LABEL
			-- Label containing description of test.

	test: EV_LIST_TEST [EV_WIDGET]
			-- The test.

	item_generator: EV_BUTTON is
		do
			create Result
		end

	list_generator: EV_HORIZONTAL_BOX is
		do
			create Result
		end

	perform is
		do
			desc_label.set_text (test.description)
			results_label.set_text ("Testing... please wait.")
			butt.disable_sensitive
			test.execute
			butt.enable_sensitive
			results_label.set_text (test.test_successful.out)
			desc_label.set_text (test.description)
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEST_TEST
