indexing
	description: 
		"EiffelVision text field. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I

	EV_TEXT_COMPONENT_IMP
		redefine
			on_key_down
		end

	EV_BAR_ITEM_IMP

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
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
			on_char,
			on_key_up,
			wel_background_color,
			wel_foreground_color
		redefine
			on_key_down,
			default_style
		end

creation
	make,
	make_with_text

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the label with an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create the label with `txt' as label.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, txt, 0, 0, 0, 0, 1)
		end

feature -- Event - command association
	
	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text field is activated, ie when the user
			-- press the enter key.
		do
			add_command (Cmd_activate, cmd, arg)
		end

feature {NONE} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed)
			-- 13 is the number of the return key.
		do
			{EV_TEXT_COMPONENT_IMP} Precursor (virtual_key, key_data)
			if virtual_key = Vk_return then
				execute_command (Cmd_activate, Void)
				set_caret_position (0)
			end
		end	

	default_style: INTEGER is
			-- We specified the Es_autovscroll style otherwise
			-- the system keep on beeping when we press the
			-- return key.
		do
			Result := Ws_visible + Ws_child + Ws_group 
				+ Ws_tabstop + Ws_border + Es_left + Es_autohscroll
		end

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

end -- class EV_TEXT_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
