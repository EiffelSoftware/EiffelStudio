indexing
	description: "EiffelVision check button.%
			% Mswindows implementation"
	author: ""
	date: "$$"
	revision: "$$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		
	EV_TOGGLE_BUTTON_IMP
		undefine
			default_process_message,
			default_style
		redefine
			make,
			make_with_text,
			state,
			set_state,
			toggle
		end

	WEL_CHECK_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_bn_clicked
		redefine
			default_style
		end	

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the label with an empty label.
		do
			make_with_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create the label with `txt' as label.
		do
			wel_make (default_parent.item, txt, 0, 0, 0, 0, 0)
			extra_width := 20
		end

feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle pressed
		do
			Result := checked
		end 

feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if flag then
				set_checked
			else
				set_unchecked
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_state (not state)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
						+ Ws_tabstop + Bs_autocheckbox
		end

end -- class EV_CHECK_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
