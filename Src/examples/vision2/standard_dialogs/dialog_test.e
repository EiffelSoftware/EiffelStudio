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
			create fdlg
			create odlg
		end

	fdlg: EV_FILE_SAVE_DIALOG
	odlg: EV_FILE_OPEN_DIALOG

	on_click is
		do
			fdlg.set_filter ("*.e")
			fdlg.show_modal
			if fdlg.file_name /= Void then
				io.put_string ("Path: " + fdlg.file_path + "%N")
				io.put_string ("Name: " + fdlg.file_title + "%N")
				io.put_string ("Full: " + fdlg.file_name + "%N")
			end
			fdlg.set_filter ("*.*")
			odlg.show_modal
			if fdlg.file_name /= Void then
				io.put_string ("Path: " + odlg.file_path + "%N")
				io.put_string ("Name: " + odlg.file_title + "%N")
				io.put_string ("Full: " + odlg.file_name + "%N")
			end
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
			Result.show
			Result.set_size (300, 300)
		end

end -- class DIALOG_TEST
