note
	description: "Eiffel Vision dialog. Mswindows implementation (hidden window)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			promote_to_modal_dialog,
			common_dialog_imp,
			has_title_bar
		end

create
	make,
	make_with_real_dialog

feature {NONE} -- Implementation

	update_style
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

	extra_minimum_height: INTEGER
			-- Compute extra minimum height that does not count `item'.
		do
			Result := Precursor {EV_DIALOG_IMP} - title_bar_height
		end

	has_title_bar: BOOLEAN = False
			-- Does Current have a title bar?

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_UNTITLED_DIALOG note option: stable attribute end
			-- Interface for `Current'

feature {NONE} -- Implementation

	promote_to_modal_dialog
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODAL which allows modality
		local
			modal_dialog_imp: EV_UNTITLED_DIALOG_IMP_MODAL
		do
			create modal_dialog_imp.make_with_dialog_window (Current)
			attached_interface.replace_implementation (modal_dialog_imp)
		end

	promote_to_modeless_dialog
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODELESS which allows modality
		local
			modeless_dialog_imp: EV_UNTITLED_DIALOG_IMP_MODELESS
		do
			create modeless_dialog_imp.make_with_dialog_window (Current)
			attached_interface.replace_implementation (modeless_dialog_imp)
		end

	common_dialog_imp: detachable EV_UNTITLED_DIALOG_IMP_COMMON
			-- Dialog implementation type common to all descendents.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_UNTITLED_DIALOG_IMP











