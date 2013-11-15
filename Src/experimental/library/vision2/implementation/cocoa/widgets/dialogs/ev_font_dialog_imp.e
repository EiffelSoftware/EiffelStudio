note
	description: "EiffelVision font selection dialog, implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			make,
			show_modal_to_window
		end

create
	make


feature {NONE} -- Initialization

	make
			-- Initialize the dialog.
		do
			create font_panel.shared_font_panel
			Precursor {EV_STANDARD_DIALOG_IMP}
--			window := font_panel
		end

feature -- Access

	font: EV_FONT
			-- Current selected font.
		do
			check False then end
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Select `a_font'.
		do
		end

feature {NONE} -- Implementation

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		do
			selected_button := Void

			font_panel.make_key_and_order_front (current)

			selected_button := ev_ok
			if attached ok_actions_internal as l_ok then
				l_ok.call (Void)
			end
		end

	font_panel: NS_FONT_PANEL

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FONT_DIALOG note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_FONT_DIALOG_IMP
