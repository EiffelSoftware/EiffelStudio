indexing
	description: "Test of tests."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEST

inherit
	EV_APPLICATION

	EV_KEY_CONSTANTS
		undefine
			default_create
		end

create
	make_and_launch

feature -- Initialization

	prepare is
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			mb: EV_VERTICAL_BOX
			cb: EV_HORIZONTAL_BOX
			rb: EV_RADIO_BUTTON
			a: EV_ACCELERATOR
			ob: EV_OPTION_BUTTON
		do
			first_window.set_title ("DYNAMIC_LIST test")
			create vb
			create hb
			create mb
			create cb
			vb.extend (hb)
			hb.extend (mb)
			mb.extend (cb)
			vb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button1", ~prepend_button (vb, "Extra!")))
			vb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button2", ~append_button (vb, "Extra!")))
			hb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button3", ~prepend_button (hb, "Extra!")))
			hb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button4", ~append_button (hb, "Extra!")))
			mb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button5", ~prepend_button (mb, "Extra!")))
			mb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button6", ~append_button (mb, "Extra!")))
			cb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button7", ~prepend_button (cb, "Extra!")))
			cb.extend (create {EV_BUTTON}.make_with_text_and_action (
				"Button8", ~append_button (cb, "Extra!")))
			first_window.extend (vb)
			vb.extend (create {EV_HORIZONTAL_BOX}.make_for_test)
			first_window.key_press_actions.extend (~on_key_press)
			first_window.key_release_actions.extend (~on_key_release)

		create ob.make_with_text ("Optieeeebuttonnn")
		ob.menu.extend (create {EV_MENU_ITEM}.make_with_text ("Sod off"))
		ob.menu.extend (create {EV_MENU_ITEM}.make_with_text ("ya&de&yada"))
		ob.menu.extend (create {EV_MENU_ITEM}.make_with_text ("Fish && Chips"))
		vb.extend (ob)
	end

	on_key_press (k: EV_KEY) is
		do
			io.put_string ("Press: " + k.out + "%N")
		end

	on_key_release (k: EV_KEY) is
		do
			io.put_string ("Release: " + k.out + "%N")
		end

	prepend_button (a_box: EV_BOX; a_text: STRING) is
		do
			a_box.put_front (create {EV_BUTTON}.make_with_text (a_text))
			a_box.put_front (create {EV_BUTTON}.make_with_text (a_text))
		end

	append_button (a_box: EV_BOX; a_text: STRING) is
		do
			a_box.extend (create {EV_BUTTON}.make_with_text (a_text))
			a_box.extend (create {EV_BUTTON}.make_with_text (a_text))
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEST_TEST

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

