note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class MENU_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	submenu1: MENU_PULL
	submenu2: MENU_PULL
	submenu3: MENU_PULL

	menu_entry11: MENU_B
	menu_entry12: MENU_B
	menu_entry13: MENU_B

	menu_entry21: MENU_B
	menu_entry22: MENU_B

	submenu31: MENU_PULL
	menu_entry32: MENU_B
	menu_entry33: MENU_B
	menu_entry311: MENU_B
	menu_entry312: MENU_B
	menu_entry313: MENU_B


	main_widget: WIDGET
		once
			create {BAR} Result.make ("Bar", Current)
		end

	set_widgets
		local
			bar: BAR
			ok_com: MESSAGE_OK_COMMAND
		do
			set_size (300, 150)
			main_widget.set_x_y (30, 30)
			bar ?= main_widget
			bar.set_x_y (0, 0)
			create submenu1.make ("s1", bar)
			create submenu2.make ("s1", bar)
			create submenu3.make ("s1", bar)
			create submenu31.make ("s1", submenu3)
			create menu_entry11.make ("s1", submenu1)
			create menu_entry12.make ("s1", submenu1)
			create menu_entry13.make ("s1", submenu1)
			create menu_entry21.make ("s1", submenu2)
			create menu_entry22.make ("s1", submenu2)
			create menu_entry32.make ("s1", submenu3)
			create menu_entry33.make ("s1", submenu3)
			create menu_entry311.make ("s1", submenu31)
			create menu_entry312.make ("s1", submenu31)
			create menu_entry313.make ("s1", submenu31)

			submenu1.set_title ("Submenu1")
			submenu2.set_title ("Submenu2")
			submenu3.set_title ("Submenu3")
			submenu31.set_title ("Submenu31")
			menu_entry11.set_text ("Menu_entry11")
			menu_entry12.set_text ("Menu_entry12")
			menu_entry13.set_text ("Menu_entry13")
			menu_entry21.set_text ("Menu_entry21")
			menu_entry22.set_text ("Menu_entry22")
			menu_entry32.set_text ("Menu_entry32")
			menu_entry33.set_text ("Menu_entry33")
			menu_entry311.set_text ("Menu_entry311")
			menu_entry312.set_text ("Menu_entry312")
			menu_entry312.set_text ("Menu_entry312")
			menu_entry313.set_text ("Menu_entry313")

			menu_entry11.add_activate_action (Current, 11)
			menu_entry12.add_activate_action (Current, 12)
			menu_entry13.add_activate_action (Current, 13)
			menu_entry21.add_activate_action (Current, 21)
			menu_entry22.add_activate_action (Current, 22)
			menu_entry32.add_activate_action (Current, 32)
			menu_entry33.add_activate_action (Current, 33)
			menu_entry311.add_activate_action (Current, 311)
			menu_entry312.add_activate_action (Current, 312)
			menu_entry313.add_activate_action (Current, 313)

			create message_box.make ("message_box", Current)
			message_box.hide_cancel_button
			message_box.hide_help_button
			message_box.set_ok_label ("Ok")
			create ok_com.make
			message_box.add_ok_action (ok_com, message_box)
		end

	message_box: MESSAGE_D

	work (arg: INTEGER_REF)
		do
			inspect
				arg.item
			when 11 then
				message_box.set_message ("Menu_entry11 activated")
				message_box.popup
			when 12 then
				message_box.set_message ("Menu_entry12 activated")
				message_box.popup
			when 13 then
				message_box.set_message ("Menu_entry13 activated")
				message_box.popup
			when 21 then
				message_box.set_message ("Menu_entry21 activated")
				message_box.popup
			when 22 then
				message_box.set_message ("Menu_entry22 activated")
				message_box.popup
			when 32 then
				message_box.set_message ("Menu_entry32 activated")
				message_box.popup
			when 33 then
				message_box.set_message ("Menu_entry33 activated")
				message_box.popup
			when 311 then
				message_box.set_message ("Menu_entry311 activated")
				message_box.popup
			when 312 then
				message_box.set_message ("Menu_entry312 activated")
				message_box.popup
			when 313 then
				message_box.set_message ("Menu_entry313 activated")
				message_box.popup
			end
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


end -- class MENU_DEMO_WINDOW

