indexing
	description: "Test of dialogs."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	DIALOG_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			test_dialogs
		end

	test_dialogs is
		local
			but: EV_BUTTON
		do
			create but.make_with_text ("dialog test")
			first_window.extend (but)
			but.press_actions.extend (~on_click)
		end

	on_click is
		local
			qdlg: EV_QUESTION_DIALOG
			wdlg: EV_WARNING_DIALOG
			idlg: EV_INFORMATION_DIALOG
			edlg: EV_ERROR_DIALOG
		do
			create idlg.make_with_text ("This is your text%NThis toooo")
			idlg.show_modal
			create wdlg.make_with_text ("I warned you...")
			wdlg.show_modal
			create edlg.make_with_text ("Sorrrry you has an firus on you're c-drive.")
			edlg.show_modal
			create qdlg.make_with_text ("Does it work?")
			qdlg.show_modal			
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
			Result.show
			Result.set_size (300, 300)
		end

end -- class DIALOG_TEST
