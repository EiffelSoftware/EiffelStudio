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
	
	EV_BAR_ITEM_IMP

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
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
			background_color,
			foreground_color
		redefine
			on_key_down
		end

	WEL_VK_CONSTANTS

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
			wel_make (par_imp, txt, 0, 0, 0, 0, 0)
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
			if virtual_key = Vk_return then
				execute_command (Cmd_activate, Void)
				set_caret_position (0)
				disable_default_processing
			end
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
