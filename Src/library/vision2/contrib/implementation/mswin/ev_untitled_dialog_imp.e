indexing
	description: "Eiffel Vision dialog. Mswindows implementation (hidden window)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP

inherit
	EV_DIALOG_IMP
		redefine
			interface,
			update_style,
			extra_minimum_height,
			promote_to_modeless_dialog,
			promote_to_modal_dialog
		end

create
	make,
	make_with_real_dialog

feature {NONE} -- Implementation

	update_style is
			-- Update the style of the window accordingly to the
			-- options set (`user_can_resize', `is_closeable', ...)
			-- and set the pixmap.
		local
			new_style: INTEGER
			bit_op: WEL_BIT_OPERATIONS
		do
			Precursor {EV_DIALOG_IMP}
				
				-- Change the style of the window.
			create bit_op
			new_style := style
			new_style := bit_op.clear_flag (new_style, Ws_caption)
			set_style (new_style)
		end

	extra_minimum_height: INTEGER is
			-- Compute extra minimum height that does not count `item'.
		do
			Result := Precursor {EV_DIALOG_IMP} - title_bar_height
			if not user_can_resize then
				Result := Result - 2 * dialog_window_frame_height
			end
		end

feature {EV_DIALOG_I} -- Implementation

	interface: EV_UNTITLED_DIALOG
			-- Interface for `Current'

feature {NONE} -- Implementation

	promote_to_modal_dialog is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODAL which allows modality
		local
			modal_dialog_imp: EV_UNTITLED_DIALOG_IMP_MODAL
		do
			create modal_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modal_dialog_imp)
		end

	promote_to_modeless_dialog is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODELESS which allows modality
		local
			modeless_dialog_imp: EV_UNTITLED_DIALOG_IMP_MODELESS
		do
			create modeless_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modeless_dialog_imp)
		end

end -- class EV_UNTITLED_DIALOG_IMP

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
