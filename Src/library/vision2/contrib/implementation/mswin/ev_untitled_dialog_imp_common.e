indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_UNTITLED_DIALOG_IMP_COMMON

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			update_style,
			extra_minimum_height,
			interface,
			other_imp,
			promote_to_dialog_window,
			has_title_bar
		end

feature {NONE} -- Implementation

	update_style is
			-- Update the style of the window accordingly to the
			-- options set (`user_can_resize', `is_closeable', ...)
			-- and set the pixmap.
		local
			new_style: INTEGER
			bit_op: WEL_BIT_OPERATIONS
		do
			Precursor {EV_DIALOG_IMP_COMMON}
				
				-- Change the style of the window.
			create bit_op
			new_style := style
			new_style := bit_op.clear_flag (new_style, Ws_caption)
			set_style (new_style)
		end

	extra_minimum_height: INTEGER is
			-- Compute extra minimum height that does not count `item'.
		do
			Result := Precursor {EV_DIALOG_IMP_COMMON} - title_bar_height
			if not user_can_resize then
				Result := Result - 2 * dialog_window_frame_height
			end
		end

	has_title_bar: BOOLEAN is False
			-- Does Current have a title bar?

feature {EV_DIALOG_I} -- Implementation

	other_imp: EV_UNTITLED_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.

feature {NONE} -- Implementation

	promote_to_dialog_window is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP which does not allows modality
		local
			dialog_window_imp: EV_UNTITLED_DIALOG_IMP
		do
			create dialog_window_imp.make_with_real_dialog (Current)
			interface.replace_implementation (dialog_window_imp)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
		
	interface: EV_UNTITLED_DIALOG
			-- Interface for `Current'.
		
end -- class EV_DIALOG_IMP_COMMON

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

