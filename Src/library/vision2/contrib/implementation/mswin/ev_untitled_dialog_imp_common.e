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
			update_style_and_pixmap,
			extra_minimum_height,
			interface,
			other_imp,
			promote_to_dialog_window
		end

feature {NONE} -- Implementation

	update_style_and_pixmap is
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

feature {EV_DIALOG_I} -- Implementation

	interface: EV_UNTITLED_DIALOG
			-- Interface for `Current'.

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
		
end -- class EV_DIALOG_IMP_COMMON

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
