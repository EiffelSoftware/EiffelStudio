indexing
        description: "EiffelVision push button.%
					% Mswindows implementation."
        status: "See notice at end of class"
        id: "$$"
        date: "$$"
        revision: "$$"
        
class
    EV_BUTTON_IMP
        
inherit
    EV_BUTTON_I

	EV_PRIMITIVE_IMP
		redefine
			plateform_build
		end
       
	EV_BAR_ITEM_IMP
		redefine
--			set_insensitive,
--			build
		end
        
	EV_TEXT_CONTAINER_IMP
		redefine
			set_default_size
		end
	
--	EV_PIXMAP_CONTAINER_IMP

	EV_FONTABLE_IMP

	WEL_BN_CONSTANTS
		export
			{NONE} all
		end

	WEL_PUSH_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
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
			on_key_up
		redefine
			on_bn_clicked
		end

creation
        make,
		make_with_text

feature {NONE} -- Initialization

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
			extra_width := 10
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			{EV_PRIMITIVE_IMP} Precursor (par)
			set_font (font)
			set_default_size
		end

feature -- Event - command association

	add_click_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
		do
			add_command (Cmd_click, a_command, arguments)
		end

	on_bn_clicked is
			-- When the button is pressed
		do
			execute_command (Cmd_click, Void)
		end

feature {NONE} -- Implementation	
	
	set_default_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			set_minimum_width (fw.string_width (Current, text) + Extra_width)
			set_minimum_height (7 * fw.string_height (Current, text) // 4 - 2)
		end

	extra_width: INTEGER

feature {NONE} -- Implementation of EV_PIXMAP_CONTAINER_IMP

--	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add `pixmap' to the button.
--		local
--			dc: WEL_CLIENT_DC
--			pixmap_imp: EV_PIXMAP_IMP
--		do
--			pixmap_imp ?= pixmap.implementation
--			check
--				pixmap_not_void: pixmap_imp /= Void
--			end
--			!! dc.make (Current)
--			dc.get
--			dc.copy_dc (pixmap_imp, client_rect)
--			dc.release
--		end

end -- class EV_BUTTON_IMP

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
