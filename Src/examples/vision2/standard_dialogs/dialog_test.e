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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

