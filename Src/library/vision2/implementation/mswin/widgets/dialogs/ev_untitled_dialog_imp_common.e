note
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_UNTITLED_DIALOG_IMP_COMMON

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			update_style,
			interface,
			other_imp,
			promote_to_dialog_window,
			has_title_bar
		end

feature {NONE} -- Implementation

	update_style
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

	has_title_bar: BOOLEAN = False
			-- Does Current have a title bar?

feature {EV_DIALOG_I} -- Implementation

	other_imp: detachable EV_UNTITLED_DIALOG_IMP note option: stable attribute end
			-- Previous Implementation if any, Void otherwise.

feature {NONE} -- Implementation

	promote_to_dialog_window
			-- Promote the current implementation to
			-- EV_DIALOG_IMP which does not allows modality
		local
			dialog_window_imp: EV_UNTITLED_DIALOG_IMP
		do
			create dialog_window_imp.make_with_real_dialog (Current)
			attached_interface.replace_implementation (dialog_window_imp)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_UNTITLED_DIALOG note option: stable attribute end;
			-- Interface for `Current'.

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DIALOG_IMP_COMMON





