indexing
	description: "Test of scrollable_area."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLL_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	bar: EV_MENU_BAR
	file_menu, edit_menu, help_menu: EV_MENU
	new_menu, save_menu, i1, i2, i3: EV_MENU
	exit_menu, open_menu, i4: EV_MENU_ITEM

	pix: EV_PIXMAP

	prepare is
		do
			create bar
			first_window.set_menu_bar (bar)

			create file_menu.make_with_text ("File")
			bar.extend (file_menu)

			create new_menu.make_with_text ("New")
			file_menu.extend (new_menu)
			create pix
			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/open.xpm"))
			create open_menu
			open_menu.set_pixmap (pix)
			open_menu.set_text ("Open")
			file_menu.extend (open_menu)
			file_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Sod off de f is niet lang genoeg voor een goede test...!"))

			create save_menu.make_with_text ("Save")
			create pix
			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/save.xpm"))
			save_menu.set_pixmap (pix)
			file_menu.extend (save_menu)
			save_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Really"))
			save_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Nah"))

			file_menu.extend (create {EV_MENU_SEPARATOR})

			create exit_menu.make_with_text ("Exit")
			file_menu.extend (exit_menu)
			exit_menu.press_actions.extend (~on_exit)

			create edit_menu.make_with_text ("Edit-a-bit-too-longggg")
			bar.extend (edit_menu)

			create help_menu.make_with_text ("Help")
			bar.extend (help_menu)

			create i1.make_with_text ("i1")
			help_menu.extend (i1)
			create i2.make_with_text ("i2")
			i1.extend (i2)
			create i3.make_with_text ("i3")
			i2.extend (i3)
			create i4.make_with_text ("i4")
			create pix
			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/isepower.xpm"))
			i4.set_pixmap (pix)
			i3.extend (i4)

		--	save_menu.go_i_th (1)
		--	save_menu.remove
		--	save_menu.remove
		end

	on_exit is
		local
			q: EV_QUESTION_DIALOG
		do
			create q
			q.set_text ("Are you sure you want to quit this nice menu-test program?????")
			q.show_modal
			if q.selected_button.is_equal ("Yes") then
				first_window.destroy
			end
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
		end

end -- class DIALOG_TEST
