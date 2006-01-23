indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_MODAL
		undefine
			extra_minimum_height,
			promote_to_dialog_window,
			update_style,
			has_title_bar
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

	EV_UNTITLED_DIALOG_IMP_COMMON
		undefine
			hide, is_modal, setup_dialog
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

create
	make_with_dialog_window

feature {EV_DIALOG_I} -- Implementation

	other_imp: EV_UNTITLED_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.
			
feature {NONE} -- Implementation

	common_dialog_imp: EV_DIALOG_IMP_MODAL is
			-- Dialog implementation type common to all descendents.
		do
		end
			
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_UNTITLED_DIALOG;
			-- Interface for `Current'.

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




end -- class EV_DIALOG_IMP_MODAL

