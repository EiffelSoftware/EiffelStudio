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
	new_menu, save_menu, i1, i2, i3, i4: EV_MENU

	prepare is
		do
			create bar
			first_window.set_menu_bar (bar)

			create file_menu.make_with_text ("File")
			bar.extend (file_menu)

			create new_menu.make_with_text ("New")
			file_menu.extend (new_menu)
			file_menu.extend (create {EV_CHECK_MENU_ITEM}.make_with_text ("Open"))
			--new_menu.extend (file_menu)

			create save_menu.make_with_text ("Save")
			file_menu.extend (save_menu)
			save_menu.extend (create {EV_MENU}.make_with_text ("Really"))
			save_menu.extend (create {EV_MENU}.make_with_text ("Nah"))

			file_menu.extend (create {EV_MENU}.make_with_text ("Exit"))

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
			i3.extend (i4)

		--	save_menu.go_i_th (1)
		--	save_menu.remove
		--	save_menu.remove
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
		end

end -- class DIALOG_TEST
