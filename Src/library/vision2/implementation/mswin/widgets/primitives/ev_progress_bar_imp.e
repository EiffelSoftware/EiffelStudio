indexing 
	description: "EiffelVision Progress bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I

	EV_PRIMITIVE_IMP
		undefine
			on_key_down
		end

	WEL_PROGRESS_BAR
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
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
			on_set_focus,
			on_kill_focus,
			on_key_up,
			default_style
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Create a progress bar with `par' as parent.
		do
			wel_make (default_parent.item, 0, 0, 0, 0, -1)
			set_range (0, 100)
		end

feature -- Status setting

	set_segmented (flag: BOOLEAN) is
			-- Set the bar in segmented mode if True and in
			-- continuous mode otherwise.
		local
			wel_imp: WEL_WINDOW
			new_style: INTEGER
			tx, ty, tw, th: INTEGER
		do
			if flag then
				new_style := clear_flag (style, Pbs_smooth)
			else
				new_style := set_flag (style, Pbs_smooth)
			end
			wel_imp ?= parent_imp
			tx := x
			ty := y
			tw := width
			th := height
			wel_destroy
			internal_window_make (wel_imp, Void,
				new_style, tx, ty, tw, th, -1, default_pointer)
		end

	set_percentage (value: INTEGER) is
			-- Make `value' the new percentage filled by the
			-- progress bar.
		do
			set_position (value)
		end

feature {NONE} -- Inapplicable

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_PROGRESS_BAR_IMP

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
