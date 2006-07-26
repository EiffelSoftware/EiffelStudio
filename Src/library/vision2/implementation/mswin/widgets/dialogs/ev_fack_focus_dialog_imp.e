indexing
	description: "Windows implementation for EV_FACK_FOCUS_DIALOG."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FACK_FOCUS_DIALOG_IMP

inherit
	EV_UNTITLED_DIALOG_IMP
		redefine
			interface,
			promote_to_modal_dialog,
			promote_to_modeless_dialog
		end

	EV_FACK_FOCUS_GROUPABLE
		rename
			item as wel_item
		end

create
	make,
	make_with_real_dialog

feature {NONE} -- Implementation

	promote_to_modal_dialog is
			-- Redefine
		local
			modal_dialog_imp: EV_UNTITLED_DIALOG_IMP_MODAL
		do
			create modal_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modal_dialog_imp)
		end

	promote_to_modeless_dialog is
			-- Redefine
		local
			modeless_dialog_imp: EV_FACK_FOCUS_DIALOG_IMP_MODELESS
		do
			create modeless_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modeless_dialog_imp)
		end

	interface: EV_FACK_FOCUS_DIALOG;
			-- Redefine

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end
