note
	description: "Test of scrollable_area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_TEST

create
	make_and_launch

feature -- Initialization

	make_and_launch
		do
			create application
			prepare
			application.launch
		end

	application: EV_APPLICATION
	bar: EV_MENU_BAR
	file_menu, edit_menu, help_menu: EV_MENU
	new_menu, save_menu, i1, i2, i3: EV_MENU
	exit_menu, open_menu, i4: EV_MENU_ITEM
	cmi: EV_CHECK_MENU_ITEM
	rgt: EV_MENU_ITEM
	vanishing: EV_MENU_SEPARATOR
	rmi: EV_RADIO_MENU_ITEM

	pix: EV_PIXMAP

	prepare
		do
			create bar
			first_window.set_menu_bar (bar)

			create file_menu.make_with_text ("File")
			bar.extend (file_menu)

			create new_menu.make_with_text ("New")
			file_menu.extend (new_menu)
--			create pix
--			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/open.xpm"))
			create open_menu
--			open_menu.set_pixmap (pix)
			open_menu.set_text ("Open")
			file_menu.extend (open_menu)
			file_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Sod off de f is niet lang genoeg voor een goede test...!"))

			create save_menu.make_with_text ("Save")
--			create pix
--			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/save.xpm"))
--			save_menu.set_pixmap (pix)
			file_menu.extend (save_menu)
			save_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Really"))
			save_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Nah"))

			file_menu.extend (create {EV_MENU_SEPARATOR})

			create exit_menu.make_with_text ("Exit")
			file_menu.extend (exit_menu)
			exit_menu.select_actions.extend (agent on_exit)

			create rgt.make_with_text ("Insert separator in help-menu")
			file_menu.extend (rgt)
			rgt.select_actions.extend (agent annoy)

			create edit_menu.make_with_text ("Edit-a-bit-too-longggg")
			bar.extend (edit_menu)

			create help_menu.make_with_text ("Help")
			bar.extend (help_menu)
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("Radio 3"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("Radio 5"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("Radio 1"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("Radio 2000"))
			help_menu.extend (create {EV_MENU_SEPARATOR})
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("NBC"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("ABC"))
			create rmi.make_with_text ("RMI")
			help_menu.extend (rmi)
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("TNT"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("CNN"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("FOX"))
			create vanishing
			help_menu.extend (vanishing)
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("www.gtk.org"))
			help_menu.extend (create {EV_RADIO_MENU_ITEM}.make_with_text ("eiffel.com"))
			create cmi.make_with_text ("Check it out...")
			help_menu.extend (cmi)
			cmi.enable_select

			help_menu.extend (create {EV_MENU_SEPARATOR})
			help_menu.extend (create {EV_MENU_SEPARATOR})

			create i1.make_with_text ("i1")
			edit_menu.extend (i1)
			create i2.make_with_text ("i2")
			i1.extend (i2)
			create i3.make_with_text ("i3")
			i2.extend (i3)
			create i4.make_with_text ("i4")
--			create pix
--			pix.set_with_file (create {RAW_FILE}.make_open_read ("/var/sw/EiffelBLEEDING/bench/bitmaps/xpm/isepower.xpm"))
--			i4.set_pixmap (pix)
			i3.extend (i4)

			io.put_string (test_radio_grouping.out + "%N")

			first_window.close_request_actions.extend (agent first_window.destroy_and_exit_if_last)
			first_window.show
		end

	test_radio_grouping: BOOLEAN
			-- Is radio grouping working correctly?
		local
			hb: EV_HORIZONTAL_BOX
			hsa, hsb, hsc: EV_VERTICAL_BOX
			rb: EV_RADIO_BUTTON
		do
			create hb
			first_window.extend (hb)

			create hsa
			hb.extend (hsa)
			create rb.make_with_text ("radio1")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsa.extend (rb)
			create rb.make_with_text ("radio2")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsa.extend (rb)
			create rb.make_with_text ("radio3")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsa.extend (rb)

			create hsb
			hb.extend (hsb)
			create rb.make_with_text ("TV1")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsb.extend (rb)
			create rb.make_with_text ("TV2")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsb.extend (rb)
			create rb.make_with_text ("TV3")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsb.extend (rb)

			create hsc
			hb.extend (hsc)
			create rb.make_with_text ("a1")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsc.extend (rb)
			create rb.make_with_text ("a2")
			rb.select_actions.extend (agent on_radio_test (rb))
			hsc.extend (rb)

			hsb.merge_radio_button_groups (hsa)
			hsb.merge_radio_button_groups (hsc)
			hsb.merge_radio_button_groups (hsc)

			Result := rb.peers.count = 8
		end

	sd: EV_FILE_OPEN_DIALOG
	si: EV_INFORMATION_DIALOG

	on_ok
		do
			create si
			si.set_text ("Dialog inside dialog.")
			si.show_modal_to_window (first_window)
		end

	on_exit
		local
			q: EV_QUESTION_DIALOG
		do
			create q
			q.set_text ("Are you sure you want to quit this nice menu-test program?????")
			q.show_modal_to_window (first_window)
			if q.selected_button.is_equal ("Yes") then
				first_window.destroy
			end
		end

	on_radio_test (arb: EV_RADIO_BUTTON)
		do
			io.put_string ("Me: " + arb.text + "%N")
			io.put_string ("Sel: " + arb.selected_peer.text + "%N")
		end

	annoy
		do
			create sd
			sd.open_actions.extend (agent on_ok)
			sd.show_modal_to_window (first_window)
		end

	first_window: EV_TITLED_WINDOW
		once
			create Result
			Result.set_title ("Main window")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DIALOG_TEST

