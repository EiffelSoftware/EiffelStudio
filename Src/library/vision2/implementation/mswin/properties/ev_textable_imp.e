indexing

	description: 
		"EiffelVision text container, gtk implementation"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_CONTAINER_IMP
	
inherit
	EV_TEXT_CONTAINER_I

	WEL_WINDOW
		rename
			parent as wel_parent
		undefine
			-- We undefine the features that are redefine by WEL_ objects
			call_default_window_procedure,
			set_default_window_procedure,
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
			destroy,
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
			set_text
		end

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		do
                        check
                                not_yet_implemented: False
                        end
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		do
			check
                                not_yet_implemented: False
                        end
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		do
		        check
                                not_yet_implemented: False
                        end
		end
	
	destroyed: BOOLEAN is
		deferred
		end

feature -- Inapplicable

	set_default_size is
			-- Set to the size of the text
		do
		end

feature -- Element change	
	
	set_text (t: STRING) is
		do
			{WEL_WINDOW} Precursor (t)
			set_default_size
		end

--feature {NONE} -- Implementation : wel_feature

--	wel_set_text (t: STRING) is
--		deferred
--		end
	
end -- class EV_TEXT_CONTAINER_IMP

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
