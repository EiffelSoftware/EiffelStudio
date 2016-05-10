note
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP_MODELESS

inherit
	EV_DIALOG_IMP_MODELESS
		undefine
			promote_to_dialog_window,
			update_style,
			has_title_bar
		redefine
			interface,
			other_imp
		end

	EV_UNTITLED_DIALOG_IMP_COMMON
		undefine
			setup_dialog, show, is_relative, is_show_requested, hide, destroy
		redefine
			interface,
			other_imp
		end

create
	make_with_dialog_window

feature {EV_DIALOG_I} -- Implementation

	other_imp: detachable EV_UNTITLED_DIALOG_IMP note option: stable attribute end
			-- Previous Implementation if any, Void otherwise.

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




end -- class EV_UNTITLED_DIALOG_IMP_MODELESS





